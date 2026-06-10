function pathlinesOut = calculatePathlines(start_points, nframes, timeres_ms, pathlineInterp, minVel, maxVel, pathLenSec, releaseFrame)
% calculatePathlines  Compute particle pathlines via ODE45 integration.
%
% Units note: velocity interpolants are in mm/s (built from app.v).
%             minVel/maxVel are in cm/s (from visParams).
%             mag stored in dataStore is in cm/s (divided by 10 here).
%
% Boundary stopping: particles stop when they leave the segmentation mask
% (maskBoundaryEvent) OR when the velocity interpolant returns NaN
% (pathlineODE already handles this by returning [0;0;0], but we also
% explicitly check mask value at each window start).

if nargin < 7 || isempty(pathLenSec) || pathLenSec <= 0
    pathLenSec = [];
end
if nargin < 8 || isempty(releaseFrame) || releaseFrame < 1
    releaseFrame = 1;
end
releaseFrame = min(round(releaseFrame), nframes);

dt         = double(timeres_ms) / 1000;
num_starts = size(start_points, 1);
T_cycle    = nframes * dt;

% Build window order starting from releaseFrame
window_order = mod((releaseFrame-1 : releaseFrame-1+nframes-1), nframes) + 1;
time_steps_ordered = (window_order - 1) * dt;  % cycle time for each window start

dataStore   = cell(nframes, num_starts);
current_ics = double(start_points);
active_mask = true(num_starts, 1);

% ODE options: stop at segmentation boundary OR image volume edge
bounds = pathlineInterp.bounds;
opts = odeset( ...
    'Events',    @(t,pos) maskBoundaryEvent(t, pos, pathlineInterp.mask, bounds), ...
    'RelTol',    1e-3, ...
    'AbsTol',    1e-5, ...
    'Refine',    5);

hWait = waitbar(0, 'Calculating pathlines...');

for k = 1:nframes

    t_cycle_start = time_steps_ordered(k);

    % Determine how long to track in this window
    if isempty(pathLenSec)
        t_window_dur = dt;
    else
        remaining = pathLenSec - (k-1)*dt;
        if remaining <= 0, break; end
        t_window_dur = min(dt, remaining);
    end

    t0_cycle = t_cycle_start;
    t1_cycle = t0_cycle + t_window_dur;

    % Split window if it crosses the cycle boundary
    t0_i = mod(t0_cycle, T_cycle);
    t1_i = mod(t1_cycle, T_cycle);
    if t1_i < t0_i - 1e-9
        sub_windows = {[t0_i, T_cycle*(1-1e-9)]; [0, t1_i]};
    else
        sub_windows = {[t0_i, t1_i]};
    end

    for i = 1:num_starts
        if ~active_mask(i), continue; end

        % Check particle is still inside mask AND within image volume
        ic = current_ics(i,:);
        outOfBounds = any(ic(:) <= bounds(:,1) + 1e-6) || ...
                      any(ic(:) >= bounds(:,2) - 1e-6);
        if outOfBounds
            active_mask(i) = false;
            continue;
        end
        try
            mVal = pathlineInterp.mask(ic(1), ic(2), ic(3));
        catch
            mVal = 0;
        end
        if mVal < 0.5
            active_mask(i) = false;
            continue;
        end

        t_all = []; y_all = [];
        ic = current_ics(i,:);
        stopped = false;

        for sw = 1:numel(sub_windows)
            t_win = sub_windows{sw};
            if abs(diff(t_win)) < 1e-9, continue; end

            try
                [t_s, y_s, te, ye, ~] = ode45( ...
                    @(t,pos) pathlineODE(t, pos, pathlineInterp.U, pathlineInterp.V, pathlineInterp.W), ...
                    t_win, double(ic), opts);
            catch
                t_s = []; y_s = []; te = []; ye = [];
                stopped = true;
            end

            if ~isempty(y_s) && size(y_s,1) >= 1
                t_all = [t_all;  t_s];  %#ok<AGROW>
                y_all = [y_all;  y_s];  %#ok<AGROW>
                ic = y_s(end,:);
            end

            % If boundary event fired, stop this particle permanently
            if ~isempty(te)
                if ~isempty(ye)
                    ic = ye(end,:);
                end
                stopped = true;
                break;
            end
        end

        if stopped
            active_mask(i) = false;
        end

        if isempty(y_all) || size(y_all,1) < 2
            continue
        end

        % Compute velocity magnitude in cm/s (interpolants are in mm/s → /10)
        t_clamp = min(max(t_all, 0), T_cycle*(1-1e-9));
        try
            U = pathlineInterp.U(y_all(:,1), y_all(:,2), y_all(:,3), t_clamp);
            V = pathlineInterp.V(y_all(:,1), y_all(:,2), y_all(:,3), t_clamp);
            W = pathlineInterp.W(y_all(:,1), y_all(:,2), y_all(:,3), t_clamp);
            % Divide by 10: mm/s → cm/s, then clamp to [minVel, maxVel]
            mag = sqrt(double(U).^2 + double(V).^2 + double(W).^2) / 10;
            mag = min(max(mag, minVel), maxVel);
        catch
            mag = zeros(size(t_all));
        end

        dataStore{k,i}.coords = y_all;
        dataStore{k,i}.vel    = mag;   % cm/s, ready for display

        if ~stopped
            current_ics(i,:) = ic;
        end
    end

    if ishandle(hWait)
        waitbar(k/nframes, hWait, sprintf('Calculating pathlines... (%d/%d)', k, nframes));
    end
end

if ishandle(hWait), close(hWait); end

pathlinesOut.dataStore    = dataStore;
pathlinesOut.time_steps   = (0:nframes)*dt;
pathlinesOut.window_order = window_order;
pathlinesOut.releaseFrame = releaseFrame;
end