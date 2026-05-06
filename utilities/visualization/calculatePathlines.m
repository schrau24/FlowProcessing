function pathlinesOut = calculatePathlines(start_points, nframes, timeres_ms, pathlineInterp, minVel, maxVel)
% calculatePathlines  Compute particle pathlines via ODE45 integration.
%
% Particles are emitted from start_points at each cardiac time window and
% tracked through the full 4D velocity field. Each particle stops when it
% leaves the segmentation mask or when integration fails.
%
% INPUTS
%   start_points    N×3 matrix of seed positions [x y z] in mm (ndgrid order)
%   nframes         number of cardiac frames
%   timeres_ms      temporal resolution in milliseconds
%   pathlineInterp  struct with fields:
%                     .U, .V, .W  – 4D griddedInterpolant for velocity (mm/s)
%                     .mask       – 3D griddedInterpolant for segmentation mask
%   minVel          minimum velocity threshold for colouring (cm/s)
%   maxVel          maximum velocity for colouring (cm/s)
%
% OUTPUT
%   pathlinesOut    struct with fields:
%                     .dataStore   num_windows × num_starts cell array
%                                  each cell: struct with .coords (Nt×3) and .vel (Nt×1)
%                     .time_steps  time points used (seconds)

dt        = timeres_ms / 1000;           % frame duration in seconds
T_total   = nframes * dt;
num_starts = size(start_points, 1);

% Divide cardiac cycle into windows, one per frame
time_steps  = dt * (0:nframes);         % nframes+1 boundaries → nframes windows
num_windows = nframes;

dataStore   = cell(num_windows, num_starts);
current_ics = start_points;
active_mask = true(num_starts, 1);

% ODE options: stop at segmentation boundary
opts = odeset( ...
    'Events',   @(t,pos) maskBoundaryEvent(t, pos, pathlineInterp.mask), ...
    'RelTol',   1e-3, ...
    'AbsTol',   1e-5, ...
    'Refine',   5, ...
    'OutputFcn', @recoverData);

hWait = waitbar(0, 'Calculating pathlines...');

for k = 1:num_windows
    t_window = [time_steps(k), time_steps(k+1)];

    for i = 1:num_starts
        if ~active_mask(i), continue; end

        % Only integrate if particle is still inside the mask
        try
            inMask = pathlineInterp.mask( ...
                current_ics(i,1), current_ics(i,2), current_ics(i,3)) > 0.5;
        catch
            inMask = false;
        end
        if ~inMask
            active_mask(i) = false;
            continue;
        end

        t_seg = []; traj_seg = [];
        try
            [t_seg, traj_seg] = ode45( ...
                @(t,pos) pathlineODE(t, pos, pathlineInterp.U, pathlineInterp.V, pathlineInterp.W), ...
                t_window, double(current_ics(i,:)), opts);
        catch
            % Recover partial trajectory written by recoverData OutputFcn
            try
                partial = evalin('base', 'last_successful_path');
                if ~isempty(partial)
                    t_seg    = partial(:,1);
                    traj_seg = partial(:,2:end);
                end
            catch; end
            active_mask(i) = false;
        end

        if isempty(traj_seg) || size(traj_seg,1) < 2
            active_mask(i) = false;
            continue;
        end

        % Clamp time to valid interpolant range to avoid extrapolation
        t_clamp  = min(max(t_seg, time_steps(1)), time_steps(end));

        % Velocity magnitude along trajectory (in cm/s)
        try
            U   = pathlineInterp.U(traj_seg(:,1), traj_seg(:,2), traj_seg(:,3), t_clamp);
            V   = pathlineInterp.V(traj_seg(:,1), traj_seg(:,2), traj_seg(:,3), t_clamp);
            W   = pathlineInterp.W(traj_seg(:,1), traj_seg(:,2), traj_seg(:,3), t_clamp);
            mag = sqrt(U.^2 + V.^2 + W.^2);
        catch
            mag = zeros(size(t_seg));
        end

        % Apply velocity thresholds
        mag = min(max(mag, minVel*10), maxVel*10);

        dataStore{k,i}.coords = traj_seg;
        dataStore{k,i}.vel    = mag;

        % Advance initial condition for next window
        current_ics(i,:) = traj_seg(end,:);
    end

    if ishandle(hWait)
        waitbar(k/num_windows, hWait, ...
            sprintf('Calculating pathlines... (%d/%d windows)', k, num_windows));
    end
end

if ishandle(hWait), close(hWait); end

pathlinesOut.dataStore  = dataStore;
pathlinesOut.time_steps = time_steps;

end