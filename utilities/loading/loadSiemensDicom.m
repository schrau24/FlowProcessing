function [nframes, res, fov, pixdim, timeres, v, MAG, magWeightVel, angio, vMean, VENC, ori] = ...
    loadSiemensDicom(directory)

warning('off','all');

%%
disp('Loading data')

% subfolders
subfolders = dir(directory); subfolders = subfolders(3:end);

isEnhancedDicom = 0; vCount = 0;
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
        if size(tmp,1) > 1 || length(files) == 1
            isEnhancedDicom = 1;
            if length(files) > 1
                nslices = size(tmp,1);
                nframes = tmp{1,'Frames'};
                timeres = info.CardiacRRIntervalSpecified/nframes;
                pixdim = [info.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.PixelSpacing; ...
                    info.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.SliceThickness]';
            else
                % loop through frame items and store triggers
                % and slices
                count = 0; nTotalImgs = tmp{1,'Frames'}; pcaFlag = 0;
                for nn = round(nTotalImgs/2):nTotalImgs
                    count = count + 1;
                    eval(sprintf('aa=info.PerFrameFunctionalGroupsSequence.Item_%i;',nn))
                    tt(count) = aa.CardiacSynchronizationSequence.Item_1.NominalCardiacTriggerDelayTime;
                    IOP = aa.PlaneOrientationSequence.Item_1.ImageOrientationPatient;
                    IPP = aa.PlanePositionSequence.Item_1.ImagePositionPatient;
                    R = IOP(1:3);
                    C = IOP(4:6);
                    normal = cross(R, C);
                    calculatedSliceLocation = dot(IPP, normal);
                    sl_loc(count) = calculatedSliceLocation;
                    if strcmp(aa.Private_2005_140f.Item_1.Private_2005_1011,'M')
                        pcaFlag = 1;
                    end
                end
                tt = unique(tt); sl_loc = unique(sl_loc);
                nframes = length(tt);               % number of reconstructed frames
                timeres = mean(diff(tt));           % temporal resolution, in ms
                nslices = tmp{1,'Frames'}/nframes;
                if pcaFlag; nslices = nslices/2; end
                pixdim =[info.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.PixelSpacing;...
                    mean(diff(sl_loc))]';
            end
        else
            count = 0;
            for nn = 1:length(files)
                count = count + 1;
                aa = dicominfo(fullfile(files(nn).folder,files(nn).name));
                tt(count) = aa.TriggerTime;
                sl_loc(count) = aa.SliceLocation;
            end
            tt = unique(tt); sl_loc = unique(sl_loc);
            nframes = length(tt);               % number of reconstructed frames
            timeres = mean(diff(tt));           % temporal resolution, in ms
            nslices = length(files)/nframes;
            pixdim = [info.PixelSpacing(1) info.PixelSpacing(2) mean(diff(sl_loc))];
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
    else            % '\P\ or 'PHASE'
        vCount = vCount+1;
        % velocity info
        if isEnhancedDicom
            img_out = img_out*info.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleSlope + ...
                info.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleIntercept;
            dirs = {'rl','ap','fh'};    % convention for HFS scans
            dcmorient = info.PerFrameFunctionalGroupsSequence.Item_1.PlaneOrientationSequence.Item_1.ImageOrientationPatient;
            rowDir = dirs{find(abs(dcmorient(1:3)) > 0.6)};
            colDir = dirs{find(abs(dcmorient(4:6)) > 0.6)};
            if strcmp(rowDir,'ap') && strcmp(colDir,'rl')
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
            idx = find(abs(tmpVDir)>0.6);
            switch tmpOri
                case 'Tra'
                    dirs = {'rl','ap','through'};
                case 'Cor'
                    dirs = {'rl','through','fh'};
                case 'Sag'
                    dirs = {'through','ap','fh'};
            end
            vDir = dirs{idx};
            fprintf('velocity direction = %s\n',vDir)
        else
            img_out = img_out*info.RescaleSlope + info.RescaleIntercept;
            % Always read IOP — standard field available in all DICOM files
            dcmorient = info.ImageOrientationPatient;
            try
                vInfo = info.Private_0051_1014;
                tmpOri = info.Private_0051_100e;
            catch
                vInfo = info.Private_0021_1129;
                dirs   = {'rl','ap','fh'};
                rowDir = dirs{find(abs(dcmorient(1:3)) > 0.6)};
                colDir = dirs{find(abs(dcmorient(4:6)) > 0.6)};
                if strcmp(rowDir,'ap') && strcmp(colDir,'rl')
                    tmpOri = 'Tra';
                elseif strcmp(rowDir,'rl') && strcmp(colDir,'fh')
                    tmpOri = 'Cor';
                elseif strcmp(rowDir,'ap') && strcmp(colDir,'fh')
                    tmpOri = 'Sag';
                else
                    warning('unknown image orientation, assuming transversal');
                    tmpOri = 'Tra';
                end
            end

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

% velocity directions correspond to the following:
% vx: in-plane up-down
% vy: in-plane right-left
% vz: through-plane
switch tmpOri
    case 'Tra'
        ori.label = 'axial';
        vz = -vz;
    case 'Sag'
        ori.label = 'sagittal';
        vx = -vx;
        vz = -vz;
    case 'Cor'
        ori.label = 'coronal';
        vx = -vx;
        vz = -vz;
end

%% Orientation labels from actual IOP direction cosines (sign-correct)
ori.label = lower(tmpOri);
switch tmpOri
    case 'Tra'; ori.label = 'axial';
    case 'Sag'; ori.label = 'sagittal';
    case 'Cor'; ori.label = 'coronal';
end
ori = dicomOrientToLabels(dcmorient, ori);
%%
v = cat(5,vx,vy,vz); v = permute(v, [1 2 3 5 4]);
clear vx vy vz

% take the means
vMean = mean(v,5);
MAG = MAG./max(MAG(:));

[magWeightVel, angio] = calc_angio(MAG, v, VENC);

disp('Load Data finished');
return