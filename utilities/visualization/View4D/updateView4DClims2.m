function clim = updateView4DClims2(handles)

vol2struct = getappdata(handles.View4DFigure,'SecondVolume');

clim = [getSliderValue(handles.Vol2LowerLimitSlider) getSliderValue(handles.Vol2UpperLimitSlider)];

vol2struct.clim = clim;
setappdata(handles.View4DFigure,'SecondVolume',vol2struct);

function clim = fixCLim(clim)
if clim(1)>=clim(2)
	clim(2) = clim(1)+1;
end