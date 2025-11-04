% SETPULLDOWNVALUE - sets the value in a pulldown menu.
%
% setPullDownValue(h,val) - set the value of the object h to the value
% specified by val. val can be:
%  - an index into the pulldown
%  - the string entry of the pull down
% if no match is found, or the value is out of range, entry 1 is set as the
% default value and the requested value is stored in the 'UserData' object
% property.

% By Ran Klein, University of Ottawa Heart Institute, 2007-03-12


% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************


function setPullDownValue(h,val)

values = get(h,'String'); % All possible entries
% A string?
if ischar(val)
	i = find(strcmpi(values,val));
	if isempty(i) % String does not exist in pulldown?
		ind = str2double(val); % is string an index to the pulldown
		if ~isempty(ind) && ind>=1 && ind<=length(values) % that is in range
			set(h,'Value',ind)
			set(h,'UserData',''); % no "failed attempt value"
		else
			set(h,'Value',1); % Set default entry
			set(h,'UserData',val); % keep the "failed attempt value"
		end
	else
		set(h,'Value',i(1));			
		set(h,'UserData',''); % no "failed attempt value"
	end
else % value is a number
	if ~isempty(val) && val>=1 && val<=length(values) % that is in range
		set(h,'Value',val);		
		set(h,'UserData',''); % no "failed attempt value"
	else
		set(h,'Value',1); % Set default entry		
		set(h,'UserData',val); % keep the "failed attempt value"
	end
end