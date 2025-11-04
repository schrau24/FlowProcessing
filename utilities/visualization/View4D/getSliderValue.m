% getSliderValue - get the position of a slider control.
%
% See also: setSliderValue

% By Ran Klein 2017-02-25

function val = getSliderValue(h)
pos = get(h,'YData');
val = pos(1);