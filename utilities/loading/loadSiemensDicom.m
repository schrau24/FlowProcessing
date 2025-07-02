function [nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadSiemensDicom(directory)

warning('off','all');

%%
disp('Loading data')

% subfolders
subfolders = dir(directory); subfolders = subfolders(3:end);

isEnhancedDicom = 0;
for ii = 1:4
    files = dir(fullfile(directory,subfolders(ii).name)); files = files(3:end);
    if files(1).isdir && length(files) == 1
        files = dir(fullfile(files(1).folder,files(1).name)); files = files(3:end);
    end
    info = dicominfo(fullfile(files(end).folder,files(end).name));
    tmp = dicomCollection(fullfile(directory,subfolders(ii).name));
    % if the tmp table has more than one row, we have enhanced dicoms,
    % which have different headers and data format to sort through
    if ii == 1
        if size(tmp,1) > 1
            isEnhancedDicom = 1;
            nslices = size(tmp,1);
            nframes = tmp{1,'Frames'};
            timeres = info.CardiacRRIntervalSpecified/nframes;
            pixdim = [info.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.PixelSpacing; ...
                info.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.SliceThickness]';
        else
            nframes = info.CardiacNumberOfImages;       % number of reconstructed frames
            timeres = info.TriggerTime/nframes;         % temporal resolution, in ms
            nslices = tmp{1,'Frames'}/nframes;
            pixdim = [info.PixelSpacing(1) info.PixelSpacing(2) info.SliceThickness];
        end
        res = [tmp{1,'Rows'} tmp{1,'Columns'} nslices];
        fov = pixdim.*res/10;                       % Field of view in cm
    end
    
    if isEnhancedDicom; img_out = zeros([res,nframes]); end
    for table_row = 1:size(tmp,1)
        [img, spatial, dim] = dicomreadVolume(tmp,sprintf('s%i',table_row));
        if isEnhancedDicom
            img_out(:,:,table_row,:) = double(img);
        else
            img_out = double(permute(reshape(img,[res(1:2) nframes res(3)]),[1 2 4 3]));
        end
    end
    
    isMag = 0;
    if isEnhancedDicom
        isMag = contains(info.ComplexImageComponent,'MAGNITUDE');
    else
        isMag = contains(info.ImageType,'\M\');
    end
    if isMag
        MAG = img_out;
        MAG = MAG/max(abs(MAG(:)));
        % flip z direction
        MAG = flip(MAG,3);
    else            % '\P\ or 'PHASE'
        % velocity info
        if isEnhancedDicom
            img_out = img_out*info.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleSlope + ...
                info.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleIntercept;
            dirs = {'rl','ap','fh'};    % convention for HFS scans
            dcmorient = info.PerFrameFunctionalGroupsSequence.Item_1.PlaneOrientationSequence.Item_1.ImageOrientationPatient;
            rowDir = dirs{find(abs(dcmorient(1:3)) > 0.6)};
            colDir = dirs{find(abs(dcmorient(4:6)) > 0.6)};
            if strcmp(rowDir,'ap') & strcmp(colDir,'rl')
                tmpOri = 'Tra';
            elseif strcmp(rowDir,'rl') && strcmp(colDir,'fh')
                tmpOri = 'Cor';
            elseif strcmp(rowDir,'ap') && strcmp(colDir,'fh')
                tmpOri = 'Sag';
            else
                warning('unknown image orientation, assuming transversal');
                tmpOri = 'Tra';
            end

            % the venc is determined differently for different scanner
            % types
            % https://dicom.nema.org/dicom/supps/sup49_30.pdf
            VENC = info.PerFrameFunctionalGroupsSequence.Item_1.MRVelocityEncodingSequence.Item_1.VelocityEncodingMaximumValue * 10;    % in mm/s
            tmpVDir = info.PerFrameFunctionalGroupsSequence.Item_1.MRVelocityEncodingSequence.Item_1.VelocityEncodingDirection;
            switch tmpOri
                case 'Tra'
                    dirs = {'rl','ap','through'};
                    vDir = dirs{find(abs(tmpVDir)>0.6)};
                case 'Cor'
                    dirs = {'rl','through','fh'};
                    vDir = dirs{find(abs(tmpVDir)>0.6)};
                case 'Sag'
                    dirs = {'through','ap','fh'};
                    vDir = dirs{find(abs(tmpVDir)>0.6)};
            end
            
        else
            img_out = img_out*info.RescaleSlope + info.RescaleIntercept;
            vInfo = info.Private_0051_1014;
            tmpOri = info.Private_0051_100e;
            tmpVDir = strfind(vInfo,'_');
            VENC = str2double(vInfo(2:tmpVDir(1)-1))*10;              % venc, in mm/s
            vDir = vInfo(tmpVDir(end)+1:end);
        end

        switch tmpOri
            case 'Tra'
                switch vDir
                    case 'through'
                        vz = VENC*img_out/max(abs(img_out(:)));
                    case 'rl'
                        vy = VENC*img_out/max(abs(img_out(:)));
                    case 'ap'
                        vx = VENC*img_out/max(abs(img_out(:)));
                end
            case 'Cor'
                switch vDir
                    case 'through'
                        vz = VENC*img_out/max(abs(img_out(:)));
                    case 'rl'
                        vy = VENC*img_out/max(abs(img_out(:)));
                    case 'fh'
                        vx = VENC*img_out/max(abs(img_out(:)));
                end
            case 'Sag'
                switch vDir
                    case 'through'
                        vz = VENC*img_out/max(abs(img_out(:)));
                    case 'ap'
                        vy = VENC*img_out/max(abs(img_out(:)));
                    case 'fh'
                        vx = VENC*img_out/max(abs(img_out(:)));
                end
        end
    end
end

%% manually change velocity directions depending on scan orientations

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
        vz = -vz;
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
        vz = -vz;
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