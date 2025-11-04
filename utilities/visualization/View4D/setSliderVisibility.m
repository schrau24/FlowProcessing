% setSliderVisibility - set the visibilty of a slider control and its text 
% label, if one exists.
%
% See also: getSliderValue, setSliderValue

% By Ran Klein 2017-02-25

function setSliderVisibility(h, val)
set(h,'Visible',val);
hLabel = getappdata(h,'Label');
if ~isempty(hLabel)
	set(hLabel,'Visible',val);
end