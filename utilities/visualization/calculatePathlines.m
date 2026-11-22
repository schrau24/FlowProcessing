function pathlinesOut = calculatePathlines(start_points, nframes, timeres_ms, pathlineInterp, minVel, maxVel, pathLenSec, releaseFrame, stepVox)
% calculatePathlines  Compute particle pathlines with a vectorised RK4 integrator.
%
% ALL active particles are advanced together: every Runge-Kutta stage is one
% vectorised call of the (4D) velocity interpolants for all particles, instead
% of one scalar ode45 call per particle and window. The step size is adaptive
% but global: h = stepVox * (smallest voxel size) / (fastest active particle),
% so no particle moves more than stepVox voxels per step (default 1).
%
% Output format is unchanged (dataStore{window,particle}.coords / .vel, ...).
%
% Units: velocity interpolants are in mm/s (built from app.v), positions in mm,
%        minVel/maxVel are in cm/s (from visParams); stored .vel is in cm/s.
%
% Stopping: a particle stops when it leaves the segmentation mask (smoothed
% mask value < 0.5) or reaches the image volume boundary. The exit point is
% located by bisection on the last step (as the ODE event did), the particle
% ends on the inside of the wall and is not advanced any further.
%
% Optional 9th input: stepVox (voxels per step, default 1).

if nargin < 7 || isempty(pathLenSec) || pathLenSec <= 0
    pathLenSec = [];
end
if nargin < 8 || isempty(releaseFrame) || releaseFrame < 1
    releaseFrame = 1;
end
if nargin < 9 || isempty(stepVox) || stepVox <= 0
    stepVox = 1;
end
releaseFrame = min(round(releaseFrame), nframes);

dt         = double(timeres_ms) / 1000;
N          = size(start_points, 1);
T_cycle    = nframes * dt;

% Build window order starting from releaseFrame
window_order = mod((releaseFrame-1 : releaseFrame-1+nframes-1), nframes) + 1;
time_steps_ordered = (window_order - 1) * dt;  % cycle time for each window start

fU = pathlineInterp.U;  fV = pathlineInterp.V;  fW = pathlineInterp.W;
fM = pathlineInterp.mask;
bounds = pathlineInterp.bounds;

gv   = fM.GridVectors;
dmin = min([gv{1}(2)-gv{1}(1), gv{2}(2)-gv{2}(1), gv{3}(2)-gv{3}(1)]);
maxStep = stepVox * dmin;                   % largest distance a particle may move per step (mm)

dataStore = cell(nframes, N);
pos       = double(start_points);
active    = true(N, 1);

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

    % Particles must still be inside the mask / volume at the window start
    idx = find(active);
    if ~isempty(idx)
        okStart = insideMask(pos(idx,:), fM, bounds);
        active(idx(~okStart)) = false;
        idx = idx(okStart);
    end
    if isempty(idx)
        break          % nothing left to track
    end

    % ---- trajectory buffers for this window (N x 3 per step, NaN = inactive)
    posList  = cell(1, 64);
    timeList = cell(1, 64);
    nRec = 1;
    A0 = NaN(N,3);  A0(idx,:) = pos(idx,:);
    T0 = NaN(N,1);  T0(idx)   = sub_windows{1}(1);
    posList{1} = A0;  timeList{1} = T0;

    cur = idx;                                   % particles integrated in this window
    for sw = 1:numel(sub_windows)
        t_win = sub_windows{sw};
        tcur  = t_win(1);
        tend  = t_win(2);
        if abs(tend - tcur) < 1e-9, continue; end
        hmin = (tend - tcur) / 2000;             % guards against vanishing steps

        while (tend - tcur) > 1e-12 && ~isempty(cur)
            P  = pos(cur,:);
            k1 = velAt(fU, fV, fW, P, tcur);
            vmax = max(sqrt(sum(k1.^2, 2)));
            h  = min(tend - tcur, max(maxStep / max(vmax, eps), hmin));

            k2 = velAt(fU, fV, fW, P + (h/2)*k1, tcur + h/2);
            k3 = velAt(fU, fV, fW, P + (h/2)*k2, tcur + h/2);
            k4 = velAt(fU, fV, fW, P + h*k3,     tcur + h);
            Pn = P + (h/6) * (k1 + 2*k2 + 2*k3 + k4);

            tn = repmat(tcur + h, numel(cur), 1);

            % particles that left the mask / volume during this step: find the
            % exit point by bisection along the step
            inside = insideMask(Pn, fM, bounds);
            bad = find(~inside);
            if ~isempty(bad)
                lo  = zeros(numel(bad),1);
                hi  = ones(numel(bad),1);
                Pb  = P(bad,:);
                dPb = Pn(bad,:) - Pb;
                for it = 1:8
                    mid = (lo + hi) / 2;
                    ins = insideMask(Pb + mid.*dPb, fM, bounds);
                    lo(ins)  = mid(ins);
                    hi(~ins) = mid(~ins);
                end
                Pn(bad,:) = Pb + lo.*dPb;
                tn(bad)   = tcur + lo*h;
            end

            % record
            nRec = nRec + 1;
            if nRec > numel(posList)
                posList(end+1:2*end)  = cell(1, numel(posList)); %#ok<AGROW>
                timeList(end+1:2*end) = cell(1, numel(timeList)); %#ok<AGROW>
            end
            A = NaN(N,3);  A(cur,:) = Pn;
            T = NaN(N,1);  T(cur)   = tn;
            posList{nRec}  = A;
            timeList{nRec} = T;

            pos(cur,:) = Pn;
            tcur = tcur + h;

            if ~isempty(bad)
                active(cur(bad)) = false;        % stopped for good
                cur(bad) = [];
            end
        end
        if isempty(cur), break; end
    end

    % ---- turn the recorded steps into per-particle trajectories ----------
    posList  = posList(1:nRec);
    timeList = timeList(1:nRec);
    A  = cat(3, posList{:});                     % N x 3 x nRec
    TT = cat(2, timeList{:});                    % N x nRec
    X2 = reshape(A(:,1,:), N, nRec);
    Y2 = reshape(A(:,2,:), N, nRec);
    Z2 = reshape(A(:,3,:), N, nRec);
    valid = ~isnan(TT);

    % velocity magnitude at every recorded point: one vectorised call
    tc = min(max(TT(valid), 0), T_cycle*(1-1e-9));
    xs = X2(valid);  ys = Y2(valid);  zs = Z2(valid);
    mag = sqrt(double(fU(xs,ys,zs,tc)).^2 + double(fV(xs,ys,zs,tc)).^2 + ...
               double(fW(xs,ys,zs,tc)).^2) / 10;          % mm/s -> cm/s
    mag(isnan(mag)) = 0;
    mag = min(max(mag, minVel), maxVel);
    M = NaN(N, nRec);
    M(valid) = mag;

    for i = find(any(valid,2))'
        v = valid(i,:);
        if nnz(v) < 2, continue, end
        dataStore{k,i}.coords = [X2(i,v)', Y2(i,v)', Z2(i,v)'];
        dataStore{k,i}.vel    = M(i,v)';     % cm/s, ready for display
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

% =========================================================================
% LOCAL HELPER – velocity (mm/s) at the positions P (n x 3) at cycle time t
% =========================================================================
function V = velAt(fU, fV, fW, P, t)
    tt = repmat(t, size(P,1), 1);
    V  = [double(fU(P(:,1),P(:,2),P(:,3),tt)), ...
          double(fV(P(:,1),P(:,2),P(:,3),tt)), ...
          double(fW(P(:,1),P(:,2),P(:,3),tt))];
    V(isnan(V)) = 0;          % no velocity data -> particle does not move
end

% =========================================================================
% LOCAL HELPER – inside the image volume AND inside the (smoothed) mask?
% =========================================================================
function ok = insideMask(P, fM, bounds)
    m  = 1e-6;
    ok = P(:,1) > bounds(1,1)+m & P(:,1) < bounds(1,2)-m & ...
         P(:,2) > bounds(2,1)+m & P(:,2) < bounds(2,2)-m & ...
         P(:,3) > bounds(3,1)+m & P(:,3) < bounds(3,2)-m;
    if any(ok)
        mv = zeros(size(P,1), 1);
        mv(ok) = fM(P(ok,1), P(ok,2), P(ok,3));
        ok = ok & (mv >= 0.5);
    end
end