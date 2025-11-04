%HOTMETAL    
%   HOTMETAL(M), creates an RGB interpolated colormap as used by 4DM and GE
%   containing M colors.
%   HOTMETAL, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   See also HSV, HOT, PINK, FLAG, COLORMAP, RGBPLOT.

%  By Ran Klein 2009-07-31


% *******************************************************************************************************************
% *                                                                                                                 *
% * Copyright [2014] Ottawa Heart Institute Research Corporation.                                                   *
% * This software is confidential and may not be copied or distributed without the express written consent of the   *
% * Ottawa Heart Institute Research Corporation.                                                                    *
% *                                                                                                                 *
% *******************************************************************************************************************


function J = hotmetal(m)

if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
J = [0   0   0;...
	 0   48  41;...
	 0   97  90;...
	 16  113 140;...
	 66  65  189;...
	 107 20  239;...
	 156 32  206;...
	 206 85  107;...
	 255 146 8;...
	 255 215 148]/255;
x = 0:1/(length(J)-1):1;
xi = ceil(0:0.5:m-1.5)/(m-1);
%xi = ceil(0:1:m-1)/(m-1); 
%%% Edited by Charles Malo --- 07/08/09---  
%Stepsize edited to have xi and m of same length to avoid memory leaks when applying this colormap
%Recommented out by Ran Klein --07/08/09-- if such memory should occur,
%pass on the same value for m when the call is made, not the size of the
%figure's colormap which is increasing at each call of this colormap.
J = interp1(x ,J, xi);

