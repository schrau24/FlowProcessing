% INTERPMESH - interpolates y and z cordinates in the x plane for a
% mesh that is defined by points X, Y, and Z
%
% [y,z,x] = interpMesh(X,Y,Z,x)
%
% Used to display intersection of a mesh with an volume slice in View4D.
%
% See also: updateView4DSlices

% By Ran Klein, University of Ottawa Heart Institue, 2008-03-18
% Modified:
% 2011-10-07  RK  Added mode input varaible and implemented 'mesh' and
%                 'cloud' modes.

% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************


function [y,z,x] = interpMesh(X,Y,Z,x,mode)

if nargin<5
	mode = 'MESH';
end

switch upper(mode)
	case 'MESH'
		y = []; z = [];
		for j=1:size(X,2)
			for i = 1:size(X,1)
				if i<size(X,1) && any(X(i:i+1,j)>=x) && any(X(i:i+1,j)<x)
					y = [y interp1(X(i:i+1,j),Y(i:i+1,j),x)];
					z = [z interp1(X(i:i+1,j),Z(i:i+1,j),x)];
				elseif j<size(X,2) && any(X(i,j:j+1)>=x) && any(X(i,j:j+1)<x)
					y = [y interp1(X(i,j:j+1),Y(i,j:j+1),x)];
					z = [z interp1(X(i,j:j+1),Z(i,j:j+1),x)];
				end
			end
		end
		if length(y)>2
			y0 = mean(y);
			z0 = mean(z);
			theta = cart2pol(y-y0, z-z0);
			[junk, i] = sort(theta);
			y = y(i);
			z = z(i);
			dist = (y(1:end-1)-y(2:end)).^2 + (z(1:end-1)-z(2:end)).^2;
			i = find(dist==max(dist),1);
			y = [y(i+1:end) y(1:i)];
			z = [z(i+1:end) z(1:i)];
		end
	case {'CLOUD','PLOT'}
		mask = X>x-0.5 & X<=x+0.5;
		y = Y(mask);
		z = Z(mask);
	otherwise
		error(['Unrecognized mesh interpolation mode: ' mode])
end

if nargout>2
	x = x*ones(size(y));
end