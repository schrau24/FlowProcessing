function viscosities = CarreauYasudaViscosity(obj)
% returns viscosity for each shear rate at the vessel wall.
% viscosity based on Carreau-Yasuda model with following
% parameters:
%  Vo - newtonian viscosity: 0.25 Pa.s
%  Vinf - viscosity: 0.0035 Pa.s
%  K - constant: 25
%  n - constant: .25
shearrates = sqrt(sum(obj.shearrates.^2,2));
Vo   = 0.25;   % (Newtonian viscosity)
Vinf = 0.0035; % (Viscosity)
K    = 25;     %
n    = 0.25;   %

viscosities = Vinf + (Vo-Vinf).*(1 + K^2 .* shearrates.^2 ).^((n-1)/2);
viscosities = repmat(viscosities,[1 size(obj.shearrates,2)]);
end
