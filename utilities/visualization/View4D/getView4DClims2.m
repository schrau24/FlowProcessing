function clim = getView4DClims2(handles)

vol2struct = getappdata(handles.View4DFigure,'SecondVolume');
clim = vol2struct.clim;
% pos = get(handles.Vol2LowerLimitSlider,'ydata');
% lim = pos(4);
% pos = get(handles.Vol2UpperLimitSlider,'ydata');
% lim(2) = pos(4);
% 
% clim(1) = fixClim( interp([0 1], vol2struct.clim, lim) );

function clim = fixCLim(clim)
if clim(1)>=clim(2)
	clim(2) = clim(1)+1;
end