% setSliderValue - set the position of a slider control for a value. Also
% updates its text label, if one exists.
%
% See also: getSliderValue

% By Ran Klein 2017-02-25

function setSliderValue(h, val)
pos = get(h,'YData');
set(h,'Ydata',pos-pos(1)+val);
hLabel = getappdata(h,'Label');
if ~isempty(hLabel)
	pos = get(hLabel,'Position');
	pos(2) = val;
	set(hLabel,'Position',pos,'String',num2str(val,4));
end