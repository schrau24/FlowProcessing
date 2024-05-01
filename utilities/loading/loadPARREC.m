function [directory, nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadPARREC()
% Get and load input directory

[filename,directory] = uigetfile('*.rec','Select Reconstructed Data');
fBase = filename(1:end-5);

warning('off','all');
%% grab each parrec and save corresponding data
disp('Loading data')
PARRECFILE = fullfile(directory,[fBase, '1.rec']);
[IMG,~] = readrec_V4_2(PARRECFILE,'quiet');
IMG = single(IMG);
% this is the readout direction
vx = squeeze(IMG(:,:,:,:,:,2,:));  
mag1 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;

PARRECFILE = fullfile(directory,[fBase, '2.rec']);
[IMG,~] = readrec_V4_2(PARRECFILE,'quiet');
IMG = single(IMG);
% this is the phase direction
vy = squeeze(IMG(:,:,:,:,:,2,:));
mag2 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;

PARRECFILE = fullfile(directory,[fBase, '3.rec']);
[IMG,header] = readrec_V4_2(PARRECFILE,'quiet');
IMG = single(IMG);
% this is the slice direction
vz = squeeze(IMG(:,:,:,:,:,2,:));
mag3 = squeeze(IMG(:,:,:,:,:,1,:)); clear IMG;
warning('on','all');

MAG = double(mean(cat(5,mag1,mag2,mag3),5));
clear mag1 mag2 mag3
vx = double(vx); vy = double(vy); vz = double(vz);

nframes = header.nphases;                                       % number of reconstructed frames
timeres = max(header.tbl(:,header.tblcols.ttime))/nframes;      % temporal resolution, in ms
fov = header.fov;                                               % Field of view in cm
res = round([header.nrows header.ncols header.nslices]);        % number of pixels in row,col,slices
VENC = max(header.pevelocity)*10;                               % venc, in mm/s
pixdim = header.pixdim;                                         % the reconstructed resolution
ori = header.tbl(1,26);                                         % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
phasedir = header.prepdir;

%% manually change velocity directions depending on scan orientations
% sagittal aortic scan with phase direction = AP
if (ori == 2 && strcmp('AP',phasedir))
    vx = -vx;
    vz = -vz;
end

% coronal carotid scan with phase direction = RL
if (ori == 3 && strcmp('RL',phasedir))
    vx = -vx;
    vz = -vz;
end

% axial brain scan with phase direction = RL
if (ori == 1 && strcmp('RL',phasedir))
    vx = -vx;
    vy = -vy;
    vz = -vz;
end

% axial whole-heart scan
if (ori == 1 && strcmp('AP',phasedir))
    % do nothing!
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