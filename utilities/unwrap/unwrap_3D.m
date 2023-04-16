function nr = unwrap_3D(phi_w, real_flag)
%% UNWRAP_3D Unwraps a 3d array
%
% Args:
%     phi_w: Wrapped input array (-pi to pi) 
%     real_flag: restrcit laplacians to real (doesn't really matter, but
%     this lowers the memory load)
% 
% Returns:
%     nr: integer array containing the NUMBER of wraps per voxel
%         (note that this is not the actual unwrapped data)

if (nargin < 2), real_flag = 1; end

[X Y Z] = ndgrid(single(-size(phi_w,1)/2:size(phi_w,1)/2-1), ...
                 single(-size(phi_w,2)/2:size(phi_w,2)/2-1), ...
                 single(-size(phi_w,3)/2:size(phi_w,3)/2-1));

mod = 2.*cos(pi*X./size(phi_w,1)) + 2.*cos(pi*Y./size(phi_w,2)) + ...
      2.*cos(pi*Z./size(phi_w,3)) - 6;

clear X Y Z

lap_phiw = lap3(phi_w,1,mod,real_flag);
lap_phi = cos(phi_w).*lap3(sin(phi_w),1,mod,real_flag) - sin(phi_w).*lap3(cos(phi_w),1,mod,real_flag);
ilap_phidiff = (lap3(lap_phi-lap_phiw,-1,mod,real_flag));
nr = int8(round(ilap_phidiff./2./pi));