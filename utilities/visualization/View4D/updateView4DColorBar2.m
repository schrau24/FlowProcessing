function clim = updateView4DColorBar2(handles, cmap)

clim = getView4DClims2(handles);
	
if ColorbarNotInitialized(handles)
	handles = initializeColorbar(handles, clim, cmap);
else
	steps = size(cmap,1);
	set(findobj(get(handles.CB2Axis,'children'),'flat','type','image'),...
		'cdata',reshape(cmap,steps,1,3),'ydata',linspace(clim(1),clim(2),steps)');
end

updateView4DSlices(handles);



function answer = ColorbarNotInitialized(handles)
answer = isempty(findobj(get(handles.CB2Axis,'children'),'flat','type','image'));


function handles = initializeColorbar(handles, clim, cmap, thresholds)
steps = size(cmap,1);
vol2struct = getappdata(handles.View4DFigure,'SecondVolume');
range = [min(vol2struct.vol(:)) max(vol2struct.vol(:))];

sliderSize = 0.02*diff(range);
% create colorbar for the first time
set(0,'CurrentFigure',handles.View4DFigure);
set(handles.View4DFigure,'CurrentAxes', handles.CB2Axis);
h=image(0.5,...
	linspace(clim(1),clim(2),steps)',...
	reshape(cmap,steps,1,3));
set(h,'parent', handles.CB2Axis,'UIContextMenu',initializeColormap2Menu(handles));
set(handles.CB2Axis,'xtick',[],...
	'ytick',[range(1) mean(range) range(2)],...
	'ylim',range,...
	'yDir','normal',...
	'YAxisLocation','right',...
	'FontSize',8,...
	'tag','CB2Axis');

% Add color limit sliders to colorbar
handles.Vol2LowerLimitSlider = patch([0.5 0.7 1 1 0.7], clim(1)+sliderSize*[0 1 1 -1 -1], [0.7 0.7 0.7],...
	'Parent',handles.CB2Axis,...
	'EdgeColor','k','visible','on',...
	'ButtonDownFcn',@SelectCB2Slider);
h = text(1,clim(1),num2str(clim(1)),...
	'Parent',handles.CB2Axis,...
	'HorizontalAlignment','Left', 'VerticalAlignment','Middle',...
	'Color','k', 'FontSize',8);
setappdata(handles.Vol2LowerLimitSlider,'Label',h);

handles.Vol2UpperLimitSlider = patch([0.5 0.7 1 1 0.7], clim(2)+sliderSize*[0 1 1 -1 -1], [0.7 0.7 0.7],...
	'Parent',handles.CB2Axis,...
	'EdgeColor','k','visible','on',...
	'ButtonDownFcn',@SelectCB2Slider);
h = text(1,clim(2),num2str(clim(2)),...
	'Parent',handles.CB2Axis,...
	'HorizontalAlignment','Left', 'VerticalAlignment','Middle',...
	'Color','k', 'FontSize',8);
setappdata(handles.Vol2UpperLimitSlider,'Label',h);

guidata(handles.View4DFigure,handles);


function SelectCB2Slider(hObject, eventdata, handles)
handles = guidata(hObject);
setappdata(handles.View4DFigure,'CurrentObject',hObject);

%% Context menu functions
function cmenu = initializeColormap2Menu(handles)
cmenu = uicontextmenu('parent',handles.View4DFigure);
uimenu(cmenu, 'Label', 'Parula', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Jet', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'HSV', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Hot', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Cool', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Spring', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Summer', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Autumn', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Winter', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Copper', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Pink', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'HotMetal', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Bone', 'callback', @setColormap2);
uimenu(cmenu, 'Label', 'Gray', 'callback', @setColormap2);
		

function setColormap2(hObject,event)
handles = guidata(hObject);
vol2struct = getappdata(handles.View4DFigure,'SecondVolume');
vol2struct.colormap = get(hObject,'Label');
setappdata(handles.View4DFigure,'SecondVolume',vol2struct);
updateView4DColormap2(hObject,event,handles);