function [directory, nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadMrStruct(directory)

warning('off','all');
%% grab each parrec and save corresponding data
disp('Loading data')

% first load magnitude mrStruct
load(fullfile(directory,'mag_struct.mat'));
MAG = mrStruct.dataAy;
MAG = MAG/max(abs(MAG(:)));
% flip z direction
MAG = flip(MAG,3);

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

% velocity directions correspond to the following:
% vx: in-plane up-down
% vy: in-plane right-left
% vz: through-plane
switch mrStruct.orient % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
    case ''     % empty orientation, tell user and set as default (sagittal)
        warning('no orientation in mrStruct, setting to default sagittal')
        ori.label = 'sagittal';
%         vx = -vx;
        vz = -vz;
        ori.vxlabel = 'F-H';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'R-L';
    case 'tra'
        ori.label = 'axial';
        if strcmp('AP',phasedir)
            ori.vxlabel = 'R-L';
            ori.vylabel = 'A-P';
        else    % phasedir == 'RL'
            ori.vxlabel = 'A-P';
            ori.vylabel = 'R-L';
        end
        ori.vzlabel = 'F-H';
    case 'sag'
        ori.label = 'sagittal';
        vx = -vx;
        vz = -vz; 
        if strcmp('AP',phasedir)
            ori.vxlabel = 'F-H';
            ori.vylabel = 'A-P';
        else    % phasedir == 'FH'
            ori.vxlabel = 'A-P';
            ori.vylabel = 'F-H';
        end
        ori.vzlabel = 'R-L';
    case 'cor'
        ori.label = 'coronal';
        vx = -vx;
        if strcmp('RL',phasedir)
            ori.vxlabel = 'F-H';
            ori.vylabel = 'R-L';
        else    % phasedir == 'FH'
            ori.vxlabel = 'R-L';
            ori.vylabel = 'F-H';
        end
        ori.vzlabel = 'A-P';
end

%%
v = cat(5,vx,vy,vz); v = permute(v, [1 2 3 5 4]);
clear vx vy vz
% flip z direction
v = flip(v,3);

% take the means
vMean = mean(v,5);
MAG = MAG./max(MAG(:));

[magWeightVel, angio] = calc_angio(MAG, v, VENC);

disp('Load Data finished');
return