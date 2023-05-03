function J = dopplermap(m,iswhite)

%DOPPLERMAP   Color map for color Doppler
%   DOPPLERMAP(M) returns an M-by-3 matrix containing a typical color map
%   used by ultrasound scanners in the color Doppler mode.
%
%   DOPPLERMAP (no input argument) is the same size as the current figure's
%   color map.
%
%   Example:
%   -------
%   P = peaks(256);
%   P = 2*rescale(P)-1;
%   imagesc(P)
%   axis square off
%   colormap dopplermap
%   colorbar
%
%
%   This function is part of MUST (Matlab UltraSound Toolbox).
%   MUST (c) 2020 Damien Garcia, LGPL-3.0-or-later
%
%   See also IQ2DOPPLER.
%
%   -- Damien Garcia -- 2009/05, last update: 2021/07
%   website: <a
%   href="matlab:web('https://www.biomecardio.com')">www.BiomeCardio.com</a>

if nargin < 1
   f = get(groot,'CurrentFigure');
   if isempty(f)
      m = size(get(groot,'DefaultFigureColormap'),1);
   else
      m = size(f.Colormap,1);
   end
end

if nargin<2, iswhite = false; end

if rem(m,2)==0
    x = [linspace(0,.5,m/2) linspace(.5,1,m/2)]';
else
    x = linspace(0,1,m)';
end

% RGB values
R = min(1.8*sqrt(x-0.5),1).*(x>=0.5); % + 0.06*(x<0.5);
G = -8*(x-0.5).^4 + 6*(x-0.5).^2;
B = 1.1*sqrt(0.5-x).*(x<=0.5); % + 0.03*(x>0.5);

% Doppler color map
J = [R G B];

%-- Note:
% This color map was generated from a conventional Doppler map given by a
% clinical scanner. Curve fitting was carried out to extract some equations
% for the R,G,B values.

if iswhite
    J = 1-J;
    J = J.*circshift(tukeywin(m),round(m/2));
    J = 1-J;
end
    


