function [nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadPARREC(directory, filename)
% Get and load input directory

fBase = filename(1:end-5);

warning('off','all');
%% grab each parrec and save corresponding data
disp('Loading data')
PARRECFILE = fullfile(directory,[fBase, '1.rec']);
[IMG,h1] = readrec_V4_2(PARRECFILE);
IMG = single(IMG);
% this is the readout direction
vx = squeeze(IMG(:,:,:,:,:,2,:));
mag1 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;

PARRECFILE = fullfile(directory,[fBase, '2.rec']);
[IMG,h2] = readrec_V4_2(PARRECFILE);
IMG = single(IMG);
% this is the phase direction
vy = squeeze(IMG(:,:,:,:,:,2,:));
mag2 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;

PARRECFILE = fullfile(directory,[fBase, '3.rec']);
[IMG,h3] = readrec_V4_2(PARRECFILE);
IMG = single(IMG);
% this is the slice direction
vz = squeeze(IMG(:,:,:,:,:,2,:));
mag3 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;
warning('on','all');

MAG = double(mean(cat(5,mag1,mag2,mag3),5));
clear mag1 mag2 mag3
vx = double(vx); vy = double(vy); vz = double(vz);

nframes = h3.nphases;                                       % number of reconstructed frames
timeres = max(h3.tbl(:,h3.tblcols.ttime))/nframes;      % temporal resolution, in ms
fov = h3.fov;                                               % Field of view in cm
res = round([h3.nrows h3.ncols h3.nslices]);        % number of pixels in row,col,slices
VENC = max(h3.pevelocity)*10;                               % venc, in mm/s
pixdim = h3.pixdim;                                         % the reconstructed resolution
phasedir = h3.prepdir;

%% manually change velocity directions depending on scan orientations

% velocity directions correspond to the following:
% vx: in-plane up-down
% vy: in-plane right-left
% vz: through-plane
switch h3.tbl(1,26) % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
    case 1
        ori.label = 'axial';
        if strcmp('AP',phasedir)
            ori.vxlabel = 'R-L';
            ori.vylabel = 'A-P';
            tmp = vx; vx = vy; vy = tmp; clear tmp;
        else    % phasedir == 'RL'
            ori.vxlabel = 'A-P';
            ori.vylabel = 'R-L';
        end
        ori.vzlabel = 'F-H';
    case 2
        ori.label = 'sagittal';
        if strcmp('AP',phasedir)
            ori.vxlabel = 'F-H';
            ori.vylabel = 'A-P';
        else    % phasedir == 'FH'
            ori.vxlabel = 'A-P';
            ori.vylabel = 'F-H';
            tmp = vx; vx = vy; vy = tmp; clear tmp;
        end
        ori.vzlabel = 'R-L';
        vx = -vx;
        vz = -vz;
    case 3
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
% scale velocity
v = (v./3142)*VENC;

% take the means
vMean = mean(v,5);
MAG = MAG./max(MAG(:));

[magWeightVel, angio] = calc_angio(MAG, v, VENC);

disp('Load Data finished');
return