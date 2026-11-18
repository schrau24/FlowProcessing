function ori = dicomOrientToLabels(dcmorient, ori)
% dicomOrientToLabels  Set ori.vxlabel, ori.vylabel, ori.vzlabel from the
%                      DICOM ImageOrientationPatient vector.
%
% dcmorient: [6x1] ImageOrientationPatient
%            [Fx Fy Fz Gx Gy Gz] — row and column direction cosines in LPS
%            LPS: X=Left(+), Y=Posterior(+), Z=Superior(+)
%
% The sign of the dominant cosine component determines which end of the
% axis is at index 1 (base) vs index N (tip):
%   LPS X+ = Left    → positive dominant = R-L (rows go rightward to leftward)
%   LPS X- = Right   → negative dominant = L-R
%   LPS Y+ = Post    → positive dominant = A-P
%   LPS Y- = Ant     → negative dominant = P-A
%   LPS Z+ = Sup     → positive dominant = F-H  (foot at row 1, head at row N)
%   LPS Z- = Inf     → negative dominant = H-F

F = dcmorient(1:3);   % row direction cosine
G = dcmorient(4:6);   % col direction cosine
N = cross(F, G);      % slice normal (through-plane direction)

ori.vylabel = axisLabel(F);
ori.vxlabel = axisLabel(G);
ori.vzlabel = axisLabel(N);

end

function lbl = axisLabel(v)
% Return a 'from-to' label for a direction cosine vector v in LPS space.
% The label reads: index_1_end - index_N_end
% (so the TIP letter = last character = direction of increasing index)

% Positive LPS axes:  X=Left, Y=Posterior, Z=Superior
% Labels for positive direction (v > 0 → index increases toward this end):
posLabels = {'L', 'P', 'H'};   % for LPS X, Y, Z positive
negLabels = {'R', 'A', 'F'};   % for LPS X, Y, Z negative

[~, ax] = max(abs(v));   % dominant LPS axis (1=X, 2=Y, 3=Z)

if v(ax) > 0
    % increasing index → toward positive LPS direction (Left/Post/Sup)
    % label = neg-to-pos, e.g. R-L, A-P, F-H
    lbl = [negLabels{ax} '-' posLabels{ax}];
else
    % increasing index → toward negative LPS direction (Right/Ant/Inf)
    % label = pos-to-neg, e.g. L-R, P-A, H-F
    lbl = [posLabels{ax} '-' negLabels{ax}];
end
end