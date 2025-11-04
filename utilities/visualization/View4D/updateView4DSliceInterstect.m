% updateView4DSliceInterstect - updates the intersection point and
% associated display in View4D.
%
% Usage:
% ------
% updateView4DSliceInterstect(hObject)
% updateView4DSliceInterstect(hObject, eventdata, handles)
%
% See also: View4D, initializeView4D

% By Ran Klein, University of Ottawa Heart Institute, 2013-05-30
% Code was part of View4D Axis_ButtonDownFcn but was seperated out so can
% drag the pointer around and have updating cross section.

function updateView4DSliceInterstect(hObject, eventdata, handles)

if nargin<3
	handles = guidata(hObject);
end

pos = get(hObject,'CurrentPoint');
s = axis(hObject);
pos = min([[floor(s(2)) floor(s(4))];max(1,round(pos(1,1:2)))],[],1);
switch hObject
	case handles.XAxis
		setappdata(handles.YAxis,'Slice',pos(1));
		setappdata(handles.ZAxis,'Slice',pos(2));
	case handles.YAxis
		setappdata(handles.XAxis,'Slice',pos(2));
		setappdata(handles.ZAxis,'Slice',pos(1));
	case handles.ZAxis
		setappdata(handles.XAxis,'Slice',pos(2));
		setappdata(handles.YAxis,'Slice',pos(1));
	otherwise
		error('How the f#$@ did we get here???!?!?!?')
end
updateView4DSlices(handles);