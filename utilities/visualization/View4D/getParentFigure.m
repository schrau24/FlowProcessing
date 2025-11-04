% getParentFigure - returns the handle of the parent figure of a GUI object
% (h)
%
% Usage:
% fig = getParentFigure(h)
%

% By Ran Klein 2014-04-30 with help from Hanif


% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************


function h = getParentFigure(h)

while ~strcmpi(get(h,'type'),'figure')
    h = get(h,'Parent');
end

