% View4DCoord - returns the coordinates that the pointer overlaps
% object, hObject.
%
% Usage:
% ------
% [x,y,z] = View4DCoord(hObject) - x, y, and z are the coordinates of
% the point where mouse pointer overlaps with the nearest object in the
% display axis of View4D.
%
% [x,y,z,data] = View4DCoord(hObject) - Also returns the 4th dimension 
% time-activity-curve (TAC) associated with the pixel at the x,y,z 
% coordinates. The data is an 1-by-n array representing the 4th dimension 
% of the data.
%
% This function can be used as part of a callback (set with the 
% PopinterCallback property) from View4D to determine the coordinates of
% the point that the user has clicked with the mouse, as demopnstrated in 
% DisplayPixelCurve.
%
% See also: View4D, DisplayPixelCurve

% By Ran Klein 11/9/2006 - Yes the fifth anniversary to the famous 9/11
% terror attack. 

function [x,y,z,data] = View4DCoord(hObject, eventdata, handles)

if nargin<3
	handles = guidata(hObject);
end

x = getappdata(handles.XAxis,'Slice');
y = getappdata(handles.YAxis,'Slice');
z = getappdata(handles.ZAxis,'Slice');

if nargout>3
	data = getappdata(handles.View4DFigure,'RawData');
	x = min(max(round(x),1),size(data,1));
	y = min(max(round(y),1),size(data,2));
	z = min(max(round(z),1),size(data,3));
	data = reshape(data(x,y,z,:),1,size(data,4));
end