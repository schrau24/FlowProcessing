classdef FlowProcessing < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        FlowProcessingUIFigure          matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        LoadingandPreprocessingTab      matlab.ui.container.Tab
        CorrectionsPanel                matlab.ui.container.Panel
        DFW                             matlab.ui.control.Button
        VelocityUnwrapping              matlab.ui.control.Button
        ProcessingPanel                 matlab.ui.container.Panel
        MapsPushButton                  matlab.ui.control.Button
        PulseWaveVelocityPushButton     matlab.ui.control.Button
        DVisualizationPanel             matlab.ui.container.Panel
        ManualsegmentationupdateButton  matlab.ui.control.Button
        mask10                          matlab.ui.control.CheckBox
        mask9                           matlab.ui.control.CheckBox
        mask8                           matlab.ui.control.CheckBox
        mask7                           matlab.ui.control.CheckBox
        mask6                           matlab.ui.control.CheckBox
        mask5                           matlab.ui.control.CheckBox
        mask4                           matlab.ui.control.CheckBox
        mask3                           matlab.ui.control.CheckBox
        mask2                           matlab.ui.control.CheckBox
        MaskLabel                       matlab.ui.control.Label
        mask1                           matlab.ui.control.CheckBox
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
        CropInfoTable                   matlab.ui.control.Table
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
        LoadDataButton                  matlab.ui.control.Button
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
        MapTime                         matlab.ui.control.DropDown
        ResetRotation_2                 matlab.ui.control.Button
        RotateUp_2                      matlab.ui.control.Button
        RotateDown_2                    matlab.ui.control.Button
        Rotate_2                        matlab.ui.control.Label
        RotateRight_2                   matlab.ui.control.Button
        RotateLeft_2                    matlab.ui.control.Button
        CalculateMap                    matlab.ui.control.Button
        VisOptions                      matlab.ui.control.Button
        SaveAnimation                   matlab.ui.control.Button
        SaveRotatedAnimation            matlab.ui.control.Button
        MapROIanalysis                  matlab.ui.control.Button
        MapVolumetricanalysis           matlab.ui.control.Button
        PeaksystoleEditField            matlab.ui.control.EditField
        PeaksystoleEditFieldLabel       matlab.ui.control.Label
        VisualizationGroup              matlab.ui.container.Panel
        VisTypeDropDown                 matlab.ui.control.DropDown
        VisOptionsDropDown              matlab.ui.control.DropDown
        SliceSpinner_2                  matlab.ui.control.Spinner
        SliceSpinner_2Label             matlab.ui.control.Label
        TimeframeSpinner                matlab.ui.control.Spinner
        TimeframeSpinnerLabel           matlab.ui.control.Label
        VisualizationPlot               matlab.ui.control.UIAxes
        MapGroup                        matlab.ui.container.Panel
        MapPlot                         matlab.ui.control.UIAxes
        FlowandPulseWaveVelocityTab     matlab.ui.container.Tab
        PlaneWidth                      matlab.ui.control.EditField
        PlanewidthmmLabel               matlab.ui.control.Label
        SplineSpacingSliderLabel        matlab.ui.control.Label
        SplineSpacingSlider             matlab.ui.control.Slider
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
        VisOptionsApp;              % the VisOptions app with associated params
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
        patchMask1;                 % segmentation 3D patch for 3D vis
        patchMask2;                 % segmentation 3D patch for 3D vis
        patchMask3;                 % segmentation 3D patch for 3D vis
        patchMask4;                 % segmentation 3D patch for 3D vis
        patchMask5;                 % segmentation 3D patch for 3D vis
        patchMask6;                 % segmentation 3D patch for 3D vis
        patchMask7;                 % segmentation 3D patch for 3D vis
        patchMask8;                 % segmentation 3D patch for 3D vis
        patchMask9;                 % segmentation 3D patch for 3D vis
        patchMask10;                % segmentation 3D patch for 3D vis

        rotAngles;                  % rotation angles used for viewing, can be changed by viewer

        usedBranches;               % a list that is built up to determine which branches to perform flow measurements on
        FullBranchDistance;         % the full distance vector (in mm)

        R2;                         % the r-squared value of the fit for cross-correlation or wavelet PWV measurement
        time_peak;                  % the determined peak systolic phase
        WSS_matrix;                 % calculated WSS matrix
        F_matrix;                   % faces for 3D vis
        V_matrix;                   % vertices for 3D vis
        rotAngles2;                 % rotation angles used for viewing maps, can be changed by viewer
        isWSScalculated = 0;        % is WSS calculated
    end

    methods (Access = public)

        function View3DSegmentation(app)

            cla(app.View3D);

            c = prism(size(app.aorta_seg,4));
            if (app.isSegmentationLoaded)
                if app.mask1.Value
                    aa = smooth3(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value));
                    hold(app.View3D,'on')
                    app.patchMask1 = patch(app.View3D, isosurface(aa,.5),'FaceColor',c(1,:),'EdgeColor', 'none','FaceAlpha',0.5);
                    reducepatch(app.patchMask1,0.6);
                end
                if ~app.isTimeResolvedSeg
                    for ii = 2:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            aa = smooth3(app.aorta_seg(:,:,:,ii));
                            hold(app.View3D,'on')
                            eval(sprintf('app.patchMask%i=patch(app.View3D,isosurface(aa,.5),''FaceColor'',c(ii,:),''EdgeColor'',''none'',''FaceAlpha'',0.5);',ii));
                            eval(sprintf('reducepatch(app.patchMask%i,0.6);,',ii));
                        end
                    end
                end
            else
                ss = smooth3(app.segment);
                app.hpatch1 = patch(app.View3D, isosurface(ss,.5),'FaceColor','red','EdgeColor', 'none','FaceAlpha',0.35);
                reducepatch(app.hpatch1 ,0.6);
            end
            hold(app.View3D,'off')

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
            if sum(abs(app.rotAngles)) > 0
                if (app.isSegmentationLoaded)
                    rotate(app.patchMask1,[1 0 0], app.rotAngles(1))
                    rotate(app.patchMask1,[0 1 0], app.rotAngles(2))
                else
                    rotate(app.hpatch1,[1 0 0], app.rotAngles(1))
                    rotate(app.hpatch1,[0 1 0], app.rotAngles(2))
                end
            end
        end

        function reset3DSegmentationAndCenterline(app)
            % Initialize figure
            colorbar(app.View3D_2,'off')
            cla(app.View3D_2);

            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value);
            else
                currSeg = zeros(size(app.aorta_seg,1:3));
                % only use segmentations that were selected in first tab
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                    end
                end
                if ~app.isSegmentationLoaded
                    currSeg = app.segment;
                end
            end
            currSeg = smooth3(currSeg);

            hpatch = patch(app.View3D_2,isosurface(currSeg,0.5),'FaceAlpha',0.20);
            reducepatch(hpatch,0.6);
            set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');

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
                currSeg = app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value);
            else
                currSeg = zeros(size(app.aorta_seg,1:3));
                % only use segmentations that were selected in first tab
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                    end
                end
                if ~app.isSegmentationLoaded
                    currSeg = app.segment;
                end
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
                case 'total flow'
                    cdata = app.flowPerHeartCycle_vol(index);
                    axisText = 'flow (mL/cycle)';
                case 'peak flow'
                    cdata = max(app.flowPulsatile_vol(index,:),[],2);
                    axisText = 'peak flow (mL/s)';
                case 'mean velocity'
                    cdata = mean(app.flowPulsatile_vol(index,:)./app.area_val,2);
                    axisText = 'mean velocity (cm/s)';
                case 'peak velocity'
                    cdata = max(app.flowPulsatile_vol(index,:)./app.area_val,[],2);
                    axisText = 'peak velocity (cm/s)';
            end

            hSurface = surface(app.View3D_2,'XData',[y(:) y(:)],'YData',[x(:) x(:)],'ZData',[z(:) z(:)],...
                'CData',[cdata(:) cdata(:)],'FaceColor','none','EdgeColor','flat',...
                'Marker','.','MarkerSize',12);

            caxis(app.View3D_2,[min(cdata) max(cdata)]);
            colormap(app.View3D_2,jet)
            cbar = colorbar(app.View3D_2);
            set(get(cbar,'xlabel'),'string',axisText,'fontsize',16,'Color','black');
            set(cbar,'FontSize',14,'color','black','Location','west');
            pos = get(cbar,'position');
            pos = [0.01 0.01 pos(3) 0.33];
            set(cbar,'position',pos);

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
            fontSz = 14;round(length(textint2)/2);
            for C = 1:length(textint2)
                Ntxt(C) = text(app.View3D_2,app.branchActual(textint2(C),2)-2,app.branchActual(textint2(C),1),app.branchActual(textint2(C),3),numString_val{C},...
                    'Color','k','HorizontalAlignment','right',...
                    'FontSize',fontSz,'FontWeight','Bold','HitTest','off','PickableParts','none');
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

            if contains(app.ParameterDropDown.Value,'flow')
                plotString = 'flow (mL/s)';
            else
                waveforms = waveforms./app.area_val;
                plotString = 'Velocity (cm/s)';
            end
            view3D_wParams(app);

            str = app.PWVPoints.Value;

            ptRange = [];
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
                c = prism(size(app.aorta_seg,4));
                ct = 0;
                if app.isSegmentationLoaded
                    if app.isTimeResolvedSeg
                        ct = ct+1;
                        hold(gca,'on');
                        h = imagesc(cat(3,c(1,1)*ones(size(img)),c(1,2)*ones(size(img)),c(1,3)*ones(size(img))));
                        set(h,'AlphaData',img2(:,:,ct))
                        hold(gca,'off');
                    else
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                ct = ct+1;
                                hold(gca,'on');
                                h = imagesc(cat(3,c(ii,1)*ones(size(img)),c(ii,2)*ones(size(img)),c(ii,3)*ones(size(img))));
                                set(h,'AlphaData',img2(:,:,ct))
                                hold(gca,'off');
                            end
                        end
                    end
                end
                axis equal off
                daspect([1 1 1]);

                h = drawrectangle(gca,'DrawingArea',[1 1 size(img,2)-1 size(img,1)-1]);
                maskSz = h.Position;
                maskSz(1:2) = floor(maskSz(1:2));
                maskSz(3:4) = ceil(maskSz(3:4));
                maskSz(maskSz<1) = 1;
                tmp_mask = zeros(size(img));
                tmp_mask(maskSz(2):(maskSz(2)+maskSz(4)), maskSz(1):(maskSz(1)+maskSz(3))) = 1;
                imgCropped = img.*tmp_mask;

                clf(cropFig);
                imagesc(imgCropped);
                colormap('gray')
                ct = 0;
                if app.isSegmentationLoaded
                    if app.isTimeResolvedSeg
                        ct = ct+1;
                        hold(gca,'on');
                        h = imagesc(cat(3,c(1,1)*ones(size(img)),c(1,2)*ones(size(img)),c(1,3)*ones(size(img))));
                        set(h,'AlphaData',img2(:,:,ct))
                        hold(gca,'off');
                    else
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                ct = ct+1;
                                hold(gca,'on');
                                h = imagesc(cat(3,c(ii,1)*ones(size(img)),c(ii,2)*ones(size(img)),c(ii,3)*ones(size(img))));
                                set(h,'AlphaData',img2(:,:,ct).*tmp_mask)
                                hold(gca,'off');
                            end
                        end
                    end
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

        function app = cropRawData(app)
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
        end

        function updateMIPs(app)

            % colormap for multimask
            c = prism(size(app.aorta_seg,4));

            % Set mips
            cla(app.AxesX);
            imSize = size(max(app.angio,[],1)); imSize = imSize(2:3);
            imagesc(app.AxesX,reshape(max(app.angio,[],1),imSize));
            if app.isSegmentationLoaded
                if ~app.isTimeResolvedSeg
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            hold(app.AxesX,'on');
                            img2 = reshape(max(app.aorta_seg(:,:,:,ii),[],1),imSize);
                            h = imagesc(app.AxesX,cat(3, c(ii,1)*ones(imSize), c(ii,2)*ones(imSize), c(ii,3)*ones(imSize)));
                            set(h,'AlphaData',0.15*img2)
                            hold(app.AxesX,'off');
                        end
                    end
                else
                    hold(app.AxesX,'on');
                    img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],1),imSize);
                    h = imagesc(app.AxesX,cat(3, c(1,1)*ones(imSize), c(1,2)*ones(imSize), c(1,3)*ones(imSize)));
                    set(h,'AlphaData',0.25*img2)
                    hold(app.AxesX,'off');
                end
            end
            set(app.AxesX,'XTickLabel','','YTickLabel','')
            colormap(app.AxesX,'gray')
            axis(app.AxesX,'equal')
            daspect(app.AxesX,[1 1 1]);

            cla(app.AxesY);
            imSize = size(max(app.angio,[],2)); imSize = imSize([1,3]);
            imagesc(app.AxesY,reshape(max(app.angio,[],2),imSize));
            if app.isSegmentationLoaded
                if ~app.isTimeResolvedSeg
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            hold(app.AxesY,'on');
                            img2 = reshape(max(app.aorta_seg(:,:,:,ii),[],2),imSize);
                            h = imagesc(app.AxesY,cat(3, c(ii,1)*ones(imSize), c(ii,2)*ones(imSize), c(ii,3)*ones(imSize)));
                            set(h,'AlphaData',0.15*img2)
                            hold(app.AxesY,'off');
                        end
                    end
                else
                    hold(app.AxesY,'on');
                    img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],2),imSize);
                    h = imagesc(app.AxesY,cat(3, c(1,1)*ones(imSize), c(1,2)*ones(imSize), c(1,3)*ones(imSize)));
                    set(h,'AlphaData',0.25*img2)
                    hold(app.AxesY,'off');
                end
            end
            set(app.AxesY,'XTickLabel','','YTickLabel','')
            colormap(app.AxesY,'gray')
            axis(app.AxesY,'equal')
            daspect(app.AxesY,[1 1 1]);

            cla(app.AxesZ);
            imSize = size(max(app.angio,[],3)); imSize = imSize([1,2]);
            imagesc(app.AxesZ,reshape(max(app.angio,[],3),imSize));
            if app.isSegmentationLoaded
                if ~app.isTimeResolvedSeg
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            hold(app.AxesZ,'on');
                            img2 = reshape(max(app.aorta_seg(:,:,:,ii),[],3),imSize);
                            h = imagesc(app.AxesZ,cat(3, c(ii,1)*ones(imSize), c(ii,2)*ones(imSize), c(ii,3)*ones(imSize)));
                            set(h,'AlphaData',0.25*img2)
                            hold(app.AxesZ,'off');
                        end
                    end
                else
                    hold(app.AxesZ,'on');
                    img2 = reshape(max(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value),[],3),imSize);
                    h = imagesc(app.AxesZ,cat(3, c(1,1)*ones(imSize), c(1,2)*ones(imSize), c(1,3)*ones(imSize)));
                    set(h,'AlphaData',0.25*img2)
                    hold(app.AxesZ,'off');
                end
            end
            set(app.AxesZ,'XTickLabel','','YTickLabel','')
            colormap(app.AxesZ,'gray')
            axis(app.AxesZ,'equal')
            daspect(app.AxesZ,[1 1 1]);
        end

        function updateVisualization(app)
            cla(app.VisualizationPlot);
            colorbar(app.VisualizationPlot,'off');
            value = app.VisTypeDropDown.Value;
            switch value
                case 'Vectors'
                    viewVelocityVectors(app);
                case 'Streamlines'
                    viewStreamlines(app);
            end
        end

        function viewVelocityVectors(app)

            t = app.TimeframeSpinner.Value;
            if t == 0   % to prevent errors when coming from other tabs
                t = 1;
            end

            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    currSeg = app.aorta_seg(:,:,:,t);
                else
                    currSeg = zeros(size(app.aorta_seg,1:3));
                    % only use segmentations that were selected in first tab
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                        end
                    end
                end
            else
                currSeg = app.segment;
            end
            currV = app.v(:,:,:,:,t);

            subsample = round(app.VisOptionsApp.SubsampleSlider.Value);
            switch app.VisOptionsDropDown.Value  % the current vector vis state
                case 'slice-wise'   % slicewise vectors
                    if contains(app.ori.label,'axial') || contains(app.ori.label,'coronal')

                        % do the rotation
                        tmp = imrotate3(currSeg,app.rotAngles2(2),[0 -1 0],'nearest');
                        tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                        currSeg = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                        for f = 1:3
                            tmp = imrotate3(currV(:,:,:,f),app.rotAngles2(2),[0 -1 0],'nearest');
                            tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                            currV_tmp(:,:,:,f) = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                        end
                        currV = currV_tmp; clear currV_tmp;

                        % grab current slice
                        sl = app.SliceSpinner_2.Value;
                        if app.SliceSpinner_2.Limits(2) ~= size(currV,3)
                            app.SliceSpinner_2.Limits = [1 size(currV,3)];
                        end
                        if sl > size(currV,3)
                            sl = round(size(currV,3)/2);
                        end
                        L = find(currSeg(1:subsample:end,1:subsample:end,sl));
                        vx = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,1)/10;
                        vy = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,2)/10;
                        vz = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,3)/10;
                        [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(1),(1:subsample:size(currSeg,1))*app.pixdim(2), ...
                            -5);   % cheat here and put the vel vectors at a negative location to overlay better

                        tmp = imrotate3(app.MAG(:,:,:,t),app.rotAngles2(2),[0 -1 0],'nearest');
                        tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                        currMAG = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                        img = repmat(currMAG(:,:,sl),[1 1 3]);
                    else % sagittal scan
                        if isequal(app.rotAngles2,[0,0]) % no additional rotation
                            % grab current slice
                            sl = app.SliceSpinner_2.Value;
                            if app.SliceSpinner_2.Limits(2) ~= size(currV,3)
                                app.SliceSpinner_2.Limits = [1 size(currV,3)];
                            end
                            if sl > size(currV,3)
                                sl = round(size(currV,3)/2);
                            end
                            currSeg = squeeze(currSeg(:,:,sl));
                            currV_1 = squeeze(currV(:,:,sl,1));
                            currV_2 = squeeze(currV(:,:,sl,2));
                            currV_3 = squeeze(currV(:,:,sl,3));
                            L = find(currSeg(1:subsample:end,1:subsample:end));
                            vx = -currSeg(1:subsample:end,1:subsample:end).*currV_1(1:subsample:end,1:subsample:end)/10;
                            vy = -currSeg(1:subsample:end,1:subsample:end).*currV_2(1:subsample:end,1:subsample:end)/10;
                            vz = -currSeg(1:subsample:end,1:subsample:end).*currV_3(1:subsample:end,1:subsample:end)/10;
                            [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(1),(1:subsample:size(currSeg,1))*app.pixdim(2), ...
                                -5);   % cheat here and put the vel vectors at a negative location to overlay better
                            if ~isequal(app.pixdim(1),app.pixdim(2))
                                fprintf('WARNING: in-plane voxel sizes are not equal. This might lead to incorrect aspect ratios. Please contact Eric Schrauben/Bobby Runderkamp. \n') % Because I am a bit uncertain about how app.pixdim is used in meshgrid (Bobby, October 2024). If the in-plane sizes are equal, however, it should be fine regardless.
                            end
                            currMAG = app.MAG(:,:,:,t);
                            img = repmat(currMAG(:,:,sl),[1 1 3]);
                            imagesc(app.VisualizationPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                            hold(app.VisualizationPlot,'on');
                            clear currV_1 currV_2 currV_3
                        elseif isequal(app.rotAngles2,[90,0]) % rotate into axial view
                            % grab current slice
                            sl = app.SliceSpinner_2.Value;
                            if app.SliceSpinner_2.Limits(2) ~= size(currV,1)
                                app.SliceSpinner_2.Limits = [1 size(currV,1)];
                            end
                            if sl > size(currV,1)
                                sl = round(size(currV,1)/2);
                            end
                            currSeg = rot90(squeeze(currSeg(sl,:,:)));
                            currV_1 = rot90(squeeze(currV(sl,:,:,1)));
                            currV_2 = rot90(squeeze(currV(sl,:,:,2)));
                            currV_3 = rot90(squeeze(currV(sl,:,:,3)));
                            L = find(currSeg(1:subsample:end,1:subsample:end));
                            vx = -currSeg(1:subsample:end,1:subsample:end).*currV_1(1:subsample:end,1:subsample:end)/10;
                            vy = -currSeg(1:subsample:end,1:subsample:end).*currV_2(1:subsample:end,1:subsample:end)/10;
                            vz = -currSeg(1:subsample:end,1:subsample:end).*currV_3(1:subsample:end,1:subsample:end)/10;
                            [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(1),(1:subsample:size(currSeg,1))*app.pixdim(3), ...
                                -5);   % cheat here and put the vel vectors at a negative location to overlay better
                            if ~isequal(app.pixdim(1),app.pixdim(2))
                                fprintf('WARNING: in-plane voxel sizes are not equal. This might lead to incorrect aspect ratios. Please contact Eric Schrauben/Bobby Runderkamp. \n') % Because I am a bit uncertain about how app.pixdim is used in meshgrid (Bobby, October 2024). If the in-plane sizes are equal, however, it should be fine regardless.
                            end
                            currMAG = app.MAG(:,:,:,t);
                            img = repmat(rot90(squeeze(currMAG(sl,:,:))),[1 1 3]);
                            imagesc(app.VisualizationPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                            hold(app.VisualizationPlot,'on');
                            clear currV_1 currV_2 currV_3
                        elseif isequal(app.rotAngles2,[0,90]) % rotate into coronal view
                            % grab current slice
                            sl = app.SliceSpinner_2.Value;
                            if app.SliceSpinner_2.Limits(2) ~= size(currV,2)
                                app.SliceSpinner_2.Limits = [1 size(currV,2)];
                            end
                            if sl > size(currV,2)
                                sl = round(size(currV,2)/2);
                            end
                            currSeg = squeeze(currSeg(:,end-sl+1,:));
                            currV_1 = squeeze(currV(:,end-sl+1,:,1));
                            currV_2 = squeeze(currV(:,end-sl+1,:,2));
                            currV_3 = squeeze(currV(:,end-sl+1,:,3));
                            L = find(currSeg(1:subsample:end,1:subsample:end));
                            vx = -currSeg(1:subsample:end,1:subsample:end).*currV_1(1:subsample:end,1:subsample:end)/10;
                            vy = -currSeg(1:subsample:end,1:subsample:end).*currV_2(1:subsample:end,1:subsample:end)/10;
                            vz = -currSeg(1:subsample:end,1:subsample:end).*currV_3(1:subsample:end,1:subsample:end)/10;
                            [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(3),(1:subsample:size(currSeg,1))*app.pixdim(2), ...
                                -5);   % cheat here and put the vel vectors at a negative location to overlay better
                            if ~isequal(app.pixdim(1),app.pixdim(2))
                                fprintf('WARNING: in-plane voxel sizes are not equal. This might lead to incorrect aspect ratios. Please contact Eric Schrauben/Bobby Runderkamp. \n') % Because I am a bit uncertain about how app.pixdim is used in meshgrid (Bobby, October 2024). If the in-plane sizes are equal, however, it should be fine regardless.
                            end
                            currMAG = app.MAG(:,:,:,t);
                            img = repmat(squeeze(currMAG(:,end-sl+1,:)),[1 1 3]);
                            imagesc(app.VisualizationPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                            hold(app.VisualizationPlot,'on');
                            clear currV_1 currV_2 currV_3
                        else
                            tmp = imrotate3(currSeg,app.rotAngles2(2),[0 -1 0],'nearest');
                            tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                            currSeg = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                            for f = 1:3
                                tmp = imrotate3(currV(:,:,:,f),app.rotAngles2(2),[0 -1 0],'nearest');
                                tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                                currV_tmp(:,:,:,f) = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                            end
                            currV = currV_tmp; clear currV_tmp;

                            % grab current slice
                            sl = app.SliceSpinner_2.Value;
                            if app.SliceSpinner_2.Limits(2) ~= size(currV,3)
                                app.SliceSpinner_2.Limits = [1 size(currV,3)];
                            end
                            if sl > size(currV,3)
                                sl = round(size(currV,3)/2);
                            end
                            L = find(currSeg(1:subsample:end,1:subsample:end,sl));
                            vx = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,1)/10;
                            vy = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,2)/10;
                            vz = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,3)/10;
                            [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(1),(1:subsample:size(currSeg,1))*app.pixdim(2), ...
                                -5);   % cheat here and put the vel vectors at a negative location to overlay better
                            if ~isequal(app.pixdim(1),app.pixdim(2))
                                fprintf('WARNING: in-plane voxel sizes are not equal. This might lead to incorrect aspect ratios. Please contact Eric Schrauben/Bobby Runderkamp. \n') % Because I am a bit uncertain about how app.pixdim is used in meshgrid (Bobby, October 2024). If the in-plane sizes are equal, however, it should be fine regardless.
                            end
                            tmp = imrotate3(app.MAG(:,:,:,t),app.rotAngles2(2),[0 -1 0],'nearest');
                            tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                            currMAG = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                            img = repmat(currMAG(:,:,sl),[1 1 3]);
                            imagesc(app.VisualizationPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                            hold(app.VisualizationPlot,'on');
                        end
                    end

                    imagesc(app.VisualizationPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],img,[0.05 0.7]);
                    hold(app.VisualizationPlot,'on');

                case 'centerline contours' % contours from centerline
                    str = app.VisOptionsApp.VisPts.Value;
                    eval(['ptRange=[' str '];']);

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
                        currL = currL(1:subsample:end);
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

                    if app.VisOptionsApp.view_3Dpatch_checkbox.Value
                        % we need a 3D patch for this setting
                        if app.isSegmentationLoaded
                            hpatch = patch(app.VisualizationPlot,isosurface(smooth3(currSeg)),'FaceAlpha',0.10);
                        else
                            hpatch = patch(app.VisualizationPlot,isosurface(smooth3(app.segment)),'FaceAlpha',0.10);
                        end
                        reducepatch(hpatch,0.6);
                        set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
                        camlight(app.VisualizationPlot);
                        lighting(app.VisualizationPlot,'gouraud');
                        lightangle(app.VisualizationPlot,0,0);
                    end

                case 'segmentation'   % 3d vectors from the whole segmentation
                    overLaySeg = currSeg;
                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(overLaySeg,2))*app.pixdim(1),(1:subsample:size(overLaySeg,1))*app.pixdim(2), ...
                        (1:subsample:size(overLaySeg,3))*app.pixdim(3));
                    vx = -overLaySeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,1)/10;
                    vy = -overLaySeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,2)/10;
                    vz = -overLaySeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,3)/10;
                    L = find(overLaySeg(1:subsample:end,1:subsample:end,1:subsample:end));
                    if app.VisOptionsApp.view_3Dpatch_checkbox.Value
                        [xx,yy,zz] = meshgrid((1:size(overLaySeg,2))*app.pixdim(1),(1:size(overLaySeg,1))*app.pixdim(2), ...
                            (1:size(overLaySeg,3))*app.pixdim(3));
                        % we need a 3D patch for this setting
                        hpatch = patch(app.VisualizationPlot,isosurface(xx,yy,zz,smooth3(overLaySeg)),'FaceAlpha',0.10);
                        reducepatch(hpatch,0.6);
                        set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
                        camlight(app.VisualizationPlot);
                        lighting(app.VisualizationPlot,'gouraud');
                        lightangle(app.VisualizationPlot,0,0);
                    end
            end
            vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);

            if ~isvalid(app.VisOptionsApp)
                a = [2 10*max(vmagn(:))/100];
                scale = [0 round(app.VENC/10)];
                backgroundC = [1 1 1];
                axisText = [0 0 0];
                cmap = 'jet';
                cbarLoc = 'bottom-left';
            else
                a = [str2double(app.VisOptionsApp.minQuiverEditField.Value) str2double(app.VisOptionsApp.maxQuiverEditField.Value)*max(vmagn(:))/100];
                scale = [str2double(app.VisOptionsApp.minVelocityVisEditField.Value) str2double(app.VisOptionsApp.maxVelocityVisEditField.Value)];
                backgroundC = [1 1 1];
                if strcmp(app.VisOptionsApp.backgroundDropDown.Value,'black')
                    backgroundC = [0 0 0];
                end
                axisText = [0 0 0];
                if strcmp(app.VisOptionsApp.TextcolorDropDown.Value,'white')
                    axisText = [1 1 1];
                end
                cmap = app.VisOptionsApp.ColormapDropDown.Value;
                cbarLoc = app.VisOptionsApp.LocationDropDown.Value;
            end

            c = [];
            % note the flipped vx and vy here
            [F,V,C]=quiver3Dpatch(xcoor_grid(L),ycoor_grid(L),zcoor_grid(L),-vy(L),-vx(L),-vz(L),c,a);
            p = patch(app.VisualizationPlot,'Faces',F,'Vertices',V,'CData',C,'FaceColor','flat','EdgeColor','none','FaceAlpha',0.75);
            caxis(app.VisualizationPlot, scale);
            colormap(app.VisualizationPlot,cmap);
            cbar = colorbar(app.VisualizationPlot);
            app.VisualizationGroup.BackgroundColor = backgroundC;
            app.VisualizationGroup.ForegroundColor = axisText;
            app.TimeframeSpinnerLabel.FontColor = axisText;
            app.SliceSpinner_2Label.FontColor = axisText;
            set(get(cbar,'xlabel'),'string','velocity (cm/s)','Color',axisText);
            set(cbar,'FontSize',13,'color',axisText,'Location','west');
            pos = get(cbar,'position');
            switch cbarLoc
                case 'bottom-left'
                    pos = [0.01 0.02 pos(3) 0.2];
                case 'mid-left'
                    pos = [0.01 0.41 pos(3) 0.2];
                case 'upper-left'
                    pos = [0.01 0.75 pos(3) 0.2];
                case 'bottom-right'
                    pos = [0.99-pos(3) 0.02 pos(3) 0.2];
                case 'mid-right'
                    pos = [0.99-pos(3) 0.41 pos(3) 0.2];
                case 'upper-right'
                    pos = [0.99-pos(3) 0.75 pos(3) 0.2];
            end
            set(cbar,'position',pos);

            % make it look good
            axis(app.VisualizationPlot, 'off','tight')
            view(app.VisualizationPlot,[0 0 1]);
            daspect(app.VisualizationPlot,[1 1 1])

            if ~contains(app.VisOptionsDropDown.Value,'slice-wise')
                % update view angle
                camorbit(app.VisualizationPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
                camroll(app.VisualizationPlot,app.rotAngles2(3));
            end
            hold(app.VisualizationPlot,'off');
        end

        function viewStreamlines(app)

            t = app.TimeframeSpinner.Value;
            if t == 0   % to prevent errors when coming from other tabs
                t = 1;
            end

            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    currSeg = app.aorta_seg(:,:,:,t);
                else
                    currSeg = zeros(size(app.aorta_seg,1:3));
                    % only use segmentations that were selected in first tab
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                        end
                    end
                end
            else
                currSeg = double(app.segment);
            end
            currV = app.v(:,:,:,:,t);

            subsample = round(app.VisOptionsApp.SubsampleSlider.Value);
            vx = -currSeg.*currV(:,:,:,1)/10;
            vy = -currSeg.*currV(:,:,:,2)/10;
            vz = -currSeg.*currV(:,:,:,3)/10;
            vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);
            [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:size(currSeg,2))*app.pixdim(1),(1:size(currSeg,1))*app.pixdim(2), ...
                (1:size(currSeg,3))*app.pixdim(3));

            % determine start positions of streamlines
            switch app.VisOptionsDropDown.Value  % the current vector vis state, slice-wise not allowed
                case 'centerline contours'
                    % set the subsampling to reduce number of streamlines
                    substreams = subsample;
                    str = app.VisOptionsApp.VisPts.Value;
                    eval(['ptRange=[' str '];']);

                    % get oblique slices
                    startX = []; startY = []; startZ = [];
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
                        currL = currL(1:substreams:end);
                        % the start points in true image coordinates
                        startX = cat(1,startX,x(currL)*app.pixdim(1));
                        startY = cat(1,startY,y(currL)*app.pixdim(2));
                        startZ = cat(1,startZ,z(currL)*app.pixdim(3));

                    end

                case 'segmentation'   % 3d streamlines from the whole segmentation
                    % set the subsampling to reduce number of streamlines,
                    % this is ~5x larger than subsample for computational
                    % reason
                    substreams = round(5*subsample);
                    L = find(currSeg);
                    startX = xcoor_grid(L(1:substreams:end));
                    startY = ycoor_grid(L(1:substreams:end));
                    startZ = zcoor_grid(L(1:substreams:end));
            end

            % make streamlines, then color according to vmag
            h = streamline(app.VisualizationPlot,stream3(xcoor_grid,ycoor_grid,zcoor_grid,-vy,-vx,-vz,...
                startX,startY,startZ));

            minVel = str2double(app.VisOptionsApp.minQuiverEditField.Value);     % minimum velocity for streamline to be plotted, in cm/s
            for ii = 1:length(h)
                h(ii).Visible = 'off';
                XX = h(ii).XData';
                YY = h(ii).YData';
                ZZ = h(ii).ZData';
                if length(XX) > 1
                    c = interp3(xcoor_grid,ycoor_grid,zcoor_grid,vmagn,XX,YY,ZZ);
                    % find c > min velocity, only plot those
                    c(c < minVel) = nan;
                    p = patchline(app.VisualizationPlot,XX,YY,ZZ,'CData',cat(1,c,nan),'EdgeColor','flat',...
                        'linewidth',1.25,'EdgeAlpha',0.90);
                end
            end
            clear h;

            if ~isvalid(app.VisOptionsApp)
                scale = [0 round(app.VENC/10)];
                backgroundC = [1 1 1];
                axisText = [0 0 0];
                cmap = 'jet';
                cbarLoc = 'bottom-left';
            else
                scale = [str2double(app.VisOptionsApp.minVelocityVisEditField.Value) str2double(app.VisOptionsApp.maxVelocityVisEditField.Value)];
                backgroundC = [1 1 1];
                if strcmp(app.VisOptionsApp.backgroundDropDown.Value,'black')
                    backgroundC = [0 0 0];
                end
                axisText = [0 0 0];
                if strcmp(app.VisOptionsApp.TextcolorDropDown.Value,'white')
                    axisText = [1 1 1];
                end
                cmap = app.VisOptionsApp.ColormapDropDown.Value;
                cbarLoc = app.VisOptionsApp.LocationDropDown.Value;
            end

            caxis(app.VisualizationPlot, scale);
            colormap(app.VisualizationPlot,cmap);
            cbar = colorbar(app.VisualizationPlot);
            app.VisualizationGroup.BackgroundColor = backgroundC;
            app.VisualizationGroup.ForegroundColor = axisText;
            set(get(cbar,'xlabel'),'string','velocity (cm/s)','Color',axisText);
            set(cbar,'FontSize',13,'color',axisText,'Location','west');
            pos = get(cbar,'position');
            switch cbarLoc
                case 'bottom-left'
                    pos = [0.01 0.02 pos(3) 0.2];
                case 'mid-left'
                    pos = [0.01 0.41 pos(3) 0.2];
                case 'upper-left'
                    pos = [0.01 0.75 pos(3) 0.2];
                case 'bottom-right'
                    pos = [0.99-pos(3) 0.02 pos(3) 0.2];
                case 'mid-right'
                    pos = [0.99-pos(3) 0.41 pos(3) 0.2];
                case 'upper-right'
                    pos = [0.99-pos(3) 0.75 pos(3) 0.2];
            end
            set(cbar,'position',pos);

            % make it look good
            axis(app.VisualizationPlot, 'off','tight')
            view(app.VisualizationPlot,[0 0 1]);
            daspect(app.VisualizationPlot,[1 1 1])

            % we need a 3D patch for this setting
            hpatch = patch(app.VisualizationPlot,isosurface(xcoor_grid,ycoor_grid,zcoor_grid,smooth3(currSeg)),'FaceAlpha',0.10);

            reducepatch(hpatch,0.6);
            set(hpatch,'FaceColor',[0.7 0.7 0.7],'EdgeColor', 'none','PickableParts','none');
            camlight(app.VisualizationPlot);
            lighting(app.VisualizationPlot,'gouraud');
            lightangle(app.VisualizationPlot,0,0);

            camorbit(app.VisualizationPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
            hold(app.VisualizationPlot,'off');
        end

        function [outImg, outVol, idx_currSeg] = viewMap(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            if ~contains(app.MapType.Value,'None')
                isWSS = 0;
                t = app.TimeframeSpinner.Value;
                if app.isTimeResolvedSeg
                    currSeg = app.aorta_seg(:,:,:,t);
                else
                    currSeg = zeros(size(app.aorta_seg,1:3));
                    % only use segmentations that were selected in first tab
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                        end
                    end
                    if ~app.isSegmentationLoaded
                        currSeg = app.segment;
                    end
                end

                tmp = imrotate3(currSeg,app.rotAngles2(2),[0 -1 0],'nearest');
                tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                currSeg = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');

                % grab current velocity
                if contains(app.MapTime.Value,'resolved')
                    currV = app.v(:,:,:,:,t)/10;
                else
                    currV = app.v/10;
                end
                for tt = 1:size(currV,5)
                    for f = 1:3
                        tmp = imrotate3(currV(:,:,:,f,tt),app.rotAngles2(2),[0 -1 0],'nearest');
                        tmp = imrotate3(tmp,app.rotAngles2(1),[-1 0 0],'nearest');
                        currV_tmp(:,:,:,f,tt) = imrotate3(tmp,app.rotAngles2(3),[0 0 1],'nearest');
                    end
                end
                currV = currV_tmp; clear currV_tmp;

                vx = currSeg.*currV(:,:,:,1,:);
                vy = currSeg.*currV(:,:,:,2,:);
                vz = currSeg.*currV(:,:,:,3,:);

                % do erosion if mask_erosion_checkbox checked
                if app.VisOptionsApp.mask_erosion_checkbox.Value
                    currSeg = mask_erosion(currSeg,0);
                end

                isSliceWise = 0;
                if contains(app.VisOptionsDropDown.Value,'slice-wise')
                    isSliceWise = 1;
                    % grab current slice, limits already correctly set in
                    % viewVelocityVectors above
                    sl = app.SliceSpinner_2.Value;
                end

                switch app.MapType.Value
                    case 'wall shear stress'
                        isWSS = 1;
                        if length(app.WSS_matrix) == 1
                            WSS = app.WSS_matrix{1};
                            faces = app.F_matrix{1};
                            verts = app.V_matrix{1};
                        else
                            t2 = app.TimeframeSpinner.Value;
                            WSS = app.WSS_matrix{t2};
                            faces = app.F_matrix{t2};
                            verts = app.V_matrix{t2};
                        end
                        WSS_magnitude = sqrt(WSS(:,1).^2 + WSS(:,2).^2 + WSS(:,3).^2);
                        outVol = WSS_magnitude;
                        outImg = [];
                        scaletmp = [0 4];
                        cBarString = 'WSS (Pa)';

                    case 'peak velocity'
                        scaletmp = [0 round(app.VENC/10)];
                        cBarString = 'peak velocity (cm/s)';
                        % for cmap, calculate absolute max of the mean
                        tmp = currSeg.*sqrt(vx.^2 + vy.^2 + vz.^2);
                        outVol = squeeze(tmp);

                    case 'mean velocity'
                        scaletmp = [0 round(app.VENC/50)];
                        cBarString = 'mean velocity (cm/s)';
                        % for cmap, calculate absolute max of the mean
                        tmp = currSeg.*sqrt(vx.^2 + vy.^2 + vz.^2);
                        outVol = squeeze(tmp);

                    case 'kinetic energy'
                        scaletmp = [0 20];
                        cBarString = 'KE (\muJ)';
                        vx = vx/100; % in m/s
                        vy = vy/100;
                        vz = vz/100;

                        % 1 Joule = 1 kg (m/s)^2
                        rho = 1.060;                            % density of blood, in kg/L
                        vox_vol = prod(app.pixdim/1000)*1000;   % volume of voxel, in L
                        vel = (vx.^2 + vy.^2 + vz.^2);          % velocity in m^2/s^2
                        KE = currSeg.*0.5*rho*vox_vol.*vel;
                        outVol = squeeze(1e6*squeeze(KE));    % in uJ

                    case 'energy loss'
                        scaletmp = [-0.001 4];
                        cBarString = 'EL (mW)';

                        % calculate viscous energy loss as the divergence of velocity,
                        % from: https://onlinelibrary.wiley.com/doi/10.1002/mrm.26129,
                        % and: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4051863/
                        v1 = squeeze(vx); v2 = squeeze(vy); v3 = squeeze(vz);
                        % calculate gradients
                        [v11, v12, v13] = gradient(v1);
                        [v21, v22, v23] = gradient(v2);
                        [v31, v32, v33] = gradient(v3);

                        % divergence
                        for tt = 1:size(v1,4)
                            div(:,:,:,tt) = squeeze(divergence(v1(:,:,:,tt),v2(:,:,:,tt),v3(:,:,:,tt)));
                        end

                        % the viscous dissipation function at each voxel
                        theta_v = 0;
                        for ii = 1:3
                            for jj = 1:3
                                dij = 0;
                                if ii==jj
                                    dij = 1;
                                end
                                theta_v = theta_v + eval(sprintf('((v%i%i + v%i%i) - 2/3*div.*dij).^2',ii,jj,jj,ii));
                            end
                        end
                        theta_v = 1/2*theta_v;

                        % dynamic viscosity mu = 0.004 Pa·s
                        EL = currSeg.*0.004 .* theta_v * prod(app.pixdim)/(10*10*10); % voxel size in cm^3
                        outVol = squeeze(EL);

                    case 'vorticity'
                        scaletmp = [0 250];
                        cBarString = 'vorticity (rad)';

                        % code adopted from open source left atrial post-processing
                        % software from Oxford (Dr. Aaron Hess):
                        % https://ora.ox.ac.uk/objects/uuid:8f2910d9-44ed-4479-85b1-dbd4f06ea54c

                        vx = squeeze(vx)/100; % in m/s
                        vy = squeeze(vy)/100;
                        vz = squeeze(vz)/100;

                        pixelspacing = app.pixdim./1000;          % in m
                        [X, Y, Z] = meshgrid((1:size(vx,2))*pixelspacing(1),(1:size(vx,1))*pixelspacing(2),(1:size(vx,3))*pixelspacing(3));clear pixelspacing

                        for tt = 1:size(vx,4)
                            [curlx,curly,curlz,cav] = curl(X,Y,Z,vx(:,:,:,tt),vy(:,:,:,tt),vz(:,:,:,tt));
                            cx(:,:,:,tt) = curlx; cy(:,:,:,tt) = curly; cz(:,:,:,tt) = curlz;
                        end
                        vorticity = currSeg.*sqrt(cx.^2+cy.^2+cz.^2);
                        clear cx cy cz curlx curly curlz;
                        outVol = squeeze(vorticity);
                end
                outVol(currSeg==0) = nan;

                if ~isvalid(app.VisOptionsApp)
                    scale = scaletmp;
                    backgroundC = [1 1 1];
                    axisText = [0 0 0];
                    cmap = 'jet(256)';
                    cbarLoc = 'bottom-left';
                else
                    scale = [str2double(app.VisOptionsApp.minMapEditField.Value) str2double(app.VisOptionsApp.maxMapEditField.Value)];
                    backgroundC = [1 1 1];
                    if strcmp(app.VisOptionsApp.backgroundDropDown_2.Value,'black')
                        backgroundC = [0 0 0];
                    end
                    axisText = [0 0 0];
                    if strcmp(app.VisOptionsApp.TextcolorDropDown_2.Value,'white')
                        axisText = [1 1 1];
                    end
                    if contains(app.VisOptionsApp.ColormapDropDown_2.Value,'inverse')
                        eval(['cmap=' erase(app.VisOptionsApp.ColormapDropDown_2.Value,'inverse ') '(256);']);
                        cmap = flip(cmap,1);
                    else
                        eval(['cmap=' app.VisOptionsApp.ColormapDropDown_2.Value '(256);']);
                    end
                    cbarLoc = app.VisOptionsApp.LocationDropDown_2.Value;
                end
                cmap(1,:) = backgroundC;

                % the plotting
                if isWSS
                    patch(app.MapPlot,'Faces',faces,'Vertices',verts,'EdgeColor','none', 'FaceVertexCData',WSS_magnitude,'FaceColor','interp','FaceAlpha',1);
                else
                    % first determine time operation
                    switch app.MapTime.Value
                        case 'time-resolved'
                            outImg = outVol;
                        case 'time-averaged'
                            outImg = nanmean(outVol,4);
                        case 'peak'
                            outImg = max(outVol,[],4,'omitnan');
                    end
                    % then project the image, or choose a slice
                    if isSliceWise
                        outImg = outImg(:,:,sl); smthMask = currSeg(:,:,sl);
                    elseif contains(app.VisOptionsApp.projectionDropDown.Value,'mean')
                        outImg = nanmean(outImg,3); smthMask = max(currSeg,[],3,'omitnan');
                    else          % app.VisOptions.MapProjection.Value = 'max'
                        outImg = max(outImg,[],3,'omitnan'); smthMask = max(currSeg,[],3,'omitnan');
                    end

                    % do smoothing if checkbox checked
                    if app.VisOptionsApp.smoothMap_checkbox.Value
                        smthMask = imresize(smthMask,2,"bilinear");
                        smthMask(smthMask < 0.75) = 0;
                        outImg = imresize(outImg,2,'bilinear').*smthMask;
                    end
                    imagesc(app.MapPlot,outImg);
                end

                clim(app.MapPlot, scale);
                colormap(app.MapPlot,cmap)
                cbar = colorbar(app.MapPlot);
                app.MapGroup.BackgroundColor = backgroundC;
                app.MapGroup.ForegroundColor = axisText;
                if isSliceWise && contains(app.MapType.Value,'velocity')
                    cBarString = 'velocity cm/s';
                end
                set(get(cbar,'xlabel'),'string',cBarString,'Color',axisText);
                set(cbar,'FontSize',13,'color',axisText,'Location','west');
                % change cbar size to fit in corner
                pos = get(cbar,'position');
                switch cbarLoc
                    case 'bottom-left'
                        pos = [0.01 0.02 pos(3) 0.2];
                    case 'mid-left'
                        pos = [0.01 0.41 pos(3) 0.2];
                    case 'upper-left'
                        pos = [0.01 0.78 pos(3) 0.2];
                    case 'bottom-right'
                        pos = [0.99-pos(3) 0.02 pos(3) 0.2];
                    case 'mid-right'
                        pos = [0.99-pos(3) 0.41 pos(3) 0.2];
                    case 'upper-right'
                        pos = [0.99-pos(3) 0.78 pos(3) 0.2];
                end
                set(cbar,'position',pos);

                % make it look good
                axis(app.MapPlot, 'off','tight')
                view(app.MapPlot, [0 0 1]);
                daspect(app.MapPlot,[1 1 1])
                idx_currSeg = find(currSeg);
                if isWSS
                    % update view angle
                    camorbit(app.MapPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
                    camroll(app.MapPlot,app.rotAngles2(3))
                    idx_currSeg = 1:length(WSS_magnitude);
                end

            end
        end

        function plotVelocities(app)

            t = app.TimeframeSpinner_3.Value;
            s = app.SliceSpinner.Value;
            if app.isTimeResolvedSeg
                currSeg = app.aorta_seg(:,:,:,t);
            else
                currSeg = zeros(size(app.aorta_seg,1:3));
                % only use segmentations that were selected in first tab
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                    end
                end
                if ~app.isSegmentationLoaded
                    currSeg = app.segment;
                end
            end

            PCA_masked = app.v(:,:,:,:,t).*repmat(permute(currSeg,[1 2 3 5 4]),[1 1 1 3 1])/10;

            % determine scaling for visualization
            scaling = round(max(abs(PCA_masked(:))));
            cmap_scaling = dopplermap(1000,1);

            imagesc(app.Unwrap_1,PCA_masked(:,:,s,1),'tag', 'alldata');
            axis(app.Unwrap_1,'equal','off');
            colormap(app.Unwrap_1,cmap_scaling);
            caxis(app.Unwrap_1, [-scaling scaling]);
            title(app.Unwrap_1,app.ori.vxlabel);

            imagesc(app.Unwrap_2,PCA_masked(:,:,s,2),'tag', 'alldata');
            axis(app.Unwrap_2,'equal','off')
            colormap(app.Unwrap_2,cmap_scaling);
            caxis(app.Unwrap_2, [-scaling scaling]);
            title(app.Unwrap_2,app.ori.vylabel);

            imagesc(app.Unwrap_3,PCA_masked(:,:,s,3),'tag', 'alldata');
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
            app.VelocityUnwrapping.Icon = 'unwrap.jpg';
            app.DFW.Icon = 'DFW.jpg';
            drawnow;
        end

        % Button pushed function: LoadDataButton
        function LoadDataButtonPushed(app, ~)
            clc;

            list = {'Philips .rec','mrStruct .mat','Siemens dicom'};
            [indx,tf] = listdlg('PromptString',{'4D flow file type',...
                'Only one file can be selected',''},...
                'SelectionMode','single','ListString',list);
            filetype = list{indx};

            switch filetype
                case 'Philips .rec'
                    [filename,directory] = uigetfile('*.rec','Select Reconstructed Data');
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadPARREC(directory, filename);
                case 'mrStruct .mat'
                    [filename,directory] = uigetfile('*.mat','Select Reconstructed Data');
                    % quick check that both files exist
                    if ~exist(fullfile(directory,'mag_struct.mat'),'file') || ~exist(fullfile(directory,'vel_struct.mat'),'file')
                        error('both mag_struct.mat and vel_struct.mat needed for loading in mrStruct files');
                    end
                    [app.directory, app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadMrStruct(directory);
                case 'Siemens dicom'
                    directory = uigetdir('Select parent Siemens dicom directory (with 4 subfolders)');
                    % quick check that all directories exist
                    if length(dir(directory)) ~= 6 % inclues . and ..
                        error('directory does not contain 4 subfolders (with Siemens dicoms)');
                    end
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadSiemensDicom(directory);
                case 'GE dicom'
                    directory = uigetdir('Select parent GE dicom directory (with 4 subfolders)');
                    % quick check that all directories exist
                    if length(dir(directory)) ~= 6 % inclues . and ..
                        error('directory does not contain 4 subfolders (with GE dicoms)');
                    end
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadGEDicom(directory);
            end
            app.directory = directory;

            % re-focus the figure
            figure(app.FlowProcessingUIFigure);

            % initialize the mask
            app.mask = ones(size(app.angio));

            % add to info table
            app.ScanInfoTable.Data = cat(2,cellstr([num2str(app.res(1)) ' x ' num2str(app.res(2)) ' x ' num2str(app.res(3))]),...
                cellstr([num2str(round(app.pixdim(1),1)) ' x ' num2str(round(app.pixdim(2),1)) ' x ' num2str(round(app.pixdim(3),1))]),...
                cellstr(num2str(app.timeres)),cellstr(num2str(app.nframes)), cellstr(num2str(app.VENC/10)));

            app.DataDirectoryEditField.Value = app.directory;
            % crop info
            app.CropInfoTable.Data = cat(1,cellstr([num2str(1) ' to ' num2str(app.res(1))]),...
                cellstr([num2str(1) ' to ' num2str(app.res(2))]),...
                cellstr([num2str(1) ' to ' num2str(app.res(3))]));

            updateMIPs(app);

            clc;
            disp('View 3D Vasculature')

            normed_MIP = app.angio./max(app.angio(:));
            % fit a Gaussian to non-zero elements to determine threshold
            [muhat,sigmahat] = norm_fit(normed_MIP(:));

            app.segment = zeros(size(app.angio));
            app.segment(normed_MIP>muhat+2*sigmahat) = 1;

            app.segment = bwareaopen(app.segment,round(sum(app.segment(:)).*0.005),6); %The value at the end of the commnad in the minimum area of each segment to keep
            app.segment = imfill(app.segment,18,'holes'); % Fill in holes created by slow flow on the inside of vessels
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
            app.rotAngles2 = [0 0 0];
            app.isRawDataCropped = 0;

            % enable intepolate button
            app.InterpolateData.Enable = 'on';

            app.ManualsegmentationupdateButton.Visible = 'on';
        end

        % Button pushed function: CleardataandrestartanalysisButton
        function CleardataandrestartanalysisButtonPushed(app, ~)
            if ~isempty(app.VisOptionsApp)
                delete(app.VisOptionsApp.VisOptionsDialogUIFigure);
            end
            delete(app.FlowProcessingUIFigure);  % close the app
            close all;
            FlowProcessing;                      % re-open it
        end

        % Button pushed function: LoadSegmentationButton
        function LoadSegmentationButtonPushed(app, ~)

            app.aorta_seg = [];
            currDir = pwd;
            cd(app.directory);
            % if clicked, let the user pick the directory containg the pre-segmented
            % dicoms, load them in and save them, also update 3D view
            [tmp,app.segDirectory] = uigetfile(fullfile(app.directory,'*.dcm;*nii.gz;*.nii'),'Select Segmentation (*.dcm or *.nii)');
            app.SegmentationDirectoryEditField.Value = app.segDirectory;

            if strncmp(tmp(end-2:end),'dcm',3)
                files = dir([app.segDirectory '/*.dcm']);
                % reset the aorta segmentation
                app.aorta_seg = zeros(size(app.angio));
                for ii = 1:numel(files)
                    img(:,:,ii) = dicomread([app.segDirectory '/' files(ii).name]);
                end
                img(find(img)) = 1;
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
                app.aorta_seg = double(niftiread(fullfile(app.segDirectory,tmp)));
                if size(app.v,1) ~= size(app.aorta_seg,1)
                    app.aorta_seg = permute(app.aorta_seg,[2 1 3]); % .nii need permutation along x/y
                end
            else    % the files are still dicoms but not with a dicom ending?
                files = dir([app.segDirectory '/*IM*']);
                % reset the aorta segmentation
                app.aorta_seg = zeros(size(app.angio));
                for ii = 1:numel(files)
                    img(:,:,ii) = dicomread([app.segDirectory '/' files(ii).name]);
                end
                img(find(img)) = 1;
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

            app.isSegmentationLoaded = 1;
            app.ManualsegmentationupdateButton.Visible = 'on';

            if app.isTimeResolvedSeg
                app.SegTimeframeSpinner.Value = app.time_peak;
            end

            % enable flip checkbox now
            app.flipSegLabel.Visible = 'on';
            app.flipsegio.Visible = 'on';
            app.flipseglr.Visible = 'on';
            app.flipsegud.Visible = 'on';

            % we assume mask is 0 or 1, if values higher than one, assign
            % them to a separate mask
            if max(app.aorta_seg(:)) > 1 && size(app.aorta_seg,4) == 1  % no time-resolved multi-masks
                tmpMask = zeros([size(app.aorta_seg), max(app.aorta_seg(:))]);
                % create a 5th dimension of mask (4th is time, usually 1)
                for ii = 1:max(app.aorta_seg(:))
                    tmp = zeros(size(app.aorta_seg));
                    tmp(app.aorta_seg == ii) = 1;
                    tmpMask(:,:,:,ii) = tmp;
                    eval(sprintf('app.mask%i.Visible=''on'';',ii));
                    eval(sprintf('app.mask%i.Value=1;',ii));
                end
                app.aorta_seg = tmpMask; clear tmp tmpMask;
                app.MaskLabel.Visible = 'on';
            else
                % keep hidden, but turn on mask1 for viewing
                app.mask1.Value = 1;
            end

            View3DSegmentation(app);
            cd(currDir);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: flipseglr
        function flipseglrValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,2);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: flipsegud
        function flipsegudValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,1);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: flipsegio
        function flipsegioValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,3);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask1
        function mask1ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask2
        function mask2ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask3
        function mask3ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask4
        function mask4ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask5
        function mask5ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask6
        function mask6ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask7
        function mask7ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask8
        function mask8ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask9
        function mask9ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: mask10
        function mask10ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);

        end

        % Value changed function: SegTimeframeSpinner
        function SegTimeframeSpinnerValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            if ~app.isRawDataCropped
                updateMIPs(app);
            end
        end

        % Button pushed function: MapsPushButton
        function MapsPushButtonPushed(app, ~)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
                app.FinishedCroppingButton.Enable = 'off';
            else % to ensure that updated thresholding is applied to aorta_seg
                if (~app.isSegmentationLoaded)
                    app.aorta_seg = app.segment;
                end
            end

            % switch to the correct tab and enable fields
            app.TabGroup.SelectedTab = app.Maps;
            app.TimeframeSpinnerLabel.Enable = 'on';
            app.TimeframeSpinner.Enable = 'on';
            app.TimeframeSpinner.Limits = [1,app.nframes];

            app.CalculateMap.Enable = 'on';

            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    Vmag = app.aorta_seg.*squeeze(sqrt(sum(app.v.^2,4)));
                    idx = find(mean(app.aorta_seg,4));
                else
                    currSeg = zeros(size(app.aorta_seg,1:3));
                    % only use segmentations that were selected in first tab
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                        end
                    end
                    Vmag = repmat(currSeg,[1 1 1 app.nframes]).*squeeze(sqrt(sum(app.v.^2,4)));
                    idx = find(sum(currSeg,4));
                end
                for t = 1:app.nframes
                    tmp = Vmag(:,:,:,t);
                    mean_velo(t) = mean(tmp(idx));
                end
                [~,app.time_peak] = find(mean_velo==max(mean_velo));
            end

            app.PeaksystoleEditField.Value = num2str(app.time_peak);
            app.TimeframeSpinner.Value = app.time_peak;
            app.TimeframeSpinner.Value = app.time_peak;

            % view vectors
            app.VisOptionsApp = VisOptionsDialog(app, round(app.VENC/10));
            viewVelocityVectors(app);
            app.SaveAnimation.Enable = 'on';
            app.SaveRotatedAnimation.Enable = 'on';
            app.VisOptions.Enable = 'on';
            app.MapROIanalysis.Enable = 'on';
            app.MapVolumetricanalysis.Enable = 'on';
        end

        % Button pushed function: PulseWaveVelocityPushButton
        function PulseWaveVelocityPushButtonButtonPushed(app, ~)

            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
                app.FinishedCroppingButton.Enable = 'off';
            end

            % these are hard-coded for now
            sortingCriteria = 3;
            spurLength = 3;

            se = strel('sphere',1);
            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    ss = imerode(app.aorta_seg(:,:,:,app.time_peak),se);
                else
                    currSeg = zeros(size(app.aorta_seg,1:3));
                    % only use segmentations that were selected in first tab
                    for ii = 1:size(app.aorta_seg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                        end
                    end
                    ss = imerode(currSeg,se);
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
        function Reset3DviewButtonPushed(app, ~)
            reset3DSegmentationAndCenterline(app);
        end

        % Button pushed function: CheckcenterlinecalculateflowButton
        function CheckcenterlinecalculateflowButtonPushed(app, ~)
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

            tmpBranch = flipud(app.branchList(idx,1:3));

            % fit and extract the spline plus normals for this centerline
            % user choice points to do spline fit along centerline, only if
            % branch is long enough
            if size(tmpBranch,1) > 25
                percBranchLengthSpline = 10;     % the target distance (%) between chosen points for fit
                ptSkip = round(size(tmpBranch,1)*percBranchLengthSpline/100);
                curve_long = cscvn(tmpBranch(1:ptSkip:end,:)');
            else
                curve_long = cscvn(tmpBranch(:,:)');
            end
            tlong = linspace(0,curve_long.breaks(end),size(tmpBranch,1));

            % the final centerline
            app.branchActual = fnval(curve_long, tlong);
            app.branchActual = app.branchActual';

            % and the tangent vector
            Tangent_V = fnval(fnder(curve_long), tlong);
            Tangent_V = Tangent_V';
            Tangent_V = normalize(Tangent_V,2,'norm');

            reset3DSegmentationAndCenterline(app);
            hline2 = line(app.View3D_2,app.branchActual(:,2),app.branchActual(:,1),app.branchActual(:,3),...
                'Color','g','Marker','*','MarkerSize',12,'LineStyle','none');
            planeWidth = round(str2double(app.PlaneWidth.Value)/mean(app.pixdim)/2);
            viewPlanesIn3D(app.View3D_2, Tangent_V, planeWidth, app.branchActual);

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
                        currSeg = zeros(size(app.aorta_seg,1:3));
                        % only use segmentations that were selected in first tab
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                            end
                        end
                        if ~app.isSegmentationLoaded
                            currSeg = app.segment;
                        end
                        for j = 1:app.nframes
                            aortaSeg_timeResolved(:,:,:,j) = currSeg;
                        end
                    end

                    % Calculate flow over whole aorta
                    displayWaitBar = true;
                    planeWidth = round(str2double(app.PlaneWidth.Value)/mean(app.pixdim)/2);
                    [app.flowPerHeartCycle_vol, app.flowPulsatile_vol, app.contours, app.tangent_V, app.area_val] = ...
                        params_timeResolved(app.branchActual, app.angio, app.MAG, app.v, app.nframes, app.pixdim, aortaSeg_timeResolved, app.isSegmentationLoaded,...
                        app.isTimeResolvedSeg, Tangent_V, planeWidth, displayWaitBar);

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
                        app.PWVPoints.Value = [num2str(app.FullBranchDistance(1)) ': ' ...
                            num2str(app.FullBranchDistance(length(branch)))];
                        app.PWVPointsLabel.Text = ['PWV dist (mm) [' num2str(app.FullBranchDistance(1)) ':' ...
                            num2str(app.FullBranchDistance(length(branch))) ']'];
                    else
                        app.PWVPoints.Value = ['5: ' num2str(length(app.branchActual)-4)];
                        app.PWVPointsLabel.Text = ['PWV Points [5:' num2str(length(app.branchActual)) ']'];
                    end
                    % immediately calculate PWV
                    CalculatePWVButtonPushed(app, []);

                    % view the flows at each centerline point, and plot the waveforms
                    view3D_wParams(app);
                    plotWaveforms(app);

                    % update maps tab, send spaced initial centerline points to maps tab
                    app.VisOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
                    app.VisOptionsApp.VisPts.Value = ['5:10:' num2str(length(app.branchActual)-4)];

                case 2  % go into update_centerline code for manual adjustments
                    app.SplineSpacingSlider.Visible = 'on';
                    app.SplineSpacingSliderLabel.Visible = 'on';
                    if app.isTimeResolvedSeg
                        data = app.aorta_seg(:,:,:,app.time_peak);
                    else
                        data = app.aorta_seg;
                    end
                    [app.branchActual, Tangent_V] = update_centerline(data, app.branchActual, planeWidth, app);

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
                        currSeg = zeros(size(app.aorta_seg,1:3));
                        % only use segmentations that were selected in first tab
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                            end
                        end
                        if ~app.isSegmentationLoaded
                            currSeg = app.segment;
                        end
                        for j = 1:app.nframes
                            aortaSeg_timeResolved(:,:,:,j) = currSeg;
                        end
                    end

                    % Calculate flow over whole aorta
                    displayWaitBar = true;
                    [app.flowPerHeartCycle_vol, app.flowPulsatile_vol, app.contours, app.tangent_V, app.area_val] = ...
                        params_timeResolved(app.branchActual, app.angio, app.MAG, app.v, app.nframes, app.pixdim, aortaSeg_timeResolved, app.isSegmentationLoaded,...
                        app.isTimeResolvedSeg, Tangent_V, planeWidth, displayWaitBar);

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
                    CalculatePWVButtonPushed(app, []);

                    % view the flows at each centerline point, and plot the waveforms
                    view3D_wParams(app);
                    plotWaveforms(app);

                    % update maps tab, send spaced initial centerline points to maps tab
                    app.VisOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
                    app.VisOptionsApp.VisPts.Value = ['5:10:' num2str(length(app.branchActual)-4)];
                    app.SplineSpacingSlider.Visible = 'off';
                    app.SplineSpacingSliderLabel.Visible = 'off';
            end
        end

        % Button pushed function: PlotWaveformsButton
        function PlotWaveformsButtonPushed(app, ~)
            plotWaveforms(app);
        end

        % Button pushed function: CalculatePWV
        function CalculatePWVButtonPushed(app, ~)
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
        function SaveResultsCallbackButtonPushed(app, ~)

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
            writetable(PWV,[saveName '.xlsx'],'Sheet','PWV','WriteMode','overwritesheet');

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

            % save sheet with ptRange and distance
            tbl = array2table(cat(2,nan,app.FullBranchDistance(ptRange)));
            tbl.Properties.VariableNames = ["point number",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','distance (mm)','WriteMode','overwritesheet');

            waveforms = waveforms(ptRange,:);
            card_time = [0:app.nframes-1]*app.timeres;
            tbl = array2table(cat(2,card_time',waveforms'));
            tbl.Properties.VariableNames = ["cardiac time(ms)",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','flow(ml per s)','WriteMode','overwritesheet');

            % save area
            tbl = array2table(cat(2,card_time',app.area_val(ptRange,:)'));
            tbl.Properties.VariableNames = ["cardiac time(ms)",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','area (cm^2)','WriteMode','overwritesheet');

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
        function CropButtonPushed(app, ~)
            if app.isSegmentationLoaded
                ct = 0;
                for ii = length(app.AxesX.Children)-1:-1:1
                    ct = ct+1;
                    img2(:,:,ct) = app.AxesX.Children(ii).AlphaData;
                end
            else
                img2 = [];
            end
            img = app.AxesX.Children(length(app.AxesX.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_ystart = maskSz(2);m_ystop = maskSz(2)+maskSz(4);
            m_zstart = maskSz(1);m_zstop = maskSz(1)+maskSz(3);

            % crop info
            app.CropInfoTable.Data{2,1} = [num2str(m_ystart) ' to ' num2str(m_ystop)];
            app.CropInfoTable.Data{3,1} = [num2str(m_zstart) ' to ' num2str(m_zstop)];

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

            updateMIPs(app);
            View3DSegmentation(app);
        end

        % Button pushed function: CropButton_2
        function CropButton_2Pushed(app, ~)
            if app.isSegmentationLoaded
                ct = 0;
                for ii = length(app.AxesX.Children)-1:-1:1
                    ct = ct+1;
                    img2(:,:,ct) = app.AxesY.Children(ii).AlphaData;
                end
            else
                img2 = [];
            end
            img = app.AxesY.Children(length(app.AxesY.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_xstart = maskSz(2);m_xstop = maskSz(2)+maskSz(4);
            m_zstart = maskSz(1);m_zstop = maskSz(1)+maskSz(3);

            % crop info
            app.CropInfoTable.Data{1,1} = [num2str(m_xstart) ' to ' num2str(m_xstop)];
            app.CropInfoTable.Data{3,1} = [num2str(m_zstart) ' to ' num2str(m_zstop)];

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

            updateMIPs(app);
            View3DSegmentation(app);
        end

        % Button pushed function: CropButton_3
        function CropButton_3Pushed(app, ~)
            if app.isSegmentationLoaded
                ct = 0;
                for ii = length(app.AxesZ.Children)-1:-1:1
                    ct = ct+1;
                    img2(:,:,ct) = app.AxesZ.Children(ii).AlphaData;
                end
            else
                img2 = [];
            end
            img = app.AxesZ.Children(length(app.AxesZ.Children),1).CData;
            maskSz = cropImage(app,img,img2);

            m_xstart = maskSz(2);m_xstop = maskSz(2)+maskSz(4);
            m_ystart = maskSz(1);m_ystop = maskSz(1)+maskSz(3);

            % crop info
            app.CropInfoTable.Data{1,1} = [num2str(m_xstart) ' to ' num2str(m_xstop)];
            app.CropInfoTable.Data{2,1} = [num2str(m_ystart) ' to ' num2str(m_ystop)];

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

            updateMIPs(app);
            View3DSegmentation(app);
        end

        % Button pushed function: FinishedCroppingButton
        function FinishedCroppingButtonPushed(app, ~)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
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
        function RotateLeftButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        eval(sprintf('rotate(app.patchMask%i,[0 1 0],10);',ii))
                    end
                end
            else
                rotate(app.hpatch1,[0 1 0],10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)+10];
        end

        % Button pushed function: RotateRight
        function RotateRightButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        eval(sprintf('rotate(app.patchMask%i,[0 1 0],-10);',ii))
                    end
                end
            else
                rotate(app.hpatch1,[0 1 0],-10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)-10];
        end

        % Button pushed function: RotateDown
        function RotateDownButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        eval(sprintf('rotate(app.patchMask%i,[1 0 0],10);',ii))
                    end
                end
            else
                rotate(app.hpatch1,[1 0 0],10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)+10 app.rotAngles(2)];
        end

        % Button pushed function: RotateUp
        function RotateUpButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if eval(sprintf('app.mask%i.Value==1',ii))
                        eval(sprintf('rotate(app.patchMask%i,[1 0 0],-10);',ii))
                    end
                end
            else
                rotate(app.hpatch1,[1 0 0],-10)
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)-10 app.rotAngles(2)];
        end

        % Button pushed function: ResetRotation
        function ResetRotationButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles = [0 0];
            View3DSegmentation(app);
        end

        % Button pushed function: AddbranchButton
        function AddbranchButtonPushed(app, ~)
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
        function AdjustthresholdSliderValueChanged(app, ~)
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
        function deleteBranch2ButtonPushed(app, ~)
            app.Branch2Label.Visible = 'off';
            app.BranchDropDown_2.Visible = 'off';
            app.FlipBranch1_2.Visible = 'off';
            app.deleteBranch2.Visible = 'off';
        end

        % Button pushed function: deleteBranch3
        function deleteBranch3ButtonPushed(app, ~)
            app.Branch3Label.Visible = 'off';
            app.BranchDropDown_3.Visible = 'off';
            app.FlipBranch1_3.Visible = 'off';
            app.deleteBranch3.Visible = 'off';
            app.deleteBranch2.Visible = 'on';
        end

        % Button pushed function: deleteBranch4
        function deleteBranch4ButtonPushed(app, ~)
            app.Branch4Label.Visible = 'off';
            app.BranchDropDown_4.Visible = 'off';
            app.FlipBranch1_4.Visible = 'off';
            app.deleteBranch4.Visible = 'off';
            app.deleteBranch3.Visible = 'on';
        end

        % Value changed function: DisplayDistanceCheckbox
        function DisplayDistanceCheckboxValueChanged(app, ~)
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
        function ParameterDropDownValueChanged(app, ~)
            view3D_wParams(app);
            plotWaveforms(app);
        end

        % Value changed function: TimeframeSpinner
        function TimeframeSpinnerValueChanged(app, ~)
            if contains(app.MapTime.Value,'resolved')
                viewMap(app);
            end
            updateVisualization(app);
        end

        % Value changed function: MapType
        function MapTypeValueChanged(app, ~)

            switch app.MapType.Value
                case 'None'
                    app.MapTime.Enable = 'off';
                    cla(app.MapPlot);
                    colorbar(app.MapPlot,'off');

                case 'wall shear stress'
                    app.VisOptionsApp.minMapEditField.Value = '0';
                    app.VisOptionsApp.maxMapEditField.Value = '4';
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'wss (Pa)';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 0;

                    app.MapROIanalysis.Enable = 'off';

                    if ~app.isWSScalculated
                        msgbox('WSS not yet calculated, push Calculate Map');
                        return;
                    end

                case 'peak velocity'
                    app.VisOptionsApp.minMapEditField.Value = '0';
                    app.VisOptionsApp.maxMapEditField.Value = num2str(round(app.VENC/10));
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 0;
                    app.VisOptionsApp.projectionDropDown.Value = 'max';

                    app.MapROIanalysis.Enable = 'on';

                case 'mean velocity'
                    app.VisOptionsApp.minMapEditField.Value = '0';
                    app.VisOptionsApp.maxMapEditField.Value = num2str(round(app.VENC/50));
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 0;
                    app.VisOptionsApp.projectionDropDown.Value = 'mean';

                    app.MapROIanalysis.Enable = 'on';

                case 'kinetic energy'
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'KE (mJ)';
                    app.VisOptionsApp.minMapEditField.Value = '0';
                    app.VisOptionsApp.maxMapEditField.Value = '10';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 0;

                    app.MapROIanalysis.Enable = 'on';

                case 'energy loss'
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'EL (mW)';
                    app.VisOptionsApp.minMapEditField.Value = '-0.1';
                    app.VisOptionsApp.maxMapEditField.Value = '3';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 1;

                    app.MapROIanalysis.Enable = 'on';

                case 'vorticity'
                    app.VisOptionsApp.MapEditFieldLabel.Text = 'vorticity (rad)';
                    app.VisOptionsApp.minMapEditField.Value = '0';
                    app.VisOptionsApp.maxMapEditField.Value = '300';
                    app.VisOptionsApp.mask_erosion_checkbox.Value = 1;

                    app.MapROIanalysis.Enable = 'on';

            end
            if ~contains(app.MapType.Value,'None')
                app.MapTime.Enable = 'on';
                viewMap(app);
            end
        end

        % Value changed function: MapTime
        function MapTimeValueChanged(app, ~)
            viewMap(app);
        end

        % Value changed function: SliceSpinner_2
        function SliceSpinner_2ValueChanged(app, ~)
            updateVisualization(app);
            viewMap(app);
        end

        function VisOptionsButtonPushed(app, ~)
            app.VisOptionsApp = VisOptionsDialog(app, round(app.VENC/10));
        end

        % Button pushed function: CalculateMap
        function CalculateMapPushed(app, ~)

            switch app.MapType.Value
                case 'wall shear stress'
                    % gather parameters for calculation
                    prompt = {'Frames (peak systole (0) or all frames (1)):','Use wall effects (0 or 1):',...
                        'Viscosity (Pa•s):'};
                    dlgtitle = 'WSS calculation parameters';
                    dims = [1 65];
                    definput = {'0','0','0.0032'};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);

                    if app.isTimeResolvedSeg
                        currSeg = app.aorta_seg(:,:,:,t);
                    else
                        currSeg = zeros(size(app.aorta_seg,1:3));
                        % only use segmentations that were selected in first tab
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                            end
                        end
                        if ~app.isSegmentationLoaded
                            currSeg = app.segment;
                        end
                    end

                    peakSystole = str2double(answer{1})==0;
                    viscosity = str2double(answer{3});

                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:size(currSeg,2))*app.pixdim(1),(1:size(currSeg,1))*app.pixdim(2), ...
                        (1:size(currSeg,3))*app.pixdim(3));

                    [Faces,Verts] = isosurface(xcoor_grid,ycoor_grid,zcoor_grid,-1.*currSeg,-0.5);
                    [Faces,Verts] = SmoothLaplacian(Faces,Verts,15); %laplacian smoothing for surface (Kevin Moerman)

                    % check and correct surface faces / vertices
                    [surface_faces,surface_vertices] = cleanupFV(Faces,Verts);
                    surface_vertices = surface_vertices .*1e-3;

                    % calculate normal vectors - uses external function
                    n = patchnormals(struct('faces',surface_faces,'vertices',surface_vertices));

                    mask_segmentation = find(currSeg);
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

                        velocity_x = double(currSeg.*app.v(:,:,:,1,t)).*1e-3;
                        velocity_y = double(currSeg.*app.v(:,:,:,2,t)).*1e-3;
                        velocity_z = double(currSeg.*app.v(:,:,:,3,t)).*1e-3;

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

                    viewMap(app);

                    app.isWSScalculated = 1;
            end
        end

        % Button pushed function: SaveAnimation
        function SaveAnimationButtonPushed(app, ~)

            saveFrame = app.TimeframeSpinner.Value;
            % temporarily hide other things for plotting
            app.MapPlot.Toolbar.Visible = 'off';
            app.VisualizationPlot.Toolbar.Visible = 'off';
            app.TimeframeSpinner.Visible = 'off';
            app.TimeframeSpinnerLabel.Visible = 'off';
            app.VisOptionsDropDown.Visible = 'off';
            app.SliceSpinner_2.Visible = 'off';
            app.SliceSpinner_2Label.Visible = 'off';

            app.MapType.Visible = 'off';

            [file,path] = uiputfile('*.gif','Selection file name and location');
            filename = fullfile(path,file);
            % loop over time frames and record
            for t = 1:app.nframes
                app.TimeframeSpinner.Value = t;
                updateVisualization(app);

                % freeze limits to avoid jittering in gif
                if t == 1
                    veclim_x = app.VisualizationPlot.XLim;
                    veclim_y = app.VisualizationPlot.YLim;
                    veclim_z = app.VisualizationPlot.ZLim;
                    app.VisualizationPlot.XLimMode = 'manual';
                    app.VisualizationPlot.YLimMode = 'manual';
                    app.VisualizationPlot.ZLimMode = 'manual';
                    maplim_x = app.MapPlot.XLim;
                    maplim_y = app.MapPlot.YLim;
                else
                    app.VisualizationPlot.XLim = veclim_x;
                    app.VisualizationPlot.YLim = veclim_y;
                    app.VisualizationPlot.ZLim = veclim_z;
                    app.MapPlot.XLim = maplim_x;
                    app.MapPlot.YLim = maplim_y;
                end
                pause(0.01);

                if ~contains(app.MapType.Value,'None')
                    app.TimeframeSpinner.Value = t;
                    viewMap(app);
                    ff = getframe(app.FlowProcessingUIFigure, [1 25 475*2 690]);
                else
                    ff = getframe(app.FlowProcessingUIFigure, [1 25 475 690]);
                end
                % Turn screenshot into image
                im = frame2im(ff);
                % add time label
                im = insertText(im,[100 1],sprintf('t = %2.2f s', (t-1)*(app.timeres/1000)),'BoxColor','white','FontSize',18);

                % Turn image into indexed image (the gif format needs this)
                [imind,cm] = rgb2ind(im(1:673,:,:),256);

                delay = 2*app.timeres/1000;
                if t == 1
                    imwrite(imind,cm,filename,'gif', 'WriteMode','overwrite','DelayTime', delay, 'LoopCount', Inf);
                else
                    imwrite(imind,cm, filename,'gif','WriteMode','append','DelayTime',delay);
                end
            end

            % turn back on
            app.VisualizationPlot.XLimMode = 'auto';
            app.VisualizationPlot.YLimMode = 'auto';
            app.VisualizationPlot.ZLimMode = 'auto';
            app.TimeframeSpinner.Visible = 'on';
            app.TimeframeSpinnerLabel.Visible = 'on';
            app.VisOptionsDropDown.Visible = 'on';
            if strncmp(app.VisOptionsDropDown.Value,'slice-wise',10)
                app.SliceSpinner_2.Visible = 'on';
                app.SliceSpinner_2Label.Visible = 'on';
            end

            app.MapType.Visible = 'on';
            app.MapPlot.Toolbar.Visible = 'on';
            app.VisualizationPlot.Toolbar.Visible = 'on';
            app.TimeframeSpinner.Value = saveFrame;
        end

        % Button pushed function: SaveRotatedAnimation
        function SaveRotatedAnimationButtonPushed(app, ~)

            saveFrame = app.TimeframeSpinner.Value;
            if strcmp(app.VisOptionsDropDown.Value,'slice-wise')
                errordlg('rotated animation not available for slice-wise vectors')
                return;
            end
            app.rotAngles2 = [0 0 0]; % reset the rotations and inform
            disp('only native orientation allowed for animated rotations');

            % temporarily hide other things for plotting
            app.MapPlot.Toolbar.Visible = 'off';
            app.VisualizationPlot.Toolbar.Visible = 'off';
            app.TimeframeSpinner.Visible = 'off';
            app.TimeframeSpinnerLabel.Visible = 'off';
            app.VisOptionsDropDown.Visible = 'off';
            app.SliceSpinner_2.Visible = 'off';
            app.SliceSpinner_2Label.Visible = 'off';
            app.MapType.Visible = 'off';

            [file,path] = uiputfile('*.gif','Selection file name and location');
            filename = fullfile(path,file);
            % we default to 180 frames and deal over rotations and time
            % frames
            % loop over time frames and record
            ct_time = 1;
            ct_rotation = 0;
            for t = 1:180
                app.TimeframeSpinner.Value = ct_time;
                updateVisualization(app);

                camorbit(app.VisualizationPlot,app.rotAngles2(2)+4*ct_rotation,app.rotAngles2(1),[1 1 0])
                axis(app.VisualizationPlot,'vis3d')
                % freeze limits to avoid jittering in gif
                if t == 1
                    veclim_x = app.VisualizationPlot.XLim;
                    veclim_y = app.VisualizationPlot.YLim;
                    veclim_z = app.VisualizationPlot.ZLim;
                    app.VisualizationPlot.XLimMode = 'manual';
                    app.VisualizationPlot.YLimMode = 'manual';
                    app.VisualizationPlot.ZLimMode = 'manual';
                    maplim_x = app.MapPlot.XLim;
                    maplim_y = app.MapPlot.YLim;
                else
                    app.VisualizationPlot.XLim = veclim_x;
                    app.VisualizationPlot.YLim = veclim_y;
                    app.VisualizationPlot.ZLim = veclim_z;
                    app.MapPlot.XLim = maplim_x;
                    app.MapPlot.YLim = maplim_y;
                end
                pause(0.01);

                % only save the vectors/streamlines plot
                ff = getframe(app.FlowProcessingUIFigure, [1 25 475 690]);
                % Turn screenshot into image
                im = frame2im(ff);
                % add time label
                im = insertText(im,[100 1],sprintf('t = %2.2f s', (ct_time-1)*(app.timeres/1000)),'BoxColor','white','FontSize',18);

                % Turn image into indexed image (the gif format needs this)
                [imind,cm] = rgb2ind(im(1:673,:,:),256);

                delay = 2*app.timeres/1000;
                if t == 1
                    imwrite(imind,cm,filename,'gif', 'WriteMode','overwrite','DelayTime', delay, 'LoopCount', Inf);
                else
                    imwrite(imind,cm, filename,'gif','WriteMode','append','DelayTime',delay);
                end
                if mod(t,2) == 1 % odd update ct_rotation
                    ct_rotation = ct_rotation + 1;
                else
                    ct_time = ct_time + 1;
                    if ct_time > app.nframes
                        ct_time = 1;
                    end
                end
            end

            % turn back on
            app.VisualizationPlot.XLimMode = 'auto';
            app.VisualizationPlot.YLimMode = 'auto';
            app.VisualizationPlot.ZLimMode = 'auto';
            app.TimeframeSpinner.Visible = 'on';
            app.TimeframeSpinnerLabel.Visible = 'on';
            app.VisOptionsDropDown.Visible = 'on';
            if strncmp(app.VisOptionsDropDown.Value,'slice-wise',10)
                app.SliceSpinner_2.Visible = 'on';
                app.SliceSpinner_2Label.Visible = 'on';
            end

            app.MapType.Visible = 'on';
            app.MapPlot.Toolbar.Visible = 'on';
            app.VisualizationPlot.Toolbar.Visible = 'on';
            app.TimeframeSpinner.Value = saveFrame;
        end

        % Button pushed function: MapROIanalysis
        function MapROIanalysisPushed(app, ~)
            clc; close(figure(700));
            choice = 2;
            while choice == 2
                close(figure(700));
                disp('Draw ROI in map image to check results')
                app.MapPlot.Toolbar.Visible = 'off';
                h = drawpolygon(app.MapPlot,'color',app.VisOptionsApp.TextcolorDropDown_2.Value,'FaceAlpha',0);
                BW = createMask(h); idx = find(BW);

                % first save image with current ROI and time frame
                ff = getframe(app.FlowProcessingUIFigure, [476 25 475 690]);
                % Turn screenshot into image
                im = frame2im(ff);
                app.MapPlot.Toolbar.Visible = 'on';

                % save state
                saveFrame = app.TimeframeSpinner.Value;

                % loop through all 2D frames with ROI, report summary statistics
                map_var = zeros(length(idx),app.nframes);
                for t = 1:app.nframes
                    app.TimeframeSpinner.Value = t;
                    [outImg, ~, ~] = viewMap(app);
                    map_var(:,t) = outImg(idx);
                end

                switch app.MapType.Value
                    case 'peak velocity'
                        paramString = 'peak velocity (cm/s)';
                        saveString = 'peak_velocity';
                    case 'mean velocity'
                        paramString = 'mean velocity (cm/s)';
                        saveString = 'mean_velocity';
                    case 'kinetic energy'
                        paramString = 'Max KE (\muJ)';
                        saveString = 'KE';
                    case 'energy loss'
                        paramString = 'EL (mW)';
                        saveString = 'EL';
                    case 'vorticity'
                        paramString = 'vorticity (rad)';
                        saveString = 'vorticity';
                end

                % make image
                card_time = (0:app.nframes-1)*app.timeres;
                fig = figure(700); clf;
                set(fig,'Name','ROI analysis')
                set(fig,'position',[2    42   958   684])
                subplot(121);
                image(im); axis off;
                subplot(122);
                plot(card_time,mean(map_var,1),'*-k','linewidth',2)
                hold on;
                plot(card_time,max(map_var,[],1),'square-b','linewidth',2)
                xlabel('cardiac time (ms)'); ylabel(paramString); box off;
                set(gca,'fontsize',16)
                legend('ROI average', 'ROI max')
                hold off;
                set(fig,'color', 'w')
                drawnow;

                app.TimeframeSpinner.Value = saveFrame;

                % check if user wants to save
                choice = choosedialog_2;

                if choice == 1
                    savePrefix = saveString;
                    prompt = {'save name:'};
                    dlgtitle = 'set save name ROI analysis';
                    dims = [1 50];
                    definput = {'vessel'};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);
                    savePrefix = strcat(answer{1},'_',savePrefix);

                    saveFolder = fullfile(app.directory,'map_results'); mkdir(saveFolder);
                    saveName =  fullfile(saveFolder,'mapROI_results');

                    % save variable
                    tbl = array2table(cat(2,card_time',mean(map_var,1)',max(map_var,[],1)'));
                    tbl.Properties.VariableNames = ["cardiac time(ms)","ROI_average","ROI_max"];
                    writetable(tbl,[saveName '.xlsx'],'Sheet',savePrefix,'WriteMode','overwritesheet');

                    imgData = frame2im(getframe(fig));
                    imwrite(imgData, [saveName '_' savePrefix '.tiff']);

                    % inform of the saving
                    msgbox(['results saved to ' saveName '.xlsx'], 'Saving complete','replace')
                    break;
                elseif choice == 0
                    close(figure(700));
                    disp('ROI analysis cancelled')
                end
            end

        end

        % Button pushed function: MapVolumetricanalysis
        function MapVolumetricanalysisPushed(app,~)
            clc; close(figure(701));
            close(figure(701));
            app.MapPlot.Toolbar.Visible = 'off';

            isPeakWSS = 0;
            if contains(app.MapType.Value,'wall shear stress') && length(app.WSS_matrix) == 1 % only peak time frame calculated
                isPeakWSS = 1;
            end

            t = app.TimeframeSpinner.Value;
            % first save image with current ROI and time frame
            ff = getframe(app.FlowProcessingUIFigure, [476 25 475 690]);
            % Turn screenshot into image
            im = frame2im(ff);
            app.MapPlot.Toolbar.Visible = 'on';
            % save state
            saveFrame = t;

            % loop through all frames using the 3D volume as the ROI, report summary statistics
            if contains(app.MapTime.Value,'resolved')
                if isPeakWSS
                    [~, outVol, idx_currSeg] = viewMap(app);
                    map_var = outVol;
                else
                    for t = 1:app.nframes
                        app.TimeframeSpinner.Value = t;
                        [~, outVol, idx_currSeg] = viewMap(app);
                        if t == 1 % now we know the length of idx_currSeg to do preallocation
                            map_var = zeros(length(idx_currSeg),app.nframes);
                        end
                        map_var(:,t) = outVol(idx_currSeg);
                    end
                end
            else    % outVol has all time frames
                [~, outVol, idx_currSeg] = viewMap(app);
                map_var = zeros(length(idx_currSeg),app.nframes); % now we know the length of idx_currSeg to do preallocation
                for t = 1:app.nframes
                    tmp = reshape(outVol,prod(size(outVol,1:3)),app.nframes);
                    map_var(:,t) = tmp(idx_currSeg,t);
                end
            end
            map_var_integral = sum(mean(map_var,1))*app.timeres/1000; % 1 number. app.timeres/1000 is temporal resolution in seconds
            map_var_peak = max(mean(map_var,1)); % 1 number. peak vorticity along cardiac dimension

            switch app.MapType.Value
                case 'wall shear stress'
                    paramString = 'wall shear stress (Pa)';
                    saveString = 'wss';
                case 'peak velocity'
                    paramString = 'peak velocity (cm/s)';
                    saveString = 'peak_velocity';
                case 'mean velocity'
                    paramString = 'mean velocity (cm/s)';
                    saveString = 'mean_velocity';
                case 'kinetic energy'
                    paramString = 'Max KE (\muJ)';
                    saveString = 'KE';
                case 'energy loss'
                    paramString = 'EL (mW)';
                    saveString = 'EL';
                case 'vorticity'
                    paramString = 'vorticity (rad)';
                    saveString = 'vorticity';
            end

            % make image
            card_time = (0:app.nframes-1)*app.timeres;
            fig = figure(701); clf;
            set(fig,'Name','Volumetric analysis')
            set(fig,'position',[2    42   958   684])
            subplot(121);
            image(im); axis off equal;
            if ~isPeakWSS
                subplot(122);
                plot(card_time,mean(map_var,1),'*-k','linewidth',2)
                hold on;
                plot(card_time,max(map_var,[],1),'square-b','linewidth',2)
                xlabel('cardiac time (ms)'); ylabel(paramString); box off;
                set(gca,'fontsize',16)
                legend('Volume average', 'Volume max')
                hold off;
            end
            set(fig,'color', 'w')
            drawnow;

            app.TimeframeSpinner.Value = saveFrame;

            savePrefix = strcat('volumetric_',saveString);
            saveFolder = fullfile(app.directory,'map_results'); mkdir(saveFolder);
            saveName =  fullfile(saveFolder,'mapVol_results');

            % save variable
            if isPeakWSS
                tbl = array2table(cat(2,card_time(app.time_peak),mean(map_var,1),max(map_var,[],1)));
                tbl.Properties.VariableNames = ["cardiac time(ms)","Vol_average","Vol_max"];
                writetable(tbl,[saveName '.xlsx'],'Sheet',saveString,'WriteMode','overwritesheet');
            else
                tbl = array2table(cat(2,card_time',mean(map_var,1)',max(map_var,[],1)'));
                tbl.Properties.VariableNames = ["cardiac time(ms)","Vol_average","Vol_max"];
                writetable(tbl,[saveName '.xlsx'],'Sheet',saveString,'WriteMode','overwritesheet');
                tbl = array2table(cat(2,map_var_integral,map_var_peak));
                tbl.Properties.VariableNames = ["integral over time", "peak over time"];
                writetable(tbl,[saveName '.xlsx'],'Sheet',savePrefix,'WriteMode','inplace','Range','D1');
            end

            % grab and save image
            imgData = frame2im(getframe(fig));
            imwrite(imgData, [saveName '_' savePrefix '.tiff']);

            % inform of the saving
            msgbox(['results saved to ' saveName '.xlsx'], 'Saving complete','replace')

            app.TimeframeSpinner.Value = saveFrame;
            viewMap(app);
        end

        % Button pushed function: Axial
        function AxialButtonPushed(app, ~)
            switch app.ori.label
                case 'axial'
                    % this was an axial scan, reset rotation
                    app.rotAngles2 = [0 0 0];
                case 'sagittal'
                    app.rotAngles2 = [90 0 0];
                case 'coronal'
                    app.rotAngles2 = [90 0 0];
            end
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: Sagittal
        function SagittalButtonPushed(app, ~)
            switch app.ori.label
                case 'axial'
                    app.rotAngles2 = [0 90 0];
                case 'sagittal'
                    % this was an sagital scan, reset rotation
                    app.rotAngles2 = [0 0 0];
                case 'coronal'
                    app.rotAngles2 = [0 90 0];
            end
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: Coronal
        function CoronalButtonPushed(app, ~)
            switch app.ori.label
                case 'axial'
                    app.rotAngles2 = [90 0 0];
                case 'sagittal'
                    app.rotAngles2 = [0 90 0];
                case 'coronal'
                    % this was an coronal scan, reset rotation
                    app.rotAngles2 = [0 0 0];
            end
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: ResetRotation_2
        function ResetRotation_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [0 0 0];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateUp_2
        function RotateUp_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1)-10 app.rotAngles2(2) app.rotAngles2(3)];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateDown_2
        function RotateDown_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1)+10 app.rotAngles2(2) app.rotAngles2(3)];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateRight_2
        function RotateRight_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2)-10 app.rotAngles2(3)];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateLeft_2
        function RotateLeft_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2)+10 app.rotAngles2(3)];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateIn_2
        function RotateIn_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2) app.rotAngles2(3)+10];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: RotateOut_2
        function RotateOut_2ButtonPushed(app, ~)
            % update rotate angles
            app.rotAngles2 = [app.rotAngles2(1) app.rotAngles2(2) app.rotAngles2(3)-10];
            updateVisualization(app);
            viewMap(app);
        end

        % Button pushed function: VelocityUnwrapping
        function VelocityUnwrappingButtonPushed(app, ~)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
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
                if app.isSegmentationLoaded
                    if app.isTimeResolvedSeg
                        Vmag = app.aorta_seg.*squeeze(sqrt(sum(app.v.^2,4)));
                        idx = find(mean(app.aorta_seg,4));
                    else
                        currSeg = zeros(size(app.aorta_seg,1:3));
                        % only use segmentations that were selected in first tab
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                            end
                        end
                        Vmag = repmat(currSeg,[1 1 1 app.nframes]).*squeeze(sqrt(sum(app.v.^2,4)));
                        idx = find(sum(currSeg,4));
                    end
                    for t = 1:app.nframes
                        tmp = Vmag(:,:,:,t);
                        mean_velo(t) = mean(tmp(idx));
                    end
                    [~,app.time_peak] = find(mean_velo==max(mean_velo));
                end
                app.PeaksystoleEditField.Value = num2str(app.time_peak);
                app.TimeframeSpinner_3.Value = app.time_peak;
            else
                app.TimeframeSpinner_3.Value = app.TimeframeSpinner.Value;
            end

            % if we have been on this page before and already have a slice,
            app.SliceSpinner.Value = round(size(app.angio,3)/2);

            plotVelocities(app);
        end

        % Button pushed function: DFWButtonPushed
        function DFWButtonPushed(app, ~)
            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
                app.isRawDataCropped = 1;

                % disable crop buttons
                app.CropButton.Enable = 'off';
                app.CropButton_2.Enable = 'off';
                app.CropButton_3.Enable = 'off';
            end

            h = waitbar(0, sprintf('Performing divergence free correction...'));
            for t = 1:app.nframes
                % original noisy data
                vxN = double(app.v(:,:,:,1,t));
                vyN = double(app.v(:,:,:,2,t));
                vzN = double(app.v(:,:,:,3,t));

                if app.isSegmentationLoaded
                    if app.isTimeResolvedSeg
                        currSeg = app.aorta_seg(:,:,:,t);
                    else
                        currSeg = zeros(size(app.aorta_seg,1:3));
                        % only use segmentations that were selected in first tab
                        for ii = 1:size(app.aorta_seg,4)
                            if eval(sprintf('app.mask%i.Value==1',ii))
                                currSeg(find(app.aorta_seg(:,:,:,ii))) = 1;
                            end
                        end
                    end
                else
                    currSeg = app.segment;
                end
                currSeg = double(currSeg);

                vxN = vxN.*currSeg;
                vyN = vyN.*currSeg;
                vzN = vzN.*currSeg;

                % DivFree Wavelet with SureShrink, MAD and random cycle spinning
                % To remove the blocking artifacts, we do partial cycle spinning
                % Here we do 2^3=8 random shifts
                spins = 2;              % Number of cycle spinning per dimension
                isRandShift = 1;        % Use random shift
                minSize = 8*ones(1,3);  % Smallest wavelet level size
                %             minSize = 5*ones(1,3); % Smallest wavelet level size, fetal

                % Denoise
                [vxDFWsms,vyDFWsms,vzDFWsms] = dfwavelet_thresh_SURE_MAD_spin(vxN,vyN,vzN,minSize,app.pixdim,spins,isRandShift);

                app.v(:,:,:,1,t) = single(vxDFWsms);
                app.v(:,:,:,2,t) = single(vyDFWsms);
                app.v(:,:,:,3,t) = single(vzDFWsms);

                if exist('h')
                    waitbar (t/app.nframes, h)
                end
            end
            if exist('h')
                close(h);
            end
            app.DFW.Enable = 'off';
        end

        % Value changed function: SliceSpinner
        function SliceSpinnerValueChanged(app, ~)
            plotVelocities(app);
        end

        % Value changed function: TimeframeSpinner_3
        function TimeframeSpinner_3ValueChanged(app, ~)
            plotVelocities(app);
        end

        % Button pushed function: LaplaceUnwrap
        function LaplaceUnwrapButtonPushed(app, ~)
            disp('Performing 4D velocity unwrapping...')

            % if raw data is not yet cropped, do it now!
            if ~app.isRawDataCropped
                app = cropRawData(app);
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
        function Unwrap_automaticButtonPushed(app, ~)
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

        % Value changed function: flipvx
        function flipvxValueChanged(app, ~)
            app.v(:,:,:,1,:) = -app.v(:,:,:,1,:);
            updateVisualization(app);
        end

        % Value changed function: flipvy
        function flipvyValueChanged(app, ~)
            app.v(:,:,:,2,:) = -app.v(:,:,:,2,:);
            updateVisualization(app);
        end

        % Value changed function: flipvz
        function flipvzValueChanged(app, ~)
            app.v(:,:,:,3,:) = -app.v(:,:,:,3,:);
            updateVisualization(app);
        end

        % Key press function: FlowProcessingUIFigure
        function FlowProcessingUIFigureKeyPress(app, event)
            key = event.Key;
            % check the tab we're in first
            switch app.TabGroup.SelectedTab.Title
                case 'Velocity Unwrapping'
                    switch key
                        case 'rightarrow'
                            value = app.TimeframeSpinner_3.Value + 1;
                            if value > app.TimeframeSpinner_3.Limits(2)
                                value = 1;
                            end
                            app.TimeframeSpinner_3.Value = value;
                        case 'leftarrow'
                            value = app.TimeframeSpinner_3.Value - 1;
                            if value < 1
                                value = app.TimeframeSpinner_3.Limits(2);
                            end
                            app.TimeframeSpinner_3.Value = value;
                        case 'uparrow'
                            value = app.SliceSpinner.Value + 1;
                            if value > app.SliceSpinner.Limits(2)
                                value = 1;
                            end
                            app.SliceSpinner.Value = value;
                        case 'downarrow'
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
                        case 'q'
                            RotateIn_2ButtonPushed(app);
                        case 'e'
                            RotateOut_2ButtonPushed(app);
                        case 'r'
                            ResetRotation_2ButtonPushed(app);
                        case 'rightarrow'
                            value = app.TimeframeSpinner.Value + 1;
                            if value > app.TimeframeSpinner.Limits(2)
                                value = 1;
                            end
                            app.TimeframeSpinner.Value = value;
                            TimeframeSpinnerValueChanged(app);
                        case 'leftarrow'
                            value = app.TimeframeSpinner.Value - 1;
                            if value < 1
                                value = app.TimeframeSpinner.Limits(2);
                            end
                            app.TimeframeSpinner.Value = value;
                            TimeframeSpinnerValueChanged(app);
                    end
                    if strncmp(app.VisOptionsDropDown.Value,'slice-wise',10)
                        switch key
                            case 'uparrow'
                                value = app.SliceSpinner_2.Value + 1;
                                if value > app.SliceSpinner_2.Limits(2)
                                    value = 1;
                                end
                                app.SliceSpinner_2.Value = value;
                                SliceSpinner_2ValueChanged(app);
                            case 'downarrow'
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
        function InterpolateDataButtonPushed(app, ~)
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
            app.segment = imfill(app.segment,18,'holes'); % Fill in holes created by slow flow on the inside of vessels
            app.segment = single(app.segment);

            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
        end

        % Value changed function: VisOptionsDropDown
        function VisTypeDropDownValueChanged(app, ~)
            value = app.VisTypeDropDown.Value;
            switch value
                case 'Vectors'
                    app.VisOptionsApp.cutoffvaluesLabel.Text = 'vector scale';
                    app.VisOptionsApp.toXEditFieldLabel.Position = [73 180+162 25 22];
                    app.VisOptionsApp.toXEditFieldLabel.Text = 'to';
                    app.VisOptionsApp.maxQuiverEditField.Enable = 'on';
                    app.VisOptionsApp.maxQuiverEditField.Visible = 'on';
                case 'Streamlines'
                    app.VisOptionsApp.cutoffvaluesLabel.Text = 'min velocity';
                    app.VisOptionsApp.toXEditFieldLabel.Position = [73 180+162 40 22];
                    app.VisOptionsApp.toXEditFieldLabel.Text = 'cm/s';
                    app.VisOptionsApp.maxQuiverEditField.Enable = 'off';
                    app.VisOptionsApp.maxQuiverEditField.Visible = 'off';
            end
            updateVisualization(app);
            viewMap(app);
        end

        % Value changed function: VisOptionsDropDown
        function VisOptionsDropDownValueChanged(app, ~)
            value = app.VisOptionsDropDown.Value;
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

                    app.MapVolumetricanalysis.Enable = 'off';

                    app.VisOptionsApp.projectionDropDown.Enable = 'off';
                    app.VisOptionsApp.projectionDropDown_Label.Enable = 'off';
                    app.VisOptionsApp.VisPts_Label.Visible = 'off';
                    app.VisOptionsApp.VisPts_Label.Enable = 'off';
                    app.VisOptionsApp.VisPts.Visible = 'off';
                    app.VisOptionsApp.VisPts.Enable = 'off';
                    app.VisTypeDropDown.Value = 'Vectors';
                case 'segmentation'
                    app.SliceSpinner_2Label.Visible = 'off';
                    app.SliceSpinner_2Label.Enable = 'off';
                    app.SliceSpinner_2.Visible = 'off';
                    app.SliceSpinner_2.Enable = 'off';

                    app.MapVolumetricanalysis.Enable = 'on';

                    app.VisOptionsApp.projectionDropDown.Enable = 'on';
                    app.VisOptionsApp.projectionDropDown_Label.Enable = 'on';
                    app.VisOptionsApp.VisPts_Label.Visible = 'off';
                    app.VisOptionsApp.VisPts_Label.Enable = 'off';
                    app.VisOptionsApp.VisPts.Visible = 'off';
                    app.VisOptionsApp.VisPts.Enable = 'off';
                    app.VisTypeDropDown.Items = {'Vectors','Streamlines'};
                case 'centerline contours'
                    app.SliceSpinner_2Label.Visible = 'off';
                    app.SliceSpinner_2Label.Enable = 'off';
                    app.SliceSpinner_2.Visible = 'off';
                    app.SliceSpinner_2.Enable = 'off';

                    app.MapVolumetricanalysis.Enable = 'on';

                    app.VisOptionsApp.projectionDropDown.Enable = 'on';
                    app.VisOptionsApp.projectionDropDown_Label.Enable = 'on';
                    app.VisOptionsApp.VisPts_Label.Visible = 'on';
                    app.VisOptionsApp.VisPts_Label.Enable = 'on';
                    app.VisOptionsApp.VisPts.Visible = 'on';
                    app.VisOptionsApp.VisPts.Enable = 'on';
                    app.VisTypeDropDown.Items = {'Vectors','Streamlines'};
            end
            updateVisualization(app);
            viewMap(app);
        end

        % Value changed function: ParameterDropDown
        function PWVTypeValueChanged(app, ~)
            if any(cellfun(@(s) ~isempty(strfind(s, app.PWVType.Value)), {'Wavelet'; 'Cross-correlation'; 'Jarvis XCorr'}))
                app.findBestFit_checkbox.Enable = 'on';
            else
                app.findBestFit_checkbox.Value = 0;
                app.findBestFit_checkbox.Enable = 'off';
            end
        end

        % Button pushed function: ManualsegmentationupdateButton
        function ManualsegmentationupdateButtonPushed(app, ~)
            if app.isSegmentationLoaded
                % grab current segmentations, angio and put into imtool3d
                if app.isTimeResolvedSeg
                    currSeg = app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value);
                else
                    currSeg = app.aorta_seg;
                    keepSegs = zeros(size(currSeg,4),1);
                    % only edit currently selected segmentations
                    for ii = 1:size(currSeg,4)
                        if eval(sprintf('app.mask%i.Value==1',ii))
                            keepSegs(ii) = 1;
                        end
                    end
                    currSeg = currSeg(:,:,:,find(keepSegs));
                end
            else
                currSeg = app.segment;
                keepSegs = 1;
            end

            clear tool
            tool = imtool3D_3planes(app.angio,currSeg);
            tool.setAspectRatio(app.pixdim); % set voxel size
            h = tool.getTool;
            h(1).setOrient(0); h(2).setOrient(0);  h(3).setOrient(0);

            waitfor(tool.getHandles.fig);
            h = tool.getTool;
            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value) = h.getMaskOutput(1);
                else
                    ctMask = 0;
                    for ii = 1:length(keepSegs)
                        if keepSegs(ii)
                            ctMask = ctMask+1;
                            app.aorta_seg(:,:,:,ii) = h.getMaskOutput(ctMask);
                        end
                    end
                end
            else
                app.segment = h.getMaskOutput(1);
            end

            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            updateMIPs(app);
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

            % Create LoadDataButton
            app.LoadDataButton = uibutton(app.LoadDataPanel, 'push');
            app.LoadDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadDataButtonPushed, true);
            app.LoadDataButton.FontName = 'SansSerif';
            app.LoadDataButton.FontSize = 16;
            app.LoadDataButton.Tooltip = {'load 4D flow reconstructed data (parrec or mrStruct)'};
            app.LoadDataButton.Position = [210 180 198 28];
            app.LoadDataButton.Text = 'Load 4D flow Data';

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

            % Create CropInfoTable
            app.CropInfoTable = uitable(app.CropPanel);
            app.CropInfoTable.ColumnName = {'cropped values'};
            app.CropInfoTable.RowName = {'x';'y';'z'};
            app.CropInfoTable.ColumnSortable = false;
            app.CropInfoTable.ColumnEditable = false;
            app.CropInfoTable.FontName = 'SansSerif';
            app.CropInfoTable.FontSize = 12;
            app.CropInfoTable.Position = [45 6 160 100];

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

            % Create ManualsegmentationupdateButton
            app.ManualsegmentationupdateButton = uibutton(app.DVisualizationPanel, 'push');
            app.ManualsegmentationupdateButton.ButtonPushedFcn = createCallbackFcn(app, @ManualsegmentationupdateButtonPushed, true);
            app.ManualsegmentationupdateButton.FontName = 'SansSerif';
            app.ManualsegmentationupdateButton.FontSize = 16;
            app.ManualsegmentationupdateButton.Tooltip = {'update loaded segmenation with imtool3d'};
            app.ManualsegmentationupdateButton.Position = [198 28 224 28];
            app.ManualsegmentationupdateButton.Text = 'Manual segmentation update';
            app.ManualsegmentationupdateButton.Visible = 'off';

            % Create MaskLabel
            app.MaskLabel = uilabel(app.DVisualizationPanel);
            app.MaskLabel.HorizontalAlignment = 'right';
            app.MaskLabel.FontName = 'SansSerif';
            app.MaskLabel.FontSize = 14;
            app.MaskLabel.Visible = 'off';
            app.MaskLabel.Tooltip = {'the number of standard deviations outside of the background signal'};
            app.MaskLabel.Position = [129 -1 59 22];
            app.MaskLabel.Text = 'Mask: ';

            % Create mask1
            app.mask1 = uicheckbox(app.DVisualizationPanel);
            app.mask1.ValueChangedFcn = createCallbackFcn(app, @mask1ValueChanged, true);
            app.mask1.Visible = 'off';
            app.mask1.Text = '1';
            app.mask1.FontName = 'SansSerif';
            app.mask1.FontSize = 14;
            app.mask1.Position = [191 -1 30 22];

            % Create mask2
            app.mask2 = uicheckbox(app.DVisualizationPanel);
            app.mask2.ValueChangedFcn = createCallbackFcn(app, @mask2ValueChanged, true);
            app.mask2.Visible = 'off';
            app.mask2.Text = '2';
            app.mask2.FontName = 'SansSerif';
            app.mask2.FontSize = 14;
            app.mask2.Position = [218 -1 30 22];

            % Create mask3
            app.mask3 = uicheckbox(app.DVisualizationPanel);
            app.mask3.ValueChangedFcn = createCallbackFcn(app, @mask3ValueChanged, true);
            app.mask3.Visible = 'off';
            app.mask3.Text = '3';
            app.mask3.FontName = 'SansSerif';
            app.mask3.FontSize = 14;
            app.mask3.Position = [245 -1 30 22];

            % Create mask4
            app.mask4 = uicheckbox(app.DVisualizationPanel);
            app.mask4.ValueChangedFcn = createCallbackFcn(app, @mask4ValueChanged, true);
            app.mask4.Visible = 'off';
            app.mask4.Text = '4';
            app.mask4.FontName = 'SansSerif';
            app.mask4.FontSize = 14;
            app.mask4.Position = [272 -1 30 22];

            % Create mask5
            app.mask5 = uicheckbox(app.DVisualizationPanel);
            app.mask5.ValueChangedFcn = createCallbackFcn(app, @mask5ValueChanged, true);
            app.mask5.Visible = 'off';
            app.mask5.Text = '5';
            app.mask5.FontName = 'SansSerif';
            app.mask5.FontSize = 14;
            app.mask5.Position = [299 -1 30 22];

            % Create mask6
            app.mask6 = uicheckbox(app.DVisualizationPanel);
            app.mask6.ValueChangedFcn = createCallbackFcn(app, @mask6ValueChanged, true);
            app.mask6.Visible = 'off';
            app.mask6.Text = '6';
            app.mask6.FontName = 'SansSerif';
            app.mask6.FontSize = 14;
            app.mask6.Position = [327 -1 30 22];

            % Create mask7
            app.mask7 = uicheckbox(app.DVisualizationPanel);
            app.mask7.ValueChangedFcn = createCallbackFcn(app, @mask7ValueChanged, true);
            app.mask7.Visible = 'off';
            app.mask7.Text = '7';
            app.mask7.FontName = 'SansSerif';
            app.mask7.FontSize = 14;
            app.mask7.Position = [355 -1 30 22];

            % Create mask8
            app.mask8 = uicheckbox(app.DVisualizationPanel);
            app.mask8.ValueChangedFcn = createCallbackFcn(app, @mask8ValueChanged, true);
            app.mask8.Visible = 'off';
            app.mask8.Text = '8';
            app.mask8.FontName = 'SansSerif';
            app.mask8.FontSize = 14;
            app.mask8.Position = [383 -1 30 22];

            % Create mask9
            app.mask9 = uicheckbox(app.DVisualizationPanel);
            app.mask9.ValueChangedFcn = createCallbackFcn(app, @mask9ValueChanged, true);
            app.mask9.Visible = 'off';
            app.mask9.Text = '9';
            app.mask9.FontName = 'SansSerif';
            app.mask9.FontSize = 14;
            app.mask9.Position = [411 -1 30 22];

            % Create mask10
            app.mask10 = uicheckbox(app.DVisualizationPanel);
            app.mask10.ValueChangedFcn = createCallbackFcn(app, @mask10ValueChanged, true);
            app.mask10.Visible = 'off';
            app.mask10.Text = '10';
            app.mask10.FontName = 'SansSerif';
            app.mask10.FontSize = 14;
            app.mask10.Position = [439 -1 38 22];

            % Create ProcessingPanel
            app.ProcessingPanel = uipanel(app.LoadingandPreprocessingTab);
            app.ProcessingPanel.BorderType = 'none';
            app.ProcessingPanel.TitlePosition = 'centertop';
            app.ProcessingPanel.Title = 'Processing';
            app.ProcessingPanel.BackgroundColor = [1 1 1];
            app.ProcessingPanel.FontName = 'SansSerif';
            app.ProcessingPanel.FontWeight = 'bold';
            app.ProcessingPanel.FontSize = 16;
            app.ProcessingPanel.Position = [1 1 617 60];

            % Create PulseWaveVelocityPushButton
            app.PulseWaveVelocityPushButton = uibutton(app.ProcessingPanel, 'push');
            app.PulseWaveVelocityPushButton.ButtonPushedFcn = createCallbackFcn(app, @PulseWaveVelocityPushButtonButtonPushed, true);
            app.PulseWaveVelocityPushButton.IconAlignment = 'center';
            app.PulseWaveVelocityPushButton.FontName = 'SansSerif';
            app.PulseWaveVelocityPushButton.FontSize = 16;
            app.PulseWaveVelocityPushButton.Tooltip = {'calculate segmentation centerline for flow/PWV measurement'};
            app.PulseWaveVelocityPushButton.Position = [355 6 187 28];
            app.PulseWaveVelocityPushButton.Text = 'Pulse Wave Velocity';

            % Create MapsPushButton
            app.MapsPushButton = uibutton(app.ProcessingPanel, 'push');
            app.MapsPushButton.ButtonPushedFcn = createCallbackFcn(app, @MapsPushButtonPushed, true);
            app.MapsPushButton.FontName = 'SansSerif';
            app.MapsPushButton.FontSize = 16;
            app.MapsPushButton.Tooltip = {'calculate and display mapped parameters'};
            app.MapsPushButton.Position = [69 6 187 28];
            app.MapsPushButton.Text = 'Maps';

            % Create CorrectionsPanel
            app.CorrectionsPanel = uipanel(app.LoadingandPreprocessingTab);
            app.CorrectionsPanel.TitlePosition = 'centertop';
            app.CorrectionsPanel.Title = 'Corrections';
            app.CorrectionsPanel.BackgroundColor = [1 1 1];
            app.CorrectionsPanel.FontName = 'SansSerif';
            app.CorrectionsPanel.FontWeight = 'bold';
            app.CorrectionsPanel.FontSize = 16;
            app.CorrectionsPanel.Position = [1 61 617 60];

            % Create VelocityUnwrapping
            app.VelocityUnwrapping = uibutton(app.CorrectionsPanel, 'push');
            app.VelocityUnwrapping.ButtonPushedFcn = createCallbackFcn(app, @VelocityUnwrappingButtonPushed, true);
            app.VelocityUnwrapping.FontName = 'SansSerif';
            app.VelocityUnwrapping.FontSize = 16;
            app.VelocityUnwrapping.Tooltip = {'open velocity unwrapping tab'};
            app.VelocityUnwrapping.Position = [69 4 187 28];
            app.VelocityUnwrapping.Text = 'Velocity Unwrapping';

            % Create DFW
            app.DFW = uibutton(app.CorrectionsPanel, 'push');
            app.DFW.ButtonPushedFcn = createCallbackFcn(app, @DFWButtonPushed, true);
            app.DFW.FontName = 'SansSerif';
            app.DFW.FontSize = 16;
            app.DFW.Tooltip = {'perform divergence free wavelet correction'};
            app.DFW.Position = [355 4 187 28];
            app.DFW.Text = 'Divergence Free';

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
            app.TimeframeSpinner_3.Tooltip = {'shortcut ''←'' or ''→'''};
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
            app.SliceSpinner.Tooltip = {'shortcut ''↑'' or ''↓'''};
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

            % Create VisualizationGroup
            app.VisualizationGroup = uipanel(app.Maps);
            app.VisualizationGroup.BorderType = 'none';
            app.VisualizationGroup.TitlePosition = 'centertop';
            app.VisualizationGroup.Title = '';
            app.VisualizationGroup.BackgroundColor = [1 1 1];
            app.VisualizationGroup.FontName = 'SansSerif';
            app.VisualizationGroup.FontWeight = 'bold';
            app.VisualizationGroup.FontSize = 16;
            app.VisualizationGroup.Position = [1 18 475 702];

            % Create VisTypeDropDown
            app.VisTypeDropDown = uidropdown(app.Maps);
            app.VisTypeDropDown.Items = {'Vectors', 'Streamlines'};
            app.VisTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @VisTypeDropDownValueChanged, true);
            app.VisTypeDropDown.FontName = 'SansSerif';
            app.VisTypeDropDown.FontWeight = 'bold';
            app.VisTypeDropDown.FontSize = 16;
            app.VisTypeDropDown.Position = [150 700 125 28];
            app.VisTypeDropDown.Value = 'Vectors';

            % Create VisualizationPlot
            app.VisualizationPlot = uiaxes(app.VisualizationGroup);
            app.VisualizationPlot.YDir = 'reverse';
            app.VisualizationPlot.ZDir = 'reverse';
            app.VisualizationPlot.XColor = 'none';
            app.VisualizationPlot.XTick = [];
            app.VisualizationPlot.YColor = 'none';
            app.VisualizationPlot.YTick = [];
            app.VisualizationPlot.FontSize = 14;
            app.VisualizationPlot.Position = [1 0 475 669];

            % Create TimeframeSpinnerLabel
            app.TimeframeSpinnerLabel = uilabel(app.Maps);
            app.TimeframeSpinnerLabel.HorizontalAlignment = 'right';
            app.TimeframeSpinnerLabel.FontName = 'SansSerif';
            app.TimeframeSpinnerLabel.FontSize = 12;
            app.TimeframeSpinnerLabel.Enable = 'off';
            app.TimeframeSpinnerLabel.Position = [360 700 66 22];
            app.TimeframeSpinnerLabel.Text = 'Time frame';

            % Create TimeframeSpinner
            app.TimeframeSpinner = uispinner(app.Maps);
            app.TimeframeSpinner.ValueChangedFcn = createCallbackFcn(app, @TimeframeSpinnerValueChanged, true);
            app.TimeframeSpinner.FontName = 'SansSerif';
            app.TimeframeSpinner.FontSize = 12;
            app.TimeframeSpinner.Enable = 'off';
            app.TimeframeSpinner.Tooltip = {'shortcut ''←'' or ''→'''};
            app.TimeframeSpinner.Position = [429 700 50 22];

            % Create SliceSpinner_2Label
            app.SliceSpinner_2Label = uilabel(app.Maps);
            app.SliceSpinner_2Label.HorizontalAlignment = 'right';
            app.SliceSpinner_2Label.FontName = 'SansSerif';
            app.SliceSpinner_2Label.FontSize = 12;
            app.SliceSpinner_2Label.Enable = 'off';
            app.SliceSpinner_2Label.Visible = 'off';
            app.SliceSpinner_2Label.Position = [278 700 32 22];
            app.SliceSpinner_2Label.Text = 'slice';

            % Create SliceSpinner_2
            app.SliceSpinner_2 = uispinner(app.Maps);
            app.SliceSpinner_2.ValueChangedFcn = createCallbackFcn(app, @SliceSpinner_2ValueChanged, true);
            app.SliceSpinner_2.FontName = 'SansSerif';
            app.SliceSpinner_2.FontSize = 12;
            app.SliceSpinner_2.Enable = 'off';
            app.SliceSpinner_2.Visible = 'off';
            app.SliceSpinner_2.Tooltip = {'shortcut ''↑'' or ''↓'''};
            app.SliceSpinner_2.Position = [310 700 50 22];

            % Create VisOptionsDropDown
            app.VisOptionsDropDown = uidropdown(app.Maps);
            app.VisOptionsDropDown.Items = {'segmentation', 'slice-wise'};
            app.VisOptionsDropDown.ValueChangedFcn = createCallbackFcn(app, @VisOptionsDropDownValueChanged, true);
            app.VisOptionsDropDown.FontName = 'SansSerif';
            app.VisOptionsDropDown.Position = [1 700 140 22];
            app.VisOptionsDropDown.Value = 'segmentation';

            % Create PeaksystoleEditFieldLabel
            app.PeaksystoleEditFieldLabel = uilabel(app.Maps);
            app.PeaksystoleEditFieldLabel.HorizontalAlignment = 'right';
            app.PeaksystoleEditFieldLabel.FontName = 'SansSerif';
            app.PeaksystoleEditFieldLabel.Enable = 'off';
            app.PeaksystoleEditFieldLabel.Position = [1056 698 74 22];
            app.PeaksystoleEditFieldLabel.Text = 'peak systole';

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
            app.CalculateMap.FontSize = 15;
            app.CalculateMap.Enable = 'off';
            app.CalculateMap.Tooltip = {'calculate WSS'};
            app.CalculateMap.Position = [1036 654 150 28];
            app.CalculateMap.Text = '(Re)Calculate Map';

            % Create VisOptions
            app.VisOptions = uibutton(app.Maps, 'push');
            app.VisOptions.ButtonPushedFcn = createCallbackFcn(app, @VisOptionsButtonPushed, true);
            app.VisOptions.IconAlignment = 'center';
            app.VisOptions.FontName = 'SansSerif';
            app.VisOptions.FontSize = 15;
            app.VisOptions.Enable = 'off';
            app.VisOptions.Tooltip = {'open dialog for visualization settings'};
            app.VisOptions.Position = [1036 570 150 28];
            app.VisOptions.Text = 'Visualization options';

            % Create SaveAnimation
            app.SaveAnimation = uibutton(app.Maps, 'push');
            app.SaveAnimation.ButtonPushedFcn = createCallbackFcn(app, @SaveAnimationButtonPushed, true);
            app.SaveAnimation.IconAlignment = 'center';
            app.SaveAnimation.FontName = 'SansSerif';
            app.SaveAnimation.FontSize = 15;
            app.SaveAnimation.Enable = 'off';
            app.SaveAnimation.Tooltip = {'save animation of plots over time'};
            app.SaveAnimation.Position = [1036 528 150 28];
            app.SaveAnimation.Text = 'Save animation';

            % Create SaveRotatedAnimation
            app.SaveRotatedAnimation = uibutton(app.Maps, 'push');
            app.SaveRotatedAnimation.ButtonPushedFcn = createCallbackFcn(app, @SaveRotatedAnimationButtonPushed, true);
            app.SaveRotatedAnimation.IconAlignment = 'center';
            app.SaveRotatedAnimation.FontName = 'SansSerif';
            app.SaveRotatedAnimation.FontSize = 13;
            app.SaveRotatedAnimation.Enable = 'off';
            app.SaveRotatedAnimation.Tooltip = {'save animation of plots over time'};
            app.SaveRotatedAnimation.Position = [1036 486 150 28];
            app.SaveRotatedAnimation.Text = 'Save rotated animation';

            % Create MapROIanalysis
            app.MapROIanalysis = uibutton(app.Maps, 'push');
            app.MapROIanalysis.ButtonPushedFcn = createCallbackFcn(app, @MapROIanalysisPushed, true);
            app.MapROIanalysis.IconAlignment = 'center';
            app.MapROIanalysis.FontName = 'SansSerif';
            app.MapROIanalysis.FontSize = 15;
            app.MapROIanalysis.Enable = 'off';
            app.MapROIanalysis.Tooltip = {'draw ROI in map and save results'};
            app.MapROIanalysis.Position = [1036 402 150 28];
            app.MapROIanalysis.Text = 'Map ROI analysis';

            % Create MapVolumetricanalysis
            app.MapVolumetricanalysis = uibutton(app.Maps, 'push');
            app.MapVolumetricanalysis.ButtonPushedFcn = createCallbackFcn(app, @MapVolumetricanalysisPushed, true);
            app.MapVolumetricanalysis.IconAlignment = 'center';
            app.MapVolumetricanalysis.FontName = 'SansSerif';
            app.MapVolumetricanalysis.FontSize = 15;
            app.MapVolumetricanalysis.Enable = 'off';
            app.MapVolumetricanalysis.Tooltip = {'draw ROI in map and save results'};
            app.MapVolumetricanalysis.Position = [1036 360 150 28];
            app.MapVolumetricanalysis.Text = 'Map volume analysis';

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
            app.MapType.Items = {'None', 'wall shear stress', 'peak velocity', 'mean velocity', 'kinetic energy', 'energy loss', 'vorticity'};
            app.MapType.ValueChangedFcn = createCallbackFcn(app, @MapTypeValueChanged, true);
            app.MapType.Tooltip = {'select map to view'};
            app.MapType.FontName = 'ZapfDingbats';
            app.MapType.FontSize = 14;
            app.MapType.Position = [481 700 144 22];
            app.MapType.Value = 'None';

            % Create MapTime
            app.MapTime = uidropdown(app.Maps);
            app.MapTime.Items = {'time-resolved', 'time-averaged', 'peak'};
            app.MapTime.ValueChangedFcn = createCallbackFcn(app, @MapTimeValueChanged, true);
            app.MapTime.Tooltip = {'select to visualize map over time mean/max'};
            app.MapTime.FontName = 'ZapfDingbats';
            app.MapTime.FontSize = 14;
            app.MapTime.Position = [897 700 144 22];
            app.MapTime.Value = 'time-resolved';

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

            % Create PlanewidthmmLabel
            app.PlanewidthmmLabel = uilabel(app.FlowandPulseWaveVelocityTab);
            app.PlanewidthmmLabel.HorizontalAlignment = 'right';
            app.PlanewidthmmLabel.FontName = 'SansSerif';
            app.PlanewidthmmLabel.FontSize = 18;
            app.PlanewidthmmLabel.Position = [875 697 151 22];
            app.PlanewidthmmLabel.Text = 'Plane width (mm): ';

            % Create PlaneWidth
            app.PlaneWidth = uieditfield(app.FlowandPulseWaveVelocityTab, 'text');
            app.PlaneWidth.FontName = 'SansSerif';
            app.PlaneWidth.FontSize = 16;
            app.PlaneWidth.Tooltip = {'Width for flow contour planes'; '(between 5 and 100 mm)'};
            app.PlaneWidth.Position = [1030 697 48 23];
            app.PlaneWidth.Value = '50';

            % Create SplineSpacingSliderLabel
            app.SplineSpacingSliderLabel = uilabel(app.FlowandPulseWaveVelocityTab);
            app.SplineSpacingSliderLabel.HorizontalAlignment = 'right';
            app.SplineSpacingSliderLabel.FontName = 'SansSerif';
            app.SplineSpacingSliderLabel.FontSize = 14;
            app.SplineSpacingSliderLabel.Position = [855 664 175 22];
            app.SplineSpacingSliderLabel.Text = 'Spline fit point spacing (%)';
            app.SplineSpacingSliderLabel.Visible = 'off';

            % Create SplineSpacingSlider
            app.SplineSpacingSlider = uislider(app.FlowandPulseWaveVelocityTab);
            app.SplineSpacingSlider.Limits = [1 50];
            app.SplineSpacingSlider.MajorTicks = [1 10 20 30 40 50];
            app.SplineSpacingSlider.MinorTicks = 5:5:45;
            app.SplineSpacingSlider.FontName = 'SansSerif';
            app.SplineSpacingSlider.FontSize = 16;
            app.SplineSpacingSlider.Tooltip = {'% point spacing for fitting spline to centerline'; '(1-100%)'};
            app.SplineSpacingSlider.Position = [1040 674 155 3];
            app.SplineSpacingSlider.Value = 10;
            app.SplineSpacingSlider.Visible = 'off';

            % Create WaveformsDisplay
            app.WaveformsDisplay = uiaxes(app.FlowandPulseWaveVelocityTab);
            xlabel(app.WaveformsDisplay, 'Cardiac time (ms)')
            ylabel(app.WaveformsDisplay, 'flow (mL/s)')
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
            app.ParameterDropDown.Items = {'total flow', 'peak flow', 'mean velocity', 'peak velocity'};
            app.ParameterDropDown.ValueChangedFcn = createCallbackFcn(app, @ParameterDropDownValueChanged, true);
            app.ParameterDropDown.Enable = 'off';
            app.ParameterDropDown.Visible = 'off';
            app.ParameterDropDown.FontName = 'SansSerif';
            app.ParameterDropDown.FontSize = 14;
            app.ParameterDropDown.Position = [185 37 162 22];
            app.ParameterDropDown.Value = 'total flow';

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
            app.CheckcenterlinecalculateflowButton.Position = [805 590 271 29];
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