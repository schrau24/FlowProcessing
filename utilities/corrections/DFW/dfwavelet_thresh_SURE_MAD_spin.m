% [vx,vy,vz] = dfwavelet_thresh_SURE_MAD_spin(vx,vy,vz,minSize,res,spins,isRand)
%
% Divergence-free wavelet denoising using Sure-based threhsold, MAD and
% cycle spinning
% 
% Inputs: 
%     vx,vy,vz    -   velocity data
%     minSize     -   minimum size for the wavelet scaling subband
%     res         -   resolution (a 1x3 array)
%     spins       -   log2(number of cycle spinning),(spins=3 equals 8 shifts)
%     isRand      -   specify whether the cycle spinning is random
%
% Outputs:
%     vx,vy,vz    -   denoised velocity data
%
%