function [X2, Y2, Z2, C2] = streamsToSurface(Xb, Yb, Zb, Cb)
% streamsToSurface  Convert NaN-delimited streamline vectors to 2-row surface matrices.
%
% MATLAB's surface() with EdgeColor 'interp' renders the mesh edges between
% adjacent columns via hardware-accelerated vertex buffers. This is faster
% than patch() with EdgeColor 'interp' for large datasets because the data
% is uploaded as a VBO rather than processed as individual line segments.
%
% The 2-row structure means:
%   - Row edges (between row 1 and row 2 of same column): zero-length, invisible
%   - Column edges (between column k and k+1): the visible streamline segments
%   - NaN values in both rows break the line between streamlines
%
% Inputs:  Xb, Yb, Zb, Cb  – column vectors with NaN separators
% Outputs: X2, Y2, Z2, C2  – 2×N matrices ready for surface()

if isempty(Xb)
    X2 = zeros(2,1,'single');
    Y2 = zeros(2,1,'single');
    Z2 = zeros(2,1,'single');
    C2 = zeros(2,1,'single');
    return
end

% Ensure column vectors
Xb = Xb(:); Yb = Yb(:); Zb = Zb(:); Cb = Cb(:);

% Stack as 2-row ribbon: row 1 and row 2 are identical.
% surface() renders the faces between adjacent columns, so this gives
% a coloured line with zero width but full hardware acceleration.
X2 = [Xb'; Xb'];
Y2 = [Yb'; Yb'];
Z2 = [Zb'; Zb'];
C2 = [Cb'; Cb'];

end