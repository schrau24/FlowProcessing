function [nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadSiemensDicom(directory)

warning('off','all');

%%
disp('Loading data')

% subfolders
subfolders = dir(directory); subfolders = subfolders(3:end);

for ii = 1:4
    files = dir(fullfile(directory,subfolders(ii).name)); files = files(3:end);
    info = dicominfo(fullfile(files(end).folder,files(end).name));
    [img, spatial, dim] = dicomreadVolume(dicomCollection(fullfile(directory,subfolders(ii).name)));
    
    if ii == 1   % grab some header info
        nframes = info.CardiacNumberOfImages;       % number of reconstructed frames
        timeres = info.TriggerTime/nframes;         % temporal resolution, in ms
        nslices = size(squeeze(img),3)/nframes;
        res = [size(img,1:2) nslices];              % number of pixels in row,col,slices
        pixdim = [info.PixelSpacing(1) info.PixelSpacing(2)  info. SliceThickness];
        % the reconstructed resolution in mm
        fov = pixdim.*res/10;                       % Field of view in cm
    end
    
    img = double(permute(reshape(img,[res(1:2) nframes res(3)]),[1 2 4 3]));
    
    if contains(info.ImageType,'\M\')
        MAG = img;
        MAG = MAG/max(abs(MAG(:)));
        % flip z direction
        MAG = flip(MAG,3);
    else            % '\P\
        % velocity info
        img = img*info.RescaleSlope + info.RescaleIntercept;
        vInfo = info.Private_0051_1014;
        tmpVDir = strfind(vInfo,'_');
        VENC = str2double(vInfo(2:tmpVDir(1)-1))*10;              % venc, in mm/s
        vDir = vInfo(tmpVDir(end)+1:end);
        switch vDir
            case 'through'
                vz = VENC*img/max(abs(img(:)));
            case 'rl'
                vy = VENC*img/max(abs(img(:)));
            case 'fh'
                vx = VENC*img/max(abs(img(:)));
        end
    end
end

%% manually change velocity directions depending on scan orientations
tmpOri = info.Private_0051_100e;

% velocity directions correspond to the following:
% vx: in-plane up-down
% vy: in-plane right-left
% vz: through-plane
switch tmpOri % orientation number (1 - axial, 2 - sagittal, 3 - coronal)
    case 'Tra'
        ori.label = 'axial';
        ori.vxlabel = 'R-L';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'F-H';
    case 'Sag'
        ori.label = 'sagittal';
        vx = -vx;
        vz = -vz;
        ori.vxlabel = 'F-H';
        ori.vylabel = 'A-P';
        ori.vzlabel = 'R-L';
    case 'Cor'
        ori.label = 'coronal';
        vx = -vx;
        ori.vxlabel = 'F-H';
        ori.vylabel = 'R-L';
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