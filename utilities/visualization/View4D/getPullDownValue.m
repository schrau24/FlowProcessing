

% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************

function val = getPullDownValue(h)
% GetPullDownValue - returns the value selected in a pulldown object of
% handle h.
%
% Usage:
% ------
% val = getPullDownValue(h)
%
% See also: setPullDownValue

% By Ran Klein, University of Ottawa Heart Institute, 20011-09-16

values = get(h,'String');
if isempty(values)
	val = [];
elseif ~iscell(values)
	val = 1;
else
	val = values{min(length(values),get(h,'Value'))};
end
