function [directory, nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadMrStruct(directory)

warning('off','all');
%% grab each parrec and save corresponding data
disp('Loading data')

% first load magnitude mrStruct
load(fullfile(directory,'mag_struct.mat'));
MAG = mrStruct.dataAy;
MAG = MAG/max(abs(MAG(:)));

% load velocity
load(fullfile(directory,'vel_struct.mat'));
vx = double(squeeze(mrStruct.dataAy(:,:,:,1,:)))*1e3; % in mm/s
vy = double(squeeze(mrStruct.dataAy(:,:,:,2,:)))*1e3; % in mm/s
vz = double(squeeze(mrStruct.dataAy(:,:,:,3,:)))*1e3; % in mm/s
warning('on','all');

nframes = size(MAG,4);                              % number of reconstructed frames
timeres = mrStruct.user.TD;                         % temporal resolution, in ms
res = size(MAG,1:3);                                % number of pixels in row,col,slices
VENC = mrStruct.user.venc_in_plane*10;              % venc, in mm/s
pixdim = mrStruct.vox(1:3);                         % the reconstructed resolution
fov = pixdim.*res/10;                               % Field of view in cm

%% manually change velocity directions depending on scan orientations
% velocity directions: vx=in-plane up-down (rows), vy=in-plane left-right (cols), vz=through-plane

switch mrStruct.orient
    case ''     % empty orientation — default to sagittal
        warning('no orientation in mrStruct, setting to default sagittal')
        ori.label   = 'sagittal';
%         vy = -vy;
%         vz = -vz;
        ori.vxlabel = 'H-F';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'L-R';

    case 'tra'
        ori.label   = 'axial';
        % mrStruct transverse: rows = R-L, cols = A-P, slices = F-H
        % phasedir not available in mrStruct — use default layout
        ori.vxlabel = 'R-L';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'F-H';

    case 'sag'
        ori.label   = 'sagittal';
        vy = -vy;
        vz = -vz;
        ori.vxlabel = 'H-F';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'L-R';


    case 'cor'
        ori.label   = 'coronal';
        vx = -vx;
        % mrStruct coronal: rows = F-H, cols = R-L, slices = A-P
        ori.vxlabel = 'F-H';
        ori.vylabel = 'R-L';
        ori.vzlabel = 'A-P';
end

%%
v = cat(5,vx,vy,vz); v = permute(v, [1 2 3 5 4]);
clear vx vy vz

MAG = flip(MAG,3);
v = flip(v,3);

% take the means
vMean = mean(v,5);
MAG = MAG./max(MAG(:));

[magWeightVel, angio] = calc_angio(MAG, v, VENC);

disp('Load Data finished');
return