function nr = unwrap_4D(phi_w, ts, real_flag)
%% UNWRAP_4D Unwraps a 4d array
%
% Args:
%     phi_w: Wrapped input array (-pi to pi) 
%     ts: Scales the temporal data to spatial dimensions
%     real_flag: restrcit laplacians to real (doesn't really matter, but
%     this lowers the memory load)
% 
% Returns:
%     nr: integer array containing the NUMBER of wraps per voxel
%         (note that this is not the actual unwrapped data)

if (nargin < 2), ts = 2; end
if (nargin < 3), real_flag = 1; end

[X Y Z T] = ndgrid(single(-size(phi_w,1)/2:size(phi_w,1)/2-1), ...
                   single(-size(phi_w,2)/2:size(phi_w,2)/2-1), ...
                   single(-size(phi_w,3)/2:size(phi_w,3)/2-1), ...
                   single(-size(phi_w,4)/2:size(phi_w,4)/2-1));
mod = 2.*cos(pi*X./size(phi_w,1)) + 2.*cos(pi*Y./size(phi_w,2)) + ...
      2.*cos(pi*Z./size(phi_w,3)) + ts.*cos(pi*T./size(phi_w,4))  - 6 - ts;

clear X Y Z T

lap_phiw = lap4(phi_w,1,mod,real_flag);
lap_phi = cos(phi_w).*lap4(sin(phi_w),1,mod,real_flag) - sin(phi_w).*lap4(cos(phi_w),1,mod,real_flag);
ilap_phidiff = (lap4(lap_phi-lap_phiw,-1,mod,real_flag));
nr = int8(round(ilap_phidiff./2./pi));