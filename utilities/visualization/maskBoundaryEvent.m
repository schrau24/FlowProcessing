function [value, isterminal, direction] = maskBoundaryEvent(t, pos, interpMask, bounds)
% maskBoundaryEvent  ODE event: stop integration when particle leaves the
%                   segmentation mask OR reaches the image volume boundary.
%
% INPUTS
%   t           current time (unused, required by ODE event signature)
%   pos         [3x1] current particle position [x; y; z] in mm
%   interpMask  griddedInterpolant of the smoothed segmentation mask
%   bounds      [3x2] matrix: [xMin xMax; yMin yMax; zMin zMax] of image volume
%
% Stopping conditions (value = 0 triggers the event):
%   1. Mask value drops below 0.5 (particle leaves segmentation)
%   2. Any coordinate reaches the image volume boundary

% --- Check image volume bounds first (fast, no interpolation needed) ------
if nargin >= 4 && ~isempty(bounds)
    margin = 1e-6;  % small tolerance to avoid floating point edge effects
    if pos(1) <= bounds(1,1) + margin || pos(1) >= bounds(1,2) - margin || ...
       pos(2) <= bounds(2,1) + margin || pos(2) >= bounds(2,2) - margin || ...
       pos(3) <= bounds(3,1) + margin || pos(3) >= bounds(3,2) - margin
        % At or beyond image boundary — stop immediately
        value      = 0;
        isterminal = 1;
        direction  = 0;
        return
    end
end

% --- Check segmentation mask ----------------------------------------------
try
    mVal = interpMask(pos(1), pos(2), pos(3));
catch
    % Outside interpolant grid — treat as outside mask
    mVal = 0;
end

value      = mVal - 0.5;   % zero-crossing at the vessel wall isocontour
isterminal = 1;             % stop integration
direction  = -1;            % only trigger when leaving mask (mVal decreasing through 0.5)
end