function [value, isterminal, direction] = maskBoundaryEvent(t, pos, interpMask)
    % pos = [x; y; z]
    % Get the mask value at current particle position
    % Use 'nearest' or 'linear' interpolation for the mask
    mVal = interpMask(pos(1), pos(2), pos(3));
    
    % Event triggers when 'value' is zero.
    % mVal is 1 inside, 0 outside. mVal - 0.5 is 0 at the boundary.
    value = mVal - 0.5; 
    
    isterminal = 1;  % Stop integration
    direction  = -1; % Only detect transition from 1 to 0 (leaving foreground)
end
