% str = bool2str(d, values) - convertts boolean flags to strings
%
% Usage:
% str = bool2str(h) - str takes the values 'off' or 'on'.
% str = bool2str(h,values) - str takes the values specified in the
% 2X1 cell values, where cell 1 is the 0 value.
% example  str = bool2str(h,{'Yes','No'})
% can be asigned by passing 

% See also: getCheckboxValue

% By Ran Klein 2011-03-31
% Modified:
% 2014-03-03  RK  Added support for cells and matrices.


% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************


function str = bool2str(d, values)

if nargin<2 || isempty(values)
	values = {'off','on'};
end

if length(d)==1
	if isempty(d)
		if length(values)>2
			str = values{3};
		else
			str='';
		end
	else
		str = values{d + 1};
	end
else
	str = cell(size(d));
	for i=1:numel(d);
		if iscell(d)
			str{i} = bool2str(d{i},values);
		else
			str{i} = bool2str(d(i),values);
		end
	end
end

