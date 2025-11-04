% Example callback function for View4D display. Triggered when pressing a 
% key that is not already defined. Must be configured by setting the
% 'KeyPressFunc' property of View4D.
% Example: View4D(vol,[], 'KeyPressFunc', 'SphereKeyPressFunc', ...)
%
% This example sets draws a yellow 5 pisel radius sphere contour on the 
% display (like an ROI) when the s key is pressed.
%
% Use View4DCoord to get the pixel coordinates and then create a spherical
% contour around that point. Will add the contour to already existing ones.
%
% Usage:
% ------
% SphereKeyPressFunc(hObject,eventdata,handles) - where hObject triggered 
% the key press function, key contains the key that was pressed,
% and handles is the View4D GUI handles structure.
%
% See also: View4DCoord, View4D

% By Ran Klein, The Ottawa Hospital, 2017-10-17

function SphereKeyPressFunc(hObject, key, handles)
switch key
	case {'s','S'}
		radius = 5;
		[x,y,z] = View4DCoord(hObject,'',handles);
		[alpha, theta] = meshgrid((0:10:360)/180*pi, (-90:10:90)/180*pi);
		z = z + radius*sin(theta);
		x = x + radius*cos(theta).*sin(alpha);
		y = y + radius*cos(theta).*cos(alpha);
		sphereContour = struct('X',y, 'Y',x, 'Z',z, 'LineStyle','-y','Type','Mesh'); % x and y coordinates swapped on purpose to conform with internal notation - TO DO: need to fix!!!!
		contours = [getappdata(handles.View4DFigure, 'Contour'), sphereContour];
		setappdata(handles.View4DFigure, 'Contour', contours);
		updateView4DSlices(handles);
end