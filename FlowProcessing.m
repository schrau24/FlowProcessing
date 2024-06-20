classdef FlowProcessing < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        FlowProcessingUIFigure          matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        LoadingandPreprocessingTab      matlab.ui.container.Tab
        ProcessingPanel                 matlab.ui.container.Panel
        VelocityUnwrapping              matlab.ui.control.Button
        MapsPushButton                  matlab.ui.control.Button
        PulseWaveVelocityPushButton     matlab.ui.control.Button
        DVisualizationPanel             matlab.ui.container.Panel
        SegTimeframeSpinner             matlab.ui.control.Spinner
        TimeframeSpinner_4Label         matlab.ui.control.Label
        flipSegLabel                    matlab.ui.control.Label
        flipsegio                       matlab.ui.control.CheckBox
        flipseglr                       matlab.ui.control.CheckBox
        flipsegud                       matlab.ui.control.CheckBox
        ResetRotation                   matlab.ui.control.Button
        RotateUp                        matlab.ui.control.Button
        RotateDown                      matlab.ui.control.Button
        Rotate                          matlab.ui.control.Label
        RotateRight                     matlab.ui.control.Button
        RotateLeft                      matlab.ui.control.Button
        View3D                          matlab.ui.control.UIAxes
        CropPanel                       matlab.ui.container.Panel
        FinishedCroppingButton          matlab.ui.control.Button
        AdjustthresholdSlider           matlab.ui.control.Slider
        AdjustthresholdSliderLabel      matlab.ui.control.Label
        CropButton_3                    matlab.ui.control.Button
        CropButton_2                    matlab.ui.control.Button
        CropButton                      matlab.ui.control.Button
        ZrangeEditField                 matlab.ui.control.EditField
        ZrangeEditFieldLabel            matlab.ui.control.Label
        toZEditField                    matlab.ui.control.EditField
        toZEditFieldLabel               matlab.ui.control.Label
        YrangeEditField                 matlab.ui.control.EditField
        YrangeEditFieldLabel            matlab.ui.control.Label
        toYEditField                    matlab.ui.control.EditField
        toYEditFieldLabel               matlab.ui.control.Label
        toXEditField                    matlab.ui.control.EditField
        toXEditFieldLabel               matlab.ui.control.Label
        XrangeEditField                 matlab.ui.control.EditField
        XrangeEditFieldLabel            matlab.ui.control.Label
        AxesZ                           matlab.ui.control.UIAxes
        AxesY                           matlab.ui.control.UIAxes
        AxesX                           matlab.ui.control.UIAxes
        LoadDataPanel                   matlab.ui.container.Panel
        InterpolateData                 matlab.ui.control.Button
        ScanInfoTable                   matlab.ui.control.Table
        SegmentationDirectoryEditField  matlab.ui.control.EditField
        SegmentationDirectoryEditFieldLabel  matlab.ui.control.Label
        LoadSegmentationButton          matlab.ui.control.Button
        DataDirectoryEditField          matlab.ui.control.EditField
        DataDirectoryEditFieldLabel     matlab.ui.control.Label
        LoadPARRECDataButton            matlab.ui.control.Button
        VelocityUnwrappingTab           matlab.ui.container.Tab
        Unwrap_manual_3                 matlab.ui.control.CheckBox
        Unwrap_manual_2                 matlab.ui.control.CheckBox
        Unwrap_manual_1                 matlab.ui.control.CheckBox
        LaplaceUnwrap                   matlab.ui.control.Button
        Unwrap_automatic                matlab.ui.control.Button
        SliceSpinner                    matlab.ui.control.Spinner
        SliceSpinner_Label              matlab.ui.control.Label
        TimeframeSpinner_3              matlab.ui.control.Spinner
        TimeframeSpinner_3Label         matlab.ui.control.Label
        Unwrap_3                        matlab.ui.control.UIAxes
        Unwrap_1                        matlab.ui.control.UIAxes
        Unwrap_2                        matlab.ui.control.UIAxes
        Maps                            matlab.ui.container.Tab
        QuickviewPanel                  matlab.ui.container.Panel
        AxialButton                     matlab.ui.control.Button
        SagittalButton                  matlab.ui.control.Button
        CoronalButton                   matlab.ui.control.Button
        flipvz                          matlab.ui.control.CheckBox
        flipvy                          matlab.ui.control.CheckBox
        flipvx                          matlab.ui.control.CheckBox
        MapType                         matlab.ui.control.DropDown
        ResetRotation_2                 matlab.ui.control.Button
        RotateUp_2                      matlab.ui.control.Button
        RotateDown_2                    matlab.ui.control.Button
        Rotate_2                        matlab.ui.control.Label
        RotateRight_2                   matlab.ui.control.Button
        RotateLeft_2                    matlab.ui.control.Button
        LinkplotsCheckBox               matlab.ui.control.CheckBox
        SaveAnimation                   matlab.ui.control.Button
        CalculateMap                    matlab.ui.control.Button
        PeaksystoleEditField            matlab.ui.control.EditField
        PeaksystoleEditFieldLabel       matlab.ui.control.Label
        VelocityVectorGroup             matlab.ui.container.Panel
        VectorOptionsDropDown           matlab.ui.control.DropDown
        VectorType                      matlab.ui.control.Label
        SliceSpinner_2                  matlab.ui.control.Spinner
        SliceSpinner_2Label             matlab.ui.control.Label
        maxVelocityVectorEditField      matlab.ui.control.EditField
        velocityVectortoEditFieldLabel  matlab.ui.control.Label
        minVelocityVectorEditField      matlab.ui.control.EditField
        velocityVectorEditFieldLabel    matlab.ui.control.Label
        maxQuiverEditField              matlab.ui.control.EditField
        toXEditFieldLabel_2             matlab.ui.control.Label
        minQuiverEditField              matlab.ui.control.EditField
        quiverscaleEditFieldLabel       matlab.ui.control.Label
        TimeframeSpinner                matlab.ui.control.Spinner
        TimeframeSpinnerLabel           matlab.ui.control.Label
        VelocityVectorsPlot             matlab.ui.control.UIAxes
        MapGroup                        matlab.ui.container.Panel
        MapTimeframeSpinnerLabel        matlab.ui.control.Label
        maxWSSEditField                 matlab.ui.control.EditField
        WSStoEditFieldLabel             matlab.ui.control.Label
        minWSSEditField                 matlab.ui.control.EditField
        WSSEditFieldLabel               matlab.ui.control.Label
        MapTimeframeSpinner             matlab.ui.control.Spinner
        MapPlot                         matlab.ui.control.UIAxes
        FlowandPulseWaveVelocityTab     matlab.ui.container.Tab
        findBestFit_checkbox            matlab.ui.control.CheckBox
        R2Display                       matlab.ui.control.EditField
        PWVDisplayTitle_2               matlab.ui.control.Label
        deleteBranch4                   matlab.ui.control.Button
        BranchDropDown_4                matlab.ui.control.DropDown
        Branch4Label                    matlab.ui.control.Label
        FlipBranch1_4                   matlab.ui.control.CheckBox
        BranchDropDown_3                matlab.ui.control.DropDown
        Branch3Label                    matlab.ui.control.Label
        FlipBranch1_3                   matlab.ui.control.CheckBox
        deleteBranch3                   matlab.ui.control.Button
        AddbranchButton                 matlab.ui.control.Button
        BranchDropDown_2                matlab.ui.control.DropDown
        Branch2Label                    matlab.ui.control.Label
        FlipBranch1_2                   matlab.ui.control.CheckBox
        deleteBranch2                   matlab.ui.control.Button
        BranchDropDown                  matlab.ui.control.DropDown
        BranchDropDownLabel             matlab.ui.control.Label
        FlipBranch1                     matlab.ui.control.CheckBox
        SaveName                        matlab.ui.control.DropDown
        SaveResultsCallback             matlab.ui.control.Button
        SavingTitle                     matlab.ui.control.Label
        PWVDisplay                      matlab.ui.control.EditField
        PWVDisplayTitle                 matlab.ui.control.Label
        PWVType                         matlab.ui.control.DropDown
        CalculatePWV                    matlab.ui.control.Button
        PlotWaveformsButton             matlab.ui.control.Button
        PWVPoints                       matlab.ui.control.EditField
        PWVPointsLabel                  matlab.ui.control.Label
        PWVPointsTitle                  matlab.ui.control.Label
        CheckcenterlinecalculateflowButton  matlab.ui.control.Button
        BranchNumberTitle               matlab.ui.control.Label
        SegmentationAndCenterline       matlab.ui.container.Panel
        ParameterDropDown               matlab.ui.control.DropDown
        ParameterLabel                  matlab.ui.control.Label
        DisplayDistanceCheckbox         matlab.ui.control.CheckBox
        Reset3DviewButton               matlab.ui.control.Button
        View3D_2                        matlab.ui.control.UIAxes
        PWVCalcDisplay                  matlab.ui.control.UIAxes
        WaveformsDisplay                matlab.ui.control.UIAxes
        ResetWorkSpace                  matlab.ui.container.Tab
        CleardataandrestartanalysisButton  matlab.ui.control.Button
    end


    properties (Access = private)
        directory;                  % the data directory
        segDirectory;               % the directory for dicoms from a pre-defined manual segmentation
        v;                          % the 5D velocity matrix (X x Y x Z x t x v)
        nframes;                    % the reconstrucated cardiac time frames
        res;                        % image dimensions in X, Y, and Z
        fov;                        % the acquired field of view, in cm
        pixdim;                     % resolution in X, Y, and Z, in mm
        ori;                        % orientation (1-axial, 2-sagittal, 3-coronal)
        timeres;                    % temporal resolution (per cardiac frame), in ms
        MAG;                        % the 4D magitude matrix (X x Y x Z x t)
        magWeightVel;               % the calculated magnitude weighted velocity
        angio;                      % a maximum intensity PCMRA
        vMean;                      % the mean velocity over time
        VENC;                       % velocity encoding, in mm/s
        segment;                    % the segmentation, updated throughout
        isSegmentationLoaded = 0;   % is the manual segmentation loaded?
        isTimeResolvedSeg = 0;      % is a time-resolved segmentation loaded?
        isInterpolated = 0;         % is the data (and segmentation) interpolated?
        isCropped = 0;              % have we performed any cropping?
        mask;                       % the mask
        isRawDataCropped;           % have we cropped the raw data yet?
        aorta_seg;                  % the specific aorta segmentation

        branchList;                 % list of all unique branches following centerline extraction
        branchActual;               % chosen branch for PWV measurements
        area_val;                   % calculated area along branch
        flowPerHeartCycle_vol;      % resulting flow over the cardiac cycle in the aorta_seg voluem
        flowPulsatile_vol;          % pulsatile flow waveforms in the aorta_seg volume
        contours;                   % the output contours calculated over the centerline, may be time-resolved
        tangent_V;                  % the output tangent vectors calculated over the centerline, for visualization

        hpatch1;                    % initial 3D patch for 3D vis
        hpatch2;                    % segmentation 3D patch for 3D vis
        rotAngles;                  % rotation angles used for viewing, can be changed by viewer

        usedBranches;               % a list that is built up to determine which branches to perform flow measurements on
        FullBranchDistance;         % the full distance vector (in mm)

        R2;                         % the r-squared value of the fit for cross-correlation or wavelet PWV measurement
        vvp_xlim;                   % velocity vector x limits
        vvp_ylim;                   % velocity vector y limits
        vvp_changed = 1;            % has the type of velocity vector plot changed?
        time_peak;                  % the determined peak systolic phase
        WSS_matrix;                 % calculated WSS matrix
        F_matrix;                   % faces for 3D vis
        V_matrix;                   % vertices for 3D vis
        rotAngles2;                 % rotation angles used for viewing maps, can be changed by viewer
        isWSScalculated = 0;        % is WSS calculated
    end

    methods (Access = private)

        function View3DSegmentation(app)

            cla(app.View3D);
            ss = smooth3(app.segment);

            app.hpatch1 = patch(app.View3D, isosurface(ss,.5),'FaceColor','red','EdgeColor', 'none','FaceAlpha',0.35);
            reducepatch(app.hpatch1 ,0.6);
            if (app.isSegmentationLoaded)
                aa = smooth3(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value));
                hold(app.View3D,'on')
                app.hpatch2 = patch(app.View3D, isosurface(aa,.5),'FaceColor','blue','EdgeColor', 'none','FaceAlpha',0.75);
                reducepatch(app.hpatch2,0.6);
            end

            % Make it all look good
            camlight(app.View3D);
            lighting(app.View3D,'gouraud');
            lightangle(app.View3D,0,0);
            view(app.View3D, [0 0 -1]);
            daspect(app.View3D,[1 1 1])
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = size(app.segment,1); m_ystop = size(app.segment,2); m_zstop = size(app.segment,3);
            xlim(app.View3D,[m_ystart m_ystop]);
            ylim(app.View3D,[m_xstart m_xstop]);
            axis(app.View3D,'off');

            % if rotation angles are non-zero, rotate now
            if sum(app.rotAngles) > 0
                rotate(app.hpatch1,[1 0 0], app.rotAngles(1))
                rotate(app.hpatch1,[0 1 0], app.rotAngles(2))
                if (app.isSegmentationLoaded)
                    rotate(app.hpatch2,[1 0 0], app.rotAngles(1))
                    rotate(app.hpatch2,[0 1 0], app.rotAngles(2))
                end
            end
        end

        function reset3DSegmentationAndCenterline(app)
            % Initialize figure
            colorbar(app.View3D_2,'off')
            cla(app.View3D_2);

            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    ss = smooth3(app.aorta_seg(:,:,:,app.time_peak));
                else
                    ss = smooth3(app.aorta_seg);
                end
                hpatch = patch(app.View3D_2,isosurface(ss,0.5),'FaceAlpha',0.20);
                reducepatch(hpatch,0.6);
                set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
            else
                ss = smooth3(app.segment);
                hpatch = patch(app.View3D_2,isosurface(ss,0.5),'FaceAlpha',0.20);
                reducepatch(hpatch,0.6);
                set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
            end

            unqBranches = unique(app.branchList(:,4));
            c = lines(length(unqBranches));
            for b = 1:length(unqBranches)
                % extract coordinates for branch and plot
                currBranch = find(app.branchList(:,4) == b);
                hline(b) = line(app.View3D_2, ...
                    app.branchList(currBranch,2),app.branchList(currBranch,1),app.branchList(currBranch,3),...
                    'Color',c(b,:),'Marker','.','MarkerSize',12,'LineStyle','none');
            end

            % make it look good
            axis(app.View3D_2, 'vis3d')
            axis(app.View3D_2, 'off')
            colormap(app.View3D_2,'colorcube')
            camlight(app.View3D_2);
            lighting(app.View3D_2,'gouraud');
            view(app.View3D_2, [0 0 -1]);
            daspect(app.View3D_2,[1 1 1])

            % Put the number labels on the CenterlinePlot
            numString_val = num2str(unqBranches);
            for i = 1:length(unqBranches)
                %find rows where textint = branchList(:,4) and take the mid point
                temp = app.branchList(app.branchList(:,4) == i,1:3);
                textLoc(i,1:3) = temp(round(size(temp,1)/2),:);
            end
            Ntxt = text(app.View3D_2,textLoc(unqBranches,2)+1,textLoc(unqBranches,1)+1,textLoc(unqBranches,3)+1,...
                numString_val,'Color','k','FontSize',20,'FontWeight', 'bold','Margin', 1,...
                'HitTest','off','PickableParts','none');

            % update view angle
            camorbit(app.View3D_2,app.rotAngles(2),app.rotAngles(1),[1 1 0])

            if length(unqBranches) > 1
                app.BranchDropDown.Items = string(unqBranches);
            else
                app.BranchDropDown.Items = {'1'};
            end
        end

        function view3D_wParams(app)
            
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,app.time_peak);
            else
                currSeg = app.aorta_seg;
            end
            
            % indices for flow plotting
            x = round(app.branchActual(:,1)); 
            y = round(app.branchActual(:,2)); 
            z = round(app.branchActual(:,3));
            index = sub2ind(size(currSeg),x,y,z);

            %reset figure
            cla(app.View3D_2);
            colorbar(app.View3D_2,'off');

            if app.isSegmentationLoaded
                hpatch = patch(app.View3D_2,isosurface(smooth3(currSeg),0.5),'FaceAlpha',0.25);
            else
                hpatch = patch(app.View3D_2,isosurface(smooth3(app.segment),0.5),'FaceAlpha',0.25);
            end
            reducepatch(hpatch,0.6);
            set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');

            % grab parameter from drop-down, and set colorbar description
            switch app.ParameterDropDown.Value
                case 'Total Flow'
                    cdata = app.flowPerHeartCycle_vol(index);
                    cbarText = 'Flow (mL/cycle)';
                case 'Peak Flow'
                    cdata = max(app.flowPulsatile_vol(index,:),[],2);
                    cbarText = 'Peak flow (mL/s)';
                case 'Mean velocity'
                    cdata = mean(app.flowPulsatile_vol(index,:)./app.area_val,2);
                    cbarText = 'Mean velocity (cm/s)';
                case 'Peak velocity'
                    cdata = max(app.flowPulsatile_vol(index,:)./app.area_val,[],2);
                    cbarText = 'Peak velocity (cm/s)';
            end

            hSurface = surface(app.View3D_2,'XData',[y(:) y(:)],'YData',[x(:) x(:)],'ZData',[z(:) z(:)],...
                'CData',[cdata(:) cdata(:)],'FaceColor','none','EdgeColor','flat',...
                'Marker','.','MarkerSize',12);

            caxis(app.View3D_2,[min(cdata) max(cdata)]);
            colormap(app.View3D_2,jet)
            cbar = colorbar(app.View3D_2);
            caxis(app.View3D_2,[0 0.95*max(cdata)])
            set(get(cbar,'xlabel'),'string',cbarText,'fontsize',16,'Color','black');
            set(cbar,'FontSize',16,'color','black','Location','west');

            % make it look good
            axis(app.View3D_2, 'vis3d')
            axis(app.View3D_2, 'off')
            camlight(app.View3D_2);
            lighting(app.View3D_2,'gouraud');
            view(app.View3D_2, [0 0 -1]);
            daspect(app.View3D_2,[1 1 1])

            % Put the number labels on the CenterlinePlot
            str = app.PWVPoints.Value;

            if app.DisplayDistanceCheckbox.Value
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                textint = app.FullBranchDistance(minIdx:5:minIdx2);
                textint2 = minIdx:5:minIdx2;
            else
                eval(['ptRange=[' str '];']);
                ptRange(ptRange>length(app.branchActual)) = [];
                textint2 = ptRange(1:5:end); textint = textint2;
            end

            numString_val = num2str(textint);
            numString_val = strsplit(numString_val);

            c = winter(length(textint2));
            for C = 1:length(textint2)
                Ntxt(C) = text(app.View3D_2,app.branchActual(textint2(C),2)-4,app.branchActual(textint2(C),1)-3,app.branchActual(textint2(C),3)+2,numString_val{C},...
                    'Color','k','HorizontalAlignment','right',...
                    'FontSize',20,'FontWeight','Bold','HitTest','off','PickableParts','none');
            end

            % update view angle
            camorbit(app.View3D_2,app.rotAngles(2),app.rotAngles(1),[1 1 0])
            drawnow;
        end

        function plotWaveforms(app)

            % grab waveforms
            x = round(app.branchActual(:,1)); 
            y = round(app.branchActual(:,2)); 
            z = round(app.branchActual(:,3));
            index = sub2ind(size(app.aorta_seg),x,y,z);
            waveforms = app.flowPulsatile_vol(index,:);

            if contains(app.ParameterDropDown.Value,'Flow')
                plotString = 'Flow (mL/s)';
            else
                waveforms = waveforms./app.area_val;
                plotString = 'Velocity (cm/s)';
            end
            view3D_wParams(app);

            str = app.PWVPoints.Value;

            if app.DisplayDistanceCheckbox.Value
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                ptRange = minIdx:minIdx2;
            else
                eval(['ptRange=[' str '];']);
                ptRange(ptRange>length(app.branchActual)) = [];
                % reset the string to correct max
                outNums = sscanf(str,'%i:%i:%i');
                if length(outNums)==2
                    app.PWVPoints.Value = sprintf('%i:%i',outNums(1),ptRange(end));
                elseif length(outNums)==3
                    app.PWVPoints.Value = sprintf('%i:%i:%i',outNums(1),outNums(2),ptRange(end));
                end
            end

            waveforms = waveforms(ptRange,:);

            % plot
            card_time = [0:app.nframes-1]*app.timeres;
            c = winter(size(waveforms,1));
            if size(waveforms,1) > 5
                alpha = linspace(0.8,0.3,size(waveforms,1));
            else
                alpha = 0.8*ones(1,size(waveforms,1));
            end
            c = cat(2,c,alpha');

            colorbar(app.WaveformsDisplay,'off')
            cla(app.WaveformsDisplay);
            hold(app.WaveformsDisplay,'on');
            for ii = 1:size(waveforms,1)
                plot(app.WaveformsDisplay,card_time,waveforms(ii,:)','Color',c(ii,:),...
                    'LineWidth',2)
            end
            xlim(app.WaveformsDisplay,[0 max(card_time)])
            app.WaveformsDisplay.XLabel.String = 'Cardiac Time (ms)';
            app.WaveformsDisplay.YLabel.String = plotString;

            if numel(ptRange) > 1
                colormap(app.WaveformsDisplay,winter);
                cbar = colorbar(app.WaveformsDisplay);
                set(get(cbar,'title'),'string','Point number','fontsize',16,'Color','black');
                set(cbar,'FontName','Calibri','FontSize',10,'color','black');
            end

            % display a max of 5 points on cbar
            if app.DisplayDistanceCheckbox.Value
                set(get(cbar,'title'),'string','Distance (mm)','fontsize',16,'Color','black');
                if size(waveforms,1) < 11
                    cbar.Ticks = linspace(0, 1, size(waveforms,1)) ;
                    cbar.TickLabels = num2cell(app.FullBranchDistance(minIdx:minIdx2));
                else
                    cbar.Ticks = linspace(0, 1, 5) ;
                    cbar.TickLabels = num2cell(round(linspace(double(app.FullBranchDistance(minIdx)),...
                        double((app.FullBranchDistance(minIdx2))),5)));
                end
            else
                if size(waveforms,1) < 11
                    cbar.Ticks = linspace(0, 1, size(waveforms,1)) ;
                    cbar.TickLabels = num2cell(ptRange);
                else
                    cbar.Ticks = linspace(0, 1, 5) ;
                    cbar.TickLabels = num2cell(round(linspace(double(min(ptRange)),double(max(ptRange)),5)));
                end
            end
            hold(app.WaveformsDisplay,'off');
        end

        function maskSz = cropImage(app,img,img2)

            choice = 0;
            while choice == 0
                cropFig = figure(100);
                set(cropFig,'Units','normalized');
                set(cropFig,'Position',[0.0016 0.0481 0.4969 0.8454])
                set(cropFig,'Name','Draw rectangle to crop image')

                % View MIP
                imagesc(img);
                colormap('gray')
                if app.isSegmentationLoaded
                    hold(gca,'on');
                    h = imagesc(cat(3,zeros(size(img)),zeros(size(img)),ones(size(img)))); 
                    set(h,'AlphaData',img2)
                    hold(gca,'off');
                end
                axis equal off
                daspect([1 1 1]);

                h = drawrectangle(gca,'DrawingArea',[1 1 size(img,2)-1 size(img,1)-1]);
                maskSz = h.Position;
                maskSz(1:2) = floor(maskSz(1:2));
                maskSz(3:4) = ceil(maskSz(3:4));
                maskSz(maskSz<1) = 1;
                mask = zeros(size(img));
                mask(maskSz(2):(maskSz(2)+maskSz(4)), maskSz(1):(maskSz(1)+maskSz(3))) = 1;
                imgCropped = img.*mask;

                clf(cropFig);
                imagesc(imgCropped);
                colormap('gray')
                if app.isSegmentationLoaded
                    hold(gca,'on');
                    h = imagesc(cat(3,zeros(size(imgCropped)),zeros(size(imgCropped)),ones(size(imgCropped)))); 
                    set(h,'AlphaData',img2.*mask)
                    hold(gca,'off');
                end
                axis equal off
                daspect([1 1 1]);
                set(cropFig,'Name','Cropped image')
                choice = checkCrop;

            end
            % if cancel, reset the mask and img
            if choice == 2
                maskSz = [1 1 size(img,2)-1 size(img,1)-1];
            end
            % update cropped state
            if choice == 1
                app.isCropped = 1;
            end

            close(cropFig)
        end

        function updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop)

            % update for ROI drawing
            app.XrangeEditField.Value = num2str(m_xstart);
            app.toXEditField.Value = num2str(m_xstop);

            app.YrangeEditField.Value = num2str(m_ystart);
            app.toYEditField.Value = num2str(m_ystop);

            app.ZrangeEditField.Value = num2str(m_zstart);
            app.toZEditField.Value = num2str(m_zstop);

            % Set mips
            cla(app.AxesX);
            imagesc(app.AxesX,reshape(max(app.angio,[],1),[app.res(2) app.res(3)]));
            if app.isSegmentationLoaded
                hold(app.AxesX,'on');
                img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],1),[app.res(2) app.res(3)]);
                h = imagesc(app.AxesX,cat(3, zeros([app.res(2) app.res(3)]), zeros([app.res(2) app.res(3)]), ones([app.res(2) app.res(3)]))); 
                set(h,'AlphaData',0.25*img2)
                hold(app.AxesX,'off');
            end
            set(app.AxesX,'XTickLabel','','YTickLabel','')
            colormap(app.AxesX,'gray')
            axis(app.AxesX,'equal')
            daspect(app.AxesX,[1 1 1]);

            cla(app.AxesY);
            imagesc(app.AxesY,reshape(max(app.angio,[],2),[app.res(1) app.res(3)]));
            if app.isSegmentationLoaded
                hold(app.AxesY,'on');
                img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],2),[app.res(1) app.res(3)]);
                h = imagesc(app.AxesY,cat(3, zeros([app.res(1) app.res(3)]), zeros([app.res(1) app.res(3)]), ones([app.res(1) app.res(3)]))); 
                set(h,'AlphaData',0.25*img2)
                hold(app.AxesY,'off');
            end
            set(app.AxesY,'XTickLabel','','YTickLabel','')
            colormap(app.AxesY,'gray')
            axis(app.AxesY,'equal')
            daspect(app.AxesY,[1 1 1]);

            cla(app.AxesZ);
            imagesc(app.AxesZ,reshape(max(app.angio,[],3),[app.res(1) app.res(2)]));
            if app.isSegmentationLoaded
                hold(app.AxesZ,'on');
                img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],3),[app.res(1) app.res(2)]);
                h = imagesc(app.AxesZ,cat(3, zeros([app.res(1) app.res(2)]), zeros([app.res(1) app.res(2)]), ones([app.res(1) app.res(2)]))); 
                set(h,'AlphaData',0.25*img2)
                hold(app.AxesZ,'off');
            end
            set(app.AxesZ,'XTickLabel','','YTickLabel','')
            colormap(app.AxesZ,'gray')
            axis(app.AxesZ,'equal')
            daspect(app.AxesZ,[1 1 1]);
        end

        function viewVelocityVectors(app)

            %reset figure
            cla(app.VelocityVectorsPlot);
            colorbar(app.VelocityVectorsPlot,'off');
            t = app.TimeframeSpinner.Value;
            if t == 0   % to prevent errors when coming from other tabs
                t = 1;
            end
            
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,t);
            else 
                currSeg = app.aorta_seg;
            end
            currV = app.v(:,:,:,:,t);

            interpFactor = 1;
            switch app.VectorOptionsDropDown.Value  % the current vector vis state
                case 'slice-wise'   % slicewise vectors
                    % grab current slice
                    sl = app.SliceSpinner_2.Value;
                    L = find(currSeg(1:interpFactor:end,1:interpFactor:end,sl));
                    vx = -currSeg(1:interpFactor:end,1:interpFactor:end,sl).*currV(1:interpFactor:end,1:interpFactor:end,sl,1)/10;
                    vy = -currSeg(1:interpFactor:end,1:interpFactor:end,sl).*currV(1:interpFactor:end,1:interpFactor:end,sl,2)/10;
                    vz = -currSeg(1:interpFactor:end,1:interpFactor:end,sl).*currV(1:interpFactor:end,1:interpFactor:end,sl,3)/10;
                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:interpFactor:size(currSeg,2))*app.pixdim(1),(1:interpFactor:size(currSeg,1))*app.pixdim(2), ...
                        -10);   % cheat here and put the vel vectors at a negative location to overlay better

                    img = repmat(app.MAG(:,:,sl,t),[1 1 3]);
                    imagesc(app.VelocityVectorsPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                    hold(app.VelocityVectorsPlot,'on');
                case 'centerline contours' % contours from centerline
                    % parse points from PWV tab
                    str = app.PWVPoints.Value;
                    if app.DisplayDistanceCheckbox.Value
                        % convert distance to points
                        out = textscan(str,'%f %f','Delimiter',':');
                        [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                        [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                        ptRange = minIdx:minIdx2;
                    else
                        eval(['ptRange=[' str '];']);
                    end
                    
                    % oblique slices
                    L = []; xcoor_grid = []; ycoor_grid = []; zcoor_grid = [];
                    vx = []; vy = []; vz = [];
                    for ii = ptRange
                        currCP = [app.branchActual(ii,2),app.branchActual(ii,1),app.branchActual(ii,3)];
                        currNorm = app.tangent_V(ii,:); currNorm = [currNorm(1) -currNorm(2) currNorm(3)];
                        [B,x,y,z] = obliqueslice(currSeg,currCP,currNorm,'FillValues',0);
                        % do a quick region grow from our centerline point
                        tmp = cat(2,x(:),y(:),z(:)) - currCP;
                        tmp = sqrt(sum(tmp.*tmp,2));
                        [~, pointLinearIndexInSlice] = min(tmp);
                        [pointColumn,pointRow] = ind2sub(size(B),pointLinearIndexInSlice(1));
                        B = regiongrowing(B,pointColumn,pointRow);

                        currL = find(B(:));
                        xcoor_grid = cat(1,xcoor_grid,x(currL));
                        ycoor_grid = cat(1,ycoor_grid,y(currL));
                        zcoor_grid = cat(1,zcoor_grid,z(currL));
                        
                        vx_tmp = obliqueslice(currV(:,:,:,1)/10,currCP,currNorm);
                        vx = cat(1,vx,-vx_tmp(currL));
                        vy_tmp = obliqueslice(currV(:,:,:,2)/10,currCP,currNorm);
                        vy = cat(1,vy,-vy_tmp(currL));
                        vz_tmp = obliqueslice(currV(:,:,:,3)/10,currCP,currNorm);
                        vz = cat(1,vz,-vz_tmp(currL));
                        
                        L = cat(1,L,currL);
                    end
                    % we keep all L points now
                    L = 1:length(L);
                    
                    % we need a 3D patch for this setting
                    if app.isSegmentationLoaded
                        hpatch = patch(app.VelocityVectorsPlot,isosurface(smooth3(currSeg),0.5),'FaceAlpha',0.10);
                    else
                        hpatch = patch(app.VelocityVectorsPlot,isosurface(smooth3(app.segment),0.5),'FaceAlpha',0.10);
                    end
                    reducepatch(hpatch,0.6);
                    set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
                    camlight(app.VelocityVectorsPlot);
                    lighting(app.VelocityVectorsPlot,'gouraud');
                    lightangle(app.VelocityVectorsPlot,0,0);
            
                case 'segmentation'   % 3d vectors from the whole segmentation
                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:interpFactor:size(currSeg,2))*app.pixdim(1),(1:interpFactor:size(currSeg,1))*app.pixdim(2), ...
                        (1:interpFactor:size(currSeg,3))*app.pixdim(3));
                    vx = -currSeg(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end).*currV(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end,1)/10;
                    vy = -currSeg(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end).*currV(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end,2)/10;
                    vz = -currSeg(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end).*currV(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end,3)/10;
                    L = find(currSeg(1:interpFactor:end,1:interpFactor:end,1:interpFactor:end));
            end
            vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);

            c = [];
            a = [str2double(app.minQuiverEditField.Value) str2double(app.maxQuiverEditField.Value)*max(vmagn(:))/100];
            % note the flipped vx and vy here
            [F,V,C]=quiver3Dpatch(xcoor_grid(L),ycoor_grid(L),zcoor_grid(L),-vy(L),-vx(L),-vz(L),c,a);
            p = patch(app.VelocityVectorsPlot,'Faces',F,'Vertices',V,'CData',C,'FaceColor','flat','EdgeColor','none','FaceAlpha',0.75);

            caxis(app.VelocityVectorsPlot, [str2double(app.minVelocityVectorEditField.Value) str2double(app.maxVelocityVectorEditField.Value)]);
            colormap(app.VelocityVectorsPlot,jet)
            cbar = colorbar(app.VelocityVectorsPlot);
            set(get(cbar,'xlabel'),'string','Velocity (cm/s)','Color','black');
            set(cbar,'FontSize',12,'color','black','Location','west');
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.2 pos(3) 0.2]);
%             set(cbar,'position',[0.01 0.65 pos(3) 0.2]);

            % make it look good
            axis(app.VelocityVectorsPlot, 'off','tight')
            view(app.VelocityVectorsPlot,[0 0 1]);
            daspect(app.VelocityVectorsPlot,[1 1 1])
            if app.vvp_changed
               app.vvp_xlim = app.VelocityVectorsPlot.XLim;
               app.vvp_ylim = app.VelocityVectorsPlot.YLim;
               app.vvp_changed = 0; % reset
            else
                xlim(app.VelocityVectorsPlot,app.vvp_xlim)
                ylim(app.VelocityVectorsPlot,app.vvp_ylim)
            end

            % update view angle
            camorbit(app.VelocityVectorsPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
            hold(app.VelocityVectorsPlot,'off');
        end

        function viewWSS(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            if length(app.WSS_matrix) == 1
                WSS = app.WSS_matrix{1};
                faces = app.F_matrix{1};
                verts = app.V_matrix{1};
            else
                t2 = app.MapTimeframeSpinner.Value;
                WSS = app.WSS_matrix{t2};
                faces = app.F_matrix{t2};
                verts = app.V_matrix{t2};
            end
            WSS_magnitude = sqrt(WSS(:,1).^2 + WSS(:,2).^2 + WSS(:,3).^2);

            patch(app.MapPlot,'Faces',faces,'Vertices',verts,'EdgeColor','none', 'FaceVertexCData',WSS_magnitude,'FaceColor','interp','FaceAlpha',1);
            caxis(app.MapPlot, [str2double(app.minWSSEditField.Value) str2double(app.maxWSSEditField.Value)]);
            colormap(app.MapPlot,jet)
            cbar = colorbar(app.MapPlot);
            set(get(cbar,'xlabel'),'string','WSS (Pa)','Color','black');
            set(cbar,'FontSize',12,'color','black','Location','west');
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.01 pos(3) 0.2]);

            % make it look good
            axis(app.MapPlot, 'off','tight')
            view(app.MapPlot, [0 0 1]);
            daspect(app.MapPlot,[1 1 1])
            if ~isempty(app.vvp_xlim)
                xlim(app.MapPlot,app.vvp_xlim)
                ylim(app.MapPlot,app.vvp_ylim)
            end

            % update view angle
            camorbit(app.MapPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
        end

        function viewPeakVelocity(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            t = app.MapTimeframeSpinner.Value;
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,t);
            else
                currSeg = app.aorta_seg;
            end
            vx = currSeg.*app.v(:,:,:,1,t)/10;
            vy = currSeg.*app.v(:,:,:,2,t)/10;
            vz = currSeg.*app.v(:,:,:,3,t)/10;
            tmp = sqrt(vx.^2 + vy.^2 + vz.^2);
            sysvel_mip = max(tmp,[],3);

            imagesc(app.MapPlot, sysvel_mip+0.001);
            caxis(app.MapPlot, [str2double(app.minVelocityVectorEditField.Value) str2double(app.maxVelocityVectorEditField.Value)]);
            cmap = jet(256); cmap(1,:) = 1;
            colormap(app.MapPlot,cmap)
            cbar = colorbar(app.MapPlot);
            set(get(cbar,'xlabel'),'string','Peak velocity (cm/s)','Color','black');
            set(cbar,'color','black','Location','west','FontSize',12);
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.2 pos(3) 0.2]);
%             set(cbar,'position',[0.01 0.65 pos(3) 0.2]);

            % make it look good
            axis(app.MapPlot, 'off','tight')
            daspect(app.MapPlot,[1 1 1])
%             if ~isempty(app.vvp_xlim)
%                 xlim(app.MapPlot,app.vvp_xlim./app.pixdim(1))
%                 ylim(app.MapPlot,app.vvp_ylim./app.pixdim(2))
%             end

        end

        function plotVelocities(app)
            PCA_masked = app.v.*repmat(permute(app.aorta_seg,[1 2 3 5 4]),[1 1 1 3 1])/10;

            % determine scaling for visualization
            scaling = round(max(abs(PCA_masked(:))));
            cmap_scaling = dopplermap(1000,1);

            imagesc(app.Unwrap_1,PCA_masked(:,:,app.SliceSpinner.Value,1,app.TimeframeSpinner_3.Value),'tag', 'alldata');
            axis(app.Unwrap_1,'equal','off');
            colormap(app.Unwrap_1,cmap_scaling);
            caxis(app.Unwrap_1, [-scaling scaling]);
            title(app.Unwrap_1,app.ori.vxlabel);

            imagesc(app.Unwrap_2,PCA_masked(:,:,app.SliceSpinner.Value,2,app.TimeframeSpinner_3.Value),'tag', 'alldata');
            axis(app.Unwrap_2,'equal','off')
            colormap(app.Unwrap_2,cmap_scaling);
            caxis(app.Unwrap_2, [-scaling scaling]);
            title(app.Unwrap_2,app.ori.vylabel);

            imagesc(app.Unwrap_3,PCA_masked(:,:,app.SliceSpinner.Value,3,app.TimeframeSpinner_3.Value),'tag', 'alldata');
            axis(app.Unwrap_3,'equal','off')
            colormap(app.Unwrap_3,cmap_scaling);
            caxis(app.Unwrap_3, [-scaling scaling]);
            title(app.Unwrap_3,app.ori.vzlabel);

            cbar = colorbar(app.Unwrap_1);
            set(get(cbar,'xlabel'),'string','velocity (cm/s)','fontsize',12,'Color','black');
            set(cbar,'FontSize',14,'color','black','Location','west');
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.01 pos(3) 0.2]);

        end

        function viewMeanVelocity(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            t = app.MapTimeframeSpinner.Value;
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,t);
            else
                currSeg = app.aorta_seg;
            end
            vx = currSeg.*squeeze(app.v(:,:,:,1,:))/10;
            vy = currSeg.*squeeze(app.v(:,:,:,2,:))/10;
            vz = currSeg.*squeeze(app.v(:,:,:,3,:))/10;
            % for cmap, calculate absolute max of the mean
            vel_mip = squeeze(mean(sqrt(vx.^2 + vy.^2 + vz.^2),3));

            imagesc(app.MapPlot, vel_mip(:,:,t)+0.001);
            caxis(app.MapPlot, [str2double(app.minVelocityVectorEditField.Value) 0.8*max(vel_mip(:))]);
            cmap = jet(256); cmap(1,:) = 1;
            colormap(app.MapPlot,cmap)
            cbar = colorbar(app.MapPlot);
            set(get(cbar,'xlabel'),'string','Mean velocity (cm/s)','Color','black');
            set(cbar,'color','black','Location','west','FontSize',12);
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.2 pos(3) 0.2]);
            %             set(cbar,'position',[0.01 0.65 pos(3) 0.2]);

            % make it look good
            axis(app.MapPlot, 'off','tight')
            daspect(app.MapPlot,[1 1 1])
            if ~isempty(app.vvp_xlim)
                xlim(app.MapPlot,app.vvp_xlim./app.pixdim(1))
                ylim(app.MapPlot,app.vvp_ylim./app.pixdim(2))
            end
        end

        function viewKE(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            t = app.MapTimeframeSpinner.Value;
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,t);
            else
                currSeg = app.aorta_seg;
            end
            vx = app.aorta_seg.*app.v(:,:,:,1,:)/10.*currSeg;
            vy = app.aorta_seg.*app.v(:,:,:,2,:)/10.*currSeg;
            vz = app.aorta_seg.*app.v(:,:,:,3,:)/10.*currSeg;
            % 1 Joule = 1 kg (m/s)^2
            rho = 1.060;                            % density of blood, in kg/L
            vox_vol = prod(app.pixdim/1000)*1000;   % volume of voxel, in L
            vel = sqrt(vx.^2 + vy.^2 + vz.^2)/100;  % velocity in m/s
            KE = 0.5*rho*vox_vol.*vel;
            KE_mip = squeeze(1e6*max(KE,[],3));

            imagesc(app.MapPlot, KE_mip(:,:,t)+0.001);
            caxis(app.MapPlot, [0 0.8*max(KE_mip(:))]);
            cmap = jet(256); cmap(1,:) = 1;
            colormap(app.MapPlot,cmap)
            cbar = colorbar(app.MapPlot);
            set(get(cbar,'xlabel'),'string','Max KE (\muJ)','Color','black');
            set(cbar,'color','black','Location','west','FontSize',12);
            % change cbar size to fit in corner
            pos = get(cbar,'position');
            set(cbar,'position',[0.01 0.01 pos(3) 0.2]);

            % make it look good
            axis(app.MapPlot, 'off','tight')
            daspect(app.MapPlot,[1 1 1])
            if ~isempty(app.vvp_xlim)
                xlim(app.MapPlot,app.vvp_xlim./app.pixdim(1))
                ylim(app.MapPlot,app.vvp_ylim./app.pixdim(2))
            end
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % add path of subfolder function
            loc = mfilename('fullpath');
            cutoff=1;
            srcdir='';
            if ispc
                tag='\';
            else
                tag='/';
            end
            for n=1:numel(loc)-1
                if strcmpi(loc(end-n),tag)
                    cutoff=numel(loc)-n;
                    break;
                end
            end
            srcdir=loc(1:cutoff);

            addpath(genpath(fullfile(srcdir)))

            app.FlowProcessingUIFigure.Icon = 'vectors.png';
            app.MapsPushButton.Icon = 'vectors.png';
            app.InterpolateData.Icon = 'interpolate.jpg';
            drawnow;
        end

        % Button pushed function: LoadPARRECDataButton
        function LoadPARRECDataButtonPushed(app, event)
            clc;
            % from load data
            [app.directory, app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadPARREC();
            
            % re-focus the figure
            figure(app.FlowProcessingUIFigure);

            % initialize the mask
            app.mask = ones(size(app.angio));

            % add to info table
            app.ScanInfoTable.Data = cat(2,cellstr([num2str(app.res(1)) ' x ' num2str(app.res(2)) ' x ' num2str(app.res(3))]),...
                cellstr([num2str(round(app.pixdim(1),1)) ' x ' num2str(round(app.pixdim(2),1)) ' x ' num2str(round(app.pixdim(3),1))]),...
                cellstr(num2str(app.timeres)),cellstr(num2str(app.nframes)), cellstr(num2str(app.VENC/10)));

            app.DataDirectoryEditField.Value = app.directory;
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);

            clc;
            disp('View 3D Vasculature')

            normed_MIP = app.angio./max(app.angio(:));
            % fit a Gaussian to non-zero elements to determine threshold
            [muhat,sigmahat] = norm_fit(normed_MIP(:));

            app.segment = zeros(size(app.angio));
            app.segment(normed_MIP>muhat+2*sigmahat) = 1;

            app.segment = bwareaopen(app.segment,round(sum(app.segment(:)).*0.005),6); %The value at the end of the commnad in the minimum area of each segment to keep
            app.segment = imfill(app.segment,'holes'); % Fill in holes created by slow flow on the inside of vessels
            app.segment = single(app.segment);
            
            % find and initialize the peak velocity frame
            Vmag = repmat(app.segment,[1 1 1 app.nframes]).*squeeze(sqrt(sum(app.v.^2,4)));
            idx = find(app.segment);
            for t = 1:app.nframes
                tmp = Vmag(:,:,:,t);
                mean_velo(t) = mean(tmp(idx));
            end
            [~,app.time_peak] = find(mean_velo==max(mean_velo));

            % initialize the mask
            app.mask = ones(size(app.angio));

            View3DSegmentation(app);

            % set intial parameters
            app.rotAngles = [0 0];
            app.rotAngles2 = [0 0];
            app.isRawDataCropped = 0;
            
            % enable intepolate button
            app.InterpolateData.Enable = 'on';
        end

        % Button pushed function: CleardataandrestartanalysisButton
        function CleardataandrestartanalysisButtonPushed(app, event)
            delete(app.FlowProcessingUIFigure);  % close the app
            FlowProcessing;                      % re-open it
        end

        % Button pushed function: LoadSegmentationButton
        function LoadSegmentationButtonPushed(app, event)

            currDir = pwd;
            cd(app.directory);
            % if clicked, let the user pick the directory containg the pre-segmented
            % dicoms, load them in and save them, also update 3D view
            [tmp,app.segDirectory] = uigetfile({'*.dcm';'*nii.gz'},'Select Segmentation (*.dcm or *.nii)');
            app.SegmentationDirectoryEditField.Value = app.segDirectory;

            if strncmp(tmp(end-2:end),'dcm',3)
                files = dir([app.segDirectory '/*.dcm']);
                % reset the aorta segmentation
                app.aorta_seg = zeros(size(app.angio));
                for ii = 1:numel(files)
                    img(:,:,ii) = dicomread([app.segDirectory '/' files(ii).name]);
                end
                app.aorta_seg = double(img);
            elseif strncmp(tmp(end-5:end),'nii.gz',5) % .nii.gz file output from nnUNET
                % find the other files (if they exist) with the same ending
                tmp2 = dir([app.segDirectory, '*nii.gz']);
                if length(tmp2)==app.nframes    % we have a time-resolved segmentation!
                    fprintf('Time-resolved segmentation, loading %i segmentations...\n',length(tmp2))
                    app.aorta_seg = zeros([size(app.angio) app.nframes]);
                    for ii = 1:length(tmp2)
                        app.aorta_seg(:,:,:,ii) = double(niftiread(fullfile(tmp2(ii).folder,tmp2(ii).name)));
                    end
                    app.isTimeResolvedSeg = 1;
                    app.SegTimeframeSpinner.Enable = 'on';
                else    % only one frame
                    app.aorta_seg = zeros(size(app.angio));
                    app.aorta_seg = double(niftiread(fullfile(app.segDirectory,tmp)));
                end
            elseif strncmp(tmp(end-3:end),'.nii',3)
                app.aorta_seg = double(permute(niftiread(fullfile(app.segDirectory,tmp)),[2 1 3]));
            else    % the files are still dicoms but not with a dicom ending?
                files = dir([app.segDirectory '/*IM*']);
                % reset the aorta segmentation
                app.aorta_seg = zeros(size(app.angio));
                for ii = 1:numel(files)
                    img(:,:,ii) = dicomread([app.segDirectory '/' files(ii).name]);
                end
                app.aorta_seg = double(img);
            end
            
            if app.isRawDataCropped     % crop the corresponding segmentation volume
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);
                if app.isTimeResolvedSeg
                    tempIMG = reshape(app.aorta_seg,[prod(app.res),app.nframes]);
                else
                    tempIMG = reshape(app.aorta_seg,[prod(app.res),1]);
                end
                tempIMG = tempIMG(maskIdx,:);
                if app.isTimeResolvedSeg
                    tempIMG = reshape(tempIMG,lx,ly,lz,app.nframes);
                else
                    tempIMG = reshape(tempIMG,lx,ly,lz);
                end
                app.aorta_seg = tempIMG;
                clear tempIMG;
            end
            
            % update peak velocity frame
            if app.isTimeResolvedSeg
                Vmag = app.aorta_seg.*squeeze(sqrt(sum(app.v.^2,4)));
            else
                Vmag = repmat(app.aorta_seg,[1 1 1 app.nframes]).*squeeze(sqrt(sum(app.v.^2,4)));
            end
            idx = find(mean(app.aorta_seg,4));
            for t = 1:app.nframes
                tmp = Vmag(:,:,:,t);
                mean_velo(t) = mean(tmp(idx));
            end
            [~,app.time_peak] = find(mean_velo==max(mean_velo));

            app.isSegmentationLoaded = 1;
            
            if app.isTimeResolvedSeg
                app.SegTimeframeSpinner.Value = app.time_peak;
            end
            
            % enable flip checkbox now in case the slice dimension is
            % flipped
            app.flipSegLabel.Visible = 'on';
            app.flipsegio.Visible = 'on';
            app.flipseglr.Visible = 'on';
            app.flipsegud.Visible = 'on';
    
            % normalize
            app.aorta_seg = single(app.aorta_seg/max(abs(app.aorta_seg(:))));
            app.aorta_seg(find(app.aorta_seg)) = 1;

            View3DSegmentation(app);
            cd(currDir);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
        end

        % Value changed function: flipseglr
        function flipseglrValueChanged(app, event)
            app.aorta_seg = flip(app.aorta_seg,2);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);            
        end

        % Value changed function: flipsegud
        function flipsegudValueChanged(app, event)
            app.aorta_seg = flip(app.aorta_seg,1);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
        end

        % Value changed function: flipsegio
        function flipsegioValueChanged(app, event)
            app.aorta_seg = flip(app.aorta_seg,3);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
        end

        % Value changed function: SegTimeframeSpinner
        function SegTimeframeSpinnerValueChanged(app, event)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            if ~app.isRawDataCropped
                updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
            end
        end

        % Button pushed function: MapsPushButton
        function MapsPushButtonPushed(app, event)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);

                % crop velocity
                tempV = reshape(app.v,[prod(app.res),3,app.nframes]);
                tempV = tempV(maskIdx,:,:);
                tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
                app.v = tempV;
                app.vMean = mean(app.v,5);
                clear tempV

                % crop MAG
                tempMAG = reshape(app.MAG,[prod(app.res),app.nframes]);
                tempMAG = tempMAG(maskIdx,:);
                tempMAG = reshape(tempMAG,lx,ly,lz,app.nframes);
                app.MAG = tempMAG;
                clear tempMAG;

                % update magWeightVel and angio
                [app.magWeightVel, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

                % others to crop, segment and aorta_seg
                tempS = app.segment(:);
                tempS = tempS(maskIdx);
                tempS = reshape(tempS,lx,ly,lz);
                app.segment = tempS;
                clear tempS;
                if (app.isSegmentationLoaded)
                    tempS = app.aorta_seg(:);
                    tempS = reshape(tempS,length(tempS)/size(app.aorta_seg,4),size(app.aorta_seg,4));
                    tempS = tempS(maskIdx,:);
                    tempS = reshape(tempS,lx,ly,lz,size(app.aorta_seg,4));
                    app.aorta_seg = tempS;
                    clear tempS;
                else
                    app.aorta_seg = app.segment;
                end
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
            else % to ensure that updated thresholding is applied to aorta_seg
                if (~app.isSegmentationLoaded)
                    app.aorta_seg = app.segment;
                end
            end

            % switch to the correct tab and enable fields
            app.TabGroup.SelectedTab = app.Maps;
            app.TimeframeSpinnerLabel.Enable = 'on';
            app.TimeframeSpinner.Enable = 'on';
            app.quiverscaleEditFieldLabel.Enable = 'on';
            app.minQuiverEditField.Enable = 'on';
            app.toXEditFieldLabel_2.Enable = 'on';
            app.maxQuiverEditField.Enable = 'on';
            app.minVelocityVectorEditField.Enable = 'on';
            app.velocityVectortoEditFieldLabel.Enable = 'on';
            app.velocityVectorEditFieldLabel.Enable = 'on';
            app.maxVelocityVectorEditField.Enable = 'on';
            app.maxVelocityVectorEditField.Value = num2str(round(app.VENC/10));
            app.TimeframeSpinner.Limits = [1,app.nframes];

            % on the WSS tab
            app.MapTimeframeSpinnerLabel.Enable = 'on';
            app.MapTimeframeSpinner.Enable = 'off';
            app.MapTimeframeSpinner.Limits = [1,app.nframes];
            app.CalculateMap.Enable = 'on';

            app.PeaksystoleEditField.Value = num2str(app.time_peak);
            app.TimeframeSpinner.Value = app.time_peak;
            app.MapTimeframeSpinner.Value = app.time_peak;

            % view vectors
            viewVelocityVectors(app);
            % set initial limits for later plotting
            app.vvp_xlim = app.VelocityVectorsPlot.XLim;
            app.vvp_ylim = app.VelocityVectorsPlot.YLim;

            app.SaveAnimation.Enable = 'on';
        end

        % Button pushed function: PulseWaveVelocityPushButton
        function PulseWaveVelocityPushButtonButtonPushed(app, event)

            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);

                % crop velocity
                tempV = reshape(app.v,[prod(app.res),3,app.nframes]);
                tempV = tempV(maskIdx,:,:);
                tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
                app.v = tempV;
                app.vMean = mean(app.v,5);
                clear tempV

                % crop MAG
                tempMAG = reshape(app.MAG,[prod(app.res),app.nframes]);
                tempMAG = tempMAG(maskIdx,:);
                tempMAG = reshape(tempMAG,lx,ly,lz,app.nframes);
                app.MAG = tempMAG;
                clear tempMAG;

                % update magWeightVel and angio
                [app.magWeightVel, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

                % others to crop, segment and aorta_seg
                tempS = app.segment(:);
                tempS = tempS(maskIdx);
                tempS = reshape(tempS,lx,ly,lz);
                app.segment = tempS;
                clear tempS;
                if (app.isSegmentationLoaded)
                    tempS = app.aorta_seg(:);
                    tempS = reshape(tempS,length(tempS)/size(app.aorta_seg,4),size(app.aorta_seg,4));
                    tempS = tempS(maskIdx,:);
                    tempS = reshape(tempS,lx,ly,lz,size(app.aorta_seg,4));
                    app.aorta_seg = tempS;
                    clear tempS;
                else
                    app.aorta_seg = app.segment;
                end
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';

            end

            % these are hard-coded for now
            sortingCriteria = 3;
            spurLength = 3;

            se = strel('sphere',1);
            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    ss = imerode(app.aorta_seg(:,:,:,app.time_peak),se);
                else
                    ss = imerode(app.aorta_seg,se);
                end
            else
                ss = imerode(app.segment,se);
            end
            [~,~, app.branchList, ~] = feature_extraction( ...
                sortingCriteria, spurLength, app.vMean, ss);

            reset3DSegmentationAndCenterline(app);
            app.TabGroup.SelectedTab = app.FlowandPulseWaveVelocityTab;
        end

        % Button pushed function: Reset3DviewButton
        function Reset3DviewButtonPushed(app, event)
            reset3DSegmentationAndCenterline(app);
        end

        % Button pushed function: CheckcenterlinecalculateflowButton
        function CheckcenterlinecalculateflowButtonPushed(app, event)
            % Grab the branches from user input, then perform aorta segmentation, check
            % the points/segmentation is correct, and calculate flow waveforms

            % parse points
            ptRange = str2double(app.BranchDropDown.Value);

            if strcmp(app.Branch2Label.Visible, 'on')
                ptRange = cat(1,ptRange,str2double(app.BranchDropDown_2.Value));
            end
            if strcmp(app.Branch3Label.Visible, 'on')
                ptRange = cat(1,ptRange,str2double(app.BranchDropDown_3.Value));
            end
            if strcmp(app.Branch4Label.Visible, 'on')
                ptRange = cat(1,ptRange,str2double(app.BranchDropDown_4.Value));
            end

            idx = [];
            %  extract branches, if flip checkbox on, flip the centerline
            for b = 1:numel(ptRange)
                tmpIdx = find(app.branchList(:,4)==ptRange(b));
                % flip everything as default
                tmpIdx = flip(tmpIdx,1);
                switch b
                    case 1
                        if app.FlipBranch1.Value
                            tmpIdx = flip(tmpIdx,1);
                        end
                    case 2
                        if app.FlipBranch1_2.Value
                            tmpIdx = flip(tmpIdx,1);
                        end
                    case 3
                        if app.FlipBranch1_3.Value
                            tmpIdx = flip(tmpIdx,1);
                        end
                    case 4
                        if app.FlipBranch1_4.Value
                            tmpIdx = flip(tmpIdx,1);
                        end
                end
                idx = cat(1,idx,tmpIdx);
            end
            app.branchActual = app.branchList(idx,1:3);

            % smooth the centerline for visualization and measurements
            windowWidth = 5;    % the smoothing window
            polynomialOrder = 1;
            xsg=sgolayfilt(app.branchActual(:,1),polynomialOrder, windowWidth);
            ysg=sgolayfilt(app.branchActual(:,2),polynomialOrder, windowWidth);
            zsg=sgolayfilt(app.branchActual(:,3),polynomialOrder, windowWidth);
            app.branchActual = ([xsg,ysg,zsg]);

            reset3DSegmentationAndCenterline(app);
            hline2 = line(app.View3D_2,app.branchActual(:,2),app.branchActual(:,1),app.branchActual(:,3),...
                'Color','g','Marker','*','MarkerSize',12,'LineStyle','none');

            choice = choosedialog;
            
            switch choice
                case 0
                    msgbox('Change selected branch numbers')
                    reset3DSegmentationAndCenterline(app);
                    return;
                    
                case 1
                    
                    clc;
                    % now we've found the centerline:
                    % 1. calculate aorta segmentation (if not already available
                    % 2. perform non-rigid registration to get time-resolved aortic
                    % segmentation
                    % 3. calculate flow
                    
                    % calculate aorta segmentation, if not already available
                    if ~app.isSegmentationLoaded   % create a new aorta_seg
                        x = round(app.branchActual(:,1)); 
                        y = round(app.branchActual(:,2)); 
                        z = round(app.branchActual(:,3));
                        index = sub2ind(size(app.segment),x,y,z);
                        g = zeros(size(app.segment));
                        g(index) = 1;
                        
                        se = strel('sphere',4);
                        gg = imdilate(g,se);
                        
                        app.aorta_seg = smooth3(gg);
                    end
                    
                    % spot to create timeresolved segmentation, or use
                    % what was already loaded
                    if app.isTimeResolvedSeg
                        aortaSeg_timeResolved = app.aorta_seg;
                    else
                        aortaSeg_timeResolved = zeros([size(app.angio) app.nframes]);
                        for j = 1:app.nframes
                            if app.isSegmentationLoaded
                                aortaSeg_timeResolved(:,:,:,j) = app.aorta_seg;
                            else
                                aortaSeg_timeResolved(:,:,:,j) = app.segment;
                            end
                        end
                    end
                    
                    app.branchActual = flipud(app.branchActual);
                    
                    % Calculate flow over whole aorta
                    displayWaitBar = true;
                    [app.flowPerHeartCycle_vol, app.flowPulsatile_vol, app.contours, app.tangent_V, app.area_val] = ...
                        params_timeResolved(app.branchActual, app.angio, app.MAG, app.v, app.nframes, app.pixdim, aortaSeg_timeResolved, app.isSegmentationLoaded,...
                        app.isTimeResolvedSeg, displayWaitBar);
                    
                    % flows are calculated, so we can enable 'Display Distance'
                    % and 'Parameter Drop Down'
                    app.DisplayDistanceCheckbox.Enable = true;
                    app.DisplayDistanceCheckbox.Visible = 'on';
                    app.ParameterDropDown.Enable = true;
                    app.ParameterDropDown.Visible = 'on';
                    app.ParameterLabel.Visible = 'on';
                    % calculate distance
                    branch = app.branchActual;
                    vox = mean(app.pixdim);
                    for i=2:size(branch,1)
                        dist_vec(i-1) = norm(branch(i,:)-branch(i-1,:))*vox;
                    end
                    app.FullBranchDistance = round([0 cumsum(dist_vec)],1);
                    if app.DisplayDistanceCheckbox.Value
                        % immediately calculate PWV
                        app.PWVPoints.Value = [num2str(app.FullBranchDistance(1)) ': ' ...
                            num2str(app.FullBranchDistance(length(branch)))];
                        app.PWVPointsLabel.Text = ['PWV dist (mm) [' num2str(app.FullBranchDistance(1)) ':' ...
                            num2str(app.FullBranchDistance(length(branch))) ']'];
                    else
                        % immediately calculate PWV
                        app.PWVPoints.Value = ['1: ' num2str(length(app.branchActual))];
                        app.PWVPointsLabel.Text = ['PWV Points [1:' num2str(length(app.branchActual)) ']'];
                    end
                    CalculatePWVButtonPushed(app, event);
                    
                    % view the flows at each centerline point, and plot the waveforms
                    view3D_wParams(app);
                    plotWaveforms(app);
                    app.VectorOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
                    
                case 2  % go into update_centerline code for manual adjustments
                    if app.isTimeResolvedSeg
                        data = app.aorta_seg(:,:,:,app.time_peak);
                    else
                        data = app.aorta_seg;
                    end
                    app.branchActual = update_centerline(data,app.branchActual);
                    reset3DSegmentationAndCenterline(app);
                    hline2 = line(app.View3D_2,app.branchActual(:,2),app.branchActual(:,1),app.branchActual(:,3),...
                        'Color','g','Marker','*','MarkerSize',12,'LineStyle','none');
                    
                    clc;
                    % now we've found the centerline:
                    % 1. calculate aorta segmentation (if not already available
                    % 2. perform non-rigid registration to get time-resolved aortic
                    % segmentation
                    % 3. calculate flow
                    
                    % calculate aorta segmentation, if not already available
                    if ~app.isSegmentationLoaded   % create a new aorta_seg
                        x = round(app.branchActual(:,1));
                        y = round(app.branchActual(:,2)); 
                        z = round(app.branchActual(:,3));
                        index = sub2ind(size(app.segment),x,y,z);
                        g = zeros(size(app.segment));
                        g(index) = 1;
                        
                        se = strel('sphere',4);
                        gg = imdilate(g,se);
                        
                        app.aorta_seg = smooth3(gg);
                    end
                    
                    % spot to create timeresolved segmentation, or use
                    % what was already loaded
                    if app.isTimeResolvedSeg
                        aortaSeg_timeResolved = app.aorta_seg;
                    else
                        aortaSeg_timeResolved = zeros([size(app.angio) app.nframes]);
                        for j = 1:app.nframes
                            if app.isSegmentationLoaded
                                aortaSeg_timeResolved(:,:,:,j) = app.aorta_seg;
                            else
                                aortaSeg_timeResolved(:,:,:,j) = app.segment;
                            end
                        end
                    end
                                        
                    % Calculate flow over whole aorta
                    displayWaitBar = true;
                    [app.flowPerHeartCycle_vol, app.flowPulsatile_vol, app.contours, app.tangent_V, app.area_val] = ...
                        params_timeResolved(app.branchActual, app.angio, app.MAG, app.v, app.nframes, app.pixdim, aortaSeg_timeResolved, app.isSegmentationLoaded,...
                        app.isTimeResolvedSeg, displayWaitBar);
                    
                    % flows are calculated, so we can enable 'Display Distance'
                    % and 'Parameter Drop Down'
                    app.DisplayDistanceCheckbox.Enable = true;
                    app.DisplayDistanceCheckbox.Visible = 'on';
                    app.ParameterDropDown.Enable = true;
                    app.ParameterDropDown.Visible = 'on';
                    app.ParameterLabel.Visible = 'on';
                    % calculate distance
                    branch = app.branchActual;
                    vox = mean(app.pixdim);
                    for i=2:size(branch,1)
                        dist_vec(i-1) = norm(branch(i,:)-branch(i-1,:))*vox;
                    end
                    app.FullBranchDistance = round([0 cumsum(dist_vec)],1);
                    if app.DisplayDistanceCheckbox.Value
                        % immediately calculate PWV
                        app.PWVPoints.Value = [num2str(app.FullBranchDistance(1)) ': ' ...
                            num2str(app.FullBranchDistance(length(branch)))];
                        app.PWVPointsLabel.Text = ['PWV dist (mm) [' num2str(app.FullBranchDistance(1)) ':' ...
                            num2str(app.FullBranchDistance(length(branch))) ']'];
                    else
                        % immediately calculate PWV
                        app.PWVPoints.Value = ['1: ' num2str(length(app.branchActual))];
                        app.PWVPointsLabel.Text = ['PWV Points [1:' num2str(length(app.branchActual)) ']'];
                    end
                    CalculatePWVButtonPushed(app, event);
                    
                    % view the flows at each centerline point, and plot the waveforms
                    view3D_wParams(app);
                    plotWaveforms(app);
                    app.VectorOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
                    
                    
                    app.VectorOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
            end
        end

        % Button pushed function: PlotWaveformsButton
        function PlotWaveformsButtonPushed(app, event)
            plotWaveforms(app);
        end

        % Button pushed function: CalculatePWV
        function CalculatePWVButtonPushed(app, event)
            cla(app.PWVCalcDisplay)
            % grab waveforms
            x = round(app.branchActual(:,1)); 
            y = round(app.branchActual(:,2)); 
            z = round(app.branchActual(:,3));
            index = sub2ind(size(app.segment),x,y,z);
            waveforms = app.flowPulsatile_vol(index,:);

            % parse points
            str = app.PWVPoints.Value;
            if app.DisplayDistanceCheckbox.Value
                % convert distance to points
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                ptRange = minIdx:minIdx2;
            else
                eval(['ptRange=[' str '];']);
            end
            waveforms = waveforms(ptRange,:);

            % grab PWV calc type: 1 is cross correlation, 2 is Wavelet, 3 is
            % maximum likelihood estimation
            % can be updated with update to calc_pwv
            switch app.PWVType.Value
                case 'Cross-correlation'
                    PWVcalctype = 1;
                    if numel(ptRange) < 3
                        errordlg('Need at least 3 points for cross-correlation PWV calculation')
                        return;
                    end
                case 'Wavelet'
                    PWVcalctype = 2;
                    if numel(ptRange) < 3
                        errordlg('Need at least 3 points for Wavelet PWV calculation')
                        return;
                    end
                case 'Maximum likelihood'
                    PWVcalctype = 3;
                case 'Jarvis XCorr'
                    PWVcalctype = 4;
                    if numel(ptRange) < 3
                        errordlg('Need at least 3 points for cross-correlation PWV calculation')
                        return;
                    end
            end
            
            % pass data into calc_pwv
            branch = app.branchActual(ptRange,:);
            vox = mean(app.pixdim);
            for i=2:size(branch,1)
                dist_vec(i-1) = norm(branch(i,:)-branch(i-1,:))*vox;
            end
            % total distance along centerline
            if PWVcalctype == 3 % max likelihood needs the 'zero' distance
                dist_total = [0 cumsum(dist_vec)];
            else
                dist_total = cumsum(dist_vec);
            end
            
            if PWVcalctype == 4     % Jarvis method, interpolate to 1 mm distances
                % interpolate waveforms to 1 mm resolution to extract
                % equally spaced waveforms
                xq = min(dist_total):ceil(max(dist_total));
                waveforms = interp1([0 dist_total],waveforms,xq,'spline');
                
                % and then take every 4th waveform for PWV calculation, 4
                % mm separation
                waveforms = waveforms(1:4:end,:);
                dist_total = xq(1:4:end);
            end
            

            if PWVcalctype < 3

                % calculate PWV using the delay times using xcorrelation
                [D,fitObject, R, dist_total2] = calc_pwv(waveforms,dist_total,app.timeres,PWVcalctype,app.area_val(ptRange));
                % the PWV, 1/slope of fit
                PWV = 1/fitObject(1);
                % the R2 of the fit
                app.R2 = R(2).*R(2);

                y1 = polyval(fitObject,dist_total2,'r');

                % plot and display slope
                cla(app.PWVCalcDisplay)
                scatter(app.PWVCalcDisplay,dist_total2,D,'.k','SizeData',75);
                hold(app.PWVCalcDisplay,'on');
                plot(app.PWVCalcDisplay,dist_total2,y1,'b','LineWidth',2);
                legend(app.PWVCalcDisplay,'delays','linear fit','Location','Northwest')
                app.PWVCalcDisplay.XLabel.String = 'distance (mm)';
                switch PWVcalctype
                    case 1
                        str = 'cross-corr delay (ms)';
                        app.PWVCalcDisplay.YLim = [0 max(D)+1];
                    case 2
                        str = 'wavelet delay (ms)';
                        app.PWVCalcDisplay.YLim = [0 max(D)+1];
                end
                app.PWVDisplayTitle_2.Text = ['R' char(178)];
                app.PWVCalcDisplay.YLabel.String = str;
                title(app.PWVCalcDisplay,'')
            elseif PWVcalctype == 3 % directly calculate PWV using maximum likelihood

                % distance in meters
                d = dist_total'/1000;

                % time res in seconds
                tRes = app.timeres/1000;

                % to follow Anders/Cecilia code, convert to velocity
                pwv0 = 10; %initial guess
                tempArea = double(mean(app.area_val(ptRange,:),2));
                vel = double(detrend(waveforms'./repmat(tempArea,1,app.nframes)','constant')'); % converted to average velocity
                scaling = 1./std(vel(:,:),[],2);
                vsc = vel.*repmat(scaling,1,app.nframes);
                mean_flow = mean(vsc);
                inParams=[randn(1,app.nframes), pwv0]; %
                fun1=@(inParams)PWVest3_share(inParams,d,vsc,tRes,tempArea./(scaling.^2));
                options = optimset('Display','iter', 'TolCon', 1e-7, 'TolX', 1e-7, 'TolFun', 1e-7,'DiffMinChange', 1e-3);
                [params,exitflag,output] = fminunc(fun1,inParams, options);
                PWV = params(end);

                card_time = [0:app.nframes-1]*app.timeres;
                cla(app.PWVCalcDisplay)
                plot(app.PWVCalcDisplay,card_time,mean_flow,'k','LineWidth',2);
                hold(app.PWVCalcDisplay,'on');
                plot(app.PWVCalcDisplay,card_time,params(1:end-1),'b','LineWidth',2);
                app.PWVCalcDisplay.YLim = [min([params(1:end-1) mean_flow]) ...
                    max([params(1:end-1) mean_flow])];
                legend(app.PWVCalcDisplay,'initial guess','final waveform','Location','Northeast')
                app.PWVCalcDisplay.XLabel.String = 'cardiac time (ms)';
                app.PWVCalcDisplay.YLabel.String = 'velocity wave (a.u.)';
                app.R2 = [];        % no R2 needed for the method
                title(app.PWVCalcDisplay,'')
            else    % Jarvis cross-correlation method over all points
                
                clear tempPWV R2tmp
                for chk = 1:size(waveforms,1)
                    % simply circshift
                    ww2 = circshift(waveforms,chk-1,1);
                    
                    currDist = circshift(dist_total(2:end),chk-1);
                    currDist = 4 + abs(currDist - currDist(1));
                    
                    % pass data into calc_pwv
                    % calculate PWV using the delay times
                    [D,fitObject, R, ~] = calc_pwv(ww2,currDist,app.timeres,1,app.area_val(ptRange));
                    
                    tempPWV(chk) = 1/fitObject(1);
                    % how good is the fit? calculate R
                    R2tmp(chk) = R(2).*R(2);
                    
                end
                
%                 % only keep tempPWV with R^2 > 0.5
%                 idx = find(R2tmp>0.5);
                idx = find(ones(size(R2tmp)));
                
                % if data is normal, take the mean, otherwise take the median
                isNORM = adtest(tempPWV(tempPWV(idx)>0));
                if isNORM
                    PWV = mean(tempPWV(tempPWV(idx)>0));
                    app.R2 = std(tempPWV(tempPWV(idx)>0));
                    app.PWVDisplayTitle_2.Text = 'stdev';
                    addstr = 'normal distribution, use mean';
                else
                    PWV = median(tempPWV(tempPWV(idx)>0));
                    app.R2 = iqr(tempPWV(tempPWV(idx)>0));
                    app.PWVDisplayTitle_2.Text = 'iqr';
                    addstr = 'non-normal distribution, use median';
                end
                
                % display results
                cla(app.PWVCalcDisplay)
                scatter(app.PWVCalcDisplay,dist_total(idx),tempPWV(idx),'.k','SizeData',75);
                hold(app.PWVCalcDisplay,'on');
                yline(app.PWVCalcDisplay,PWV,'r--','LineWidth',2);
                xlim(app.PWVCalcDisplay, [0 max(dist_total)])
                ylim(app.PWVCalcDisplay, [min(tempPWV) max(tempPWV)])
                ylabel(app.PWVCalcDisplay, 'PWV (m/s)')
                app.PWVCalcDisplay.XLabel.String = 'distance (mm)';
                title(app.PWVCalcDisplay, addstr)
                legend(app.PWVCalcDisplay,'PWV over vessel','final PWV','location','northeast') 
            end
            app.PWVDisplay.Value = sprintf('%1.2f', PWV);
            app.R2Display.Value = sprintf('%0.3f', app.R2);

            % if 'find best fit' checked, repeat PWV measurements across the
            % 20 closest starting points
            if app.findBestFit_checkbox.Value && PWVcalctype < 3
                nChks = 20;
                Chks = min(ptRange)-nChks/2:min(ptRange)+nChks/2; Chks(Chks<1) = [];
                count = 0;
                for chk = Chks
                    count = count+1;
                    tmpPtRange = chk:max(ptRange);
                    waveforms = app.flowPulsatile_vol(index,:);
                    % pass data into calc_pwv
                    branch = app.branchActual(tmpPtRange,:);
                    clear dist_vec
                    for i=2:size(branch,1)
                        dist_vec(i-1) = norm(branch(i,:)-branch(i-1,:))*vox;
                    end
                    [~,fitObject, R, ~] = calc_pwv(waveforms(tmpPtRange,:),cumsum(dist_vec),app.timeres,PWVcalctype,app.area_val(ptRange));
                    tempPWV(count) = 1/fitObject(1);
                    tempR2(count) = R(2).*R(2);
                end

                [R,I] = max(tempR2);
                PWV = tempPWV(I);
            end

            view3D_wParams(app);
            plotWaveforms(app);

            if app.findBestFit_checkbox.Value && PWVcalctype < 3
                % inform of the best fit
                msgbox(sprintf('Best fit found for starting point=%i; R^2=%0.3f; PWV=%1.2f m/s', Chks(I), R, PWV), 'Best fit','replace')
            end
        end

        % Button pushed function: SaveResultsCallback
        function SaveResultsCallbackButtonPushed(app, event)

            savePrefix = app.SaveName.Value;
            saveFolder = fullfile(app.directory, 'PWV_results'); mkdir(saveFolder);
            saveName =  fullfile(saveFolder, savePrefix);

            % is DisplayDistance, convert to true points for saving
            if app.DisplayDistanceCheckbox.Value
                % convert distance to points
                str = app.PWVPoints.Value;
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                PWV = table(str2double(app.PWVDisplay.Value),{app.R2},{[num2str(minIdx) ':' num2str(minIdx2)]});
            else
                PWV = table(str2double(app.PWVDisplay.Value),{app.R2},{app.PWVPoints.Value});
            end

            PWV.Properties.VariableNames = {'PWV','R2','Save_Points'};
            writetable(PWV,[saveName '.xlsx'],'Sheet','PWV');

            % save the waveforms too
            % grab waveforms
            x = round(app.branchActual(:,1));
            y = round(app.branchActual(:,2)); 
            z = round(app.branchActual(:,3));
            index = sub2ind(size(app.aorta_seg),x,y,z);
            waveforms = app.flowPulsatile_vol(index,:);
            str = app.PWVPoints.Value;
            if app.DisplayDistanceCheckbox.Value
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                ptRange = minIdx:minIdx2;
            else
                eval(['ptRange=[' str '];']);
            end
            waveforms = waveforms(ptRange,:);
            card_time = [0:app.nframes-1]*app.timeres;
            tbl = array2table(cat(2,card_time',waveforms'));
            tbl.Properties.VariableNames = ["cardiac time(ms)",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','flow(ml per s)');

            % grab and save image
            robot = java.awt.Robot();
            temp = app.FlowProcessingUIFigure.Position; % returns position as [left bottom width height]
            allMonPos = get(0,'MonitorPositions');
            curMon = find(temp(1)<(allMonPos(:,1)+allMonPos(:,3)),1,'first');
            curMonHeight = allMonPos(curMon,4)+1;
            pos = [temp(1) curMonHeight-(temp(2)+temp(4)) temp(3)-1 temp(4)]; % [left top width height].... UL X, UL Y, width, height
            rect = java.awt.Rectangle(pos(1),pos(2),pos(3),pos(4));
            cap = robot.createScreenCapture(rect);
            % Convert to an RGB image
            rgb = typecast(cap.getRGB(0,0,cap.getWidth,cap.getHeight,[],0,cap.getWidth),'uint8');
            imgData = zeros(cap.getHeight,cap.getWidth,3,'uint8');
            imgData(:,:,1) = reshape(rgb(3:4:end),cap.getWidth,[])';
            imgData(:,:,2) = reshape(rgb(2:4:end),cap.getWidth,[])';
            imgData(:,:,3) = reshape(rgb(1:4:end),cap.getWidth,[])';
            imwrite(imgData, [saveName '.tiff']);

            % save the processing information in a results struct
            results = [];
            results.directory = app.directory;
            results.segDirectory = app.segDirectory;
            results.branchActual = app.branchActual;
            results.segment = app.segment;
            results.flowPulsatile = app.flowPulsatile_vol;
            results.flowPerHeartCycle_vol = app.flowPerHeartCycle_vol;
            results.mask = app.mask;
            results.aorta_seg = app.aorta_seg;
            %             results.MAG = app.MAG;
            %             results.v = app.v;
            results.nframes = app.nframes;
            results.fov = app.fov;
            results.pixdim = app.pixdim;
            results.timeres = app.timeres;
            results.angio = app.angio;
            results.VENC = app.VENC;
            save([saveName '_results.mat'],'results','-v7.3')

            % inform of the saving
            msgbox(['results saved to ' saveName '.xlsx'], 'Saving complete','replace')
        end

        % Button pushed function: CropButton
        function CropButtonPushed(app, event)
            if app.isSegmentationLoaded
                img2 = app.AxesX.Children(1).AlphaData;
            else
                img2 = [];
            end
            img = app.AxesX.Children(length(app.AxesX.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_xstart = str2double(app.XrangeEditField.Value);
            m_xstop = str2double(app.toXEditField.Value);
            m_ystart = maskSz(2);m_ystop = maskSz(2)+maskSz(4);
            m_zstart = maskSz(1);m_zstop = maskSz(1)+maskSz(3);

            tempMask = zeros(size(img));tempMask(m_ystart:m_ystop,m_zstart:m_zstop) = 1;
            app.mask = app.mask.*repmat(permute(tempMask,[3 1 2]),[size(app.mask,1) 1 1]);

            % update angio and segmentation
            app.angio = app.angio.*app.mask;
            app.segment = app.segment.*app.mask;
            if (app.isSegmentationLoaded)
                app.aorta_seg = app.aorta_seg.*app.mask;
            else
                app.aorta_seg = app.segment;
            end

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
            View3DSegmentation(app);
        end

        % Button pushed function: CropButton_2
        function CropButton_2Pushed(app, event)
            if app.isSegmentationLoaded
                img2 = app.AxesY.Children(1).AlphaData;
            else
                img2 = [];
            end
            img = app.AxesY.Children(length(app.AxesY.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_xstart = maskSz(2);m_xstop = maskSz(2)+maskSz(4);
            m_ystart = str2double(app.YrangeEditField.Value);
            m_ystop = str2double(app.toYEditField.Value);
            m_zstart = maskSz(1);m_zstop = maskSz(1)+maskSz(3);

            tempMask = zeros(size(img));tempMask(m_xstart:m_xstop,m_zstart:m_zstop) = 1;
            app.mask = app.mask.*repmat(permute(tempMask,[1 3 2]),[1 size(app.mask,2) 1]);

            % update angio and segmentation
            app.angio = app.angio.*app.mask;
            app.segment = app.segment.*app.mask;
            if (app.isSegmentationLoaded)
                app.aorta_seg = app.aorta_seg.*app.mask;
            else
                app.aorta_seg = app.segment;
            end

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
            View3DSegmentation(app);
        end

        % Button pushed function: CropButton_3
        function CropButton_3Pushed(app, event)
            if app.isSegmentationLoaded
                img2 = app.AxesZ.Children(1).AlphaData;
            else
                img2 = [];
            end
            img = app.AxesZ.Children(length(app.AxesZ.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_xstart = maskSz(2);m_xstop = maskSz(2)+maskSz(4);
            m_ystart = maskSz(1);m_ystop = maskSz(1)+maskSz(3);
            m_zstart = str2double(app.ZrangeEditField.Value);
            m_zstop = str2double(app.toZEditField.Value);

            tempMask = zeros(size(img));tempMask(m_xstart:m_xstop,m_ystart:m_ystop) = 1;
            app.mask = app.mask.*repmat(tempMask,[1 1 size(app.mask,3)]);

            % update angio and segmentation
            app.angio = app.angio.*app.mask;
            app.segment = app.segment.*app.mask;
            if (app.isSegmentationLoaded)
                app.aorta_seg = app.aorta_seg.*app.mask;
            else
                app.aorta_seg = app.segment;
            end

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
            View3DSegmentation(app);
        end

        % Button pushed function: FinishedCroppingButton
        function FinishedCroppingButtonPushed(app, event)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);

                % crop velocity
                tempV = reshape(app.v,[prod(app.res),3,app.nframes]);
                tempV = tempV(maskIdx,:,:);
                tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
                app.v = tempV;
                app.vMean = mean(app.v,5);
                clear tempV

                % crop MAG
                tempMAG = reshape(app.MAG,[prod(app.res),app.nframes]);
                tempMAG = tempMAG(maskIdx,:);
                tempMAG = reshape(tempMAG,lx,ly,lz,app.nframes);
                app.MAG = tempMAG;
                clear tempMAG;

                % update magWeightVel and angio
                [app.magWeightVel, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

                % others to crop, segment and aorta_seg
                tempS = app.segment(:);
                tempS = tempS(maskIdx);
                tempS = reshape(tempS,lx,ly,lz);
                app.segment = tempS;
                clear tempS;
                if (app.isSegmentationLoaded)
                    tempS = app.aorta_seg(:);
                    tempS = reshape(tempS,length(tempS)/size(app.aorta_seg,4),size(app.aorta_seg,4));
                    tempS = tempS(maskIdx,:);
                    tempS = reshape(tempS,lx,ly,lz,size(app.aorta_seg,4));
                    app.aorta_seg = tempS;
                    clear tempS;
                else
                    app.aorta_seg = app.segment;
                end
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
                app.FinishedCroppingButton.Enable = 'off';
            end
            View3DSegmentation(app);
        end

        % Button pushed function: RotateLeft
        function RotateLeftButtonPushed(app, event)
            rotate(app.hpatch1,[0 1 0],10)
            if (app.isSegmentationLoaded)
                rotate(app.hpatch2,[0 1 0],10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)+10];
        end

        % Button pushed function: RotateRight
        function RotateRightButtonPushed(app, event)
            rotate(app.hpatch1,[0 1 0],-10)
            if (app.isSegmentationLoaded)
                rotate(app.hpatch2,[0 1 0],-10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)-10];
        end

        % Button pushed function: RotateDown
        function RotateDownButtonPushed(app, event)
            rotate(app.hpatch1,[1 0 0],10)
            if (app.isSegmentationLoaded)
                rotate(app.hpatch2,[1 0 0],10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)+10 app.rotAngles(2)];
        end

        % Button pushed function: RotateUp
        function RotateUpButtonPushed(app, event)
            rotate(app.hpatch1,[1 0 0],-10)
            if (app.isSegmentationLoaded)
                rotate(app.hpatch2,[1 0 0],-10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)-10 app.rotAngles(2)];
        end

        % Button pushed function: ResetRotation
        function ResetRotationButtonPushed(app, event)
            % update rotate angles
            app.rotAngles = [0 0];
            View3DSegmentation(app);
        end

        % Button pushed function: AddbranchButton
        function AddbranchButtonPushed(app, event)
            % turn on branch 2 if not on
            if strcmp(app.Branch2Label.Visible, 'off')
                app.Branch2Label.Visible = 'on';
                app.BranchDropDown_2.Visible = 'on';
                app.FlipBranch1_2.Visible = 'on';
                app.deleteBranch2.Visible = 'on';
                % update items to remove branch 1
                currBranches = app.BranchDropDown.Value;
                idx=strcmp(currBranches,app.BranchDropDown.Items);
                app.BranchDropDown_2.Items = app.BranchDropDown.Items(~idx);
                % turn on branch 3
            elseif strcmp(app.Branch3Label.Visible,'off')
                app.Branch3Label.Visible = 'on';
                app.BranchDropDown_3.Visible = 'on';
                app.FlipBranch1_3.Visible = 'on';
                app.deleteBranch3.Visible = 'on';
                app.deleteBranch2.Visible = 'off';
                % update items to remove branch 1 and branch 2
                idx=strcmp(app.BranchDropDown.Value,app.BranchDropDown.Items) | ...
                    strcmp(app.BranchDropDown_2.Value,app.BranchDropDown.Items);
                app.BranchDropDown_3.Items = app.BranchDropDown.Items(~idx);
                % turn on branch 4
            elseif strcmp(app.Branch4Label.Visible,'off')
                app.Branch4Label.Visible = 'on';
                app.BranchDropDown_4.Visible = 'on';
                app.FlipBranch1_4.Visible = 'on';
                app.deleteBranch4.Visible = 'on';
                app.deleteBranch3.Visible = 'off';
                % update items to remove branch 1 and branch 2
                idx=strcmp(app.BranchDropDown.Value,app.BranchDropDown.Items) | ...
                    strcmp(app.BranchDropDown_2.Value,app.BranchDropDown.Items) | ...
                    strcmp(app.BranchDropDown_3.Value,app.BranchDropDown.Items);
                app.BranchDropDown_4.Items = app.BranchDropDown.Items(~idx);
            end
        end

        % Value changed function: AdjustthresholdSlider
        function AdjustthresholdSliderValueChanged(app, event)
            value = app.AdjustthresholdSlider.Value;

            % update segmentation
            [muhat,sigmahat] = norm_fit(app.angio(:));

            app.segment = zeros(size(app.angio));
            app.segment(app.angio>muhat+value*sigmahat) = 1;
            app.segment = bwareaopen(app.segment,round(sum(app.segment(:)).*0.005),6); %The value at the end of the commnad in the minimum area of each segment to keep
            app.segment = imfill(app.segment,18,'holes'); % Fill in holes created by slow flow on the inside of vessels
            app.segment = single(app.segment);

            % update 3D isosurface view
            View3DSegmentation(app);
        end

        % Button pushed function: deleteBranch2
        function deleteBranch2ButtonPushed(app, event)
            app.Branch2Label.Visible = 'off';
            app.BranchDropDown_2.Visible = 'off';
            app.FlipBranch1_2.Visible = 'off';
            app.deleteBranch2.Visible = 'off';
        end

        % Button pushed function: deleteBranch3
        function deleteBranch3ButtonPushed(app, event)
            app.Branch3Label.Visible = 'off';
            app.BranchDropDown_3.Visible = 'off';
            app.FlipBranch1_3.Visible = 'off';
            app.deleteBranch3.Visible = 'off';
            app.deleteBranch2.Visible = 'on';
        end

        % Button pushed function: deleteBranch4
        function deleteBranch4ButtonPushed(app, event)
            app.Branch4Label.Visible = 'off';
            app.BranchDropDown_4.Visible = 'off';
            app.FlipBranch1_4.Visible = 'off';
            app.deleteBranch4.Visible = 'off';
            app.deleteBranch3.Visible = 'on';
        end

        % Value changed function: DisplayDistanceCheckbox
        function DisplayDistanceCheckboxValueChanged(app, event)
            value = app.DisplayDistanceCheckbox.Value;
            str = app.PWVPoints.Value;

            if value
                % grab distances
                eval(['ptRange=[' str '];']);
                app.PWVPoints.Value = [num2str(app.FullBranchDistance(ptRange(1))) ': ' num2str(app.FullBranchDistance(ptRange(end)))];
                app.PWVPointsLabel.Text = ['Vessel dist (mm) [' num2str(app.FullBranchDistance(ptRange(1))) ':' num2str(app.FullBranchDistance(ptRange(end))) ']'];
            else
                % convert distance to points
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                ptRange = minIdx:minIdx2;
                app.PWVPoints.Value = [num2str(ptRange(1)) ': ' num2str(ptRange(end))];
                app.PWVPointsLabel.Text = ['PWV Points [' num2str(ptRange(1)) ':' num2str(ptRange(end)) ']'];
            end
            view3D_wParams(app);
            plotWaveforms(app);
        end

        % Value changed function: ParameterDropDown
        function ParameterDropDownValueChanged(app, event)
            view3D_wParams(app);
            plotWaveforms(app);
        end

        % Value changed function: TimeframeSpinner
        function TimeframeSpinnerValueChanged(app, event)
            if app.LinkplotsCheckBox.Value
                app.MapTimeframeSpinner.Value = app.TimeframeSpinner.Value;
                switch app.MapType.Value
                    case 'Wall shear stress'
                        if app.isWSScalculated && length(app.WSS_matrix) > 1
                            viewWSS(app);
                        end
                    case 'Peak velocity'
                        viewPeakVelocity(app);
                    case 'Mean velocity'
                        viewMeanVelocity(app);
                    case 'Kinetic energy'
                        viewKE(app);
                end
            end
            viewVelocityVectors(app);
        end

        % Value changed function: MapTimeframeSpinner
        function MapTimeframeSpinnerValueChanged(app, event)
            switch app.MapType.Value
                case 'Wall shear stress'
                    viewWSS(app);
                case 'Peak velocity'
                    viewPeakVelocity(app);
                case 'Mean velocity'
                    viewMeanVelocity(app);
                case 'Kinetic energy'
                    viewKE(app);
            end
            if app.LinkplotsCheckBox.Value
                app.TimeframeSpinner.Value = app.MapTimeframeSpinner.Value;
                viewVelocityVectors(app);
            end

        end

        % Value changed function: SliceSpinner_2
        function SliceSpinner_2ValueChanged(app, event)
            viewVelocityVectors(app);
        end

        % Button pushed function: CalculateMap
        function CalculateMapPushed(app, event)

            switch app.MapType.Value
                case 'Wall shear stress'
                    % gather parameters for calculation
                    prompt = {'Frames (peak systole (0) or all frames (1)):','Use wall effects (0 or 1):',...
                        'Viscosity (Pa•s):'};
                    dlgtitle = 'WSS calculation parameters';
                    dims = [1 65];
                    definput = {'0','0','0.0032'};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);

                    peakSystole = str2double(answer{1})==0;
                    viscosity = str2double(answer{3});

                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:size(app.aorta_seg,2))*app.pixdim(1),(1:size(app.aorta_seg,1))*app.pixdim(2), ...
                        (1:size(app.aorta_seg,3))*app.pixdim(3));

                    [Faces,Verts] = isosurface(xcoor_grid,ycoor_grid,zcoor_grid,-1.*app.aorta_seg,-0.5);
                    [Faces,Verts] = SmoothLaplacian(Faces,Verts,15); %laplacian smoothing for surface (Kevin Moerman)

                    % check and correct surface faces / vertices
                    [surface_faces,surface_vertices] = cleanupFV(Faces,Verts);
                    surface_vertices = surface_vertices .*1e-3;

                    % calculate normal vectors - uses external function
                    n = patchnormals(struct('faces',surface_faces,'vertices',surface_vertices));

                    mask_segmentation = find(app.aorta_seg);
                    maskedData_x = xcoor_grid(mask_segmentation) .*1e-3;
                    maskedData_y = ycoor_grid(mask_segmentation) .*1e-3;
                    maskedData_z = zcoor_grid(mask_segmentation) .*1e-3;

                    points_inside_mesh = isPointInsideMesh(surface_faces,surface_vertices,n,[maskedData_x,maskedData_y,maskedData_z],'inside');

                    % VARIABLE INWARD NORMAL:
                    number_of_points_on_normal = ones(size(surface_vertices,1),1).*3; %round(length_inward_normal_in_m./distance_per_point_in_m);
                    length_inward_normal_in_m  = getMaximumDiameter(surface_faces,surface_vertices,n) ./ 2;% ./ number_of_points_on_normal

                    diameter = length_inward_normal_in_m.*2*100;

                    L = (isnan(length_inward_normal_in_m));
                    workaround1 = length_inward_normal_in_m;
                    workaround1(L) = [];
                    length_inward_normal_in_m(L)=mean(workaround1);

                    disp(['mean length_inward_normal_in_cm = ' num2str(mean(length_inward_normal_in_m)*100)])
                    disp(['max length_inward_normal_in_cm = ' num2str(max(length_inward_normal_in_m)*100)])
                    disp(['min length_inward_normal_in_cm = ' num2str(min(length_inward_normal_in_m)*100)])

                    close all;
                    figure('Name','Diameter');
                    patch('faces',Faces,'vertices',Verts,'EdgeColor','none','FaceVertexCData',diameter,'FaceColor','interp','faceAlpha',1);colorbar
                    axis equal, view([0 0 1]); axis off
                    caxis([0 4])
                    axis ij
                    set(gca,'ZDir','reverse');
                    hold off
                    drawnow;

                    %% STEP 2: DATA INTERPOLATION
                    disp('================================================================================')
                    disp('Step 2: interpolating velocity data.');
                    maskedData_x = [maskedData_x(points_inside_mesh(:)); surface_vertices(:,1)];
                    maskedData_y = [maskedData_y(points_inside_mesh(:)); surface_vertices(:,2)];
                    maskedData_z = [maskedData_z(points_inside_mesh(:)); surface_vertices(:,3)];

                    if peakSystole
                        cardphases = app.time_peak;
                    else
                        cardphases = 1:app.nframes;
                        h = waitbar(0, sprintf('Calculating WSS...'));
                    end

                    idx_number_cardiac_phase = 1;
                    app.WSS_matrix = {};
                    app.F_matrix = {};
                    app.V_matrix = {};

                    for t = cardphases

                        velocity_x = double(app.aorta_seg.*app.v(:,:,:,1,t)).*1e-3;
                        velocity_y = double(app.aorta_seg.*app.v(:,:,:,2,t)).*1e-3;
                        velocity_z = double(app.aorta_seg.*app.v(:,:,:,3,t)).*1e-3;

                        velocity_x = velocity_x(mask_segmentation);
                        velocity_y = velocity_y(mask_segmentation);
                        velocity_z = velocity_z(mask_segmentation);

                        %%% VELOCITY DATA
                        velocity_x = [velocity_x(points_inside_mesh(:)); zeros(size(surface_vertices,1),1)];
                        velocity_y = [velocity_y(points_inside_mesh(:)); zeros(size(surface_vertices,1),1)];
                        velocity_z = [velocity_z(points_inside_mesh(:)); zeros(size(surface_vertices,1),1)];

                        % Do some checks
                        % check if input has same size all around
                        if ~isequaln(size(maskedData_x),size(maskedData_y),size(maskedData_z),size(velocity_x),size(velocity_y),size(velocity_z))
                            disp(size(maskedData_x),size(maskedData_y),size(maskedData_z),size(velocity_x),size(velocity_y),size(velocity_z))
                            error('Please make sure that position and velocity input all have the same size.')
                        end
                        if any(isnan(velocity_x(:))) ||  any(isnan(velocity_y(:))) || any(isnan(velocity_z(:)))
                            error('ML:ISNAN','Stop it, NaN in the data. Line 73, calculate_wss5.m')
                        end
                        if ~license('checkout','Curve_Fitting_Toolbox')
                            error('out of licenses');
                        end

                        [shearstress_object,surface_faces,surface_vertices] = calculate_wss_3d_flexdiameter(...
                            n,number_of_points_on_normal,length_inward_normal_in_m,maskedData_x,maskedData_y,maskedData_z,...
                            velocity_x,velocity_y,velocity_z,viscosity,surface_faces,surface_vertices);

                        WSS = shearstress_object.wallshearstress;
                        WSS(isnan(WSS))=0;

                        app.WSS_matrix{idx_number_cardiac_phase} = WSS;
                        app.F_matrix{idx_number_cardiac_phase} = surface_faces;
                        app.V_matrix{idx_number_cardiac_phase} = surface_vertices*1e+3; % convert back to mm
                        idx_number_cardiac_phase = idx_number_cardiac_phase + 1;
                        if exist('h')
                            waitbar (t/app.nframes, h)
                        end
                    end
                    if exist('h')
                        close(h);
                    end

                    viewWSS(app)
                    if peakSystole  % disable spinner as only one frame available
                        app.MapTimeframeSpinner.Enable = 'off';
                        app.LinkplotsCheckBox.Enable = 'off';
                    else
                        app.MapTimeframeSpinner.Enable = 'on';
                        app.LinkplotsCheckBox.Enable = 'on';
                    end

                    app.minWSSEditField.Enable = 'on';
                    app.WSSEditFieldLabel.Enable = 'on';
                    app.maxWSSEditField.Enable = 'on';
                    app.WSStoEditFieldLabel.Enable = 'on';
                    app.isWSScalculated = 1;
            end
        end

        % Value changed function: LinkplotsCheckBox
        function LinkplotsCheckBoxValueChanged(app, event)
            if app.LinkplotsCheckBox.Value
                app.MapTimeframeSpinner.Value = app.TimeframeSpinner.Value;
            end
        end

        % Button pushed function: SaveAnimation
        function SaveAnimationButtonPushed(app, event)
            % temporarily hide other things for plotting
            app.TimeframeSpinner.Visible = 'off';
            app.TimeframeSpinnerLabel.Visible = 'off';
            app.minQuiverEditField.Visible = 'off';
            app.maxQuiverEditField.Visible = 'off';
            app.minVelocityVectorEditField.Visible = 'off';
            app.maxVelocityVectorEditField.Visible = 'off';
            app.quiverscaleEditFieldLabel.Visible = 'off';
            app.velocityVectortoEditFieldLabel.Visible = 'off';
            app.velocityVectorEditFieldLabel.Visible = 'off';
            app.toXEditFieldLabel_2.Visible = 'off';
            app.VectorOptionsDropDown.Visible = 'off';
            app.VectorType.Visible = 'off';
            app.SliceSpinner_2.Visible = 'off';
            app.SliceSpinner_2Label.Visible = 'off';

            app.MapTimeframeSpinner.Visible = 'off';
            app.MapTimeframeSpinnerLabel.Visible = 'off';
            app.minWSSEditField.Visible = 'off';
            app.maxWSSEditField.Visible = 'off';
            app.WSSEditFieldLabel.Visible = 'off';
            app.WSStoEditFieldLabel.Visible = 'off';

            app.MapType.Visible = 'off';

            [file,path] = uiputfile('*.gif','Selection file name and location');
            filename = fullfile(path,file);
            % loop over time frames and record
            for t = 1:app.nframes
                app.TimeframeSpinner.Value = t;
                viewVelocityVectors(app);

                if app.LinkplotsCheckBox.Value && ~strncmp(app.MapType.Value,'None',4)
                    app.MapTimeframeSpinner.Value = t;
                    switch app.MapType.Value
                        case 'Wall shear stress'
                            viewWSS(app);
                        case 'Peak velocity'
                            viewPeakVelocity(app);
                        case 'Mean velocity'
                            viewMeanVelocity(app);
                        case 'Kinetic energy'
                            viewKE(app);
                    end
                    ff = getframe(app.FlowProcessingUIFigure, [1 25 475*2 690]);
                else
                    ff = getframe(app.FlowProcessingUIFigure, [1 25 475 690]);
                end


                % Turn screenshot into image
                im = frame2im(ff);
                % add time label
                im = insertText(im,[1 1],sprintf('t = %2.2f s', (t-1)*(app.timeres/1000)),'BoxColor','white');
                
                % Turn image into indexed image (the gif format needs this)
                [imind,cm] = rgb2ind(im,256);

                delay = 2*app.timeres/1000;
                if t == 1
                    imwrite(imind,cm,filename,'gif', 'WriteMode','overwrite','DelayTime', delay, 'LoopCount', Inf);
                else
                    imwrite(imind,cm, filename,'gif','WriteMode','append','DelayTime',delay);
                end
            end

            % turn back on
            app.TimeframeSpinner.Visible = 'on';
            app.TimeframeSpinnerLabel.Visible = 'on';
            app.minQuiverEditField.Visible = 'on';
            app.maxQuiverEditField.Visible = 'on';
            app.minVelocityVectorEditField.Visible = 'on';
            app.maxVelocityVectorEditField.Visible = 'on';
            app.quiverscaleEditFieldLabel.Visible = 'on';
            app.velocityVectortoEditFieldLabel.Visible = 'on';
            app.velocityVectorEditFieldLabel.Visible = 'on';
            app.toXEditFieldLabel_2.Visible = 'on';
            app.VectorOptionsDropDown.Visible = 'on';
            app.VectorType.Visible = 'on';
            if strncmp(app.VectorOptionsDropDown.Value,'slice-wise',10)
                app.SliceSpinner_2.Visible = 'on';
                app.SliceSpinner_2Label.Visible = 'on';
            end

            app.MapTimeframeSpinner.Visible = 'on';
            app.MapTimeframeSpinnerLabel.Visible = 'on';
            app.minWSSEditField.Visible = 'on';
            app.maxWSSEditField.Visible = 'on';
            app.WSSEditFieldLabel.Visible = 'on';
            app.WSStoEditFieldLabel.Visible = 'on';
            app.MapType.Visible = 'on';
        end

        % Button pushed function: Axial
        function AxialButtonPushed(app, event)
            switch app.ori.label
                case 'axial'
                    % this was an axial scan, reset rotation
                    app.rotAngles2 = [0 0];
                case 'sagittal'
                    app.rotAngles2 = [90 0];
                case 'coronal'
                    app.rotAngles2 = [90 0];
            end
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: Sagittal
        function SagittalButtonPushed(app, event)
           switch app.ori.label
                case 'axial'
                    app.rotAngles2 = [0 90];
                case 'sagittal'
                     % this was an sagital scan, reset rotation
                    app.rotAngles2 = [0 0];
                case 'coronal'
                    app.rotAngles2 = [0 90];
            end
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end
        
        % Button pushed function: Coronal
        function CoronalButtonPushed(app, event)
            switch app.ori.label
                case 'axial'
                    app.rotAngles2 = [90 0];
                case 'sagittal'
                    app.rotAngles2 = [0 90];
                case 'coronal'
                    % this was an coronal scan, reset rotation
                    app.rotAngles2 = [0 0];
            end
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end
        
        % Button pushed function: ResetRotation_2
        function ResetRotation_2ButtonPushed(app, event)
            % update rotate angles
            app.rotAngles2 = [0 0];
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: RotateUp_2
        function RotateUp_2ButtonPushed(app, event)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1)-10 app.rotAngles2(2)];
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: RotateDown_2
        function RotateDown_2ButtonPushed(app, event)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1)+10 app.rotAngles2(2)];
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: RotateRight_2
        function RotateRight_2ButtonPushed(app, event)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2)-10];
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: RotateLeft_2
        function RotateLeft_2ButtonPushed(app, event)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2)+10];
            viewVelocityVectors(app);
            if (app.isWSScalculated && strcmp(app.MapType.Value,'Wall shear stress'))
                viewWSS(app);
            end
        end

        % Button pushed function: VelocityUnwrapping
        function VelocityUnwrappingButtonPushed(app, event)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);

                % crop velocity
                tempV = reshape(app.v,[prod(app.res),3,app.nframes]);
                tempV = tempV(maskIdx,:,:);
                tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
                app.v = tempV;
                app.vMean = mean(app.v,5);
                clear tempV

                % crop MAG
                tempMAG = reshape(app.MAG,[prod(app.res),app.nframes]);
                tempMAG = tempMAG(maskIdx,:);
                tempMAG = reshape(tempMAG,lx,ly,lz,app.nframes);
                app.MAG = tempMAG;
                clear tempMAG;

                % update magWeightVel and angio
                [app.magWeightVel, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

                % others to crop, segment and aorta_seg
                tempS = app.segment(:);
                tempS = tempS(maskIdx);
                tempS = reshape(tempS,lx,ly,lz);
                app.segment = tempS;
                clear tempS;
                if (app.isSegmentationLoaded)
                    tempS = app.aorta_seg(:);
                    tempS = reshape(tempS,length(tempS)/size(app.aorta_seg,4),size(app.aorta_seg,4));
                    tempS = tempS(maskIdx,:);
                    tempS = reshape(tempS,lx,ly,lz,size(app.aorta_seg,4));
                    app.aorta_seg = tempS;
                    clear tempS;
                else
                    app.aorta_seg = app.segment;
                end
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
            end

            app.TabGroup.SelectedTab = app.VelocityUnwrappingTab;
            app.TimeframeSpinner_3.Limits = [1,app.nframes];
            app.SliceSpinner.Limits = [1 size(app.angio,3)];

            % if we've already looked at maps and changed the time-frame,
            % then use that, otherwise calculate time_peak
            if app.TimeframeSpinner.Enable == 'off'
                app.PeaksystoleEditField.Value = num2str(app.time_peak);
                app.TimeframeSpinner_3.Value = app.time_peak;
            else
                app.TimeframeSpinner_3.Value = app.TimeframeSpinner.Value;
            end

            % if we have been on this page before and already have a slice,
            app.SliceSpinner.Value = round(size(app.angio,3)/2);

            plotVelocities(app);
        end

        % Value changed function: SliceSpinner
        function SliceSpinnerValueChanged(app, event)
            plotVelocities(app);
        end

        % Value changed function: TimeframeSpinner_3
        function TimeframeSpinner_3ValueChanged(app, event)
            plotVelocities(app);
        end

        % Button pushed function: LaplaceUnwrap
        function LaplaceUnwrapButtonPushed(app, event)
            disp('Performing 4D velocity unwrapping...')

            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                [x, y, z] = ind2sub(size(app.mask),find(app.mask));
                lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
                maskIdx = find(app.mask);

                % crop velocity
                tempV = reshape(app.v,[prod(app.res),3,app.nframes]);
                tempV = tempV(maskIdx,:,:);
                tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
                app.v = tempV;
                app.vMean = mean(app.v,5);
                clear tempV

                % crop MAG
                tempMAG = reshape(app.MAG,[prod(app.res),app.nframes]);
                tempMAG = tempMAG(maskIdx,:);
                tempMAG = reshape(tempMAG,lx,ly,lz,app.nframes);
                app.MAG = tempMAG;
                clear tempMAG;

                % update magWeightVel and angio
                [app.magWeightVel, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

                % others to crop, segment and aorta_seg
                tempS = app.segment(:);
                tempS = tempS(maskIdx);
                tempS = reshape(tempS,lx,ly,lz);
                app.segment = tempS;
                clear tempS;
                if (app.isSegmentationLoaded)
                    tempS = app.aorta_seg(:);
                    tempS = tempS(maskIdx);
                    tempS = reshape(tempS,lx,ly,lz);
                    app.aorta_seg = tempS;
                    clear tempS;
                else
                    app.aorta_seg = app.segment;
                end
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
            end

            % first remove outliers (force everything to +/- VENC)
            V2 = app.v;
            V2(V2 < -app.VENC) = -app.VENC;
            V2(V2 > app.VENC) = app.VENC;
            % now scale V2 to +/- pi for unwrapping
            V2 = V2./app.VENC.*pi;

            % grab velocities
            phi_w_x = squeeze(V2(:,:,:,1,:));
            phi_w_y = squeeze(V2(:,:,:,2,:));
            phi_w_z = squeeze(V2(:,:,:,3,:));

            % perform unwrapping
            if (size(phi_w_x,4))==1
                phi_w_x_unwrapped = phi_w_x + 2*pi .* double(unwrap_3D(phi_w_x));
                phi_w_y_unwrapped = phi_w_y + 2*pi .* double(unwrap_3D(phi_w_y));
                phi_w_z_unwrapped = phi_w_z + 2*pi .* double(unwrap_3D(phi_w_z));
            else
                phi_w_x_unwrapped = phi_w_x + 2*pi .* double(unwrap_4D(phi_w_x));
                phi_w_y_unwrapped = phi_w_y + 2*pi .* double(unwrap_4D(phi_w_y));
                phi_w_z_unwrapped = phi_w_z + 2*pi .* double(unwrap_4D(phi_w_z));
            end

            % find the absolute maximum phi value across unwrapped data
            max_phi = max(abs(phi_w_x_unwrapped(:)));
            if max(abs(phi_w_y_unwrapped(:))) > max_phi
                max_phi = max(abs(phi_w_y_unwrapped(:)));
            end
            if max(abs(phi_w_z_unwrapped(:))) > max_phi
                max_phi = max(abs(phi_w_z_unwrapped(:)));
            end

            % rescale images based on 'new' venc
            app.v(:,:,:,1,:) = phi_w_x_unwrapped./pi*app.VENC;
            app.v(:,:,:,2,:) = phi_w_y_unwrapped./pi*app.VENC;
            app.v(:,:,:,3,:) = phi_w_z_unwrapped./pi*app.VENC;
            app.vMean = mean(app.v,5);

            % we only do unwrapping once, so disable after completion
            app.LaplaceUnwrap.Enable = 'off';

            plotVelocities(app);
        end

        % Button pushed function: Unwrap_automatic
        function Unwrap_automaticButtonPushed(app, event)
            sl = app.SliceSpinner.Value;
            tf = app.TimeframeSpinner_3.Value;
            tmpV = squeeze(app.v(:,:,sl,:,tf-1:tf)).* ...
                app.aorta_seg(:,:,sl);
            venc = app.VENC;
            vOut = unaliasSlice(tmpV,venc); clear tmpV;
            % assign values back to app.v
            idx = find(app.aorta_seg(:,:,sl));
            tmpV = squeeze(app.v(:,:,sl,1,tf)); vOut1 = vOut(:,:,1);
            tmpV(idx) = vOut1(idx);
            app.v(:,:,sl,1,tf) = tmpV;
            tmpV = squeeze(app.v(:,:,sl,2,tf)); vOut1 = vOut(:,:,2);
            tmpV(idx) = vOut1(idx);
            app.v(:,:,sl,2,tf) = tmpV;
            tmpV = squeeze(app.v(:,:,sl,3,tf)); vOut1 = vOut(:,:,3);
            tmpV(idx) = vOut1(idx);
            app.v(:,:,sl,3,tf) = tmpV;

            plotVelocities(app);

        end

        % Window button down function: FlowProcessingUIFigure
        function FlowProcessingUIFigureWindowButtonDown(app, event)
            if (app.TabGroup.SelectedTab == app.VelocityUnwrappingTab) && ...
                    ~isempty(event.Source.CurrentObject) && isequal(event.Source.CurrentObject.Tag,'alldata') && ...
                    (app.Unwrap_manual_1.Value || app.Unwrap_manual_2.Value || app.Unwrap_manual_3.Value)

                imSize = size(app.angio,[1 2]);

                x1 = round(app.Unwrap_1.CurrentPoint);
                x2 = round(app.Unwrap_2.CurrentPoint);
                x3 = round(app.Unwrap_3.CurrentPoint);
                if x1(3) > 0 && x1(3) < imSize(1) && x1(1) > 0 && x1(1) < imSize(2) && app.Unwrap_manual_1.Value
                    currV = 1;
                    x = x1(3); y = x1(1);
                elseif  x2(3) > 0 && x2(3) < imSize(1) && x2(1) > 0 && x2(1) < imSize(2) && app.Unwrap_manual_2.Value
                    currV = 2;
                    x = x2(3); y = x2(1);
                elseif x3(3) > 0 && x3(3) < imSize(1) && x3(1) > 0 && x3(1) < imSize(2) && app.Unwrap_manual_3.Value
                    currV = 3;
                    x = x3(3); y = x3(1);
                end

                % perform unwrap
                venc = app.VENC;
                if app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) < 0
                    app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) = app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) + 2*venc;
                elseif app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) > 0
                    app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) = app.v(x,y,app.SliceSpinner.Value,currV,app.TimeframeSpinner_3.Value) - 2*venc;
                end
                plotVelocities(app);

            end
        end

        % Value changed function: maxWSSEditField
        function maxWSSEditFieldValueChanged(app, event)
            viewWSS(app);
        end

        % Value changed function: minWSSEditField
        function minWSSEditFieldValueChanged(app, event)
            viewWSS(app);
        end

        % Value changed function: maxQuiverEditField
        function maxQuiverEditFieldValueChanged(app, event)
            viewVelocityVectors(app);
        end

        % Value changed function: minQuiverEditField
        function minQuiverEditFieldValueChanged(app, event)
            viewVelocityVectors(app);
        end

        % Value changed function: minVelocityVectorEditField
        function minVelocityVectorEditFieldValueChanged(app, event)
            viewVelocityVectors(app);
        end

        % Value changed function: maxVelocityVectorEditField
        function maxVelocityVectorEditFieldValueChanged(app, event)
            viewVelocityVectors(app);
        end

        % Value changed function: MapType
        function MapTypeValueChanged(app, event)

            switch app.MapType.Value
                case 'None'
                    app.minWSSEditField.Visible = 'off';
                    app.maxWSSEditField.Visible = 'off';
                    app.WSSEditFieldLabel.Visible = 'off';
                    app.WSStoEditFieldLabel.Visible = 'off';

                    app.MapTimeframeSpinner.Enable = 'off';
                    cla(app.MapPlot);
                    colorbar(app.MapPlot,'off');
                case 'Wall shear stress'
                    app.minWSSEditField.Visible = 'on';
                    app.maxWSSEditField.Visible = 'on';
                    app.WSSEditFieldLabel.Visible = 'on';
                    app.WSStoEditFieldLabel.Visible = 'on';

                    if app.isWSScalculated
                        viewWSS(app);
                    end

                case 'Peak velocity'
                    app.minWSSEditField.Visible = 'off';
                    app.maxWSSEditField.Visible = 'off';
                    app.WSSEditFieldLabel.Visible = 'off';
                    app.WSStoEditFieldLabel.Visible = 'off';

                    app.MapTimeframeSpinner.Enable = 'on';
                    app.LinkplotsCheckBox.Enable = 'on';
                    viewPeakVelocity(app);

                case 'Mean velocity'
                    app.minWSSEditField.Visible = 'off';
                    app.maxWSSEditField.Visible = 'off';
                    app.WSSEditFieldLabel.Visible = 'off';
                    app.WSStoEditFieldLabel.Visible = 'off';

                    app.MapTimeframeSpinner.Enable = 'on';
                    app.LinkplotsCheckBox.Enable = 'on';
                    viewMeanVelocity(app);

                case 'Kinetic energy'
                    app.minWSSEditField.Visible = 'off';
                    app.maxWSSEditField.Visible = 'off';
                    app.WSSEditFieldLabel.Visible = 'off';
                    app.WSStoEditFieldLabel.Visible = 'off';

                    app.MapTimeframeSpinner.Enable = 'on';
                    app.LinkplotsCheckBox.Enable = 'on';
                    viewKE(app);
            end
        end

        % Value changed function: flipvx
        function flipvxValueChanged(app, event)
            app.v(:,:,:,1,:) = -app.v(:,:,:,1,:);
            viewVelocityVectors(app)
        end

        % Value changed function: flipvy
        function flipvyValueChanged(app, event)
            app.v(:,:,:,2,:) = -app.v(:,:,:,2,:);
            viewVelocityVectors(app)
        end

        % Value changed function: flipvz
        function flipvzValueChanged(app, event)
            app.v(:,:,:,3,:) = -app.v(:,:,:,3,:);
            viewVelocityVectors(app)
        end

        % Key press function: FlowProcessingUIFigure
        function FlowProcessingUIFigureKeyPress(app, event)
            key = event.Key;
            % check the tab we're in first
            switch app.TabGroup.SelectedTab.Title
                case 'Velocity Unwrapping'
                    switch key
                        case 'uparrow'
                            value = app.TimeframeSpinner_3.Value + 1;
                            if value > app.TimeframeSpinner_3.Limits(2)
                                value = 1;
                            end
                            app.TimeframeSpinner_3.Value = value;
                        case 'downarrow'
                            value = app.TimeframeSpinner_3.Value - 1;
                            if value < 1
                                value = app.TimeframeSpinner_3.Limits(2);
                            end
                            app.TimeframeSpinner_3.Value = value;
                        case 'rightarrow'
                            value = app.SliceSpinner.Value + 1;
                            if value > app.SliceSpinner.Limits(2)
                                value = 1;
                            end
                            app.SliceSpinner.Value = value;
                        case 'leftarrow'
                            value= app.SliceSpinner.Value - 1;
                            if value < 1
                                value = app.SliceSpinner.Limits(2);
                            end
                            app.SliceSpinner.Value = value;
                    end
                    plotVelocities(app);

                case 'Maps'
                    switch key
                        case 'w'
                            RotateUp_2ButtonPushed(app);
                        case 's'
                            RotateDown_2ButtonPushed(app);
                        case 'd'
                            RotateRight_2ButtonPushed(app);
                        case 'a'
                            RotateLeft_2ButtonPushed(app);
                        case 'r'
                            ResetRotation_2ButtonPushed(app);
                        case 'uparrow'
                            value = app.TimeframeSpinner.Value + 1;
                            if value > app.TimeframeSpinner.Limits(2)
                                value = 1;
                            end
                            app.TimeframeSpinner.Value = value;
                            TimeframeSpinnerValueChanged(app);
                        case 'downarrow'
                            value = app.TimeframeSpinner.Value - 1;
                            if value < 1
                                value = app.TimeframeSpinner.Limits(2);
                            end
                            app.TimeframeSpinner.Value = value;
                            TimeframeSpinnerValueChanged(app);
                    end
                    if strncmp(app.VectorOptionsDropDown.Value,'slice-wise',10)
                        switch key
                            case 'rightarrow'
                                value = app.SliceSpinner_2.Value + 1;
                                if value > app.SliceSpinner_2.Limits(2)
                                    value = 1;
                                end
                                app.SliceSpinner_2.Value = value;
                                SliceSpinner_2ValueChanged(app);
                            case 'leftarrow'
                                value= app.SliceSpinner_2.Value - 1;
                                if value < 1
                                    value = app.SliceSpinner_2.Limits(2);
                                end
                                app.SliceSpinner_2.Value = value;
                                SliceSpinner_2ValueChanged(app);
                        end
                    end

                case 'Loading and Preprocessing'
                    switch key
                        case 'w'
                            RotateUpButtonPushed(app);
                        case 's'
                            RotateDownButtonPushed(app);
                        case 'd'
                            RotateRightButtonPushed(app);
                        case 'a'
                            RotateLeftButtonPushed(app);
                        case 'r'
                            ResetRotationButtonPushed(app);
                    end
            end
        end

        % Button pushed function: InterpolateData
        function InterpolateDataButtonPushed(app, event)
            interpRes = interpolateInputs(app.pixdim);

            % determine interpolation 3D matrix size
            if app.isSegmentationLoaded
                [app.res, app.MAG, app.v, app.aorta_seg] = interpolateData(interpRes, app.pixdim, app.MAG, app.v, app.aorta_seg);
            else
                [app.res, app.MAG, app.v] = interpolateData(interpRes, app.pixdim, app.MAG, app.v);
            end
            app.vMean = mean(app.v,5);
            app.isInterpolated = 1;
            app.pixdim = [interpRes interpRes interpRes];

            % add to infoTable
            app.ScanInfoTable.Data = cat(1, app.ScanInfoTable.Data,...
                cat(2,cellstr(['*' num2str(app.res(1)) ' x ' num2str(app.res(2)) ' x ' num2str(app.res(3))]),...
                cellstr(['*' num2str(interpRes) ' x ' num2str(interpRes) ' x ' num2str(interpRes)]),...
                cellstr('*interpolated'),cellstr(''), cellstr('')));

            % recalculate app.angio and app.segment
            [~, app.angio] = calc_angio(app.MAG, app.v, app.VENC);

            % initialize the mask again
            app.mask = ones(size(app.angio));

            normed_MIP = app.angio./max(app.angio(:));
            % fit a Gaussian to non-zero elements to determine threshold
            [muhat,sigmahat] = norm_fit(normed_MIP(:));

            app.segment = zeros(size(app.angio));
            app.segment(normed_MIP>muhat+2*sigmahat) = 1;

            app.segment = bwareaopen(app.segment,round(sum(app.segment(:)).*0.005),6); %The value at the end of the commnad in the minimum area of each segment to keep
            app.segment = imfill(app.segment,'holes'); % Fill in holes created by slow flow on the inside of vessels
            app.segment = single(app.segment);

            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app, m_xstart, m_xstop, m_ystart, m_ystop, m_zstart, m_zstop);
        end

        % Value changed function: VectorOptionsDropDown
        function VectorOptionsDropDownValueChanged(app, event)
            value = app.VectorOptionsDropDown.Value;
            switch value
                case 'slice-wise'
                    % add the magnitude slice, and re-plot the velocity vectors
                    % only in that slice
                    app.SliceSpinner_2Label.Visible = 'on';
                    app.SliceSpinner_2Label.Enable = 'on';
                    app.SliceSpinner_2.Visible = 'on';
                    app.SliceSpinner_2.Enable = 'on';
                    app.SliceSpinner_2.Value = round(size(app.angio,3)/2);
                    app.SliceSpinner_2.Limits = [1 size(app.angio,3)];
                case 'segmentation'
                    app.SliceSpinner_2Label.Visible = 'off';
                    app.SliceSpinner_2Label.Enable = 'off';
                    app.SliceSpinner_2.Visible = 'off';
                    app.SliceSpinner_2.Enable = 'off';
                case 'centerline contours'
                    app.SliceSpinner_2Label.Visible = 'off';
                    app.SliceSpinner_2Label.Enable = 'off';
                    app.SliceSpinner_2.Visible = 'off';
                    app.SliceSpinner_2.Enable = 'off';
            end
            % reset plot limits and send changed flag
            app.vvp_xlim = [];
            app.vvp_ylim = [];
            app.vvp_changed = 1;
            viewVelocityVectors(app);
        end
        
        % Value changed function: ParameterDropDown
        function PWVTypeValueChanged(app, event)
            if app.PWVType.Value < 3
                app.findBestFit_checkbox.Enable = 'on';
            else
                app.findBestFit_checkbox.Value = 0;
                app.findBestFit_checkbox.Enable = 'off';
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create FlowProcessingUIFigure and hide until all components are created
            app.FlowProcessingUIFigure = uifigure('Visible', 'off');
            app.FlowProcessingUIFigure.Color = [1 1 1];
            app.FlowProcessingUIFigure.Colormap = [0.2431 0.149 0.6588;0.251 0.1647 0.7059;0.2588 0.1804 0.7529;0.2627 0.1961 0.7961;0.2706 0.2157 0.8353;0.2745 0.2353 0.8706;0.2784 0.2549 0.898;0.2784 0.2784 0.9216;0.2824 0.302 0.9412;0.2824 0.3216 0.9569;0.2784 0.3451 0.9725;0.2745 0.3686 0.9843;0.2706 0.3882 0.9922;0.2588 0.4118 0.9961;0.2431 0.4353 1;0.2196 0.4588 0.9961;0.1961 0.4863 0.9882;0.1843 0.5059 0.9804;0.1804 0.5294 0.9686;0.1765 0.549 0.9529;0.1686 0.5686 0.9373;0.1529 0.5922 0.9216;0.1451 0.6078 0.9098;0.1373 0.6275 0.898;0.1255 0.6471 0.8902;0.1098 0.6627 0.8745;0.0941 0.6784 0.8588;0.0706 0.6941 0.8392;0.0314 0.7098 0.8157;0.0039 0.7216 0.7922;0.0078 0.7294 0.7647;0.0431 0.7412 0.7412;0.098 0.749 0.7137;0.1412 0.7569 0.6824;0.1725 0.7686 0.6549;0.1922 0.7765 0.6235;0.2157 0.7843 0.5922;0.2471 0.7922 0.5569;0.2902 0.7961 0.5176;0.3412 0.8 0.4784;0.3922 0.8039 0.4353;0.4471 0.8039 0.3922;0.5059 0.8 0.349;0.5608 0.7961 0.3059;0.6157 0.7882 0.2627;0.6706 0.7804 0.2235;0.7255 0.7686 0.1922;0.7725 0.7608 0.1647;0.8196 0.749 0.1529;0.8627 0.7412 0.1608;0.902 0.7333 0.1765;0.9412 0.7294 0.2118;0.9725 0.7294 0.2392;0.9961 0.7451 0.2353;0.9961 0.7647 0.2196;0.9961 0.7882 0.2039;0.9882 0.8118 0.1882;0.9804 0.8392 0.1765;0.9686 0.8627 0.1647;0.9608 0.8902 0.1529;0.9608 0.9137 0.1412;0.9647 0.9373 0.1255;0.9686 0.9608 0.1059;0.9765 0.9843 0.0824];
            app.FlowProcessingUIFigure.Position = [357 92 1234 760];
            app.FlowProcessingUIFigure.Name = '4D Flow Processing Tool';
            app.FlowProcessingUIFigure.WindowButtonDownFcn = createCallbackFcn(app, @FlowProcessingUIFigureWindowButtonDown, true);
            app.FlowProcessingUIFigure.KeyPressFcn = createCallbackFcn(app, @FlowProcessingUIFigureKeyPress, true);

            % Create TabGroup
            app.TabGroup = uitabgroup(app.FlowProcessingUIFigure);
            app.TabGroup.TabLocation = 'bottom';
            app.TabGroup.Position = [1 1 1234 760];

            % Create LoadingandPreprocessingTab
            app.LoadingandPreprocessingTab = uitab(app.TabGroup);
            app.LoadingandPreprocessingTab.Title = 'Loading and Preprocessing';
            app.LoadingandPreprocessingTab.BackgroundColor = [1 1 1];

            % Create LoadDataPanel
            app.LoadDataPanel = uipanel(app.LoadingandPreprocessingTab);
            app.LoadDataPanel.BorderType = 'none';
            app.LoadDataPanel.TitlePosition = 'centertop';
            app.LoadDataPanel.Title = 'Load Data';
            app.LoadDataPanel.BackgroundColor = [1 1 1];
            app.LoadDataPanel.FontName = 'SansSerif';
            app.LoadDataPanel.FontWeight = 'bold';
            app.LoadDataPanel.FontSize = 16;
            app.LoadDataPanel.Position = [1 496 617 240];

            % Create LoadPARRECDataButton
            app.LoadPARRECDataButton = uibutton(app.LoadDataPanel, 'push');
            app.LoadPARRECDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadPARRECDataButtonPushed, true);
            app.LoadPARRECDataButton.FontName = 'SansSerif';
            app.LoadPARRECDataButton.FontSize = 16;
            app.LoadPARRECDataButton.Tooltip = {'load Philips 4D flow reconstructed par/rec data'};
            app.LoadPARRECDataButton.Position = [210 180 198 28];
            app.LoadPARRECDataButton.Text = 'Load PAR/REC Data';

            % Create DataDirectoryEditFieldLabel
            app.DataDirectoryEditFieldLabel = uilabel(app.LoadDataPanel);
            app.DataDirectoryEditFieldLabel.HorizontalAlignment = 'right';
            app.DataDirectoryEditFieldLabel.FontName = 'SansSerif';
            app.DataDirectoryEditFieldLabel.FontSize = 9;
            app.DataDirectoryEditFieldLabel.Position = [6 147 63 22];
            app.DataDirectoryEditFieldLabel.Text = 'Data Directory';

            % Create DataDirectoryEditField
            app.DataDirectoryEditField = uieditfield(app.LoadDataPanel, 'text');
            app.DataDirectoryEditField.Editable = 'off';
            app.DataDirectoryEditField.FontName = 'SansSerif';
            app.DataDirectoryEditField.FontSize = 9;
            app.DataDirectoryEditField.Position = [77 147 531 22];

            % Create LoadSegmentationButton
            app.LoadSegmentationButton = uibutton(app.LoadDataPanel, 'push');
            app.LoadSegmentationButton.ButtonPushedFcn = createCallbackFcn(app, @LoadSegmentationButtonPushed, true);
            app.LoadSegmentationButton.FontName = 'SansSerif';
            app.LoadSegmentationButton.FontSize = 16;
            app.LoadSegmentationButton.Tooltip = {'choose folder with segmentation dicoms (from nnUNET or Mimics)'};
            app.LoadSegmentationButton.Position = [68 107 213 28];
            app.LoadSegmentationButton.Text = 'Load Segmentation';

            % Create SegmentationDirectoryEditFieldLabel
            app.SegmentationDirectoryEditFieldLabel = uilabel(app.LoadDataPanel);
            app.SegmentationDirectoryEditFieldLabel.HorizontalAlignment = 'right';
            app.SegmentationDirectoryEditFieldLabel.FontName = 'SansSerif';
            app.SegmentationDirectoryEditFieldLabel.FontSize = 9;
            app.SegmentationDirectoryEditFieldLabel.Position = [6 75 100 22];
            app.SegmentationDirectoryEditFieldLabel.Text = 'Segmentation Directory';

            % Create SegmentationDirectoryEditField
            app.SegmentationDirectoryEditField = uieditfield(app.LoadDataPanel, 'text');
            app.SegmentationDirectoryEditField.Editable = 'off';
            app.SegmentationDirectoryEditField.FontName = 'SansSerif';
            app.SegmentationDirectoryEditField.FontSize = 9;
            app.SegmentationDirectoryEditField.Position = [121 75 486 22];

            % Create ScanInfoTable
            app.ScanInfoTable = uitable(app.LoadDataPanel);
            app.ScanInfoTable.ColumnName = {'matrix'; 'resolution (mm)'; 'time resolution (ms)'; 'cardiac frames'; 'venc (cm/s)'};
            app.ScanInfoTable.RowName = {};
            app.ScanInfoTable.ColumnSortable = [false false false false false];
            app.ScanInfoTable.ColumnEditable = [false false false false false];
            app.ScanInfoTable.FontName = 'SansSerif';
            app.ScanInfoTable.FontSize = 10;
            app.ScanInfoTable.Position = [25 1 570 70];

            % Create InterpolateData
            app.InterpolateData = uibutton(app.LoadDataPanel, 'push');
            app.InterpolateData.ButtonPushedFcn = createCallbackFcn(app, @InterpolateDataButtonPushed, true);
            app.InterpolateData.FontName = 'SansSerif';
            app.InterpolateData.FontSize = 16;
            app.InterpolateData.Enable = 'off';
            app.InterpolateData.Tooltip = {'interpolate to isotropic resolution'};
            app.InterpolateData.Position = [346 108 213 28];
            app.InterpolateData.Text = 'Interpolate Data';

            % Create CropPanel
            app.CropPanel = uipanel(app.LoadingandPreprocessingTab);
            app.CropPanel.BorderType = 'none';
            app.CropPanel.TitlePosition = 'centertop';
            app.CropPanel.Title = 'Crop';
            app.CropPanel.BackgroundColor = [1 1 1];
            app.CropPanel.FontName = 'SansSerif';
            app.CropPanel.FontWeight = 'bold';
            app.CropPanel.FontSize = 16;
            app.CropPanel.Position = [1 128 617 369];

            % Create AxesX
            app.AxesX = uiaxes(app.CropPanel);
            app.AxesX.XColor = 'none';
            app.AxesX.XTick = 0;
            app.AxesX.YColor = 'none';
            app.AxesX.YTick = 0;
            app.AxesX.Position = [11 95 200 200];

            % Create AxesY
            app.AxesY = uiaxes(app.CropPanel);
            app.AxesY.XColor = 'none';
            app.AxesY.XTick = [];
            app.AxesY.YColor = 'none';
            app.AxesY.YTick = [];
            app.AxesY.FontUnits = 'normalized';
            app.AxesY.FontSize = 0.0691244237613988;
            app.AxesY.Position = [212 95 200 200];

            % Create AxesZ
            app.AxesZ = uiaxes(app.CropPanel);
            app.AxesZ.XColor = 'none';
            app.AxesZ.XTick = [];
            app.AxesZ.YColor = 'none';
            app.AxesZ.YTick = [];
            app.AxesZ.Position = [412 95 200 200];

            % Create XrangeEditFieldLabel
            app.XrangeEditFieldLabel = uilabel(app.CropPanel);
            app.XrangeEditFieldLabel.HorizontalAlignment = 'right';
            app.XrangeEditFieldLabel.FontName = 'SansSerif';
            app.XrangeEditFieldLabel.FontSize = 14;
            app.XrangeEditFieldLabel.Position = [45 67 55 22];
            app.XrangeEditFieldLabel.Text = 'X-range';

            % Create XrangeEditField
            app.XrangeEditField = uieditfield(app.CropPanel, 'text');
            app.XrangeEditField.Editable = 'off';
            app.XrangeEditField.HorizontalAlignment = 'right';
            app.XrangeEditField.FontName = 'SansSerif';
            app.XrangeEditField.Position = [105 67 30 22];
            app.XrangeEditField.Value = '1';

            % Create toXEditFieldLabel
            app.toXEditFieldLabel = uilabel(app.CropPanel);
            app.toXEditFieldLabel.HorizontalAlignment = 'right';
            app.toXEditFieldLabel.FontName = 'SansSerif';
            app.toXEditFieldLabel.FontSize = 14;
            app.toXEditFieldLabel.Position = [128 67 25 22];
            app.toXEditFieldLabel.Text = 'to';

            % Create toXEditField
            app.toXEditField = uieditfield(app.CropPanel, 'text');
            app.toXEditField.HorizontalAlignment = 'right';
            app.toXEditField.FontName = 'SansSerif';
            app.toXEditField.Position = [157 67 32 22];
            app.toXEditField.Value = 'res';

            % Create toYEditFieldLabel
            app.toYEditFieldLabel = uilabel(app.CropPanel);
            app.toYEditFieldLabel.HorizontalAlignment = 'right';
            app.toYEditFieldLabel.FontName = 'SansSerif';
            app.toYEditFieldLabel.FontSize = 14;
            app.toYEditFieldLabel.Position = [127 36 25 22];
            app.toYEditFieldLabel.Text = 'to';

            % Create toYEditField
            app.toYEditField = uieditfield(app.CropPanel, 'text');
            app.toYEditField.HorizontalAlignment = 'right';
            app.toYEditField.FontName = 'SansSerif';
            app.toYEditField.Position = [156 36 32 22];
            app.toYEditField.Value = 'res';

            % Create YrangeEditFieldLabel
            app.YrangeEditFieldLabel = uilabel(app.CropPanel);
            app.YrangeEditFieldLabel.HorizontalAlignment = 'right';
            app.YrangeEditFieldLabel.FontName = 'SansSerif';
            app.YrangeEditFieldLabel.FontSize = 14;
            app.YrangeEditFieldLabel.Position = [45 36 54 22];
            app.YrangeEditFieldLabel.Text = 'Y-range';

            % Create YrangeEditField
            app.YrangeEditField = uieditfield(app.CropPanel, 'text');
            app.YrangeEditField.HorizontalAlignment = 'right';
            app.YrangeEditField.FontName = 'SansSerif';
            app.YrangeEditField.Position = [104 36 30 22];
            app.YrangeEditField.Value = '1';

            % Create toZEditFieldLabel
            app.toZEditFieldLabel = uilabel(app.CropPanel);
            app.toZEditFieldLabel.HorizontalAlignment = 'right';
            app.toZEditFieldLabel.FontName = 'SansSerif';
            app.toZEditFieldLabel.FontSize = 14;
            app.toZEditFieldLabel.Position = [127 6 25 22];
            app.toZEditFieldLabel.Text = 'to';

            % Create toZEditField
            app.toZEditField = uieditfield(app.CropPanel, 'text');
            app.toZEditField.HorizontalAlignment = 'right';
            app.toZEditField.FontName = 'SansSerif';
            app.toZEditField.Position = [156 6 32 22];
            app.toZEditField.Value = 'res';

            % Create ZrangeEditFieldLabel
            app.ZrangeEditFieldLabel = uilabel(app.CropPanel);
            app.ZrangeEditFieldLabel.HorizontalAlignment = 'right';
            app.ZrangeEditFieldLabel.FontName = 'SansSerif';
            app.ZrangeEditFieldLabel.FontSize = 14;
            app.ZrangeEditFieldLabel.Position = [44 6 55 22];
            app.ZrangeEditFieldLabel.Text = 'Z-range';

            % Create ZrangeEditField
            app.ZrangeEditField = uieditfield(app.CropPanel, 'text');
            app.ZrangeEditField.HorizontalAlignment = 'right';
            app.ZrangeEditField.FontName = 'SansSerif';
            app.ZrangeEditField.Position = [104 6 30 22];
            app.ZrangeEditField.Value = '1';

            % Create CropButton
            app.CropButton = uibutton(app.CropPanel, 'push');
            app.CropButton.ButtonPushedFcn = createCallbackFcn(app, @CropButtonPushed, true);
            app.CropButton.IconAlignment = 'center';
            app.CropButton.FontName = 'SansSerif';
            app.CropButton.FontSize = 16;
            app.CropButton.Position = [65 303 93 28];
            app.CropButton.Text = 'Crop';

            % Create CropButton_2
            app.CropButton_2 = uibutton(app.CropPanel, 'push');
            app.CropButton_2.ButtonPushedFcn = createCallbackFcn(app, @CropButton_2Pushed, true);
            app.CropButton_2.IconAlignment = 'center';
            app.CropButton_2.FontName = 'SansSerif';
            app.CropButton_2.FontSize = 16;
            app.CropButton_2.Position = [266 303 93 28];
            app.CropButton_2.Text = 'Crop';

            % Create CropButton_3
            app.CropButton_3 = uibutton(app.CropPanel, 'push');
            app.CropButton_3.ButtonPushedFcn = createCallbackFcn(app, @CropButton_3Pushed, true);
            app.CropButton_3.IconAlignment = 'center';
            app.CropButton_3.FontName = 'SansSerif';
            app.CropButton_3.FontSize = 16;
            app.CropButton_3.Position = [466 303 93 28];
            app.CropButton_3.Text = 'Crop';

            % Create AdjustthresholdSliderLabel
            app.AdjustthresholdSliderLabel = uilabel(app.CropPanel);
            app.AdjustthresholdSliderLabel.HorizontalAlignment = 'right';
            app.AdjustthresholdSliderLabel.FontName = 'SansSerif';
            app.AdjustthresholdSliderLabel.FontSize = 14;
            app.AdjustthresholdSliderLabel.Tooltip = {'the number of standard deviations outside of the background signal'};
            app.AdjustthresholdSliderLabel.Position = [284 34 106 22];
            app.AdjustthresholdSliderLabel.Text = 'Adjust threshold';

            % Create AdjustthresholdSlider
            app.AdjustthresholdSlider = uislider(app.CropPanel);
            app.AdjustthresholdSlider.Limits = [0.5 4];
            app.AdjustthresholdSlider.MajorTicks = [1 2 3 4];
            app.AdjustthresholdSlider.ValueChangedFcn = createCallbackFcn(app, @AdjustthresholdSliderValueChanged, true);
            app.AdjustthresholdSlider.MinorTicks = [0.6 0.8 1.2 1.4 1.6 1.8 2.2 2.4 2.6 2.8 3.2 3.4 3.6 3.8];
            app.AdjustthresholdSlider.FontName = 'SansSerif';
            app.AdjustthresholdSlider.Position = [411 43 150 3];
            app.AdjustthresholdSlider.Value = 2;

            % Create FinishedCroppingButton
            app.FinishedCroppingButton = uibutton(app.CropPanel, 'push');
            app.FinishedCroppingButton.ButtonPushedFcn = createCallbackFcn(app, @FinishedCroppingButtonPushed, true);
            app.FinishedCroppingButton.IconAlignment = 'center';
            app.FinishedCroppingButton.FontName = 'SansSerif';
            app.FinishedCroppingButton.FontSize = 16;
            app.FinishedCroppingButton.Position = [237 59 150 28];
            app.FinishedCroppingButton.Text = 'Finished Cropping';

            % Create DVisualizationPanel
            app.DVisualizationPanel = uipanel(app.LoadingandPreprocessingTab);
            app.DVisualizationPanel.BorderType = 'none';
            app.DVisualizationPanel.TitlePosition = 'centertop';
            app.DVisualizationPanel.Title = '3D Visualization';
            app.DVisualizationPanel.BackgroundColor = [1 1 1];
            app.DVisualizationPanel.FontName = 'SansSerif';
            app.DVisualizationPanel.FontWeight = 'bold';
            app.DVisualizationPanel.FontSize = 16;
            app.DVisualizationPanel.Position = [617 6 615 730];

            % Create View3D
            app.View3D = uiaxes(app.DVisualizationPanel);
            app.View3D.View = [0 0];
            app.View3D.Projection = 'perspective';
            app.View3D.GridLineStyle = 'none';
            app.View3D.MinorGridLineStyle = 'none';
            app.View3D.XColor = 'none';
            app.View3D.XTick = [];
            app.View3D.YColor = 'none';
            app.View3D.YTick = [];
            app.View3D.ZColor = 'none';
            app.View3D.Position = [8 9 598 691];

            % Create RotateLeft
            app.RotateLeft = uibutton(app.DVisualizationPanel, 'push');
            app.RotateLeft.ButtonPushedFcn = createCallbackFcn(app, @RotateLeftButtonPushed, true);
            app.RotateLeft.IconAlignment = 'center';
            app.RotateLeft.VerticalAlignment = 'bottom';
            app.RotateLeft.BackgroundColor = [1 1 1];
            app.RotateLeft.FontName = 'SansSerif';
            app.RotateLeft.FontSize = 24;
            app.RotateLeft.FontWeight = 'bold';
            app.RotateLeft.Tooltip = {'shortcut ''a'''};
            app.RotateLeft.Position = [9 58 28 28];
            app.RotateLeft.Text = '<';

            % Create RotateRight
            app.RotateRight = uibutton(app.DVisualizationPanel, 'push');
            app.RotateRight.ButtonPushedFcn = createCallbackFcn(app, @RotateRightButtonPushed, true);
            app.RotateRight.IconAlignment = 'center';
            app.RotateRight.VerticalAlignment = 'bottom';
            app.RotateRight.BackgroundColor = [1 1 1];
            app.RotateRight.FontName = 'SansSerif';
            app.RotateRight.FontSize = 24;
            app.RotateRight.FontWeight = 'bold';
            app.RotateRight.Tooltip = {'shortcut ''d'''};
            app.RotateRight.Position = [88 58 28 28];
            app.RotateRight.Text = '>';

            % Create Rotate
            app.Rotate = uilabel(app.DVisualizationPanel);
            app.Rotate.HorizontalAlignment = 'center';
            app.Rotate.FontName = 'SansSerif';
            app.Rotate.FontSize = 16;
            app.Rotate.Position = [36 61 53 22];
            app.Rotate.Text = 'Rotate';

            % Create RotateDown
            app.RotateDown = uibutton(app.DVisualizationPanel, 'push');
            app.RotateDown.ButtonPushedFcn = createCallbackFcn(app, @RotateDownButtonPushed, true);
            app.RotateDown.IconAlignment = 'center';
            app.RotateDown.VerticalAlignment = 'bottom';
            app.RotateDown.BackgroundColor = [1 1 1];
            app.RotateDown.FontName = 'SansSerif';
            app.RotateDown.FontSize = 24;
            app.RotateDown.FontWeight = 'bold';
            app.RotateDown.Tooltip = {'shortcut ''s'''};
            app.RotateDown.Position = [49 33 28 28];
            app.RotateDown.Text = '▼';

            % Create RotateUp
            app.RotateUp = uibutton(app.DVisualizationPanel, 'push');
            app.RotateUp.ButtonPushedFcn = createCallbackFcn(app, @RotateUpButtonPushed, true);
            app.RotateUp.IconAlignment = 'center';
            app.RotateUp.VerticalAlignment = 'bottom';
            app.RotateUp.BackgroundColor = [1 1 1];
            app.RotateUp.FontName = 'SansSerif';
            app.RotateUp.FontSize = 24;
            app.RotateUp.FontWeight = 'bold';
            app.RotateUp.Tooltip = {'shortcut ''w'''};
            app.RotateUp.Position = [49 84 28 28];
            app.RotateUp.Text = '▲';

            % Create ResetRotation
            app.ResetRotation = uibutton(app.DVisualizationPanel, 'push');
            app.ResetRotation.ButtonPushedFcn = createCallbackFcn(app, @ResetRotationButtonPushed, true);
            app.ResetRotation.IconAlignment = 'center';
            app.ResetRotation.FontName = 'SansSerif';
            app.ResetRotation.FontSize = 16;
            app.ResetRotation.Tooltip = {'Reset rotation to original view'; 'shortcut ''r'''};
            app.ResetRotation.Position = [9 1 107 28];
            app.ResetRotation.Text = 'Reset rotation';

			% Create TimeframeSpinner_4Label
            app.TimeframeSpinner_4Label = uilabel(app.DVisualizationPanel);
            app.TimeframeSpinner_4Label.HorizontalAlignment = 'right';
            app.TimeframeSpinner_4Label.FontName = 'SansSerif';
            app.TimeframeSpinner_4Label.FontSize = 14;
            app.TimeframeSpinner_4Label.Position = [533 37 76 22];
            app.TimeframeSpinner_4Label.Text = 'Time frame';

            % Create SegTimeframeSpinner
            app.SegTimeframeSpinner = uispinner(app.DVisualizationPanel);
            app.SegTimeframeSpinner.ValueChangedFcn = createCallbackFcn(app, @SegTimeframeSpinnerValueChanged, true);
            app.SegTimeframeSpinner.FontName = 'SansSerif';
            app.SegTimeframeSpinner.FontSize = 14;
            app.SegTimeframeSpinner.Enable = 'off';
            app.SegTimeframeSpinner.Tooltip = {''};
            app.SegTimeframeSpinner.Position = [549 12 60 22];
            app.SegTimeframeSpinner.Value = 1;


            % Create flipsegud
            app.flipsegud = uicheckbox(app.DVisualizationPanel);
            app.flipsegud.ValueChangedFcn = createCallbackFcn(app, @flipsegudValueChanged, true);
            app.flipsegud.Visible = 'off';
            app.flipsegud.Tooltip = {'flip segmentation (if slice direction was wrong)'};
            app.flipsegud.Text = 'up/down';
            app.flipsegud.FontName = 'SansSerif';
            app.flipsegud.FontSize = 14;
            app.flipsegud.Position = [491 664 75 22];

            % Create flipseglr
            app.flipseglr = uicheckbox(app.DVisualizationPanel);
            app.flipseglr.ValueChangedFcn = createCallbackFcn(app, @flipseglrValueChanged, true);
            app.flipseglr.Visible = 'off';
            app.flipseglr.Tooltip = {'flip segmentation (if slice direction was wrong)'};
            app.flipseglr.Text = 'left/right';
            app.flipseglr.FontName = 'SansSerif';
            app.flipseglr.FontSize = 14;
            app.flipseglr.Position = [491 643 72 22];

            % Create flipsegio
            app.flipsegio = uicheckbox(app.DVisualizationPanel);
            app.flipsegio.ValueChangedFcn = createCallbackFcn(app, @flipsegioValueChanged, true);
            app.flipsegio.Visible = 'off';
            app.flipsegio.Tooltip = {'flip segmentation (if slice direction was wrong)'};
            app.flipsegio.Text = 'in/out';
            app.flipsegio.FontName = 'SansSerif';
            app.flipsegio.FontSize = 14;
            app.flipsegio.Position = [491 622 56 22];

            % Create flipSegLabel
            app.flipSegLabel = uilabel(app.DVisualizationPanel);
            app.flipSegLabel.HorizontalAlignment = 'right';
            app.flipSegLabel.FontName = 'SansSerif';
            app.flipSegLabel.FontSize = 14;
            app.flipSegLabel.Visible = 'off';
            app.flipSegLabel.Tooltip = {'the number of standard deviations outside of the background signal'};
            app.flipSegLabel.Position = [494 685 116 22];
            app.flipSegLabel.Text = 'Flip segmentation';

            % Create ProcessingPanel
            app.ProcessingPanel = uipanel(app.LoadingandPreprocessingTab);
            app.ProcessingPanel.BorderType = 'none';
            app.ProcessingPanel.TitlePosition = 'centertop';
            app.ProcessingPanel.Title = 'Processing';
            app.ProcessingPanel.BackgroundColor = [1 1 1];
            app.ProcessingPanel.FontName = 'SansSerif';
            app.ProcessingPanel.FontWeight = 'bold';
            app.ProcessingPanel.FontSize = 16;
            app.ProcessingPanel.Position = [1 1 617 121];

            % Create PulseWaveVelocityPushButton
            app.PulseWaveVelocityPushButton = uibutton(app.ProcessingPanel, 'push');
            app.PulseWaveVelocityPushButton.ButtonPushedFcn = createCallbackFcn(app, @PulseWaveVelocityPushButtonButtonPushed, true);
            app.PulseWaveVelocityPushButton.IconAlignment = 'center';
            app.PulseWaveVelocityPushButton.FontName = 'SansSerif';
            app.PulseWaveVelocityPushButton.FontSize = 16;
            app.PulseWaveVelocityPushButton.Tooltip = {'calculate segmentation centerline for flow/PWV measurement'};
            app.PulseWaveVelocityPushButton.Position = [372 18 187 28];
            app.PulseWaveVelocityPushButton.Text = 'Pulse Wave Velocity';

            % Create MapsPushButton
            app.MapsPushButton = uibutton(app.ProcessingPanel, 'push');
            app.MapsPushButton.ButtonPushedFcn = createCallbackFcn(app, @MapsPushButtonPushed, true);
            app.MapsPushButton.FontName = 'SansSerif';
            app.MapsPushButton.FontSize = 16;
            app.MapsPushButton.Tooltip = {'calculate and display mapped parameters'};
            app.MapsPushButton.Position = [65 18 187 28];
            app.MapsPushButton.Text = 'Maps';

            % Create VelocityUnwrapping
            app.VelocityUnwrapping = uibutton(app.ProcessingPanel, 'push');
            app.VelocityUnwrapping.ButtonPushedFcn = createCallbackFcn(app, @VelocityUnwrappingButtonPushed, true);
            app.VelocityUnwrapping.FontName = 'SansSerif';
            app.VelocityUnwrapping.FontSize = 16;
            app.VelocityUnwrapping.Tooltip = {'open velocity unwrapping tab'};
            app.VelocityUnwrapping.Position = [219 57 187 28];
            app.VelocityUnwrapping.Text = 'Velocity Unwrapping';

            % Create VelocityUnwrappingTab
            app.VelocityUnwrappingTab = uitab(app.TabGroup);
            app.VelocityUnwrappingTab.Title = 'Velocity Unwrapping';
            app.VelocityUnwrappingTab.BackgroundColor = [1 1 1];

            % Create Unwrap_2
            app.Unwrap_2 = uiaxes(app.VelocityUnwrappingTab);
            app.Unwrap_2.FontName = 'SansSerif';
            app.Unwrap_2.Colormap = [0.2431 0.149 0.6588;0.251 0.1647 0.7059;0.2588 0.1804 0.7529;0.2627 0.1961 0.7961;0.2706 0.2157 0.8353;0.2745 0.2353 0.8706;0.2784 0.2549 0.898;0.2784 0.2784 0.9216;0.2824 0.302 0.9412;0.2824 0.3216 0.9569;0.2784 0.3451 0.9725;0.2745 0.3686 0.9843;0.2706 0.3882 0.9922;0.2588 0.4118 0.9961;0.2431 0.4353 1;0.2196 0.4588 0.9961;0.1961 0.4863 0.9882;0.1843 0.5059 0.9804;0.1804 0.5294 0.9686;0.1765 0.549 0.9529;0.1686 0.5686 0.9373;0.1529 0.5922 0.9216;0.1451 0.6078 0.9098;0.1373 0.6275 0.898;0.1255 0.6471 0.8902;0.1098 0.6627 0.8745;0.0941 0.6784 0.8588;0.0706 0.6941 0.8392;0.0314 0.7098 0.8157;0.0039 0.7216 0.7922;0.0078 0.7294 0.7647;0.0431 0.7412 0.7412;0.098 0.749 0.7137;0.1412 0.7569 0.6824;0.1725 0.7686 0.6549;0.1922 0.7765 0.6235;0.2157 0.7843 0.5922;0.2471 0.7922 0.5569;0.2902 0.7961 0.5176;0.3412 0.8 0.4784;0.3922 0.8039 0.4353;0.4471 0.8039 0.3922;0.5059 0.8 0.349;0.5608 0.7961 0.3059;0.6157 0.7882 0.2627;0.6706 0.7804 0.2235;0.7255 0.7686 0.1922;0.7725 0.7608 0.1647;0.8196 0.749 0.1529;0.8627 0.7412 0.1608;0.902 0.7333 0.1765;0.9412 0.7294 0.2118;0.9725 0.7294 0.2392;0.9961 0.7451 0.2353;0.9961 0.7647 0.2196;0.9961 0.7882 0.2039;0.9882 0.8118 0.1882;0.9804 0.8392 0.1765;0.9686 0.8627 0.1647;0.9608 0.8902 0.1529;0.9608 0.9137 0.1412;0.9647 0.9373 0.1255;0.9686 0.9608 0.1059;0.9765 0.9843 0.0824];
            app.Unwrap_2.XColor = 'none';
            app.Unwrap_2.XTick = [];
            app.Unwrap_2.YColor = 'none';
            app.Unwrap_2.YTick = [];
            app.Unwrap_2.FontSize = 14;
            app.Unwrap_2.Position = [414 59 400 563];

            % Create Unwrap_1
            app.Unwrap_1 = uiaxes(app.VelocityUnwrappingTab);
            app.Unwrap_1.FontName = 'SansSerif';
            app.Unwrap_1.Colormap = [0.2431 0.149 0.6588;0.251 0.1647 0.7059;0.2588 0.1804 0.7529;0.2627 0.1961 0.7961;0.2706 0.2157 0.8353;0.2745 0.2353 0.8706;0.2784 0.2549 0.898;0.2784 0.2784 0.9216;0.2824 0.302 0.9412;0.2824 0.3216 0.9569;0.2784 0.3451 0.9725;0.2745 0.3686 0.9843;0.2706 0.3882 0.9922;0.2588 0.4118 0.9961;0.2431 0.4353 1;0.2196 0.4588 0.9961;0.1961 0.4863 0.9882;0.1843 0.5059 0.9804;0.1804 0.5294 0.9686;0.1765 0.549 0.9529;0.1686 0.5686 0.9373;0.1529 0.5922 0.9216;0.1451 0.6078 0.9098;0.1373 0.6275 0.898;0.1255 0.6471 0.8902;0.1098 0.6627 0.8745;0.0941 0.6784 0.8588;0.0706 0.6941 0.8392;0.0314 0.7098 0.8157;0.0039 0.7216 0.7922;0.0078 0.7294 0.7647;0.0431 0.7412 0.7412;0.098 0.749 0.7137;0.1412 0.7569 0.6824;0.1725 0.7686 0.6549;0.1922 0.7765 0.6235;0.2157 0.7843 0.5922;0.2471 0.7922 0.5569;0.2902 0.7961 0.5176;0.3412 0.8 0.4784;0.3922 0.8039 0.4353;0.4471 0.8039 0.3922;0.5059 0.8 0.349;0.5608 0.7961 0.3059;0.6157 0.7882 0.2627;0.6706 0.7804 0.2235;0.7255 0.7686 0.1922;0.7725 0.7608 0.1647;0.8196 0.749 0.1529;0.8627 0.7412 0.1608;0.902 0.7333 0.1765;0.9412 0.7294 0.2118;0.9725 0.7294 0.2392;0.9961 0.7451 0.2353;0.9961 0.7647 0.2196;0.9961 0.7882 0.2039;0.9882 0.8118 0.1882;0.9804 0.8392 0.1765;0.9686 0.8627 0.1647;0.9608 0.8902 0.1529;0.9608 0.9137 0.1412;0.9647 0.9373 0.1255;0.9686 0.9608 0.1059;0.9765 0.9843 0.0824];
            app.Unwrap_1.XColor = 'none';
            app.Unwrap_1.XTick = [];
            app.Unwrap_1.YColor = 'none';
            app.Unwrap_1.YTick = [];
            app.Unwrap_1.FontSize = 14;
            app.Unwrap_1.Position = [5 59 400 563];

            % Create Unwrap_3
            app.Unwrap_3 = uiaxes(app.VelocityUnwrappingTab);
            app.Unwrap_3.FontName = 'SansSerif';
            app.Unwrap_3.Colormap = [0.2431 0.149 0.6588;0.251 0.1647 0.7059;0.2588 0.1804 0.7529;0.2627 0.1961 0.7961;0.2706 0.2157 0.8353;0.2745 0.2353 0.8706;0.2784 0.2549 0.898;0.2784 0.2784 0.9216;0.2824 0.302 0.9412;0.2824 0.3216 0.9569;0.2784 0.3451 0.9725;0.2745 0.3686 0.9843;0.2706 0.3882 0.9922;0.2588 0.4118 0.9961;0.2431 0.4353 1;0.2196 0.4588 0.9961;0.1961 0.4863 0.9882;0.1843 0.5059 0.9804;0.1804 0.5294 0.9686;0.1765 0.549 0.9529;0.1686 0.5686 0.9373;0.1529 0.5922 0.9216;0.1451 0.6078 0.9098;0.1373 0.6275 0.898;0.1255 0.6471 0.8902;0.1098 0.6627 0.8745;0.0941 0.6784 0.8588;0.0706 0.6941 0.8392;0.0314 0.7098 0.8157;0.0039 0.7216 0.7922;0.0078 0.7294 0.7647;0.0431 0.7412 0.7412;0.098 0.749 0.7137;0.1412 0.7569 0.6824;0.1725 0.7686 0.6549;0.1922 0.7765 0.6235;0.2157 0.7843 0.5922;0.2471 0.7922 0.5569;0.2902 0.7961 0.5176;0.3412 0.8 0.4784;0.3922 0.8039 0.4353;0.4471 0.8039 0.3922;0.5059 0.8 0.349;0.5608 0.7961 0.3059;0.6157 0.7882 0.2627;0.6706 0.7804 0.2235;0.7255 0.7686 0.1922;0.7725 0.7608 0.1647;0.8196 0.749 0.1529;0.8627 0.7412 0.1608;0.902 0.7333 0.1765;0.9412 0.7294 0.2118;0.9725 0.7294 0.2392;0.9961 0.7451 0.2353;0.9961 0.7647 0.2196;0.9961 0.7882 0.2039;0.9882 0.8118 0.1882;0.9804 0.8392 0.1765;0.9686 0.8627 0.1647;0.9608 0.8902 0.1529;0.9608 0.9137 0.1412;0.9647 0.9373 0.1255;0.9686 0.9608 0.1059;0.9765 0.9843 0.0824];
            app.Unwrap_3.XColor = 'none';
            app.Unwrap_3.XTick = [];
            app.Unwrap_3.YColor = 'none';
            app.Unwrap_3.YTick = [];
            app.Unwrap_3.FontSize = 14;
            app.Unwrap_3.Position = [823 59 400 563];

            % Create TimeframeSpinner_3Label
            app.TimeframeSpinner_3Label = uilabel(app.VelocityUnwrappingTab);
            app.TimeframeSpinner_3Label.HorizontalAlignment = 'right';
            app.TimeframeSpinner_3Label.FontName = 'SansSerif';
            app.TimeframeSpinner_3Label.FontSize = 18;
            app.TimeframeSpinner_3Label.Position = [414 643 96 22];
            app.TimeframeSpinner_3Label.Text = 'Time frame';

            % Create TimeframeSpinner_3
            app.TimeframeSpinner_3 = uispinner(app.VelocityUnwrappingTab);
            app.TimeframeSpinner_3.ValueChangedFcn = createCallbackFcn(app, @TimeframeSpinner_3ValueChanged, true);
            app.TimeframeSpinner_3.FontName = 'SansSerif';
            app.TimeframeSpinner_3.FontSize = 18;
            app.TimeframeSpinner_3.Tooltip = {'shortcut ''↑'' or ''↓'''};
            app.TimeframeSpinner_3.Position = [523 642 60 23];

            % Create SliceSpinner_Label
            app.SliceSpinner_Label = uilabel(app.VelocityUnwrappingTab);
            app.SliceSpinner_Label.HorizontalAlignment = 'right';
            app.SliceSpinner_Label.FontName = 'SansSerif';
            app.SliceSpinner_Label.FontSize = 18;
            app.SliceSpinner_Label.Position = [701 643 45 22];
            app.SliceSpinner_Label.Text = 'Slice';

            % Create SliceSpinner
            app.SliceSpinner = uispinner(app.VelocityUnwrappingTab);
            app.SliceSpinner.ValueChangedFcn = createCallbackFcn(app, @SliceSpinnerValueChanged, true);
            app.SliceSpinner.FontName = 'SansSerif';
            app.SliceSpinner.FontSize = 18;
            app.SliceSpinner.Tooltip = {'shortcut ''←'' or ''→'''};
            app.SliceSpinner.Position = [754 642 60 23];

            % Create Unwrap_automatic
            app.Unwrap_automatic = uibutton(app.VelocityUnwrappingTab, 'push');
            app.Unwrap_automatic.ButtonPushedFcn = createCallbackFcn(app, @Unwrap_automaticButtonPushed, true);
            app.Unwrap_automatic.IconAlignment = 'center';
            app.Unwrap_automatic.FontName = 'SansSerif';
            app.Unwrap_automatic.FontSize = 16;
            app.Unwrap_automatic.Tooltip = {'perform automatic unwrapping of the current slice/timepoint, assuming previous timepoint has no wrapping'};
            app.Unwrap_automatic.Position = [924 686 187 28];
            app.Unwrap_automatic.Text = 'Automatic unwrap slice';

            % Create LaplaceUnwrap
            app.LaplaceUnwrap = uibutton(app.VelocityUnwrappingTab, 'push');
            app.LaplaceUnwrap.ButtonPushedFcn = createCallbackFcn(app, @LaplaceUnwrapButtonPushed, true);
            app.LaplaceUnwrap.IconAlignment = 'center';
            app.LaplaceUnwrap.FontName = 'SansSerif';
            app.LaplaceUnwrap.FontSize = 16;
            app.LaplaceUnwrap.Tooltip = {'Perform 4D Laplacian unwrapping'};
            app.LaplaceUnwrap.Position = [924 647 187 28];
            app.LaplaceUnwrap.Text = 'Laplacian unwrapping';

            % Create Unwrap_manual_1
            app.Unwrap_manual_1 = uicheckbox(app.VelocityUnwrappingTab);
            app.Unwrap_manual_1.Tooltip = {'select voxels to unwrap'};
            app.Unwrap_manual_1.Text = 'Unwrap manually';
            app.Unwrap_manual_1.FontName = 'SansSerif';
            app.Unwrap_manual_1.FontSize = 16;
            app.Unwrap_manual_1.Position = [132 33 146 22];

            % Create Unwrap_manual_2
            app.Unwrap_manual_2 = uicheckbox(app.VelocityUnwrappingTab);
            app.Unwrap_manual_2.Tooltip = {'select voxels to unwrap'};
            app.Unwrap_manual_2.Text = 'Unwrap manually';
            app.Unwrap_manual_2.FontName = 'SansSerif';
            app.Unwrap_manual_2.FontSize = 16;
            app.Unwrap_manual_2.Position = [541 33 146 22];

            % Create Unwrap_manual_3
            app.Unwrap_manual_3 = uicheckbox(app.VelocityUnwrappingTab);
            app.Unwrap_manual_3.Tooltip = {'select voxels to unwrap'};
            app.Unwrap_manual_3.Text = 'Unwrap manually';
            app.Unwrap_manual_3.FontName = 'SansSerif';
            app.Unwrap_manual_3.FontSize = 16;
            app.Unwrap_manual_3.Position = [950 33 146 22];

            % Create Maps
            app.Maps = uitab(app.TabGroup);
            app.Maps.Title = 'Maps';
            app.Maps.BackgroundColor = [1 1 1];

            % Create MapGroup
            app.MapGroup = uipanel(app.Maps);
            app.MapGroup.BorderType = 'none';
            app.MapGroup.TitlePosition = 'centertop';
            app.MapGroup.Title = 'Map';
            app.MapGroup.BackgroundColor = [1 1 1];
            app.MapGroup.FontName = 'SansSerif';
            app.MapGroup.FontWeight = 'bold';
            app.MapGroup.FontSize = 16;
            app.MapGroup.Position = [480 18 475 702];

            % Create MapPlot
            app.MapPlot = uiaxes(app.MapGroup);
            app.MapPlot.YDir = 'reverse';
            app.MapPlot.ZDir = 'reverse';
            app.MapPlot.XColor = 'none';
            app.MapPlot.XTick = [];
            app.MapPlot.YColor = 'none';
            app.MapPlot.YTick = [];
            app.MapPlot.FontSize = 14;
            app.MapPlot.Position = [1 0 475 669];

            % Create MapTimeframeSpinner
            app.MapTimeframeSpinner = uispinner(app.MapGroup);
            app.MapTimeframeSpinner.ValueChangedFcn = createCallbackFcn(app, @MapTimeframeSpinnerValueChanged, true);
            app.MapTimeframeSpinner.FontSize = 14;
            app.MapTimeframeSpinner.Enable = 'off';
            app.MapTimeframeSpinner.Position = [416 633 60 22];

            % Create WSSEditFieldLabel
            app.WSSEditFieldLabel = uilabel(app.MapGroup);
            app.WSSEditFieldLabel.HorizontalAlignment = 'center';
            app.WSSEditFieldLabel.FontName = 'SansSerif';
            app.WSSEditFieldLabel.Enable = 'off';
            app.WSSEditFieldLabel.Position = [366 26 84 22];
            app.WSSEditFieldLabel.Text = 'wss scale (Pa)';

            % Create minWSSEditField
            app.minWSSEditField = uieditfield(app.MapGroup, 'text');
            app.minWSSEditField.ValueChangedFcn = createCallbackFcn(app, @minWSSEditFieldValueChanged, true);
            app.minWSSEditField.HorizontalAlignment = 'right';
            app.minWSSEditField.FontName = 'SansSerif';
            app.minWSSEditField.Enable = 'off';
            app.minWSSEditField.Position = [368 3 30 22];
            app.minWSSEditField.Value = '0';

            % Create WSStoEditFieldLabel
            app.WSStoEditFieldLabel = uilabel(app.MapGroup);
            app.WSStoEditFieldLabel.HorizontalAlignment = 'right';
            app.WSStoEditFieldLabel.FontName = 'SansSerif';
            app.WSStoEditFieldLabel.Enable = 'off';
            app.WSStoEditFieldLabel.Position = [391 3 25 22];
            app.WSStoEditFieldLabel.Text = 'to';

            % Create maxWSSEditField
            app.maxWSSEditField = uieditfield(app.MapGroup, 'text');
            app.maxWSSEditField.ValueChangedFcn = createCallbackFcn(app, @maxWSSEditFieldValueChanged, true);
            app.maxWSSEditField.HorizontalAlignment = 'right';
            app.maxWSSEditField.FontName = 'SansSerif';
            app.maxWSSEditField.Enable = 'off';
            app.maxWSSEditField.Position = [420 3 32 22];
            app.maxWSSEditField.Value = '4';

            % Create MapTimeframeSpinnerLabel
            app.MapTimeframeSpinnerLabel = uilabel(app.MapGroup);
            app.MapTimeframeSpinnerLabel.HorizontalAlignment = 'right';
            app.MapTimeframeSpinnerLabel.FontSize = 14;
            app.MapTimeframeSpinnerLabel.Enable = 'off';
            app.MapTimeframeSpinnerLabel.Position = [398 660 76 22];
            app.MapTimeframeSpinnerLabel.Text = 'Time frame';

            % Create VelocityVectorGroup
            app.VelocityVectorGroup = uipanel(app.Maps);
            app.VelocityVectorGroup.BorderType = 'none';
            app.VelocityVectorGroup.TitlePosition = 'centertop';
            app.VelocityVectorGroup.Title = 'Velocity Vectors';
            app.VelocityVectorGroup.BackgroundColor = [1 1 1];
            app.VelocityVectorGroup.FontName = 'SansSerif';
            app.VelocityVectorGroup.FontWeight = 'bold';
            app.VelocityVectorGroup.FontSize = 16;
            app.VelocityVectorGroup.Position = [1 18 475 702];

            % Create VelocityVectorsPlot
            app.VelocityVectorsPlot = uiaxes(app.VelocityVectorGroup);
            app.VelocityVectorsPlot.YDir = 'reverse';
            app.VelocityVectorsPlot.ZDir = 'reverse';
            app.VelocityVectorsPlot.XColor = 'none';
            app.VelocityVectorsPlot.XTick = [];
            app.VelocityVectorsPlot.YColor = 'none';
            app.VelocityVectorsPlot.YTick = [];
            app.VelocityVectorsPlot.FontSize = 14;
            app.VelocityVectorsPlot.Position = [1 0 475 669];

            % Create TimeframeSpinnerLabel
            app.TimeframeSpinnerLabel = uilabel(app.VelocityVectorGroup);
            app.TimeframeSpinnerLabel.HorizontalAlignment = 'right';
            app.TimeframeSpinnerLabel.FontName = 'SansSerif';
            app.TimeframeSpinnerLabel.FontSize = 14;
            app.TimeframeSpinnerLabel.Enable = 'off';
            app.TimeframeSpinnerLabel.Position = [392 658 76 22];
            app.TimeframeSpinnerLabel.Text = 'Time frame';

            % Create TimeframeSpinner
            app.TimeframeSpinner = uispinner(app.VelocityVectorGroup);
            app.TimeframeSpinner.ValueChangedFcn = createCallbackFcn(app, @TimeframeSpinnerValueChanged, true);
            app.TimeframeSpinner.FontName = 'SansSerif';
            app.TimeframeSpinner.FontSize = 14;
            app.TimeframeSpinner.Enable = 'off';
            app.TimeframeSpinner.Tooltip = {'shortcut ''↑'' or ''↓'''};
            app.TimeframeSpinner.Position = [408 633 60 22];

            % Create quiverscaleEditFieldLabel
            app.quiverscaleEditFieldLabel = uilabel(app.VelocityVectorGroup);
            app.quiverscaleEditFieldLabel.HorizontalAlignment = 'right';
            app.quiverscaleEditFieldLabel.FontName = 'SansSerif';
            app.quiverscaleEditFieldLabel.Enable = 'off';
            app.quiverscaleEditFieldLabel.Position = [376 23 70 22];
            app.quiverscaleEditFieldLabel.Text = 'quiver scale';

            % Create minQuiverEditField
            app.minQuiverEditField = uieditfield(app.VelocityVectorGroup, 'text');
            app.minQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @minQuiverEditFieldValueChanged, true);
            app.minQuiverEditField.HorizontalAlignment = 'right';
            app.minQuiverEditField.FontName = 'SansSerif';
            app.minQuiverEditField.Enable = 'off';
            app.minQuiverEditField.Position = [374 4 30 22];
            app.minQuiverEditField.Value = '2';

            % Create toXEditFieldLabel_2
            app.toXEditFieldLabel_2 = uilabel(app.VelocityVectorGroup);
            app.toXEditFieldLabel_2.HorizontalAlignment = 'right';
            app.toXEditFieldLabel_2.FontName = 'SansSerif';
            app.toXEditFieldLabel_2.Enable = 'off';
            app.toXEditFieldLabel_2.Position = [397 4 25 22];
            app.toXEditFieldLabel_2.Text = 'to';

            % Create maxQuiverEditField
            app.maxQuiverEditField = uieditfield(app.VelocityVectorGroup, 'text');
            app.maxQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @maxQuiverEditFieldValueChanged, true);
            app.maxQuiverEditField.HorizontalAlignment = 'right';
            app.maxQuiverEditField.FontName = 'SansSerif';
            app.maxQuiverEditField.Enable = 'off';
            app.maxQuiverEditField.Position = [426 4 32 22];
            app.maxQuiverEditField.Value = '5';

            % Create velocityVectorEditFieldLabel
            app.velocityVectorEditFieldLabel = uilabel(app.VelocityVectorGroup);
            app.velocityVectorEditFieldLabel.HorizontalAlignment = 'right';
            app.velocityVectorEditFieldLabel.FontName = 'SansSerif';
            app.velocityVectorEditFieldLabel.Enable = 'off';
            app.velocityVectorEditFieldLabel.Position = [354 72 114 22];
            app.velocityVectorEditFieldLabel.Text = 'velocity scale (cm/s)';

            % Create minVelocityVectorEditField
            app.minVelocityVectorEditField = uieditfield(app.VelocityVectorGroup, 'text');
            app.minVelocityVectorEditField.ValueChangedFcn = createCallbackFcn(app, @minVelocityVectorEditFieldValueChanged, true);
            app.minVelocityVectorEditField.HorizontalAlignment = 'right';
            app.minVelocityVectorEditField.FontName = 'SansSerif';
            app.minVelocityVectorEditField.Enable = 'off';
            app.minVelocityVectorEditField.Position = [374 52 30 22];
            app.minVelocityVectorEditField.Value = '0';

            % Create velocityVectortoEditFieldLabel
            app.velocityVectortoEditFieldLabel = uilabel(app.VelocityVectorGroup);
            app.velocityVectortoEditFieldLabel.HorizontalAlignment = 'right';
            app.velocityVectortoEditFieldLabel.FontName = 'SansSerif';
            app.velocityVectortoEditFieldLabel.Enable = 'off';
            app.velocityVectortoEditFieldLabel.Position = [397 52 25 22];
            app.velocityVectortoEditFieldLabel.Text = 'to';

            % Create maxVelocityVectorEditField
            app.maxVelocityVectorEditField = uieditfield(app.VelocityVectorGroup, 'text');
            app.maxVelocityVectorEditField.ValueChangedFcn = createCallbackFcn(app, @maxVelocityVectorEditFieldValueChanged, true);
            app.maxVelocityVectorEditField.HorizontalAlignment = 'right';
            app.maxVelocityVectorEditField.FontName = 'SansSerif';
            app.maxVelocityVectorEditField.Enable = 'off';
            app.maxVelocityVectorEditField.Position = [426 52 32 22];
            app.maxVelocityVectorEditField.Value = 'max';

            % Create SliceSpinner_2Label
            app.SliceSpinner_2Label = uilabel(app.VelocityVectorGroup);
            app.SliceSpinner_2Label.HorizontalAlignment = 'right';
            app.SliceSpinner_2Label.FontName = 'SansSerif';
            app.SliceSpinner_2Label.Enable = 'off';
            app.SliceSpinner_2Label.Visible = 'off';
            app.SliceSpinner_2Label.Position = [36 32 32 22];
            app.SliceSpinner_2Label.Text = 'Slice';

            % Create SliceSpinner_2
            app.SliceSpinner_2 = uispinner(app.VelocityVectorGroup);
            app.SliceSpinner_2.ValueChangedFcn = createCallbackFcn(app, @SliceSpinner_2ValueChanged, true);
            app.SliceSpinner_2.FontName = 'SansSerif';
            app.SliceSpinner_2.FontSize = 14;
            app.SliceSpinner_2.Enable = 'off';
            app.SliceSpinner_2.Visible = 'off';
            app.SliceSpinner_2.Tooltip = {'shortcut ''←'' or ''→'''};
            app.SliceSpinner_2.Position = [20 8 60 22];

            % Create VectorType
            app.VectorType = uilabel(app.VelocityVectorGroup);
            app.VectorType.HorizontalAlignment = 'right';
            app.VectorType.FontName = 'SansSerif';
            app.VectorType.Position = [17 59 66 22];
            app.VectorType.Text = 'Vector type';

            % Create VectorOptionsDropDown
            app.VectorOptionsDropDown = uidropdown(app.VelocityVectorGroup);
            app.VectorOptionsDropDown.Items = {'segmentation', 'slice-wise'};
            app.VectorOptionsDropDown.ValueChangedFcn = createCallbackFcn(app, @VectorOptionsDropDownValueChanged, true);
            app.VectorOptionsDropDown.FontName = 'SansSerif';
            app.VectorOptionsDropDown.Position = [6 33 162 22];
            app.VectorOptionsDropDown.Value = 'segmentation';

            % Create PeaksystoleEditFieldLabel
            app.PeaksystoleEditFieldLabel = uilabel(app.Maps);
            app.PeaksystoleEditFieldLabel.HorizontalAlignment = 'right';
            app.PeaksystoleEditFieldLabel.FontName = 'SansSerif';
            app.PeaksystoleEditFieldLabel.Enable = 'off';
            app.PeaksystoleEditFieldLabel.Position = [1056 698 74 22];
            app.PeaksystoleEditFieldLabel.Text = 'Peak systole';

            % Create PeaksystoleEditField
            app.PeaksystoleEditField = uieditfield(app.Maps, 'text');
            app.PeaksystoleEditField.Editable = 'off';
            app.PeaksystoleEditField.FontName = 'SansSerif';
            app.PeaksystoleEditField.Enable = 'off';
            app.PeaksystoleEditField.Tooltip = {'the calculated peak systolic phase'};
            app.PeaksystoleEditField.Position = [1142 697 39 22];

            % Create CalculateMap
            app.CalculateMap = uibutton(app.Maps, 'push');
            app.CalculateMap.ButtonPushedFcn = createCallbackFcn(app, @CalculateMapPushed, true);
            app.CalculateMap.IconAlignment = 'center';
            app.CalculateMap.FontName = 'SansSerif';
            app.CalculateMap.FontSize = 16;
            app.CalculateMap.Enable = 'off';
            app.CalculateMap.Tooltip = {'calculate WSS'};
            app.CalculateMap.Position = [1036 654 145 28];
            app.CalculateMap.Text = '(Re)Calculate Map';

            % Create SaveAnimation
            app.SaveAnimation = uibutton(app.Maps, 'push');
            app.SaveAnimation.ButtonPushedFcn = createCallbackFcn(app, @SaveAnimationButtonPushed, true);
            app.SaveAnimation.IconAlignment = 'center';
            app.SaveAnimation.FontName = 'SansSerif';
            app.SaveAnimation.FontSize = 16;
            app.SaveAnimation.Enable = 'off';
            app.SaveAnimation.Tooltip = {'save animation of plots over time'};
            app.SaveAnimation.Position = [1022 575 159 28];
            app.SaveAnimation.Text = 'Save animation';

            % Create LinkplotsCheckBox
            app.LinkplotsCheckBox = uicheckbox(app.Maps);
            app.LinkplotsCheckBox.ValueChangedFcn = createCallbackFcn(app, @LinkplotsCheckBoxValueChanged, true);
            app.LinkplotsCheckBox.Enable = 'off';
            app.LinkplotsCheckBox.Tooltip = {'link timing for velocity vector and wss plots (only if WSS calculated for all time frames)'};
            app.LinkplotsCheckBox.Text = 'Link plots';
            app.LinkplotsCheckBox.FontName = 'SansSerif';
            app.LinkplotsCheckBox.FontSize = 14;
            app.LinkplotsCheckBox.Position = [1100 617 81 22];
            app.LinkplotsCheckBox.Value = true;

            % Create RotateLeft_2
            app.RotateLeft_2 = uibutton(app.Maps, 'push');
            app.RotateLeft_2.ButtonPushedFcn = createCallbackFcn(app, @RotateLeft_2ButtonPushed, true);
            app.RotateLeft_2.IconAlignment = 'center';
            app.RotateLeft_2.VerticalAlignment = 'bottom';
            app.RotateLeft_2.BackgroundColor = [1 1 1];
            app.RotateLeft_2.FontName = 'SansSerif';
            app.RotateLeft_2.FontSize = 24;
            app.RotateLeft_2.FontWeight = 'bold';
            app.RotateLeft_2.Tooltip = {'shortcut ''a'''};
            app.RotateLeft_2.Position = [1050 68 28 28];
            app.RotateLeft_2.Text = '<';

            % Create RotateRight_2
            app.RotateRight_2 = uibutton(app.Maps, 'push');
            app.RotateRight_2.ButtonPushedFcn = createCallbackFcn(app, @RotateRight_2ButtonPushed, true);
            app.RotateRight_2.IconAlignment = 'center';
            app.RotateRight_2.VerticalAlignment = 'bottom';
            app.RotateRight_2.BackgroundColor = [1 1 1];
            app.RotateRight_2.FontName = 'SansSerif';
            app.RotateRight_2.FontSize = 24;
            app.RotateRight_2.FontWeight = 'bold';
            app.RotateRight_2.Tooltip = {'shortcut ''d'''};
            app.RotateRight_2.Position = [1129 68 28 28];
            app.RotateRight_2.Text = '>';

            % Create Rotate_2
            app.Rotate_2 = uilabel(app.Maps);
            app.Rotate_2.HorizontalAlignment = 'center';
            app.Rotate_2.FontName = 'SansSerif';
            app.Rotate_2.FontSize = 16;
            app.Rotate_2.Position = [1077 71 53 22];
            app.Rotate_2.Text = 'Rotate';

            % Create RotateDown_2
            app.RotateDown_2 = uibutton(app.Maps, 'push');
            app.RotateDown_2.ButtonPushedFcn = createCallbackFcn(app, @RotateDown_2ButtonPushed, true);
            app.RotateDown_2.IconAlignment = 'center';
            app.RotateDown_2.VerticalAlignment = 'bottom';
            app.RotateDown_2.BackgroundColor = [1 1 1];
            app.RotateDown_2.FontName = 'SansSerif';
            app.RotateDown_2.FontSize = 24;
            app.RotateDown_2.FontWeight = 'bold';
            app.RotateDown_2.Tooltip = {'shortcut ''s'''};
            app.RotateDown_2.Position = [1090 43 28 28];
            app.RotateDown_2.Text = '▼';

            % Create RotateUp_2
            app.RotateUp_2 = uibutton(app.Maps, 'push');
            app.RotateUp_2.ButtonPushedFcn = createCallbackFcn(app, @RotateUp_2ButtonPushed, true);
            app.RotateUp_2.IconAlignment = 'center';
            app.RotateUp_2.VerticalAlignment = 'bottom';
            app.RotateUp_2.BackgroundColor = [1 1 1];
            app.RotateUp_2.FontName = 'SansSerif';
            app.RotateUp_2.FontSize = 24;
            app.RotateUp_2.FontWeight = 'bold';
            app.RotateUp_2.Tooltip = {'shortcut ''w'''};
            app.RotateUp_2.Position = [1090 94 28 28];
            app.RotateUp_2.Text = '▲';

            % Create ResetRotation_2
            app.ResetRotation_2 = uibutton(app.Maps, 'push');
            app.ResetRotation_2.ButtonPushedFcn = createCallbackFcn(app, @ResetRotation_2ButtonPushed, true);
            app.ResetRotation_2.IconAlignment = 'center';
            app.ResetRotation_2.FontName = 'SansSerif';
            app.ResetRotation_2.FontSize = 16;
            app.ResetRotation_2.Tooltip = {'Reset rotation to original view'; 'shortcut ''r'''};
            app.ResetRotation_2.Position = [1050 11 107 28];
            app.ResetRotation_2.Text = 'Reset rotation';

            % Create MapType
            app.MapType = uidropdown(app.Maps);
            app.MapType.Items = {'None', 'Wall shear stress', 'Peak velocity', 'Mean velocity', 'Kinetic energy', 'Energy Loss', 'Vortex detection'};
            app.MapType.ValueChangedFcn = createCallbackFcn(app, @MapTypeValueChanged, true);
            app.MapType.Tooltip = {'select map to view'; 'currently not implemented: vorticity and energy loss'};
            app.MapType.FontName = 'ZapfDingbats';
            app.MapType.FontSize = 14;
            app.MapType.Position = [811 702 144 22];
            app.MapType.Value = 'None';

            % Create flipvx
            app.flipvx = uicheckbox(app.Maps);
            app.flipvx.ValueChangedFcn = createCallbackFcn(app, @flipvxValueChanged, true);
            app.flipvx.Tooltip = {'flip velocity X direction (if vectors look wrong)'};
            app.flipvx.Text = 'Flip vx';
            app.flipvx.FontName = 'SansSerif';
            app.flipvx.FontSize = 16;
            app.flipvx.Position = [1162 270 68 22];

            % Create flipvy
            app.flipvy = uicheckbox(app.Maps);
            app.flipvy.ValueChangedFcn = createCallbackFcn(app, @flipvyValueChanged, true);
            app.flipvy.Tooltip = {'flip velocity Y direction (if vectors look wrong)'};
            app.flipvy.Text = 'Flip vy';
            app.flipvy.FontName = 'SansSerif';
            app.flipvy.FontSize = 16;
            app.flipvy.Position = [1162 247 68 22];

            % Create flipvz
            app.flipvz = uicheckbox(app.Maps);
            app.flipvz.ValueChangedFcn = createCallbackFcn(app, @flipvzValueChanged, true);
            app.flipvz.Tooltip = {'flip velocity Z direction (if vectors look wrong)'};
            app.flipvz.Text = 'Flip vz';
            app.flipvz.FontName = 'SansSerif';
            app.flipvz.FontSize = 16;
            app.flipvz.Position = [1162 225 68 22];
            
            % Create QuickviewPanel
            app.QuickviewPanel = uipanel(app.Maps);
            app.QuickviewPanel.BorderType = 'none';
            app.QuickviewPanel.TitlePosition = 'centertop';
            app.QuickviewPanel.Title = 'Quick view';
            app.QuickviewPanel.BackgroundColor = [1 1 1];
            app.QuickviewPanel.FontName = 'SansSerif';
            app.QuickviewPanel.FontSize = 16;
            app.QuickviewPanel.Position = [991 139 235 65];

            % Create AxialButton
            app.AxialButton = uibutton(app.QuickviewPanel, 'push');
            app.AxialButton.ButtonPushedFcn = createCallbackFcn(app, @AxialButtonPushed, true);
            app.AxialButton.IconAlignment = 'center';
            app.AxialButton.FontName = 'SansSerif';
            app.AxialButton.Position = [8 8 60 28];
            app.AxialButton.Text = 'Axial';

            % Create SagittalButton
            app.SagittalButton = uibutton(app.QuickviewPanel, 'push');
            app.SagittalButton.ButtonPushedFcn = createCallbackFcn(app, @SagittalButtonPushed, true);
            app.SagittalButton.IconAlignment = 'center';
            app.SagittalButton.FontName = 'SansSerif';
            app.SagittalButton.Position = [87 8 60 28];
            app.SagittalButton.Text = 'Sagittal';

            % Create CoronalButton
            app.CoronalButton = uibutton(app.QuickviewPanel, 'push');
            app.CoronalButton.ButtonPushedFcn = createCallbackFcn(app, @CoronalButtonPushed, true);
            app.CoronalButton.IconAlignment = 'center';
            app.CoronalButton.FontName = 'SansSerif';
            app.CoronalButton.Position = [166 8 60 28];
            app.CoronalButton.Text = 'Coronal';

            % Create FlowandPulseWaveVelocityTab
            app.FlowandPulseWaveVelocityTab = uitab(app.TabGroup);
            app.FlowandPulseWaveVelocityTab.Title = 'Flow and Pulse Wave Velocity';
            app.FlowandPulseWaveVelocityTab.BackgroundColor = [1 1 1];

            % Create WaveformsDisplay
            app.WaveformsDisplay = uiaxes(app.FlowandPulseWaveVelocityTab);
            xlabel(app.WaveformsDisplay, 'Cardiac time (ms)')
            ylabel(app.WaveformsDisplay, 'Flow (mL/s)')
            app.WaveformsDisplay.FontName = 'SansSerif';
            app.WaveformsDisplay.FontSize = 14;
            app.WaveformsDisplay.Position = [470 269 711 232];

            % Create PWVCalcDisplay
            app.PWVCalcDisplay = uiaxes(app.FlowandPulseWaveVelocityTab);
            xlabel(app.PWVCalcDisplay, 'delay (ms)')
            ylabel(app.PWVCalcDisplay, 'distance (mm)')
            app.PWVCalcDisplay.FontName = 'SansSerif';
            app.PWVCalcDisplay.FontSize = 14;
            app.PWVCalcDisplay.Position = [491 25 385 190];

            % Create SegmentationAndCenterline
            app.SegmentationAndCenterline = uipanel(app.FlowandPulseWaveVelocityTab);
            app.SegmentationAndCenterline.BorderType = 'none';
            app.SegmentationAndCenterline.TitlePosition = 'centertop';
            app.SegmentationAndCenterline.Title = '3D View';
            app.SegmentationAndCenterline.BackgroundColor = [1 1 1];
            app.SegmentationAndCenterline.FontName = 'SansSerif';
            app.SegmentationAndCenterline.FontWeight = 'bold';
            app.SegmentationAndCenterline.FontSize = 16;
            app.SegmentationAndCenterline.Position = [1 18 450 702];

            % Create View3D_2
            app.View3D_2 = uiaxes(app.SegmentationAndCenterline);
            app.View3D_2.XColor = 'none';
            app.View3D_2.XTick = [];
            app.View3D_2.YColor = 'none';
            app.View3D_2.YTick = [];
            app.View3D_2.Position = [1 0 459 669];

            % Create Reset3DviewButton
            app.Reset3DviewButton = uibutton(app.SegmentationAndCenterline, 'push');
            app.Reset3DviewButton.ButtonPushedFcn = createCallbackFcn(app, @Reset3DviewButtonPushed, true);
            app.Reset3DviewButton.FontName = 'SansSerif';
            app.Reset3DviewButton.FontSize = 14;
            app.Reset3DviewButton.Tooltip = {'Reset 3D view with overlaid branch number(s) '};
            app.Reset3DviewButton.Position = [343 4 108 29];
            app.Reset3DviewButton.Text = 'Reset 3D view';

            % Create DisplayDistanceCheckbox
            app.DisplayDistanceCheckbox = uicheckbox(app.SegmentationAndCenterline);
            app.DisplayDistanceCheckbox.ValueChangedFcn = createCallbackFcn(app, @DisplayDistanceCheckboxValueChanged, true);
            app.DisplayDistanceCheckbox.Tooltip = {'Display distance on 3D view and turn on distance-based PWV point selection'};
            app.DisplayDistanceCheckbox.Text = 'Display distance';
            app.DisplayDistanceCheckbox.FontName = 'SansSerif';
            app.DisplayDistanceCheckbox.FontSize = 14;
            app.DisplayDistanceCheckbox.Position = [95 7 124 22];

            % Create ParameterLabel
            app.ParameterLabel = uilabel(app.SegmentationAndCenterline);
            app.ParameterLabel.HorizontalAlignment = 'right';
            app.ParameterLabel.FontName = 'SansSerif';
            app.ParameterLabel.FontSize = 14;
            app.ParameterLabel.Visible = 'off';
            app.ParameterLabel.Position = [95 37 75 22];
            app.ParameterLabel.Text = 'Parameter:';

            % Create ParameterDropDown
            app.ParameterDropDown = uidropdown(app.SegmentationAndCenterline);
            app.ParameterDropDown.Items = {'Total Flow', 'Peak Flow', 'Mean velocity', 'Peak velocity'};
            app.ParameterDropDown.ValueChangedFcn = createCallbackFcn(app, @ParameterDropDownValueChanged, true);
            app.ParameterDropDown.Enable = 'off';
            app.ParameterDropDown.Visible = 'off';
            app.ParameterDropDown.FontName = 'SansSerif';
            app.ParameterDropDown.FontSize = 14;
            app.ParameterDropDown.Position = [185 37 162 22];
            app.ParameterDropDown.Value = 'Total Flow';

            % Create BranchNumberTitle
            app.BranchNumberTitle = uilabel(app.FlowandPulseWaveVelocityTab);
            app.BranchNumberTitle.HorizontalAlignment = 'right';
            app.BranchNumberTitle.FontName = 'SansSerif';
            app.BranchNumberTitle.FontSize = 18;
            app.BranchNumberTitle.FontWeight = 'bold';
            app.BranchNumberTitle.Position = [537 696 209 22];
            app.BranchNumberTitle.Text = 'Set branches for vessel';

            % Create CheckcenterlinecalculateflowButton
            app.CheckcenterlinecalculateflowButton = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.CheckcenterlinecalculateflowButton.ButtonPushedFcn = createCallbackFcn(app, @CheckcenterlinecalculateflowButtonPushed, true);
            app.CheckcenterlinecalculateflowButton.FontName = 'SansSerif';
            app.CheckcenterlinecalculateflowButton.FontSize = 18;
            app.CheckcenterlinecalculateflowButton.Tooltip = {'for selected branches, calculate all flows'};
            app.CheckcenterlinecalculateflowButton.Position = [865 630 271 29];
            app.CheckcenterlinecalculateflowButton.Text = 'Check centerline, calculate flow';

            % Create PWVPointsTitle
            app.PWVPointsTitle = uilabel(app.FlowandPulseWaveVelocityTab);
            app.PWVPointsTitle.HorizontalAlignment = 'right';
            app.PWVPointsTitle.FontName = 'SansSerif';
            app.PWVPointsTitle.FontSize = 18;
            app.PWVPointsTitle.FontWeight = 'bold';
            app.PWVPointsTitle.Position = [866 556 264 22];
            app.PWVPointsTitle.Text = 'Set PWV measurement points';

            % Create PWVPointsLabel
            app.PWVPointsLabel = uilabel(app.FlowandPulseWaveVelocityTab);
            app.PWVPointsLabel.HorizontalAlignment = 'right';
            app.PWVPointsLabel.FontName = 'SansSerif';
            app.PWVPointsLabel.FontSize = 18;
            app.PWVPointsLabel.Position = [775 522 248 22];
            app.PWVPointsLabel.Text = 'PWV points: ';

            % Create PWVPoints
            app.PWVPoints = uieditfield(app.FlowandPulseWaveVelocityTab, 'text');
            app.PWVPoints.FontName = 'SansSerif';
            app.PWVPoints.FontSize = 16;
            app.PWVPoints.Tooltip = {'Centerline point labels used for PWV calculation. '};
            app.PWVPoints.Position = [1027 522 106 23];

            % Create PlotWaveformsButton
            app.PlotWaveformsButton = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.PlotWaveformsButton.ButtonPushedFcn = createCallbackFcn(app, @PlotWaveformsButtonPushed, true);
            app.PlotWaveformsButton.FontName = 'SansSerif';
            app.PlotWaveformsButton.FontSize = 18;
            app.PlotWaveformsButton.Tooltip = {'view waveforms for currently selected points'};
            app.PlotWaveformsButton.Position = [539 522 216 29];
            app.PlotWaveformsButton.Text = 'Examine flow waveforms';

            % Create CalculatePWV
            app.CalculatePWV = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.CalculatePWV.ButtonPushedFcn = createCallbackFcn(app, @CalculatePWVButtonPushed, true);
            app.CalculatePWV.FontSize = 18;
            app.CalculatePWV.Tooltip = {'(re-)calculate PWV for currently selected points'};
            app.CalculatePWV.Position = [690 216 137 29];
            app.CalculatePWV.Text = 'Calculate PWV';

            % Create PWVType
            app.PWVType = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.PWVType.Items = {'Cross-correlation', 'Wavelet', 'Maximum likelihood', 'Jarvis XCorr'};
            app.PWVType.FontName = 'ZapfDingbats';
            app.PWVType.FontSize = 14;
            app.PWVType.Position = [506 219 174 22];
            app.PWVType.Value = 'Wavelet';
            app.PWVType.ValueChangedFcn = createCallbackFcn(app, @PWVTypeValueChanged, true);

            % Create PWVDisplayTitle
            app.PWVDisplayTitle = uilabel(app.FlowandPulseWaveVelocityTab);
            app.PWVDisplayTitle.HorizontalAlignment = 'right';
            app.PWVDisplayTitle.FontName = 'SansSerif';
            app.PWVDisplayTitle.FontSize = 18;
            app.PWVDisplayTitle.FontWeight = 'bold';
            app.PWVDisplayTitle.Position = [952 212 192 22];
            app.PWVDisplayTitle.Text = 'Calculated PWV (m/s)';

            % Create PWVDisplay
            app.PWVDisplay = uieditfield(app.FlowandPulseWaveVelocityTab, 'text');
            app.PWVDisplay.Editable = 'off';
            app.PWVDisplay.HorizontalAlignment = 'center';
            app.PWVDisplay.FontName = 'ZapfDingbats';
            app.PWVDisplay.FontSize = 18;
            app.PWVDisplay.Tooltip = {''};
            app.PWVDisplay.Position = [1008 178 80 26];

            % Create SavingTitle
            app.SavingTitle = uilabel(app.FlowandPulseWaveVelocityTab);
            app.SavingTitle.HorizontalAlignment = 'right';
            app.SavingTitle.FontName = 'SansSerif';
            app.SavingTitle.FontSize = 18;
            app.SavingTitle.FontWeight = 'bold';
            app.SavingTitle.Position = [1008 97 65 22];
            app.SavingTitle.Text = 'Saving';

            % Create SaveResultsCallback
            app.SaveResultsCallback = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.SaveResultsCallback.ButtonPushedFcn = createCallbackFcn(app, @SaveResultsCallbackButtonPushed, true);
            app.SaveResultsCallback.FontName = 'SansSerif';
            app.SaveResultsCallback.FontSize = 18;
            app.SaveResultsCallback.Position = [991 25 100 29];
            app.SaveResultsCallback.Text = 'Save';

            % Create SaveName
            app.SaveName = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.SaveName.Items = {'Global PWV', 'Ascending Aorta', 'Descending Aorta', 'Left Carotid', 'Right Carotid'};
            app.SaveName.FontName = 'SansSerif';
            app.SaveName.FontSize = 10;
            app.SaveName.Position = [971 66 140 22];
            app.SaveName.Value = 'Global PWV';

            % Create FlipBranch1
            app.FlipBranch1 = uicheckbox(app.FlowandPulseWaveVelocityTab);
            app.FlipBranch1.Tooltip = {''};
            app.FlipBranch1.Text = 'Flip branch';
            app.FlipBranch1.FontName = 'SansSerif';
            app.FlipBranch1.FontSize = 14;
            app.FlipBranch1.Position = [685 664 91 22];

            % Create BranchDropDownLabel
            app.BranchDropDownLabel = uilabel(app.FlowandPulseWaveVelocityTab);
            app.BranchDropDownLabel.HorizontalAlignment = 'right';
            app.BranchDropDownLabel.FontName = 'SansSerif';
            app.BranchDropDownLabel.FontSize = 16;
            app.BranchDropDownLabel.Tooltip = {''};
            app.BranchDropDownLabel.Position = [537 664 70 22];
            app.BranchDropDownLabel.Text = 'Branch 1';

            % Create BranchDropDown
            app.BranchDropDown = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.BranchDropDown.Items = {'1'};
            app.BranchDropDown.Tooltip = {''};
            app.BranchDropDown.FontName = 'SansSerif';
            app.BranchDropDown.FontSize = 16;
            app.BranchDropDown.Position = [617 664 51 22];
            app.BranchDropDown.Value = '1';

            % Create deleteBranch2
            app.deleteBranch2 = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.deleteBranch2.ButtonPushedFcn = createCallbackFcn(app, @deleteBranch2ButtonPushed, true);
            app.deleteBranch2.VerticalAlignment = 'bottom';
            app.deleteBranch2.BackgroundColor = [1 1 1];
            app.deleteBranch2.FontName = 'ZapfDingbats';
            app.deleteBranch2.FontSize = 16;
            app.deleteBranch2.FontWeight = 'bold';
            app.deleteBranch2.FontColor = [1 0 0];
            app.deleteBranch2.Visible = 'off';
            app.deleteBranch2.Tooltip = {'remove this branch from list'};
            app.deleteBranch2.Position = [506 632 25 25];
            app.deleteBranch2.Text = 'X';

            % Create FlipBranch1_2
            app.FlipBranch1_2 = uicheckbox(app.FlowandPulseWaveVelocityTab);
            app.FlipBranch1_2.Visible = 'off';
            app.FlipBranch1_2.Tooltip = {''};
            app.FlipBranch1_2.Text = 'Flip branch';
            app.FlipBranch1_2.FontName = 'SansSerif';
            app.FlipBranch1_2.FontSize = 14;
            app.FlipBranch1_2.Position = [685 633 91 22];

            % Create Branch2Label
            app.Branch2Label = uilabel(app.FlowandPulseWaveVelocityTab);
            app.Branch2Label.HorizontalAlignment = 'right';
            app.Branch2Label.FontName = 'SansSerif';
            app.Branch2Label.FontSize = 16;
            app.Branch2Label.Visible = 'off';
            app.Branch2Label.Tooltip = {''};
            app.Branch2Label.Position = [537 633 70 22];
            app.Branch2Label.Text = 'Branch 2';

            % Create BranchDropDown_2
            app.BranchDropDown_2 = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.BranchDropDown_2.Items = {'1'};
            app.BranchDropDown_2.Visible = 'off';
            app.BranchDropDown_2.Tooltip = {''};
            app.BranchDropDown_2.FontName = 'SansSerif';
            app.BranchDropDown_2.FontSize = 16;
            app.BranchDropDown_2.Position = [617 633 51 22];
            app.BranchDropDown_2.Value = '1';

            % Create AddbranchButton
            app.AddbranchButton = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.AddbranchButton.ButtonPushedFcn = createCallbackFcn(app, @AddbranchButtonPushed, true);
            app.AddbranchButton.FontName = 'SansSerif';
            app.AddbranchButton.FontSize = 14;
            app.AddbranchButton.Tooltip = {'Push to concatenate multiple branches (up to 4)'};
            app.AddbranchButton.Position = [774 696 90 24];
            app.AddbranchButton.Text = 'Add branch';

            % Create deleteBranch3
            app.deleteBranch3 = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.deleteBranch3.ButtonPushedFcn = createCallbackFcn(app, @deleteBranch3ButtonPushed, true);
            app.deleteBranch3.VerticalAlignment = 'bottom';
            app.deleteBranch3.BackgroundColor = [1 1 1];
            app.deleteBranch3.FontName = 'ZapfDingbats';
            app.deleteBranch3.FontSize = 16;
            app.deleteBranch3.FontWeight = 'bold';
            app.deleteBranch3.FontColor = [1 0 0];
            app.deleteBranch3.Visible = 'off';
            app.deleteBranch3.Tooltip = {'remove this branch from list'};
            app.deleteBranch3.Position = [506 600 25 25];
            app.deleteBranch3.Text = 'X';

            % Create FlipBranch1_3
            app.FlipBranch1_3 = uicheckbox(app.FlowandPulseWaveVelocityTab);
            app.FlipBranch1_3.Visible = 'off';
            app.FlipBranch1_3.Tooltip = {''};
            app.FlipBranch1_3.Text = 'Flip branch';
            app.FlipBranch1_3.FontName = 'SansSerif';
            app.FlipBranch1_3.FontSize = 14;
            app.FlipBranch1_3.Position = [685 601 91 22];

            % Create Branch3Label
            app.Branch3Label = uilabel(app.FlowandPulseWaveVelocityTab);
            app.Branch3Label.HorizontalAlignment = 'right';
            app.Branch3Label.FontName = 'SansSerif';
            app.Branch3Label.FontSize = 16;
            app.Branch3Label.Visible = 'off';
            app.Branch3Label.Tooltip = {''};
            app.Branch3Label.Position = [537 601 70 22];
            app.Branch3Label.Text = 'Branch 3';

            % Create BranchDropDown_3
            app.BranchDropDown_3 = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.BranchDropDown_3.Items = {'1'};
            app.BranchDropDown_3.Visible = 'off';
            app.BranchDropDown_3.Tooltip = {''};
            app.BranchDropDown_3.FontName = 'SansSerif';
            app.BranchDropDown_3.FontSize = 16;
            app.BranchDropDown_3.Position = [617 601 51 22];
            app.BranchDropDown_3.Value = '1';

            % Create FlipBranch1_4
            app.FlipBranch1_4 = uicheckbox(app.FlowandPulseWaveVelocityTab);
            app.FlipBranch1_4.Visible = 'off';
            app.FlipBranch1_4.Tooltip = {''};
            app.FlipBranch1_4.Text = 'Flip branch';
            app.FlipBranch1_4.FontName = 'SansSerif';
            app.FlipBranch1_4.FontSize = 14;
            app.FlipBranch1_4.Position = [685 570 91 22];

            % Create Branch4Label
            app.Branch4Label = uilabel(app.FlowandPulseWaveVelocityTab);
            app.Branch4Label.HorizontalAlignment = 'right';
            app.Branch4Label.FontName = 'SansSerif';
            app.Branch4Label.FontSize = 16;
            app.Branch4Label.Visible = 'off';
            app.Branch4Label.Tooltip = {''};
            app.Branch4Label.Position = [537 570 70 22];
            app.Branch4Label.Text = 'Branch 4';

            % Create BranchDropDown_4
            app.BranchDropDown_4 = uidropdown(app.FlowandPulseWaveVelocityTab);
            app.BranchDropDown_4.Items = {'1'};
            app.BranchDropDown_4.Visible = 'off';
            app.BranchDropDown_4.Tooltip = {''};
            app.BranchDropDown_4.FontName = 'SansSerif';
            app.BranchDropDown_4.FontSize = 16;
            app.BranchDropDown_4.Position = [617 570 51 22];
            app.BranchDropDown_4.Value = '1';

            % Create deleteBranch4
            app.deleteBranch4 = uibutton(app.FlowandPulseWaveVelocityTab, 'push');
            app.deleteBranch4.ButtonPushedFcn = createCallbackFcn(app, @deleteBranch4ButtonPushed, true);
            app.deleteBranch4.VerticalAlignment = 'bottom';
            app.deleteBranch4.BackgroundColor = [1 1 1];
            app.deleteBranch4.FontName = 'ZapfDingbats';
            app.deleteBranch4.FontSize = 16;
            app.deleteBranch4.FontWeight = 'bold';
            app.deleteBranch4.FontColor = [1 0 0];
            app.deleteBranch4.Visible = 'off';
            app.deleteBranch4.Tooltip = {'remove this branch from list'};
            app.deleteBranch4.Position = [506 569 25 25];
            app.deleteBranch4.Text = 'X';

            % Create PWVDisplayTitle_2
            app.PWVDisplayTitle_2 = uilabel(app.FlowandPulseWaveVelocityTab);
            app.PWVDisplayTitle_2.HorizontalAlignment = 'center';
            app.PWVDisplayTitle_2.FontName = 'SansSerif';
            app.PWVDisplayTitle_2.FontSize = 14;
            app.PWVDisplayTitle_2.FontWeight = 'bold';
            app.PWVDisplayTitle_2.Position = [1022 152 53 22];
            app.PWVDisplayTitle_2.Text = ['R' char(178)];

            % Create R2Display
            app.R2Display = uieditfield(app.FlowandPulseWaveVelocityTab, 'text');
            app.R2Display.Editable = 'off';
            app.R2Display.HorizontalAlignment = 'center';
            app.R2Display.FontName = 'ZapfDingbats';
            app.R2Display.FontSize = 18;
            app.R2Display.Tooltip = {''};
            app.R2Display.Position = [1008 126 80 26];

            % Create findBestFit_checkbox
            app.findBestFit_checkbox = uicheckbox(app.FlowandPulseWaveVelocityTab);
            app.findBestFit_checkbox.Tooltip = {'If checked, multiple PWV are performed and the one with best R2 is reported to user. Only for Wavelet and Cross-correlation'};
            app.findBestFit_checkbox.Text = 'Find best fit';
            app.findBestFit_checkbox.FontSize = 14;
            app.findBestFit_checkbox.Position = [840 218 94 22];

            % Create ResetWorkSpace
            app.ResetWorkSpace = uitab(app.TabGroup);
            app.ResetWorkSpace.Title = 'Reset Workspace';

            % Create CleardataandrestartanalysisButton
            app.CleardataandrestartanalysisButton = uibutton(app.ResetWorkSpace, 'push');
            app.CleardataandrestartanalysisButton.ButtonPushedFcn = createCallbackFcn(app, @CleardataandrestartanalysisButtonPushed, true);
            app.CleardataandrestartanalysisButton.FontName = 'SansSerif';
            app.CleardataandrestartanalysisButton.Position = [101 550 178 22];
            app.CleardataandrestartanalysisButton.Text = 'Clear data and restart analysis';

            % Show the figure after all components are created
            app.FlowProcessingUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = FlowProcessing

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.FlowProcessingUIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.FlowProcessingUIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.FlowProcessingUIFigure)
        end
    end
end