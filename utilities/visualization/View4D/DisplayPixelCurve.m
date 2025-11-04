% Example callback function for View4D display. Triggered when selecting a
% pixel in one of the images. Must be configured by setting the
% 'PointerCallback' property of View4D.
% Example: View4D(vol,[], 'PointerCallback', 'DisplayPixelCurve', ...)
%
% This example sets up another figure with the pixel time-activity-curve
% (TAC) plotted. The figure is created when a pixel is selected for the 
% first time and then gets updated on every subsequent selection. The new 
% figure is associated with the View4D figure so that when the View4D 
% figure is closed, so is the new figure.
%
% Use View4DCoord to get the pixel coordinates and the 4th dimension array
% of the corrisponding pixel.
%
% Usage:
% ------
% DisplayPixelCurve(hObject,eventdata,handles) - where hObject triggered the
% pixel selection, eventdata contains any callback data about the event,
% and handles is the View4D GUI handles structure.
%
% See also: View4DCoord, View4D

% By Ran Klein, University of Ottawa Heart Institute, 2013-12-04

function DisplayPixelCurve(hObject, eventdata, handles)

%% Find the TAC figure
fig = findobj(get(0,'children'),'tag','PixelCurveDisplay');

%% Figure doesn't exist - create it below View4D figure.
if isempty(fig)
	View4DFig = getParentFigure(hObject);
	set(View4DFig,'Units','Normalized');
	pos = get(View4DFig,'Position');
	pos(4) = 0.2;
	pos(2) = pos(2)-pos(4);
	fig = figure('tag','PixelCurveDisplay','Units','Normalized');
	drawnow;
	set(fig,'Position',pos);
	
	% add fig to list of View4D children objects so that is closed when
	% View4D figure is closed.
	setappdata(View4DFig,'ChildObjects',[fig	getappdata(View4DFig,'ChildObjects')]);
	
	% make View4D figure the active figure again
	figure(View4DFig); 
end
[x,y,z,pCurve] = View4DCoord(hObject,eventdata,handles);
clf(fig); ah = axes; set(ah,'parent',fig);
plot(ah,pCurve); 
title(ah,['(' num2str(x) ', ',num2str(y) ', ' num2str(z) ')']);




function fig = getParentFigure(fig)
% if the object is a figure or figure descendent, return the
% figure.  Otherwise return [].
while ~isempty(fig) && ~strcmp('figure', get(fig,'Type'))
  fig = get(fig,'Parent');
end
