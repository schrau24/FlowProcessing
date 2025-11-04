function updateView4DColormap(hObject, eventdata, handles)

if nargin<3
	handles = guidata(hObject);
end

[clim, thresholds] = getView4DClims(handles);

ha = get(hObject,'Parent');
if ha == handles.CBAxis
	pos = get(ha,'CurrentPoint');
	ylim = get(ha,'ylim');
	pos = max(ylim(1),min(ylim(2),pos(3)));
	oldPos = get(hObject,'ydata');
	
	switch hObject
		case handles.VolLowerLimitSlider
			pos2 = getSliderValue(handles.VolUpperLimitSlider);
			pos = min(pos,pos2);
			set(handles.MinIntEdit,'string',num2str(pos));
		case handles.VolUpperLimitSlider
			pos2 = getSliderValue(handles.VolLowerLimitSlider);
			pos = max(pos,pos2);
			set(handles.MaxIntEdit,'string',num2str(pos));
			if strcmpi(getappdata(handles.GDScale,'ScaleLimitsMode'),'[-max max]')
				set(handles.VolLowerLimitText,'Position',[0 -pos 0],'string',num2str(-pos,4));
				set(handles.MinIntEdit,'string',num2str(-pos));
				pos2 = get(handles.VolLowerLimitSlider,'YData');
				set(handles.VolLowerLimitSlider,'YData',pos2-pos2(1)-pos);
			end
		case handles.ThresholdLowerSlider
			pos2 = getSliderValue(handles.ThresholdUpperSlider);
			thresholds(1) = min(pos,pos2);
			setappdata(ha,'Thresholds',thresholds);
		case handles.ThresholdUpperSlider
			pos2 = getSliderValue(handles.ThresholdLowerSlider);
			thresholds(2) = max(pos,pos2);
			setappdata(ha,'Thresholds',thresholds);
	end
	setSliderValue(hObject,pos);
end

% get colormap
cmap=feval(lower(getappdata(handles.View4DFigure,'Colormap')),128);
% colormap inverted?
if get(handles.ColormapInverse,'value')
	cmap = flipud(cmap);
end
% colormap with thresholds?
if get(handles.ThresholdCheckbox,'Value') && ~isempty(thresholds)
	set([handles.ThresholdLowerSlider, handles.ThresholdUpperSlider],'visible','on');
	thresholds = round(interp1(clim, [1 size(cmap,1)], thresholds));
	if isnan(thresholds(1)), thresholds(1)=1; end
	if isnan(thresholds(2)), thresholds(2)=size(cmap,1); end
	cmap(thresholds(1):thresholds(2),:) = ones(diff(thresholds)+1,1) * [1 0 0];
elseif isfield(handles,'ThresholdLowerSlider')
	set([handles.ThresholdLowerSlider, handles.ThresholdUpperSlider],'visible','off');
end
set(handles.View4DFigure,'colormap',cmap);

updateView4DColorBar(handles);
