function vol2struct = updateView4DColormap2(hObject, eventdata, handles)

if nargin<3
	handles = guidata(hObject);
end

vol2struct = getappdata(handles.View4DFigure,'SecondVolume');
if isempty(vol2struct)
	return;
end

clim = getView4DClims2(handles);

ha = get(hObject,'Parent');
if ha == handles.CB2Axis
	pos = get(ha,'CurrentPoint');
	ylim = get(ha,'ylim');
	pos = max(ylim(1),min(ylim(2),pos(3)));
	oldPos = get(hObject,'ydata');
	
	switch hObject
		case handles.Vol2LowerLimitSlider
			pos2 = getSliderValue(handles.Vol2UpperLimitSlider);
			pos(1) = min(pos,pos2);
		case handles.Vol2UpperLimitSlider
			pos2 = getSliderValue(handles.Vol2LowerLimitSlider);
			pos = max(pos,pos2);
		otherwise
	end
	setSliderValue(hObject, pos);
	clim = updateView4DClims2(handles);
	vol2struct.clim = clim;
end

% get colormap
vol2struct.cmap=feval(lower(vol2struct.colormap),128);
% colormap inverted?
if get(handles.Colormap2Inverse,'value')
	vol2struct.cmap = flipud(vol2struct.cmap);
end

setappdata(handles.View4DFigure,'SecondVolume',vol2struct);

updateView4DColorBar2(handles, vol2struct.cmap);
