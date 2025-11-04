% updateView4DAlpha - update the alpha mixing between volume 1 and 2 in
% View 4D display
%
% By Ran Klein, The Ottawa Hospital, 2016-12-30

function updateView4DAlpha(hObject, eventdata, handles)
vol2struct = getappdata(handles.View4DFigure,'SecondVolume');
if isempty(vol2struct)
	return;
end

h = [handles.XAxis, handles.YAxis, handles.ZAxis];
for i=1:length(h)
	set(findobj(get(h(i),'Children'),'flat','Tag','image1'),'AlphaData',1-vol2struct.alpha);
	set(findobj(get(h(i),'Children'),'flat','Tag','image2'),'AlphaData',vol2struct.alpha);
end
