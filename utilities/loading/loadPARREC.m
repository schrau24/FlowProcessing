function [nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadPARREC(directory, filename)
% Get and load input directory

fBase = filename(1:end-5);

warning('off','all');
% find all reconstructions in the same folder
files = dir([directory, fBase, '*.par']);
% quickly load in headers to parse data type
keepPar = zeros(size(files));
delayedReconFlag = 0;
for ii = 1:length(files)
    [~,h] = readrec_V4_2(fullfile(files(ii).folder,files(ii).name),'quiet','par');
    if unique(h.tbl(:,5)) == 0  % we only have type = MAG
        if sum(unique(h.tbl(:,6)) == [2;4]) == 2    % we have magnitude and pcmra, this is a delayed recon
            delayedReconFlag = 1; keepPar(ii) = 2;
        end
    else
        keepPar(ii) = 1;
    end
end

%% grab each parrec and save corresponding data
disp('Loading data')
if delayedReconFlag
    for ii = 1:length(files)
        if keepPar(ii) > 0
            if keepPar(ii) == 2
                PARRECFILE = fullfile(directory,files(ii).name);
                [IMG,h1] = readrec_V4_2(PARRECFILE);
                MAG = double(squeeze(IMG(:,:,:,:,:,1,:))); clear IMG;
            else
                PARRECFILE = fullfile(directory,files(ii).name);
                [IMG,h3] = readrec_V4_2(PARRECFILE);
                [~,I] = max(h3.pevelocity);
                switch I
                    case 1  % measurement direction velocity, in mm/s
                        vx = squeeze(double(IMG))*10;
                    case 2  % phase direction velocity, in mm/s
                        vy = squeeze(double(IMG))*10;
                    case 3  % slice direction velocity, in mm/s
                        vz = squeeze(double(IMG))*10;
                end
            end
        end
    end
else
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
end

nframes = h3.nphases;                                       % number of reconstructed frames
timeres = max(h3.tbl(:,h3.tblcols.ttime))/nframes;          % temporal resolution, in ms
fov = h3.fov;                                               % Field of view in cm
res = round([h3.nrows h3.ncols h3.nslices]);                % number of pixels in row,col,slices
VENC = max(h3.pevelocity)*10;                               % venc, in mm/s
pixdim = h3.pixdim;                                         % the reconstructed resolution
phasedir = h3.prepdir;
if strcmp(phasedir,'Anterior-Posterior')
    phasedir = 'AP';
end
if strcmp(phasedir,'Right-Left')
    phasedir = 'RL';
end
if strcmp(phasedir,'Foot-Head')
    phasedir = 'FH';
end
angulations = h3.tbl(1,17:19);                              % the rotated axis, ap, fh, rl

%% manually change velocity directions depending on scan orientations

% velocity directions correspond to the following:
% vx: in-plane up-down
% vy: in-plane right-left
% vz: through-plane
if delayedReconFlag
    switch h3.tbl(1,26) % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
        case 1
            ori.label = 'axial';
            angulations = [angulations(3) angulations(1) angulations(2)]; % rl, ap, fh
            if strcmp('AP',phasedir)
                ori.vxlabel = 'R-L';
                ori.vylabel = 'A-P';
                tmp = vx; vx = vy; vy = tmp; clear tmp;
            else    % phasedir == 'RL'
                ori.vxlabel = 'A-P';
                ori.vylabel = 'R-L';
                angulations = [angulations(2) angulations(1) angulations(3)]; % ap, rl, fh
            end
            ori.vzlabel = 'F-H';
        case 2
            ori.label = 'sagittal';
            angulations = [angulations(2) angulations(1) angulations(3)]; % fh, ap, rl
            if strcmp('AP',phasedir)
                ori.vxlabel = 'F-H';
                ori.vylabel = 'A-P';
            else    % phasedir == 'FH'
                ori.vxlabel = 'A-P';
                ori.vylabel = 'F-H';
                angulations = [angulations(2) angulations(1) angulations(3)]; % ap, fh, rl
            end
            tmp = vx; vx = vz; vz = tmp; clear tmp;
            vx = -vx;
            ori.vzlabel = 'R-L';
        case 3
            ori.label = 'coronal';
            angulations = [angulations(2) angulations(3) angulations(1)]; % fh, rl, ap
            if strcmp('RL',phasedir)
                ori.vxlabel = 'F-H';
                ori.vylabel = 'R-L';
            else    % phasedir == 'FH'
                ori.vxlabel = 'R-L';
                ori.vylabel = 'F-H';
                angulations = [angulations(2) angulations(1) angulations(3)]; % rl, fh, ap
            end
            tmp = vx; vx = vz; tmp2 = vy; vy = tmp; vz = tmp2; clear tmp tmp2;
            ori.vzlabel = 'A-P';
            vx = -vx;
%             vz = -vz;
    end
else
    switch h3.tbl(1,26) % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
        case 1
            ori.label = 'axial';
            angulations = [angulations(3) angulations(1) angulations(2)]; % rl, ap, fh
            if strcmp('AP',phasedir)
                ori.vxlabel = 'R-L';
                ori.vylabel = 'A-P';
                tmp = vx; vx = vy; vy = tmp; clear tmp;
            else    % phasedir == 'RL'
                ori.vxlabel = 'A-P';
                ori.vylabel = 'R-L';
                angulations = [angulations(2) angulations(1) angulations(3)]; % ap, rl, fh
            end
            ori.vzlabel = 'F-H';
        case 2
            ori.label = 'sagittal';
            angulations = [angulations(2) angulations(1) angulations(3)]; % fh, ap, rl
            if strcmp('AP',phasedir)
                ori.vxlabel = 'F-H';
                ori.vylabel = 'A-P';
            else    % phasedir == 'FH'
                ori.vxlabel = 'A-P';
                ori.vylabel = 'F-H';
                tmp = vx; vx = vy; vy = tmp; clear tmp;
                angulations = [angulations(2) angulations(1) angulations(3)]; % ap, fh, rl
            end
            ori.vzlabel = 'R-L';
            vx = -vx;
            vz = -vz;
        case 3
            ori.label = 'coronal';
            angulations = [angulations(2) angulations(3) angulations(1)]; % fh, rl, ap
            vx = -vx;
            if strcmp('RL',phasedir)
                ori.vxlabel = 'F-H';
                ori.vylabel = 'R-L';
            else    % phasedir == 'FH'
                ori.vxlabel = 'R-L';
                ori.vylabel = 'F-H';
                angulations = [angulations(2) angulations(1) angulations(3)]; % rl, fh, ap
            end
            ori.vzlabel = 'A-P';
    end
end
ori.angulations = angulations;
%%
v = cat(5,vx,vy,vz); v = permute(v, [1 2 3 5 4]);
clear vx vy vz
if ~delayedReconFlag    % delayed recon is already scaled
    % scale velocity
    v = (v./3142)*VENC;
end

% take the means
vMean = mean(v,5);
MAG = MAG./max(MAG(:));

[magWeightVel, angio] = calc_angio(MAG, v, VENC);

disp('Load Data finished');
return