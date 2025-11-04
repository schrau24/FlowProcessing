function [clim, handles] = updateView4DColorBar(handles)

cmap = get(handles.View4DFigure,'colormap');
[clim, thresholds, dataLim] = getView4DClims(handles);

if ColorbarNotInitialized(handles)
	[handles, thresholds] = initializeColorbar(handles, clim, cmap, thresholds);
else
	steps = size(cmap,1);
	if isempty(clim)
		clim = ylim(handles.CBAxis);
	end
	set(findobj(get(handles.CBAxis,'children'),'flat','type','image'),...
		'cdata',reshape(cmap,steps,1,3),'ydata',linspace(clim(1),clim(2),steps)');
end

% Adjust labels
if get(handles.ISScale,'value')
	set(handles.CBAxis,'YTickLabels',{'min','','max'});
else
	ticks = [dataLim(1); mean(dataLim); dataLim(2)];
	set(handles.CBAxis,'YTick',ticks,'YTickLabels',num2str(ticks,4),'YLim',dataLim);
end

% Enable controls
if get(handles.UScale,'Value')
	setSliderVisibility(handles.VolUpperLimitSlider,'on');
	set(handles.MaxIntEdit,'String', num2str(getSliderValue(handles.VolUpperLimitSlider),4));
	setSliderVisibility(handles.VolLowerLimitSlider, bool2str(~any(strcmpi(getappdata(handles.GDScale,'ScaleLimitsMode'),{'[-max max]','[0 max]'})),{'off','on'}));
	set(handles.MinIntEdit,'String', num2str(getSliderValue(handles.VolLowerLimitSlider),4));
else
	setSliderVisibility(handles.VolUpperLimitSlider, 'off');
	setSliderVisibility(handles.VolLowerLimitSlider, 'off');
end

% Adjust threshold sliders
if isempty(thresholds)
	set([handles.ThresholdLowerSlider, handles.ThresholdUpperSlider],'Visible','Off');
else
	setSliderValue(handles.ThresholdLowerSlider, thresholds(1));
	setSliderValue(handles.ThresholdUpperSlider, thresholds(2));
end

updateView4DSlices(handles);


function answer = ColorbarNotInitialized(handles)
answer = isempty(findobj(get(handles.CBAxis,'children'),'flat','type','image'));


function [handles, thresholds] = initializeColorbar(handles, clim, cmap, thresholds)
steps = size(cmap,1);
vol = getappdata(handles.View4DFigure,'SummedData');
range = [min(vol(:)) max(vol(:))];

sliderSize = 0.02*diff(range);
% create colorbar for the first time
set(0,'CurrentFigure',handles.View4DFigure);
set(handles.View4DFigure,'CurrentAxes', handles.CBAxis);
h=imagesc(0.5,...
	linspace(clim(1),clim(2),steps)',...
	reshape(cmap,steps,1,3));
set(h,'parent', handles.CBAxis,'UIContextMenu',initializeColormapMenu(handles));
set(handles.CBAxis,'xlim',[0 1],...
	'ytick',[range(1) mean(range) range(2)],...
	'xtick',[],...
	'ylim',range,...
	'yDir','normal',...
	'FontSize',8,...
	'tag','CBAxis');

% Add color limit sliders to colorbar
visiblityStatus = bool2str(get(handles.UScale,'Value'),{'Off','On'});
handles.VolLowerLimitSlider = patch([0.5 0.7 1 1 0.7], clim(1)+sliderSize*[0 1 1 -1 -1], [0.7 0.7 0.7],...
	'Parent',handles.CBAxis,...
	'EdgeColor','k','visible',visiblityStatus,...
	'ButtonDownFcn',@SelectCBSlider);
h = text(0,clim(1),num2str(clim(1)),...
	'Parent',handles.CBAxis,...
	'HorizontalAlignment','Right', 'VerticalAlignment','Middle',...
	'Color','k', 'FontSize',8,...
	'Visible',visiblityStatus);
setappdata(handles.VolLowerLimitSlider,'Label',h);
handles.VolUpperLimitSlider = patch([0.5 0.7 1 1 0.7], clim(2)+sliderSize*[0 1 1 -1 -1], [0.7 0.7 0.7],...
	'Parent',handles.CBAxis,...
	'EdgeColor','k','visible',visiblityStatus,...
	'ButtonDownFcn',@SelectCBSlider);
h = text(0,clim(2),num2str(clim(2)),...
	'Parent',handles.CBAxis,...
	'HorizontalAlignment','Right', 'VerticalAlignment','Middle',...
	'Color','k', 'FontSize',8,...
	'Visible',visiblityStatus);
setappdata(handles.VolUpperLimitSlider,'Label',h);

% Add threshold sliders to colorbar
handles.ThresholdLowerSlider = patch([0.5 0.3 0 0 0.3 0.5], clim(1)+sliderSize*[0 -1 -1 1 1 0],[1 0.7 0.7],...
	'Parent',handles.CBAxis,...
	'EdgeColor','k','visible','off',...
	'ButtonDownFcn',@SelectCBSlider);
handles.ThresholdUpperSlider = patch([0.5 0.3 0 0 0.3 0.5], clim(2)+sliderSize*[0 -1 -1 1 1 0],[1 0.7 0.7],...
	'Parent',handles.CBAxis,...
	'EdgeColor','k','visible','off',...
	'ButtonDownFcn',@SelectCBSlider);
if ~isempty(getappdata(handles.CBAxis,'Thresholds'))
	set([handles.ThresholdLowerSlider, handles.ThresholdUpperSlider],'visible','on');
else
	thresholds = interp1([0 1], clim, [0.25 0.75]);
	setappdata(handles.CBAxis,'Thresholds',thresholds); % default value
end
guidata(handles.View4DFigure,handles);

%% Slider mouse select callback function
function SelectCBSlider(hObject, eventdata, handles)
handles = guidata(hObject);
setappdata(handles.View4DFigure,'CurrentObject',hObject);


%% Context menu functions
function cmenu = initializeColormapMenu(handles)
cmenu = uicontextmenu('parent',handles.View4DFigure);
uimenu(cmenu, 'Label', 'Parula', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Jet', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'HSV', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Hot', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Cool', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Spring', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Summer', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Autumn', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Winter', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Copper', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Pink', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'HotMetal', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Bone', 'callback', @setColormap);
uimenu(cmenu, 'Label', 'Gray', 'callback', @setColormap);
		

function setColormap(hObject,event)
handles = guidata(hObject);
setappdata(handles.View4DFigure,'Colormap',get(hObject,'Label'));
updateView4DColormap(hObject,event,handles)