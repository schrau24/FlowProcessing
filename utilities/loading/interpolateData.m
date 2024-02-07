function [newIMGSize, MAG, v, varargout] = interpolateData(interpRes,pixdim,MAG,v,varargin)

% when interpolate data button is pressed, interpolate to the desired
% resolution

% first magnitude data
tmp = MAG;
sizeA = size(tmp);

newPixDim = [interpRes interpRes interpRes];
newIMGSize = floor(sizeA(1:3).*(pixdim./newPixDim));

F = griddedInterpolant(tmp);
TMPinterp=F({linspace(1,sizeA(1),newIMGSize(1)),...
    linspace(1,sizeA(2),newIMGSize(2)),...
    linspace(1,sizeA(3),newIMGSize(3)),...
    1:sizeA(4)});

MAG = TMPinterp;
clearvars tmp TMPinterp

% velocity data
tmp = v;
sizeA = size(tmp);

F = griddedInterpolant(tmp);
TMPinterp=F({linspace(1,sizeA(1),newIMGSize(1)),...
    linspace(1,sizeA(2),newIMGSize(2)),...
    linspace(1,sizeA(3),newIMGSize(3)),...
    1:sizeA(4), 1:sizeA(5)});

v = TMPinterp;
clearvars tmp TMPinterp

% and the segmentation, if loaded
if ~isempty(varargin)
    tmp = varargin{1};
    sizeA = size(tmp);
    
    F = griddedInterpolant(tmp);
    TMPinterp=F({linspace(1,sizeA(1),newIMGSize(1)),...
        linspace(1,sizeA(2),newIMGSize(2)),...
        linspace(1,sizeA(3),newIMGSize(3))});
    
    varargout{1} = TMPinterp;
    clearvars tmp TMPinterp
end