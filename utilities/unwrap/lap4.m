function out = lap4(in, dir, mod, real_flag)
%% LAP4 Runs 4D laplacian on input matrix
% 
% Args:
%     in: 4D input array
%     dir: forward or inverse transform (1 or -1)
%     mod: Laplaican kernel in frequency space
%     real_flag: restrict output to real (doesn't really matter, but this
%                lowers the memory load)
% 
% Returns:
%     out: output matrix


if (nargin < 4), real_flag = 0; end

[sx sy sz st] = size(in);

K = fftshift(fftn(ifftshift(in)));

if (dir==1)
    K = K.*mod;
elseif (dir==-1)
    mod(floor(sx/2)+1,floor(sy/2)+1,floor(sz/2)+1,floor(st/2)+1) = 1;
    K = K./mod;
else
    disp('ERROR')
end

if real_flag
    out = real(fftshift(ifftn(ifftshift(K))));
else
    out = fftshift(ifftn(ifftshift(K)));
end