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
        FramesToUseLabel                matlab.ui.control.Label
        FramesToUse                     matlab.ui.control.EditField
        CropButton_3                    matlab.ui.control.Button
        CropButton_2                    matlab.ui.control.Button
        CropButton                      matlab.ui.control.Button
        CropInfoTable                   matlab.ui.control.Table
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
        ViewDataButton                  matlab.ui.control.Button
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
        isStreamsChanged                matlab.ui.control.CheckBox
        isPathlinesChanged              matlab.ui.control.CheckBox
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
        ManageWorkspace                 matlab.ui.container.Tab
        ClearAppAndRestartButton        matlab.ui.control.Button
        RestoreAppStateButton           matlab.ui.control.Button
        SaveAppStateButton              matlab.ui.control.Button
    end

    % Properties that need to be accessible by companion apps (e.g. VisOptionsDialog)
    properties (Access = public)
        maskHandles;                % cell(1,10) of mask checkbox handles – set in startupFcn

        % Cached numeric vis parameters – written by VisOptionsDialog on every field change
        % so that FlowProcessing.m never calls str2double at render time.
        visParams = struct( ...
            'minVel',    0, ...
            'maxVel',    150, ...
            'minQuiver', 0, ...
            'maxQuiver', 100, ...
            'minMap',    0, ...
            'maxMap',    150);
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
        tangent_V;                  % in-plane perpendicular vector (V2) from params_timeResolved
        vesselTangent = [];         % true vessel tangent = plane normal, from fitCenterlineSpline
        contourCoords = struct();   % x_full/y_full/z_full plane coords from params_timeResolved

        h1;                         % handle for first unwrap imagesc
        h2;                         % handle for second unwrap imagesc
        h3;                         % handle for third unwrap imagesc
        cbar_unwrap;                % handle for unwrap colorbar

        hpatch1;                    % initial 3D patch for 3D vis
        patchMasks = cell(1,10);    % segmentation 3D patch handles (replaces patchMask1..10)

        rotAngles;                  % rotation angles used for viewing, can be changed by viewer

        % --- isosurface geometry caches (dirty-flag pattern) ------------
        segIsoFV        = [];       % cached isosurface for app.segment (main seg)
        segIsoFV_dirty  = true;     % set true whenever app.segment changes
        segIsoFV_coords = [];       % cached [xx,yy,zz] meshgrid struct for main seg
        visSegIsoFV       = [];     % cached isosurface for currSeg (vis tab)
        visSegIsoFV_dirty = true;

        isAnimating = false;    	% true during SaveRotatedAnimation – suppresses axis tight

        usedBranches;               % a list that is built up to determine which branches to perform flow measurements on
        FullBranchDistance;         % the full distance vector (in mm)

        vectorPatch;                % the patch used and updated for vectors
        streamsOut = [];            % struct holding calculated streamlines
        streamPatch;                % the patch used and updated for streamlines
        pathlinesOut = [];          % struct holding calculated pathlines (dataStore + time_steps)
        pathlinePatch;              % surface handles for pathline rendering (nParticles × 1)
        pathlineInterp = [];        % cached 4D griddedInterpolant structs (expensive – reuse)
        sliceImg;                   % handle for background slice in 'slicewise'
        vis3Dsurface;               % the patch used for visualization plot
        is3DChanged = 1;            % to check if 3D segment has changed
        vis3DSegsurface;            % the segmentation patch used for visualization plot
        is3DSegChanged = 1;         % to check if loaded 3D segmentation has changed
        cbar_vis;                   % handle for visualization colorbar

        R2;                         % the r-squared value of the fit for cross-correlation or wavelet PWV measurement
        time_peak;                  % the determined peak systolic phase
        WSS_matrix;                 % calculated WSS matrix
        F_matrix;                   % faces for 3D vis
        V_matrix;                   % vertices for 3D vis
        rotAngles2;                 % rotation angles used for viewing maps, can be changed by viewer
        isWSScalculated = 0;        % is WSS calculated

        % Orientation axis widget handles (cell arrays, one per 3D axes)
        % Each cell: {hX, hY, hZ, tX, tY, tZ} — three lines + three text labels
        oriAxis_View3D    = {};
        oriAxis_VisPlt    = {};
    end

    methods (Access = public)

        % -----------------------------------------------------------------
        % ORIENTATION LABEL HELPER
        % Place anatomical direction labels at the ends of each 3D axis.
        %
        % Native-orientation display convention (view([0 0 -1])):
        %   MATLAB plot-X = array dim2 (columns) = ori.vylabel direction
        %   MATLAB plot-Y = array dim1 (rows)    = ori.vxlabel direction
        %   MATLAB plot-Z = array dim3 (slices)  = ori.vzlabel direction
        %
        % The labels are derived directly from the loader-supplied ori struct
        % so they are correct for every scanner type and orientation without
        % any coordinate transformation.
        % -----------------------------------------------------------------
        % -----------------------------------------------------------------
        % ORIENTATION AXIS WIDGET
        % Draws three orthogonal labelled axes in the upper-left corner of
        % the given 3D axes. Returns handles so rotate() can be called on
        % them in lock-step with the main data patches.
        %
        % Placement: the widget origin is fixed at the upper-left corner of
        % the current data bounding box (in data coordinates).  The arms
        % are scaled to ~15% of the smallest FOV dimension.
        %
        % Axis → anatomical direction mapping for the native view([0 0 -1]):
        %   plot-X = array dim2 (cols)   = ori.vylabel
        %   plot-Y = array dim1 (rows)   = ori.vxlabel
        %   plot-Z = array dim3 (slices) = ori.vzlabel
        % -----------------------------------------------------------------
        function handles = drawOriAxis(app, ax)
            % drawOriAxis  Create (or recreate) the orientation axis widget.
            % Each arm shows a single letter at its tip: the first letter of
            % the axis label, which corresponds to the positive index direction
            % (e.g. 'F-H' → arm points toward Foot, label = 'F').

            delete(findobj(ax, 'Tag', 'ori_axis_widget'));

            if ~isfield(app.ori, 'vxlabel')
                handles = struct(); return;
            end

            xl = xlim(ax); yl = ylim(ax); zl = zlim(ax);
            armLen = 0.1 * min([diff(xl), diff(yl), diff(zl)]);
            if armLen <= 0, armLen = 10; end

            % Widget origin: upper-left corner
            ox = xl(1) + diff(xl)*0.05;     if ox<1; ox = 1; end
            oy = yl(1) - diff(yl)*0.05;     if oy<1; oy = 1; end
            oz = zl(1);                     if oz<1; oz = 1; end

            % Tip letter = last character = direction of increasing array index
            % Convention: 'F-H' means low-index=Foot, high-index=Head → tip='H'
            tipX = app.ori.vylabel(end);   % dim2 (cols, plot-X)
            tipY = app.ori.vxlabel(end);   % dim1 (rows, plot-Y)
            tipZ = app.ori.vzlabel(end);   % dim3 (slices, plot-Z)

            hold(ax, 'on');

            hX = line(ax, [ox, ox+armLen], [oy, oy], [oz, oz], ...
                'Color',[0.9 0.2 0.2], 'LineWidth',2, 'Tag','ori_axis_widget');
            tX = text(ax, ox+armLen*1.3, oy, oz, tipX, ...
                'Color',[0.9 0.2 0.2], 'FontSize',11, 'FontWeight','bold', ...
                'HorizontalAlignment','center','VerticalAlignment','middle', ...
                'Tag','ori_axis_widget', 'PickableParts','none');

            hY = line(ax, [ox, ox], [oy, oy+armLen], [oz, oz], ...
                'Color',[0.2 0.75 0.2], 'LineWidth',2, 'Tag','ori_axis_widget');
            tY = text(ax, ox, oy+armLen*1.3, oz, tipY, ...
                'Color',[0.2 0.75 0.2], 'FontSize',11, 'FontWeight','bold', ...
                'HorizontalAlignment','center','VerticalAlignment','middle', ...
                'Tag','ori_axis_widget', 'PickableParts','none');

            hZ = line(ax, [ox, ox], [oy, oy], [oz, oz+armLen], ...
                'Color',[0.2 0.4 0.9], 'LineWidth',2, 'Tag','ori_axis_widget');
            tZ = text(ax, ox, oy, oz+armLen*1.3, tipZ, ...
                'Color',[0.2 0.4 0.9], 'FontSize',11, 'FontWeight','bold', ...
                'HorizontalAlignment','center','VerticalAlignment','middle', ...
                'Tag','ori_axis_widget', 'PickableParts','none');

            hold(ax, 'off');

            handles = struct('hX',hX,'hY',hY,'hZ',hZ,'tX',tX,'tY',tY,'tZ',tZ);
        end

        function rotateOriAxis(~, handles, axis_vec, angle_deg)
            % rotateOriAxis  Apply the same rotate() call to the widget that was
            % applied to the data patches, so the widget stays in sync.
            if isempty(handles) || ~isfield(handles,'hX'), return; end
            objs = [handles.hX, handles.hY, handles.hZ, ...
                handles.tX, handles.tY, handles.tZ];
            valid = objs(isvalid(objs));
            if ~isempty(valid)
                rotate(valid, axis_vec, angle_deg);
            end
        end

        % -----------------------------------------------------------------
        % HELPER: return the active combined segmentation for a given frame.
        % Replaces the 12+ duplicated currSeg construction blocks.
        % -----------------------------------------------------------------
        function currSeg = getCurrentSeg(app, t)
            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    currSeg = logical(app.aorta_seg(:,:,:,t));
                else
                    activeIdx = app.getActiveMaskIndices();
                    if isempty(activeIdx)
                        currSeg = false(size(app.aorta_seg,1), size(app.aorta_seg,2), size(app.aorta_seg,3));
                    else
                        currSeg = any(app.aorta_seg(:,:,:,activeIdx), 4);
                    end
                end
            else
                currSeg = logical(app.segment);
            end
        end

        % -----------------------------------------------------------------
        % HELPER: return indices of currently checked mask checkboxes.
        % -----------------------------------------------------------------
        function idx = getActiveMaskIndices(app)
            if isempty(app.maskHandles)
                idx = [];
                return
            end
            idx = find(cellfun(@(h) h.Value, app.maskHandles));
        end

        function View3DSegmentation(app)

            cla(app.View3D);

            c = prism(size(app.aorta_seg,4));
            if (app.isSegmentationLoaded)
                if app.isTimeResolvedSeg
                    if app.maskHandles{1}.Value
                        aa = smooth3(app.aorta_seg(:,:,:,app.SegTimeframeSpinner.Value));
                        hold(app.View3D,'on')
                        app.patchMasks{1} = patch(app.View3D, isosurface(aa,.5), ...
                            'FaceColor',c(1,:),'EdgeColor','none','FaceAlpha',0.5);
                        reducepatch(app.patchMasks{1}, 0.6);
                    end
                else
                    for ii = 1:size(app.aorta_seg, 4)
                        if app.maskHandles{ii}.Value
                            aa = smooth3(app.aorta_seg(:,:,:,ii));
                            hold(app.View3D,'on')
                            app.patchMasks{ii} = patch(app.View3D, isosurface(aa,.5), ...
                                'FaceColor',c(ii,:),'EdgeColor','none','FaceAlpha',0.5);
                            reducepatch(app.patchMasks{ii}, 0.6);
                        end
                    end
                end
            else
                ss = smooth3(app.segment);
                app.hpatch1 = patch(app.View3D, isosurface(ss, 0.5), ...
                    'FaceColor','red','EdgeColor','none','FaceAlpha',0.35);
                reducepatch(app.hpatch1 ,0.6);
            end
            hold(app.View3D,'off');

            % Make it all look good
            camlight(app.View3D);
            lighting(app.View3D,'gouraud');
            lightangle(app.View3D,0,0);
            view(app.View3D, [0 0 -1]);
            % DataAspectRatio: [X Y Z] = [col=dim2, row=dim1, slice=dim3]
            daspect(app.View3D, [app.pixdim(2), app.pixdim(1), app.pixdim(3)]);
            axis(app.View3D,'off');

            % Compute volume extents in physical mm (plot space is voxel indices
            % but daspect scales them, so limits must still be in voxel units).
            % Use the largest half-extent across all three axes so nothing clips.
            nRow = size(app.segment,1);
            nCol = size(app.segment,2);
            nSli = size(app.segment,3);
            cx = nCol/2;  cy = nRow/2;  cz = nSli/2;

            % Half-extents in physical mm, then convert back to voxel units
            hx = cx;                                     % col voxels
            hy = cy;                                     % row voxels
            hz = cz * (app.pixdim(3)/app.pixdim(1));    % slices scaled to col-voxel units
            R  = max([hx, hy, hz]) * 1.1;

            xlim(app.View3D, [cx-R, cx+R]);
            ylim(app.View3D, [cy-R, cy+R]);
            zlim(app.View3D, [cz-R*app.pixdim(1)/app.pixdim(3), cz+R*app.pixdim(1)/app.pixdim(3)]);

            app.oriAxis_View3D = app.drawOriAxis(app.View3D);

            % Rotate around the volume centroid so the object stays centred
            if sum(abs(app.rotAngles)) > 0
                if app.isSegmentationLoaded
                    rotate(app.patchMasks{1}, [1 0 0], app.rotAngles(1), [cx cy cz]);
                    rotate(app.patchMasks{1}, [0 1 0], app.rotAngles(2), [cx cy cz]);
                else
                    rotate(app.hpatch1, [1 0 0], app.rotAngles(1), [cx cy cz]);
                    rotate(app.hpatch1, [0 1 0], app.rotAngles(2), [cx cy cz]);
                end
            end
        end

        function reset3DSegmentationAndCenterline(app)
            % Initialize figure
            colorbar(app.View3D_2,'off')
            cla(app.View3D_2);

            currSeg = app.getCurrentSeg(app.SegTimeframeSpinner.Value);
            currSeg = smooth3(double(currSeg));

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

            currSeg = app.getCurrentSeg(app.SegTimeframeSpinner.Value);

            % indices for flow plotting
            x = round(app.branchActual(:,1));
            y = round(app.branchActual(:,2));
            z = round(app.branchActual(:,3));
            index = sub2ind(size(currSeg),x,y,z);

            %reset figure
            cla(app.View3D_2);
            colorbar(app.View3D_2,'off');

            hpatch = patch(app.View3D_2, isosurface(smooth3(double(currSeg)),0.5),'FaceAlpha',0.25);
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
                ptRange = str2num(str);
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
                ptRange = str2num(str);
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
                        for ii = app.getActiveMaskIndices()
                            ct = ct+1;
                            hold(gca,'on');
                            h = imagesc(cat(3,c(ii,1)*ones(size(img)),c(ii,2)*ones(size(img)),c(ii,3)*ones(size(img))));
                            set(h,'AlphaData',img2(:,:,ct))
                            hold(gca,'off');
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
                        for ii = app.getActiveMaskIndices()
                            ct = ct+1;
                            hold(gca,'on');
                            h = imagesc(cat(3,c(ii,1)*ones(size(img)),c(ii,2)*ones(size(img)),c(ii,3)*ones(size(img))));
                            set(h,'AlphaData',img2(:,:,ct).*tmp_mask)
                            hold(gca,'off');
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

            % crop in time too
            str = app.FramesToUse.Value;
            ptRange = str2num(str);
            app.nframes = length(ptRange);

            [x, y, z] = ind2sub(size(app.mask),find(app.mask));
            lx = length(unique(x)); ly = length(unique(y)); lz = length(unique(z));
            maskIdx = find(app.mask);

            % crop velocity
            tempV = reshape(app.v(:,:,:,:,ptRange),[prod(app.res),3,app.nframes]);
            tempV = tempV(maskIdx,:,:);
            tempV = reshape(tempV,lx,ly,lz,3,app.nframes);
            app.v = tempV;
            app.vMean = mean(app.v,5);
            clear tempV

            % crop MAG
            tempMAG = reshape(app.MAG(:,:,:,ptRange),[prod(app.res),app.nframes]);
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

            % Determine which mask indices are active (computed once for all 3 axes)
            if app.isSegmentationLoaded && ~app.isTimeResolvedSeg
                activeMasks = app.getActiveMaskIndices();
            end
            tSeg = app.SegTimeframeSpinner.Value;

            % Helper: overlay active mask projections onto a given axes
            function overlayMasks(ax, dim, imSize, alpha)
                if ~app.isSegmentationLoaded, return; end
                if app.isTimeResolvedSeg
                    hold(ax,'on');
                    img2 = reshape(max(app.aorta_seg(:,:,:,tSeg),[],dim), imSize);
                    h = imagesc(ax, cat(3, c(1,1)*ones(imSize), c(1,2)*ones(imSize), c(1,3)*ones(imSize)));
                    set(h,'AlphaData', alpha*img2);
                    hold(ax,'off');
                else
                    for ii = activeMasks
                        hold(ax,'on');
                        img2 = reshape(max(app.aorta_seg(:,:,:,ii),[],dim), imSize);
                        h = imagesc(ax, cat(3, c(ii,1)*ones(imSize), c(ii,2)*ones(imSize), c(ii,3)*ones(imSize)));
                        set(h,'AlphaData', 0.15*img2);
                        hold(ax,'off');
                    end
                end
            end

            % X axis MIP
            cla(app.AxesX);
            imSize = size(max(app.angio,[],1)); imSize = imSize(2:3);
            imagesc(app.AxesX,reshape(max(app.angio,[],1),imSize));
            overlayMasks(app.AxesX, 1, imSize, 0.25);
            set(app.AxesX,'XTickLabel','','YTickLabel','')
            colormap(app.AxesX,'gray'); axis(app.AxesX,'equal'); daspect(app.AxesX,[1 1 1]);
            set(app.AxesX,'DataAspectRatio',[app.pixdim(1) app.pixdim(3) 1])

            % Y axis MIP
            cla(app.AxesY);
            imSize = size(max(app.angio,[],2)); imSize = imSize([1,3]);
            imagesc(app.AxesY,reshape(max(app.angio,[],2),imSize));
            overlayMasks(app.AxesY, 2, imSize, 0.25);
            set(app.AxesY,'XTickLabel','','YTickLabel','')
            colormap(app.AxesY,'gray'); axis(app.AxesY,'equal'); daspect(app.AxesY,[1 1 1]);
            set(app.AxesY,'DataAspectRatio',[app.pixdim(2) app.pixdim(3) 1])

            % Z axis MIP
            cla(app.AxesZ);
            imSize = size(max(app.angio,[],3)); imSize = imSize([1,2]);
            imagesc(app.AxesZ,reshape(max(app.angio,[],3),imSize));
            overlayMasks(app.AxesZ, 3, imSize, 0.25);
            set(app.AxesZ,'XTickLabel','','YTickLabel','')
            colormap(app.AxesZ,'gray'); axis(app.AxesZ,'equal'); daspect(app.AxesZ,[1 1 1]);
            set(app.AxesZ,'DataAspectRatio',[app.pixdim(1) app.pixdim(2) 1])
        end

        function updateVisualization(app)

            t = app.TimeframeSpinner.Value;
            if t == 0, t = 1; end

            % get segmentation via helper (eliminates duplicated block)
            currSeg = app.getCurrentSeg(t);

            % grab vis parameters – use cached numeric values where possible
            if ~isvalid(app.VisOptionsApp)
                scale = [0 round(app.VENC/10)];
                backgroundC = [1 1 1];
                axisText = [0 0 0];
                cmap = 'jet';
                cbarLoc = 'bottom-left';
            else
                if isempty(app.visParams.maxVel)
                    app.visParams.maxVel = app.VENC/10;
                end
                scale      = [app.visParams.minVel, app.visParams.maxVel];
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

            clim(app.VisualizationPlot, scale);
            colormap(app.VisualizationPlot, cmap);
            app.VisualizationGroup.BackgroundColor = backgroundC;
            app.VisualizationGroup.ForegroundColor = axisText;
            app.TimeframeSpinnerLabel.FontColor = axisText;
            app.SliceSpinner_2Label.FontColor = axisText;
            set(get(app.cbar_vis,'xlabel'),'string','velocity (cm/s)','Color',axisText);
            set(app.cbar_vis,'FontSize',13,'color',axisText,'Location','west');
            pos = get(app.cbar_vis,'position');
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
            set(app.cbar_vis,'position',pos);
            delete(findall(app.VisualizationPlot,'Type','light'))

            % toggle 3D surfaces
            % vis3Dsurface  = background anatomy shell (app.segment, full FOV)
            % vis3DSegsurface = vessel of interest (currSeg / aorta_seg)
            % Both use pixdim-scaled grids so they share the same mm coordinate space.
            if app.VisOptionsApp.view_3Dpatch_checkbox.Value
                if isempty(app.vis3Dsurface) || app.is3DChanged
                    app.vis3Dsurface = []; idxToRemove = [];
                    for ii = 1:numel(app.VisualizationPlot.Children)
                        if strcmp(app.VisualizationPlot.Children(ii).Tag,'3D_surface')
                            idxToRemove = ii; break;
                        end
                    end
                    delete(app.VisualizationPlot.Children(idxToRemove));

                    if app.segIsoFV_dirty || isempty(app.segIsoFV)
                        [xx,yy,zz] = meshgrid( ...
                            (1:size(app.segment,2))*app.pixdim(1), ...
                            (1:size(app.segment,1))*app.pixdim(2), ...
                            (1:size(app.segment,3))*app.pixdim(3));
                        app.segIsoFV       = isosurface(xx,yy,zz,smooth3(app.segment));
                        app.segIsoFV_dirty  = false;
                    end
                    app.vis3Dsurface = patch(app.VisualizationPlot, app.segIsoFV, ...
                        'FaceAlpha',0.15,'FaceColor',[0.7 0.7 0.7],'EdgeColor','none', ...
                        'PickableParts','none','Tag','3D_surface');
                    app.is3DChanged = 0;
                else
                    app.vis3Dsurface.Visible = 'on';
                end
            else
                if ~isempty(app.vis3Dsurface) && isvalid(app.vis3Dsurface)
                    app.vis3Dsurface.Visible = 'off';
                end
            end

            if app.VisOptionsApp.view_3DSegpatch_checkbox.Value
                if isempty(app.vis3DSegsurface) || app.is3DSegChanged
                    app.vis3DSegsurface = []; idxToRemove = [];
                    for ii = 1:numel(app.VisualizationPlot.Children)
                        if strcmp(app.VisualizationPlot.Children(ii).Tag,'3D_seg_surface')
                            idxToRemove = ii; break;
                        end
                    end
                    delete(app.VisualizationPlot.Children(idxToRemove));

                    if app.visSegIsoFV_dirty || isempty(app.visSegIsoFV)
                        [xx,yy,zz] = meshgrid( ...
                            (1:size(currSeg,2))*app.pixdim(1), ...
                            (1:size(currSeg,1))*app.pixdim(2), ...
                            (1:size(currSeg,3))*app.pixdim(3));
                        app.visSegIsoFV       = isosurface(xx,yy,zz,smooth3(double(currSeg)));
                        app.visSegIsoFV_dirty = false;
                    end
                    app.vis3DSegsurface = patch(app.VisualizationPlot, app.visSegIsoFV, ...
                        'FaceAlpha',0.15,'FaceColor',[0.7 0.7 0.7],'EdgeColor','none', ...
                        'PickableParts','none','Tag','3D_seg_surface');
                    app.is3DSegChanged = 0;
                else
                    app.vis3DSegsurface.Visible = 'on';
                end
            else
                if ~isempty(app.vis3DSegsurface) && isvalid(app.vis3DSegsurface)
                    app.vis3DSegsurface.Visible = 'off';
                end
            end

            switch app.VisTypeDropDown.Value
                case 'Vectors'
                    set(app.streamPatch,'Visible','off');
                    if ~isempty(app.pathlinePatch)
                        set(app.pathlinePatch,'Visible','off');
                    end
                    set(app.vectorPatch,'Visible','on');
                    viewVelocityVectors(app, currSeg, t);
                case 'Streamlines'
                    if ~isempty(app.sliceImg)
                        delete(app.sliceImg)
                        app.sliceImg = [];
                    end
                    if ~isempty(app.pathlinePatch)
                        set(app.pathlinePatch,'Visible','off');
                    end
                    set(app.vectorPatch,'Visible','off');
                    set(app.streamPatch,'Visible','on');
                    viewStreamlines(app, currSeg, t);
                case 'Pathlines'
                    if ~isempty(app.sliceImg)
                        delete(app.sliceImg)
                        app.sliceImg = [];
                    end
                    set(app.vectorPatch,'Visible','off');
                    set(app.streamPatch,'Visible','off');
                    viewPathlines(app, currSeg, t);
            end

            % Always finalise axis/camera in the full update so the scene
            % is correctly framed after any patch is created or toggled.
            % Skip during animation – limits are frozen by the animation loop.
            if ~app.isAnimating
                axis(app.VisualizationPlot, 'off', 'tight')
                view(app.VisualizationPlot, [0 0 1]);
                daspect(app.VisualizationPlot, [1 1 1]);
                if ~(contains(app.VisOptionsDropDown.Value,'slice-wise'))
                    camorbit(app.VisualizationPlot, app.rotAngles2(2), app.rotAngles2(1), [1 1 0])
                    camroll(app.VisualizationPlot, app.rotAngles2(3));
                end
                if app.VisOptionsApp.view_orientation_checkbox.Value
                    app.oriAxis_VisPlt = app.drawOriAxis(app.VisualizationPlot);
                else
                    idxToRemove = [];
                    for ii = 1:numel(app.VisualizationPlot.Children)
                        if strcmp(app.VisualizationPlot.Children(ii).Tag,'ori_axis_widget')
                            idxToRemove = cat(1,idxToRemove,ii);
                        end
                    end
                    delete(app.VisualizationPlot.Children(idxToRemove));
                end
            end
            hold(app.VisualizationPlot, 'off');
        end

        % -----------------------------------------------------------------
        % FAST PATH: called only when the timeframe changes.
        % Skips all appearance/geometry work (colormap, isosurfaces, camera,
        % colorbar, lights) – those are unchanged. Only updates the velocity
        % data shown on existing patch/image objects.
        % -----------------------------------------------------------------
        function updateVisualizationData(app)

            t = app.TimeframeSpinner.Value;
            if t == 0, t = 1; end

            % If patches don't exist yet, fall back to the full update
            % which will also set up axis limits and camera correctly.
            if isempty(app.vectorPatch) && isempty(app.streamPatch) && isempty(app.pathlinePatch)
                updateVisualization(app);
                return;
            end

            currSeg = app.getCurrentSeg(t);

            switch app.VisTypeDropDown.Value
                case 'Streamlines'
                    if ~isempty(app.streamsOut)
                        alphas = [0.2 0.5 0.9];
                        firstRender = isempty(app.streamPatch) || app.isStreamsChanged.Value;
                        for k = 1:numel(app.streamPatch)
                            [X2,Y2,Z2,C2] = streamsToSurface( ...
                                app.streamsOut.Xb{k,t}, app.streamsOut.Yb{k,t}, ...
                                app.streamsOut.Zb{k,t}, app.streamsOut.Cb{k,t});
                            set(app.streamPatch(k), ...
                                'XData',X2,'YData',Y2,'ZData',Z2,'CData',C2, ...
                                'EdgeAlpha', alphas(k));
                        end
                        % On the first render the axis limits are not yet set —
                        % reset them so the patches are visible.
                        if firstRender && ~app.isAnimating
                            axis(app.VisualizationPlot, 'off', 'tight')
                            view(app.VisualizationPlot, [0 0 1]);
                            daspect(app.VisualizationPlot, [1 1 1]);
                            camorbit(app.VisualizationPlot, app.rotAngles2(2), app.rotAngles2(1), [1 1 0])
                            camroll(app.VisualizationPlot, app.rotAngles2(3));
                        end
                    end

                case 'Pathlines'
                    % Timeframe spinner selects which time window to display
                    viewPathlines(app, currSeg, t);

                case 'Vectors'
                    % Recompute geometry for the new frame, update patch in-place.
                    viewVelocityVectors(app, currSeg, t);
            end
        end

        function viewVelocityVectors(app, currSeg, t)

            currV = app.v(:,:,:,:,t);

            subsample = round(app.VisOptionsApp.SubsampleSlider.Value);
            switch app.VisOptionsDropDown.Value  % the current vector vis state
                case 'slice-wise'   % slicewise vectors

                    % 1. Uniformly rotate the spatial volume, velocity vectors, and magnitude image
                    % This replaces the 3-step manual rot90 cascade and handles 3D vectors.
                    [currSeg, currV, currMAG] = app.rotateVol3D(currSeg, currV, app.MAG(:,:,:,t), app.rotAngles2);

                    % 2. Grab and clamp the current slice based on the NEW rotated Z-dimension
                    sl = app.SliceSpinner_2.Value;

                    if app.SliceSpinner_2.Limits(2) ~= size(currV,3)
                        app.SliceSpinner_2.Limits = [1 size(currV,3)];
                    end

                    % If the previous slice value is now out-of-bounds for the new view, reset to middle
                    if sl > size(currV,3)
                        sl = round(size(currV,3)/2);
                        app.SliceSpinner_2.Value = sl; % Update the UI so it doesn't get stuck
                    end

                    % 3. Extract the slice data and calculate velocity components
                    % Since rotateVol3D handled the view shift, dimension 3 is ALWAYS the correct slice axis now.
                    L = find(currSeg(1:subsample:end,1:subsample:end,sl));
                    vx = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,1)/10;
                    vy = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,2)/10;
                    vz = -currSeg(1:subsample:end,1:subsample:end,sl).*currV(1:subsample:end,1:subsample:end,sl,3)/10;

                    x_idx = 1:subsample:size(currSeg,2);
                    y_idx = 1:subsample:size(currSeg,1);

                    x_vec = (x_idx - size(currSeg,2)/2) * app.pixdim(1);
                    y_vec = (y_idx - size(currSeg,1)/2) * app.pixdim(2);

                    % Build the meshgrid
                    [xcoor_grid, ycoor_grid, zcoor_grid] = meshgrid(x_vec, y_vec, -5);
                    if ~isequal(app.pixdim(1),app.pixdim(2))
                        fprintf('WARNING: in-plane voxel sizes are not equal. This might lead to incorrect aspect ratios. Please contact Eric Schrauben/Bobby Runderkamp. \n')
                    end

                    % 5. Render the image
                    img = repmat(currMAG(:,:,sl),[1 1 3]);

                    x_bounds = [min(xcoor_grid(:)), max(xcoor_grid(:))];
                    y_bounds = [min(ycoor_grid(:)), max(ycoor_grid(:))];

                    app.VisualizationPlot.NextPlot = 'add';
                    if isempty(app.sliceImg)
                        app.sliceImg = imagesc(app.VisualizationPlot, x_bounds, y_bounds, img, [0.05 0.7]);
                    else
                        % Update BOTH the pixel data and the spatial location
                        set(app.sliceImg, 'CData', img, 'XData', x_bounds, 'YData', y_bounds);
                    end
                    %===================================================================================================
                case 'centerline contours' % contours from centerline
                    str = app.VisOptionsApp.VisPts.Value;
                    ptRange = str2num(str);

                    if isempty(app.contourCoords) || ~isfield(app.contourCoords,'x') || ...
                            isempty(app.contourCoords.x)
                        % Fallback: contourCoords not yet populated (before first flow calc)
                        return;
                    end

                    % Use the plane coordinates already computed by params_timeResolved.
                    % x_full/y_full/z_full are [nBranch × planePixels] arrays in voxel indices.
                    % Clamp ptRange to valid branch indices.
                    ptRange(ptRange > size(app.contourCoords.x,1)) = [];
                    ptRange(ptRange < 1) = [];
                    if isempty(ptRange), return; end

                    % Retrieve the stored plane geometry for selected points
                    nPlanePx = size(app.contourCoords.x, 2);
                    Side     = app.contourCoords.planeWidth * 3;   % InterpVals=3 inside params_timeResolved
                    width    = Side*2+1;

                    L = []; xcoor_grid = []; ycoor_grid = []; zcoor_grid = [];
                    vx = []; vy = []; vz = [];
                    for ii = ptRange
                        % In contourCoords: .x = col positions, .y = row positions
                        % (opposite to variable names — confirmed empirically)
                        x_plane = double(app.contourCoords.y(ii,:));   % rows
                        y_plane = double(app.contourCoords.x(ii,:));   % cols
                        z_plane = double(app.contourCoords.z(ii,:));   % slices

                        seg_plane = app.contours(ii,:,1);
                        maskPx = find(seg_plane > 0.5);
                        if isempty(maskPx), continue; end
                        maskPx = maskPx(1:subsample:end);

                        xcoor_grid = cat(1, xcoor_grid, x_plane(maskPx)' * app.pixdim(1));
                        ycoor_grid = cat(1, ycoor_grid, y_plane(maskPx)' * app.pixdim(2));
                        zcoor_grid = cat(1, zcoor_grid, z_plane(maskPx)' * app.pixdim(3));

                        xq = x_plane(maskPx)';   % rows
                        yq = y_plane(maskPx)';   % cols
                        zq = z_plane(maskPx)';   % slices
                        % interp3(V, col, row, slice)
                        vx = cat(1, vx, -interp3(currV(:,:,:,1)/10, xq, yq, zq, 'linear', 0));
                        vy = cat(1, vy, -interp3(currV(:,:,:,2)/10, xq, yq, zq, 'linear', 0));
                        vz = cat(1, vz, -interp3(currV(:,:,:,3)/10, xq, yq, zq, 'linear', 0));

                        L = cat(1, L, (1:length(maskPx))' + length(L));
                    end

                    L = 1:length(L);

                    % Draw planes if enabled (shared helper)
                    app.showContoursIfEnabled(ptRange);
                case 'segmentation'   % 3d vectors from the whole segmentation
                    [xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:subsample:size(currSeg,2))*app.pixdim(1),(1:subsample:size(currSeg,1))*app.pixdim(2), ...
                        (1:subsample:size(currSeg,3))*app.pixdim(3));
                    vx = -currSeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,1)/10;
                    vy = -currSeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,2)/10;
                    vz = -currSeg(1:subsample:end,1:subsample:end,1:subsample:end).*currV(1:subsample:end,1:subsample:end,1:subsample:end,3)/10;
                    L = find(currSeg(1:subsample:end,1:subsample:end,1:subsample:end));
            end

            vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);

            % check to do smoothing of velocity field
            if mean(vmagn(find(vmagn))) < (app.VENC/10)/10
                vmagn = imgaussfilt3(vmagn,std(vmagn(:))/10);
            end

            c = [];
            % note the flipped vx and vy here
            a = [app.visParams.minQuiver, app.visParams.maxQuiver * max(vmagn(:))/100];
            [F,V,C]=quiver3Dpatch(xcoor_grid(L),ycoor_grid(L),zcoor_grid(L),-vy(L),-vx(L),-vz(L),c,a);

            if isempty(app.vectorPatch)
                app.vectorPatch = patch(app.VisualizationPlot,'Faces',F,'Vertices',V,'CData',C,'FaceColor','flat',...
                    'EdgeColor','none','FaceAlpha',0.75,'Tag','vector_patch');
                % First render – set up axis and camera
                axis(app.VisualizationPlot, 'off','tight')
                view(app.VisualizationPlot,[0 0 1]);
                daspect(app.VisualizationPlot,[1 1 1])
                if ~contains(app.VisOptionsDropDown.Value,'slice-wise')
                    camorbit(app.VisualizationPlot,app.rotAngles2(2),app.rotAngles2(1),[1 1 0])
                    camroll(app.VisualizationPlot,app.rotAngles2(3));
                end
            else
                % Data update only – reuse existing axes/camera state
                set(app.vectorPatch,'Faces',F,'Vertices',V,'CData',C,...
                    'FaceColor','flat','EdgeColor','none','FaceAlpha',0.75);
            end
            uistack(app.vectorPatch,'top');
        end

        function viewStreamlines(app, currSeg, t)

            alphas = [0.2 0.5 0.9]; nbins = length(alphas);

            % Step 1: recalculate streamlines if needed (vis type change, param change etc.)
            if app.isStreamsChanged.Value || isempty(app.streamsOut)

                % Always delete ALL existing streamline surface objects first
                % so we never try to set() them with a differently-sized matrix.
                toDelete = findall(app.VisualizationPlot, 'Tag', 'streamline_patch1', ...
                    '-or','Tag','streamline_patch2','-or','Tag','streamline_patch3');
                delete(toDelete);
                app.streamPatch = [];

                app.streamsOut = calculateStreamlines(currSeg, app.v, ...
                    round(app.VisOptionsApp.SubsampleSlider.Value), app.pixdim, ...
                    app.visParams.minQuiver, app.visParams.maxVel, ...
                    app.VisOptionsDropDown.Value, ...
                    app.VisOptionsApp.VisPts.Value, app.contourCoords);

                % Pad all frames to the same length per bin so surface object
                % dimensions never change between frames (required by MATLAB surface).
                [nbins_out, nframes_out] = size(app.streamsOut.Xb);
                for k = 1:nbins_out
                    maxLen = max(cellfun(@numel, app.streamsOut.Xb(k,:)));
                    if maxLen == 0, maxLen = 1; end
                    for tt = 1:nframes_out
                        app.streamsOut.Xb{k,tt}(end+1:maxLen,1) = NaN;
                        app.streamsOut.Yb{k,tt}(end+1:maxLen,1) = NaN;
                        app.streamsOut.Zb{k,tt}(end+1:maxLen,1) = NaN;
                        app.streamsOut.Cb{k,tt}(end+1:maxLen,1) = NaN;
                        % Guarantee column vector regardless of original orientation
                        app.streamsOut.Xb{k,tt} = app.streamsOut.Xb{k,tt}(:);
                        app.streamsOut.Yb{k,tt} = app.streamsOut.Yb{k,tt}(:);
                        app.streamsOut.Zb{k,tt} = app.streamsOut.Zb{k,tt}(:);
                        app.streamsOut.Cb{k,tt} = app.streamsOut.Cb{k,tt}(:);
                    end
                end
                app.isStreamsChanged.Value = 0;
            end

            % Step 2: create surface objects if they don't exist yet
            ptRange_vis = str2num(app.VisOptionsApp.VisPts.Value);
            if isempty(app.streamPatch)
                for k = 1:nbins
                    [X2,Y2,Z2,C2] = streamsToSurface( ...
                        app.streamsOut.Xb{k,t}, app.streamsOut.Yb{k,t}, ...
                        app.streamsOut.Zb{k,t}, app.streamsOut.Cb{k,t});
                    app.streamPatch(k) = surface(app.VisualizationPlot, ...
                        X2, Y2, Z2, C2, ...
                        'EdgeColor','interp','FaceColor','none', ...
                        'EdgeAlpha', alphas(k), ...
                        'Tag', sprintf('streamline_patch%i',k));
                end
            else
                % Step 3: surfaces exist and are correctly sized — swap data only
                for k = 1:nbins
                    [X2,Y2,Z2,C2] = streamsToSurface( ...
                        app.streamsOut.Xb{k,t}, app.streamsOut.Yb{k,t}, ...
                        app.streamsOut.Zb{k,t}, app.streamsOut.Cb{k,t});
                    set(app.streamPatch(k),'XData',X2,'YData',Y2,'ZData',Z2,'CData',C2);
                end
            end
            uistack(app.streamPatch,'top');
            app.showContoursIfEnabled(ptRange_vis);
        end

        % -----------------------------------------------------------------
        % PATHLINE VISUALIZATION
        % Pathlines trace particle trajectories through time using ODE45
        % integration through a 4D velocity field. Each particle is emitted
        % from a centerline contour seed point and tracked for the full
        % cardiac cycle. The timeframe spinner selects the emission time
        % window to display.
        % -----------------------------------------------------------------
        function viewPathlines(app, currSeg, t)

            % --- (Re)calculate if needed --------------------------------
            if app.isPathlinesChanged.Value || isempty(app.pathlinesOut)

                % Clean up old patch objects
                if ~isempty(app.pathlinePatch)
                    try; delete(app.pathlinePatch); catch; end
                    app.pathlinePatch = [];
                end

                % Get seed points from centerline contours (same logic as
                % calculateStreamlines / viewVelocityVectors)
                str      = app.VisOptionsApp.VisPts.Value;
                ptRange  = str2num(str);
                subsample = round(app.VisOptionsApp.SubsampleSlider.Value);

                startX = []; startY = []; startZ = [];
                ptRange(ptRange > size(app.contourCoords.x,1)) = [];
                ptRange(ptRange < 1) = [];
                for ii = ptRange
                    x_plane = double(app.contourCoords.y(ii,:));   % rows
                    y_plane = double(app.contourCoords.x(ii,:));   % cols
                    z_plane = double(app.contourCoords.z(ii,:));   % slices

                    seg_plane = app.contourCoords.seg(ii,:);
                    maskPx = find(seg_plane > 0.5);
                    if isempty(maskPx), continue; end
                    maskPx = maskPx(1:subsample:end);

                    startX = cat(1, startX, x_plane(maskPx)' * app.pixdim(1));
                    startY = cat(1, startY, y_plane(maskPx)' * app.pixdim(2));
                    startZ = cat(1, startZ, z_plane(maskPx)' * app.pixdim(3));
                end

                if isempty(startX)
                    warning('viewPathlines: no valid seed points found.');
                    return
                end

                % start_points: N×3 in [x y z] = [row col slice] * pixdim
                % NOTE: ndgrid convention swaps x↔y vs meshgrid — kept
                % consistent with pathline_testing.m (startY, startX, startZ)
                start_points = [startY, startX, startZ];

                % Build 4D interpolants (cached — only recompute when invalidated)
                if isempty(app.pathlineInterp)
                    hWait = waitbar(0, 'Building 4D velocity interpolants...');
                    [Xg, Yg, Zg, Tg] = ndgrid( ...
                        (1:size(currSeg,1)) * app.pixdim(1), ...
                        (1:size(currSeg,2)) * app.pixdim(2), ...
                        (1:size(currSeg,3)) * app.pixdim(3), ...
                        (1:app.nframes)     * (app.timeres/1000));
                    vx_4d = -squeeze(app.v(:,:,:,1,:));
                    vy_4d = -squeeze(app.v(:,:,:,2,:));
                    vz_4d = -squeeze(app.v(:,:,:,3,:));
                    app.pathlineInterp.U    = griddedInterpolant(Xg, Yg, Zg, Tg, -vx_4d, 'linear');
                    app.pathlineInterp.V    = griddedInterpolant(Xg, Yg, Zg, Tg, -vy_4d, 'linear');
                    app.pathlineInterp.W    = griddedInterpolant(Xg, Yg, Zg, Tg, -vz_4d, 'linear');
                    smoothMask = smooth3(double(currSeg));

                    % Close open vessel ends (inlet/outlet planes where the
                    % segmentation has no wall cap).
                    %
                    % We dilate the binary mask isotropically by 1 voxel — this
                    % adds a thin shell around the ENTIRE vessel including the
                    % open ends. Taking the union with the original gives a fully
                    % closed mask. Only the newly added voxels (the caps) matter
                    % because the existing walls are already in smoothMask.
                    %
                    % This works for any vessel orientation (axial, oblique, etc.)
                    % because it closes faces in all three dimensions uniformly.
                    se3d        = strel('sphere', 1);
                    dilatedSeg  = imdilate(logical(currSeg), se3d);
                    endCaps     = smooth3(double(dilatedSeg & ~logical(currSeg)));
                    smoothMask  = min(smoothMask + endCaps * 0.6, 1);
                    % The 0.6 factor ensures the cap crosses the 0.5 boundary
                    % threshold used in maskBoundaryEvent while staying below 1.

                    [Xg3, Yg3, Zg3] = ndgrid( ...
                        (1:size(currSeg,1)) * app.pixdim(1), ...
                        (1:size(currSeg,2)) * app.pixdim(2), ...
                        (1:size(currSeg,3)) * app.pixdim(3));
                    app.pathlineInterp.mask = griddedInterpolant(Xg3, Yg3, Zg3, smoothMask, 'linear');
                    % Store volume bounds so maskBoundaryEvent can stop particles
                    % that reach the edge of the image volume (cropped or not).
                    app.pathlineInterp.bounds = [ ...
                        Xg3(1),   Xg3(end); ...   % [xMin, xMax]
                        Yg3(1),   Yg3(end); ...   % [yMin, yMax]
                        Zg3(1),   Zg3(end)];      % [zMin, zMax]
                    if ishandle(hWait), close(hWait); end
                end

                % Read user-specified pathline parameters from VisOptionsDialog
                pathLenVal = str2double(app.VisOptionsApp.PathlineLengthEditField.Value);
                if isnan(pathLenVal) || pathLenVal <= 0
                    pathLenSec = [];   % empty = track for full cardiac cycle
                else
                    pathLenSec = pathLenVal;
                end

                releaseVal = str2double(app.VisOptionsApp.PathlineReleaseEditField.Value);
                if isnan(releaseVal) || releaseVal < 1
                    releaseFrame = [];  % empty = release at all frames
                else
                    releaseFrame = round(releaseVal);
                end

                % ODE integration
                app.pathlinesOut = calculatePathlines( ...
                    start_points, app.nframes, app.timeres, ...
                    app.pathlineInterp, app.visParams.minVel, app.visParams.maxVel, ...
                    pathLenSec, releaseFrame);

                app.isPathlinesChanged.Value = 0;
            end

            % --- Render: show trajectory accumulated up to timeframe t ----
            % The dataStore rows correspond to windows in the order they were
            % computed (starting at releaseFrame). The timeframe spinner
            % controls how many windows of path are shown (trail length).
            if isempty(app.pathlinesOut) || isempty(app.pathlinesOut.dataStore)
                return
            end

            % Number of windows to show = t (clamped to what was computed)
            nComputed    = size(app.pathlinesOut.dataStore, 1);
            numParticles = size(app.pathlinesOut.dataStore, 2);
            nShow        = min(t, nComputed);

            % Delete old patches and recreate (pathlines don't have a
            % fixed uniform length like streamlines so surface trick doesn't apply —
            % use patch with NaN separators; there are far fewer particles
            % than streamline points so this is fast enough)
            if ~isempty(app.pathlinePatch)
                try; delete(app.pathlinePatch); catch; end
                app.pathlinePatch = [];
            end

            patchIdx     = 0;
            hold(app.VisualizationPlot, 'on');

            % Collect all particle trajectories first so we can pad to uniform length
            allX = cell(numParticles,1); allY = cell(numParticles,1);
            allZ = cell(numParticles,1); allC = cell(numParticles,1);
            for i = 1:numParticles
                Xp = []; Yp = []; Zp = []; Cp = [];
                for k = 1:nShow
                    d = app.pathlinesOut.dataStore{k, i};
                    if isempty(d), continue; end
                    Xp = [Xp; d.coords(:,2); NaN];
                    Yp = [Yp; d.coords(:,1); NaN];
                    Zp = [Zp; d.coords(:,3); NaN];
                    Cp = [Cp; d.vel;       NaN];
                end
                allX{i} = Xp(:); allY{i} = Yp(:);
                allZ{i} = Zp(:); allC{i} = Cp(:);
            end

            % Pad all to same length for uniform surface dimensions
            maxLen = max(cellfun(@numel, allX));
            if maxLen == 0, hold(app.VisualizationPlot,'off'); return; end

            for i = 1:numParticles
                if isempty(allX{i}), continue; end
                n = numel(allX{i});
                if n < maxLen
                    allX{i}(end+1:maxLen,1) = NaN;
                    allY{i}(end+1:maxLen,1) = NaN;
                    allZ{i}(end+1:maxLen,1) = NaN;
                    allC{i}(end+1:maxLen,1) = NaN;
                end

                [X2,Y2,Z2,C2] = streamsToSurface(allX{i}, allY{i}, allZ{i}, allC{i});
                patchIdx = patchIdx + 1;
                app.pathlinePatch(patchIdx) = surface(app.VisualizationPlot, ...
                    X2, Y2, Z2, C2, ...
                    'EdgeColor', 'interp', ...
                    'FaceColor',    'none', ...
                    'EdgeAlpha', 0.75, ...
                    'LineWidth', 0.75, ...
                    'Tag', 'pathline_patch');
            end
            hold(app.VisualizationPlot, 'off');

            if ~isempty(app.pathlinePatch)
                clim(app.VisualizationPlot, [app.visParams.minVel, app.visParams.maxVel]);
                uistack(app.pathlinePatch, 'top');
            end
            ptRange_pl = str2num(app.VisOptionsApp.VisPts.Value);
            app.showContoursIfEnabled(ptRange_pl);
        end
        
        % -----------------------------------------------------------------
        % SHARED HELPER: draw contour planes on VisualizationPlot when the
        % show_planes_checkbox is checked. Called from viewVelocityVectors,
        % viewStreamlines, and viewPathlines.
        % -----------------------------------------------------------------
        function showContoursIfEnabled(app, ptRange)
            if ~app.VisOptionsApp.show_planes_checkbox.Value
                delete(findobj(app.VisualizationPlot,'Tag','vis_plane'));
                return;
            end
            if isempty(app.contourCoords) || ~isfield(app.contourCoords,'x') || ...
                    isempty(app.contourCoords.x) || isempty(app.vesselTangent)
                return;
            end
            delete(findobj(app.VisualizationPlot,'Tag','vis_plane'));
            ptRange(ptRange > min(size(app.vesselTangent,1), size(app.branchActual,1))) = [];
            ptRange(ptRange < 1) = [];
            if isempty(ptRange), return; end
            pw     = round(max(1, app.contourCoords.planeWidth)*mean(app.pixdim));
            b_mm   = app.branchActual(ptRange,:) .* app.pixdim(:)';
            tv_sub = app.vesselTangent(ptRange,:);
            hold(app.VisualizationPlot,'on');
            viewPlanesIn3D(app.VisualizationPlot, tv_sub, pw, b_mm, 1);
            newObjs = findobj(app.VisualizationPlot,'Type','patch', ...
                '-not','Tag','vector_patch','-not','Tag','streamline_patch1', ...
                '-not','Tag','streamline_patch2','-not','Tag','streamline_patch3', ...
                '-not','Tag','3D_surface','-not','Tag','3D_seg_surface');
            set(newObjs,'Tag','vis_plane');
            hold(app.VisualizationPlot,'off');
        end
        % ang = [pitch, yaw, roll] matching original rotAngles2 convention.
        % -----------------------------------------------------------------
        function [seg_r, V_r, mag_r] = rotateVol3D(app, seg, V, mag, ang) %#ok<INUSL>
            % Rotate seg
            tmp   = imrotate3(seg,  ang(2), [0 -1 0], 'nearest');
            tmp   = imrotate3(tmp,  ang(1), [-1 0 0], 'nearest');
            seg_r = imrotate3(tmp,  ang(3), [0  0 1], 'nearest');

            % 1. Rotate each velocity component spatially
            % This moves the voxels to their new 3D positions
            nComp = size(V, 4);
            V_r   = [];
            for f = 1:nComp
                tmp      = imrotate3(V(:,:,:,f), ang(2), [0 -1 0], 'nearest');
                tmp      = imrotate3(tmp,        ang(1), [-1 0 0], 'nearest');
                Vf_r  = imrotate3(tmp,        ang(3), [0  0 1], 'nearest');
                if isempty(V_r)
                    V_r = zeros([size(Vf_r), nComp], 'like', V);
                end
                V_r(:,:,:,f) = Vf_r;
            end

            % 2. Mathematical Vector Rotation
            % Construct individual rotation matrices matching the imrotate3 steps.

            % Step A: Rotate around [0 1 0] by ang(2)
            Ry = [cosd(ang(2)),  0, sind(ang(2)); ...
                0,             1,  0;            ...
                -sind(ang(2)),  0,  cosd(ang(2))];

            % Step B: Rotate around [1 0 0] by ang(1)
            Rx = [1,  0,             0;            ...
                0,  cosd(ang(1)),  -sind(ang(1)); ...
                0, sind(ang(1)),  cosd(ang(1))];

            % Step C: Rotate around [0 0 1] by ang(3) -> standard positive Z-axis rotation
            Rz = [cosd(ang(3)), -sind(ang(3)),  0; ...
                sind(ang(3)),  cosd(ang(3)),  0; ...
                0,             0,             1];

            % Combine matrices in sequential order (Y first, then X, then Z)
            R = Rz * Rx * Ry;

            % CRITICAL FIX: Extract components in true Cartesian order [Vx; Vy; Vz]
            % Channel 1 is Vy, Channel 2 is Vx, Channel 3 is Vz
            Vx_flat = reshape(V_r(:,:,:,2), [], 1);
            Vy_flat = reshape(V_r(:,:,:,1), [], 1);
            Vz_flat = reshape(V_r(:,:,:,3), [], 1);

            V_flat = [Vx_flat, Vy_flat, Vz_flat].'; % Unified 3 x N matrix

            % Perform the matrix multiplication to re-orient the arrows correctly
            V_rot_flat = R * V_flat;

            % Reassign back to V_r matching the layout (Ch1=Vy, Ch2=Vx, Ch3=Vz)
            sz_xyz = size(V_r(:,:,:,1));
            V_r(:,:,:,2) = reshape(V_rot_flat(1,:), sz_xyz); % Rotated Vx -> Channel 2
            V_r(:,:,:,1) = reshape(V_rot_flat(2,:), sz_xyz); % Rotated Vy -> Channel 1
            V_r(:,:,:,3) = reshape(V_rot_flat(3,:), sz_xyz); % Rotated Vz -> Channel 3

            % Rotate MAG
            tmp   = imrotate3(mag,  ang(2), [0 -1 0], 'nearest');
            tmp   = imrotate3(tmp,  ang(1), [-1 0 0], 'nearest');
            mag_r = imrotate3(tmp,  ang(3), [0  0 1], 'nearest');
        end


        function [outImg, outVol, idx_currSeg] = viewMap(app)
            cla(app.MapPlot);
            colorbar(app.MapPlot,'off');
            if ~contains(app.MapType.Value,'None')
                isWSS = 0;
                t = app.TimeframeSpinner.Value;
                currSeg = app.getCurrentSeg(t);

                % Rotate using the full segment volume (same size as app.v) so
                % imrotate3 output sizes are consistent. Apply currSeg mask afterward.
                [seg_rot, currV_rot, ~] = app.rotateVol3D(app.segment, app.v(:,:,:,:,1)/10, app.MAG(:,:,:,1), app.rotAngles2);

                % Rotate currSeg separately (may be smaller if from aorta_seg)
                tmpSeg  = imrotate3(double(currSeg), app.rotAngles2(2), [0 -1 0], 'nearest');
                tmpSeg  = imrotate3(tmpSeg,          app.rotAngles2(1), [-1 0 0], 'nearest');
                currSeg = logical(imrotate3(tmpSeg,  app.rotAngles2(3), [0  0 1], 'nearest'));

                % Pad or crop currSeg to match rotated full-volume size if needed
                sz_full = size(seg_rot);
                sz_seg  = size(currSeg);
                if ~isequal(sz_full, sz_seg)
                    tmp = false(sz_full);
                    r = min(sz_full(1),sz_seg(1)); c = min(sz_full(2),sz_seg(2)); s = min(sz_full(3),sz_seg(3));
                    tmp(1:r,1:c,1:s) = currSeg(1:r,1:c,1:s);
                    currSeg = tmp;
                end

                % grab current velocity (all frames, already divided by 10 for units)
                if contains(app.MapTime.Value,'resolved')
                    currV = zeros([sz_full, 3, size(app.v,5)], 'like', app.v);
                    for tt = 1:size(app.v,5)
                        [~, currV_tt, ~] = app.rotateVol3D(app.segment, app.v(:,:,:,:,tt)/10, app.MAG(:,:,:,1), app.rotAngles2);
                        currV(:,:,:,:,tt) = currV_tt;
                    end
                else
                    currV = repmat(currV_rot,[1 1 1 1 size(app.v,5)]);
                end

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
                        % Pack all 9 gradient components into a 3x3 cell for clean indexing
                        gradV = {v11, v12, v13; v21, v22, v23; v31, v32, v33};
                        theta_v = 0;
                        for ii = 1:3
                            for jj = 1:3
                                dij = double(ii == jj);
                                theta_v = theta_v + (gradV{ii,jj} + gradV{jj,ii} - (2/3)*div.*dij).^2;
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
                if ~isWSS
                    outVol(currSeg==0) = nan;
                end

                if ~isvalid(app.VisOptionsApp)
                    scale = scaletmp;
                    backgroundC = [1 1 1];
                    axisText = [0 0 0];
                    cmap = 'jet(256)';
                    cbarLoc = 'bottom-left';
                else
                    scale = [app.visParams.minMap, app.visParams.maxMap];
                    backgroundC = [1 1 1];
                    if strcmp(app.VisOptionsApp.backgroundDropDown_2.Value,'black')
                        backgroundC = [0 0 0];
                    end
                    axisText = [0 0 0];
                    if strcmp(app.VisOptionsApp.TextcolorDropDown_2.Value,'white')
                        axisText = [1 1 1];
                    end
                    if contains(app.VisOptionsApp.ColormapDropDown_2.Value,'inverse')
                        cmap = feval(erase(app.VisOptionsApp.ColormapDropDown_2.Value,'inverse '), 256);
                        cmap = flip(cmap,1);
                    else
                        cmap = feval(app.VisOptionsApp.ColormapDropDown_2.Value, 256);
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
                            % outVol is x×y×z×t — select the current frame
                            outImg = outVol(:,:,:,t);
                        case 'time-averaged'
                            outImg = mean(outVol,4,'omitnan');
                        case 'peak'
                            outImg = max(outVol,[],4,'omitnan');
                    end
                    % then project the image, or choose a slice
                    if isSliceWise
                        outImg = outImg(:,:,sl); smthMask = currSeg(:,:,sl);
                    elseif contains(app.VisOptionsApp.projectionDropDown.Value,'mean')
                        outImg = mean(outImg,3,'omitnan'); smthMask = max(currSeg,[],3,'omitnan');
                    else          % app.VisOptions.MapProjection.Value = 'max'
                        outImg = max(outImg,[],3,'omitnan'); smthMask = max(currSeg,[],3,'omitnan');
                    end

                    % do smoothing if checkbox checked
                    if app.VisOptionsApp.smoothMap_checkbox.Value
                        smthMask = imresize(smthMask,2,"bilinear");
                        smthMask(smthMask < 0.75) = 0;
                        outImg = imresize(outImg,2,'bilinear').*smthMask;
                    end
                    [xcoor_grid,ycoor_grid] = meshgrid((1:size(outImg,2))*app.pixdim(1),(1:size(outImg,1))*app.pixdim(2));
                    imagesc(app.MapPlot,[min(xcoor_grid) max(xcoor_grid)],[min(ycoor_grid) max(ycoor_grid)],outImg);
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
            currSeg = app.getCurrentSeg(t);

            PCA_masked = app.v(:,:,:,:,t).*repmat(permute(currSeg,[1 2 3 5 4]),[1 1 1 3 1])/10;

            if isempty(app.h1) || ~isvalid(app.h1)
                scaling = round(max(abs(PCA_masked(:))));
                cmap_scaling = dopplermap(1000,1);

                % Apply to all axes once
                colormap(app.Unwrap_1, cmap_scaling);
                colormap(app.Unwrap_2, cmap_scaling);
                colormap(app.Unwrap_3, cmap_scaling);

                % Create images
                app.h1 = imagesc(app.Unwrap_1, PCA_masked(:,:,s,1));
                axis(app.Unwrap_1, 'equal', 'off');
                title(app.Unwrap_1, app.ori.vxlabel);
                app.h2 = imagesc(app.Unwrap_2, PCA_masked(:,:,s,2));
                axis(app.Unwrap_2, 'equal', 'off');
                title(app.Unwrap_2, app.ori.vylabel);
                app.h3 = imagesc(app.Unwrap_3, PCA_masked(:,:,s,3));
                axis(app.Unwrap_3, 'equal', 'off');
                title(app.Unwrap_3, app.ori.vzlabel);

                clim(app.Unwrap_1, [-scaling scaling]);
                clim(app.Unwrap_2, [-scaling scaling]);
                clim(app.Unwrap_3, [-scaling scaling]);

                % Colorbar once
                app.cbar_unwrap = colorbar(app.Unwrap_1, 'Location', 'west');
                xlabel(app.cbar_unwrap, 'velocity (cm/s)', 'FontSize', 12, 'Color', 'black');
                set(app.cbar_unwrap, 'FontSize', 12, 'Color', 'black');
                pos = get(app.cbar_unwrap,'Position');
                set(app.cbar_unwrap, 'Position', [0.01 0.01 pos(3) 0.2]);
            else
                % Update existing images only
                set(app.h1, 'CData', PCA_masked(:,:,s,1));
                set(app.h2, 'CData', PCA_masked(:,:,s,2));
                set(app.h3, 'CData', PCA_masked(:,:,s,3));

                % Update color limits if scaling changed
                scaling = round(max(abs(PCA_masked(:))));
                clim(app.Unwrap_1, [-scaling scaling]);
                clim(app.Unwrap_2, [-scaling scaling]);
                clim(app.Unwrap_3, [-scaling scaling]);
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
            app.VelocityUnwrapping.Icon = 'unwrap.jpg';
            app.DFW.Icon = 'DFW.jpg';

            % Build maskHandles cell array – eliminates all eval(sprintf('app.mask%i...')) calls
            app.maskHandles = {app.mask1, app.mask2, app.mask3, app.mask4, app.mask5, ...
                app.mask6, app.mask7, app.mask8, app.mask9, app.mask10};

            % Initialise visParams cache with sensible defaults
            app.visParams.minVel    = 0;
            app.visParams.maxVel    = 150;
            app.visParams.minQuiver = 0;
            app.visParams.maxQuiver = 100;
            app.visParams.minMap    = 0;
            app.visParams.maxMap    = 150;

            drawnow;
        end

        % Button pushed function: LoadDataButton
        function LoadDataButtonPushed(app, ~)
            clc;

            list = {'Philips .rec','Philips dicom', 'mrStruct .mat','Siemens dicom','GE dicom','United Imaging dicom'};
            [indx,tf] = listdlg('PromptString',{'4D flow file type',...
                'Only one file can be selected',''},...
                'SelectionMode','single','ListString',list);
            filetype = list{indx};

            switch filetype
                case 'Philips .rec'
                    [filename,directory] = uigetfile('*.rec','Select Reconstructed Data');
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadPARREC(directory, filename);
                case 'Philips dicom'
                    directory = uigetdir('Select parent Philips dicom directory (with 4 subfolders)');
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadPhilipsDicom(directory);
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
                    if length(dir(directory)) ~= 6 % includes . and ..
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

                case 'United Imaging dicom'
                    directory = uigetdir('Select parent United Imaging dicom directory (with 4 subfolders)');
                    % quick check that all directories exist
                    if length(dir(directory)) ~= 6 % inclues . and ..
                        error('directory does not contain 4 subfolders (with United Imaging dicoms)');
                    end
                    [app.nframes, app.res, app.fov, app.pixdim, app.timeres, app.v, app.MAG, ...
                        app.magWeightVel, app.angio, app.vMean, app.VENC, app.ori] = loadUnitedImagingDicom(directory);
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

            app.ViewDataButton.Enable = 'on';
            app.FramesToUse.Enable = 'on';
            app.FramesToUse.Value = ['1:' num2str(app.nframes)];

            app.ManualsegmentationupdateButton.Visible = 'on';
        end

        % Button pushed function: ViewDataButtonPushed
        function ViewDataButtonPushed(app, ~)
            % collect data to view in View4D
            View4D(cat(1,cat(2,(app.MAG*app.VENC*2)-app.VENC,squeeze(app.v(:,:,:,1,:))),...
                cat(2,squeeze(app.v(:,:,:,2,:)),squeeze(app.v(:,:,:,3,:)))),[],'axisnames',{'','',''});
        end

        % Button pushed function: SaveAppStateButton
        function SaveAppStateButtonPushed(app, ~)
            % get output name
            [file,path] = uiputfile([app.directory '\*.mat'],'Select app state file name and location');
            filename = fullfile(path,file);

            state = struct();
            props = properties(app);
            for i = 1:length(props)
                name = props{i};
                comp = app.(name);  % May be a component or a property, so far...
                c = string(class(comp));
                if c == "matlab.ui.control.NumericEditField" ...
                        || c == "matlab.ui.control.EditField" ...
                        || c == "matlab.ui.control.CheckBox"
                    state.(name)= comp.Value;
                elseif c == "matlab.ui.control.DropDown"
                    % These are weird, had to be specially handled to save a string
                    % instead of an index into the list:
                    v = comp.Value;
                    if  ~isempty(v)
                        id = find(strcmp(comp.Items,v));
                        state.(name)= comp.Items{id};
                    end
                elseif c == "matlab.ui.container.CheckBoxTree"
                    for ii = 1:size(comp.CheckedNodes,1)
                        tag(ii) = string(app.(name).CheckedNodes(ii).Tag);
                    end
                    if exist('tag','var')
                        state.(name) = tag;
                    end
                elseif c == "matlab.ui.control.ListBox"
                    state.(name) = comp.Items;
                elseif c == "matlab.ui.control.Table"
                    state.(name) = comp.Data;
                end
            end
            % we also load the privateValuesList and loop through that
            allValues = struct(); visOptions = struct();
            privateValuesList;  % loads appPrivateValues
            for i = 1:length(appPrivateValues)
                name = appPrivateValues(i);
                if contains(name,'VisOptionsApp')
                    % we loop through and save the VisOptionsApp state
                    tempApp = app.VisOptionsApp;
                    propsVisOptions = properties(tempApp);
                    for ii = 1:length(propsVisOptions)
                        nameVisOptions = propsVisOptions{ii};
                        comp = tempApp.(nameVisOptions);  % May be a component or a property, so far...
                        c = string(class(comp));
                        if c == "matlab.ui.control.NumericEditField" ...
                                || c == "matlab.ui.control.EditField" ...
                                || c == "matlab.ui.control.CheckBox"
                            visOptions.(nameVisOptions)= comp.Value;
                        elseif c == "matlab.ui.control.DropDown"
                            % These are weird, had to be specially handled to save a string
                            % instead of an index into the list:
                            v = comp.Value;
                            if  ~isempty(v)
                                id = find(strcmp(comp.Items,v));
                                visOptions.(nameVisOptions)= comp.Items{id};
                            end
                        elseif c == "matlab.ui.container.CheckBoxTree"
                            for ii = 1:size(comp.CheckedNodes,1)
                                tag(ii) = string(tempApp.(nameVisOptions).CheckedNodes(ii).Tag);
                            end
                            if exist('tag','var')
                                visOptions.(nameVisOptions) = tag;
                            end
                        elseif c == "matlab.ui.control.ListBox"
                            visOptions.(nameVisOptions) = comp.Items;
                        elseif c == "matlab.ui.control.Table"
                            visOptions.(nameVisOptions) = comp.Data;
                        end
                    end
                else
                    allValues.(name) = app.(name);
                end
            end
            save(filename,'state','allValues','visOptions');
            % inform of the saving
            msgbox(['App state saved to ' filename], 'Saving complete','replace')
        end

        % Button pushed function: RestoreAppStateButton
        function RestoreAppStateButtonPushed(app, ~)
            if ~isempty(app.directory)
                [file,path] = uigetfile([app.directory '\*.mat'],'Selection app state file name');
            else
                [file,path] = uigetfile('*.mat','Selection app state file name');
            end
            filename = fullfile(path,file);

            load(filename, 'state','allValues','visOptions')
            fields = fieldnames(state);
            for i = 1:length(fields)
                name = fields{i};
                try   % or could use isprop(app, name) to test presence
                    comp = app.(name);
                    if class(comp) == "matlab.ui.container.CheckBoxTree"
                        tags = state.(name);
                        for ii = 1:size(tags,2)
                            checkedNodes(ii) = findall(0,'tag',tags(ii));
                        end
                        app.(name).CheckedNodes = checkedNodes;
                    elseif class(comp) == "matlab.ui.control.ListBox"
                        comp.Items = state.(name);
                    elseif class(comp) == "matlab.ui.control.Table"
                        comp.Data = state.(name);
                    else
                        comp.Value = state.(name);
                    end
                catch err
                    disp(['Did not use saved field', name, ': ', err.identifier])
                end
            end
            % we also load the privateValuesList and loop through that
            privateValuesList;  % loads appPrivateValues
            for i = 1:length(appPrivateValues)
                name = appPrivateValues(i);
                if contains(name,'VisOptionsApp')
                    app.VisOptionsApp = VisOptionsDialog(app, round(app.VENC/10));
                    % we loop through and save the VisOptionsApp state
                    fields = fieldnames(visOptions);
                    for ii = 1:length(fields)
                        visOptionsName = fields{ii};
                        try   % or could use isprop(app, name) to test presence
                            comp = app.VisOptionsApp.(visOptionsName);
                            if class(comp) == "matlab.ui.container.CheckBoxTree"
                                tags = visOptions.(visOptionsName);
                                for ii = 1:size(tags,2)
                                    checkedNodes(ii) = findall(0,'tag',tags(ii));
                                end
                                app.VisOptionsApp(visOptionsName).CheckedNodes = checkedNodes;
                            elseif class(comp) == "matlab.ui.control.ListBox"
                                comp.Items = visOptions.(visOptionsName);
                            elseif class(comp) == "matlab.ui.control.Table"
                                comp.Data = visOptions.(visOptionsName);
                            else
                                comp.Value = visOptions.(visOptionsName);
                            end
                        catch err
                            disp(['Did not use saved field', name, ': ', err.identifier])
                        end
                    end
                else
                    try
                        app.(name) = allValues.(name);
                    catch
                        warning('%s is not a member of app group',name);
                    end
                end
            end

            % try to run some basic functions
            app.InterpolateData.Enable = 'on';
            app.ViewDataButton.Enable = 'on';
            app.ManualsegmentationupdateButton.Visible = 'on';
            try
                View3DSegmentation(app);
            catch err
                disp(['could not restore View3DSegmentation: ', err.identifier])
            end
            try
                updateMIPs(app);
            catch err
                disp(['could not restore  updateMIPs: ', err.identifier])
            end
            try
                app.TimeframeSpinner_3.Limits = [1,app.nframes];
                app.SliceSpinner.Limits = [1 size(app.angio,3)];
                app.PeaksystoleEditField.Value = num2str(app.time_peak);
                app.TimeframeSpinner_3.Value = app.time_peak;

                % if we have been on this page before and already have a slice,
                app.SliceSpinner.Value = round(size(app.angio,3)/2);
                app.h1 = [];
                plotVelocities(app);
            catch err
                disp(['could not restore  plotVelocities: ', err.identifier])
            end
            try
                app.TimeframeSpinnerLabel.Enable = 'on';
                app.TimeframeSpinner.Enable = 'on';
                app.TimeframeSpinner.Limits = [1,app.nframes];
                app.CalculateMap.Enable = 'on';
                app.TimeframeSpinner.Value = app.time_peak;

                app.SaveAnimation.Enable = 'on';
                app.SaveRotatedAnimation.Enable = 'on';
                app.VisOptions.Enable = 'on';
                app.MapROIanalysis.Enable = 'on';
                app.MapVolumetricanalysis.Enable = 'on';
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
                        app.VisTypeDropDown.Value = 'Vectors';
                    case 'segmentation'
                        app.SliceSpinner_2Label.Visible = 'off';
                        app.SliceSpinner_2Label.Enable = 'off';
                        app.SliceSpinner_2.Visible = 'off';
                        app.SliceSpinner_2.Enable = 'off';

                        app.MapVolumetricanalysis.Enable = 'on';

                        app.VisOptionsApp.projectionDropDown.Enable = 'on';
                        app.VisOptionsApp.projectionDropDown_Label.Enable = 'on';
                        app.VisTypeDropDown.Items = {'Vectors','Streamlines'};
                    case 'centerline contours'
                        app.SliceSpinner_2Label.Visible = 'off';
                        app.SliceSpinner_2Label.Enable = 'off';
                        app.SliceSpinner_2.Visible = 'off';
                        app.SliceSpinner_2.Enable = 'off';

                        app.MapVolumetricanalysis.Enable = 'on';

                        app.VisOptionsApp.projectionDropDown.Enable = 'on';
                        app.VisOptionsApp.projectionDropDown_Label.Enable = 'on';

                        app.VisTypeDropDown.Items = {'Vectors','Streamlines','Pathlines'};
                end
                app.TimeframeSpinner.Value = app.time_peak;
                app.VisOptionsApp = VisOptionsDialog(app, round(app.VENC/10));
                updateVisualization(app);
                viewMap(app);
            catch err
                disp(['could not restore  updateVisualization: ', err.identifier])
            end
            try
                plotWaveforms(app);
            catch err
                disp(['could not restore  plotWaveforms: ', err.identifier])
            end
        end

        % Button pushed function: ClearAppAndRestartButton
        function ClearAppAndRestartButtonPushed(app, ~)
            try
                if ~isempty(app.VisOptionsApp) && ...
                        ishandle(app.VisOptionsApp.VisOptionsDialogUIFigure)
                    delete(app.VisOptionsApp.VisOptionsDialogUIFigure);
                end
            catch
            end
            delete(app.FlowProcessingUIFigure);  % close the app
            close all force;
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
                    app.SegTimeframeSpinner.Limits = [0 app.nframes];
                else    % only one frame
                    app.aorta_seg = zeros(size(app.angio));
                    app.aorta_seg = double(niftiread(fullfile(app.segDirectory,tmp)));
                end
                % lastly check nifti info in case of needed permutations
                % (slicer export issue), check for rotation
                info_tmp = niftiinfo(fullfile(tmp2(1).folder,tmp));
                threshold = 1e-3; R = info_tmp.Transform.T(1:3,1:3);
                Rn = R ./ vecnorm(R);
                isAxisAligned = true;
                for i = 1:3
                    nz = sum(abs(Rn(:,i)) > threshold);
                    if nz ~= 1
                        isAxisAligned = false;
                        break;
                    end
                end

                if ~isAxisAligned
                    app.aorta_seg = permute(app.aorta_seg,[2 1 3]);
                end
            elseif strncmp(tmp(end-3:end),'.nii',3)
                app.aorta_seg = double(niftiread(fullfile(app.segDirectory,tmp)));
                info_tmp = niftiinfo(fullfile(app.segDirectory,tmp));
                if any(info_tmp.Transform.T([2 3 5]) ~= 0)
                    app.aorta_seg = permute(app.aorta_seg,[2 1 3]);
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
                if prod(size(app.aorta_seg,1:3)) ~= length(maskIdx)
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
                    app.maskHandles{ii}.Visible = 'on';
                    app.maskHandles{ii}.Value   = 1;
                end
                app.aorta_seg = tmpMask; clear tmp tmpMask;
                app.MaskLabel.Visible = 'on';
            else
                % keep hidden, but turn on mask1 for viewing
                app.mask1.Value = 1;
            end

            View3DSegmentation(app);
            cd(currDir);

            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: FramesToUseValueChanged
        function FramesToUseValueChanged(app, ~)

            str = app.FramesToUse.Value;
            ptRange = str2num(str);

            % first we recalculate the angio, then show the result
            [app.magWeightVel, app.angio] = calc_angio(app.MAG(:,:,:,ptRange), app.v(:,:,:,:,ptRange), app.VENC);
            updateMIPs(app);
            normed_MIP = app.angio./max(app.angio(:));
            % fit a Gaussian to non-zero elements to determine threshold
            [muhat,sigmahat] = norm_fit(normed_MIP(:));

            app.segment = zeros(size(app.angio));
            app.segment(normed_MIP>muhat+2*sigmahat) = 1;

            app.segment = bwareaopen(app.segment,round(sum(app.segment(:)).*0.005),6); %The value at the end of the commnad in the minimum area of each segment to keep
            app.segment = imfill(app.segment,18,'holes'); % Fill in holes created by slow flow on the inside of vessels
            app.segment = single(app.segment);

            View3DSegmentation(app);
        end

        % Value changed function: flipseglr
        function flipseglrValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,2);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: flipsegud
        function flipsegudValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,1);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: flipsegio
        function flipsegioValueChanged(app, ~)
            app.aorta_seg = flip(app.aorta_seg,3);
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask1
        function mask1ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask2
        function mask2ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            updateMIPs(app);
        end

        % Value changed function: mask3
        function mask3ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask4
        function mask4ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            updateMIPs(app);
        end

        % Value changed function: mask5
        function mask5ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask6
        function mask6ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
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

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask9
        function mask9ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateMIPs(app);
        end

        % Value changed function: mask10
        function mask10ValueChanged(app, ~)
            View3DSegmentation(app);
            m_xstart = 1; m_ystart = 1; m_zstart = 1;
            m_xstop = app.res(1); m_ystop = app.res(2); m_zstop = app.res(3);

            app.is3DSegChanged = 1;
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
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
                app.FramesToUse.Enable = 'off';
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

            if app.isTimeResolvedSeg
                Vmag = app.aorta_seg.*squeeze(sqrt(sum(app.v.^2,4)));
                idx = find(mean(app.aorta_seg,4));
            else
                currSeg = app.getCurrentSeg(app.TimeframeSpinner.Value);
                Vmag = repmat(currSeg,[1 1 1 app.nframes]).*squeeze(sqrt(sum(app.v.^2,4)));
                idx = find(sum(currSeg,4));
            end
            for t = 1:app.nframes
                tmp = Vmag(:,:,:,t);
                mean_velo(t) = mean(tmp(idx));
            end
            [~,app.time_peak] = find(mean_velo==max(mean_velo));

            app.PeaksystoleEditField.Value = num2str(app.time_peak);
            app.TimeframeSpinner.Value = app.time_peak;

            % view vectors
            app.VisOptionsApp = VisOptionsDialog(app, round(app.VENC/10));
            if contains(app.VisOptionsDropDown.Value,'slice-wise')
                app.VisOptionsApp.view_3Dpatch_checkbox.Value = 0;
            else
                app.VisOptionsApp.view_3Dpatch_checkbox.Value = 1;
            end
            colormap(app.VisualizationPlot, 'jet');
            clim(app.VisualizationPlot, [0 app.VENC/10]);

            % Colorbar once
            colorbar(app.VisualizationPlot,'off');
            app.cbar_vis = colorbar(app.VisualizationPlot);

            % reset the patches
            app.streamPatch = [];
            app.vectorPatch = [];
            idxToRemove = [];
            for ii = 1:numel(app.VisualizationPlot.Children)
                if contains(app.VisualizationPlot.Children(ii).Tag,'vector_patch')
                    idxToRemove = cat(1,idxToRemove,ii);
                end
            end
            delete(app.VisualizationPlot.Children(idxToRemove));

            idxToRemove = [];
            for ii = 1:numel(app.VisualizationPlot.Children)
                if contains(app.VisualizationPlot.Children(ii).Tag,'streamline_patch')
                    idxToRemove = cat(1,idxToRemove,ii);
                end
            end
            delete(app.VisualizationPlot.Children(idxToRemove));

            app.vis3Dsurface = [];
            app.vis3DSegsurface = [];
            idxToRemove = [];
            for ii = 1:numel(app.VisualizationPlot.Children)
                if contains(app.VisualizationPlot.Children(ii).Tag,'3D_seg_surface')
                    idxToRemove = cat(1,idxToRemove,ii);
                end
                if contains(app.VisualizationPlot.Children(ii).Tag,'3D_surface')
                    idxToRemove = cat(1,idxToRemove,ii);
                end
            end
            delete(app.VisualizationPlot.Children(idxToRemove));

            updateVisualization(app);
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
                app.FramesToUse.Enable = 'off';
            end

            % these are hard-coded for now
            sortingCriteria = 3;
            spurLength = 3;

            se = strel('sphere',1);
            if app.isSegmentationLoaded
                if app.isTimeResolvedSeg
                    ss = imerode(app.aorta_seg(:,:,:,app.time_peak),se);
                else
                    currSeg = app.getCurrentSeg();
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

            % Initial spline fit at default smoothing
            planeWidth = round(str2double(app.PlaneWidth.Value)/mean(app.pixdim)/2);
            [app.branchActual, Tangent_V] = app.fitCenterlineSpline(tmpBranch, 10);

            reset3DSegmentationAndCenterline(app);
            line(app.View3D_2, app.branchActual(:,2), app.branchActual(:,1), app.branchActual(:,3), ...
                'Color','g','Marker','*','MarkerSize',12,'LineStyle','none');
            viewPlanesIn3D(app.View3D_2, Tangent_V, planeWidth, app.branchActual);

            choice = choosedialog;

            switch choice
                case 0
                    msgbox('Change selected branch numbers')
                    reset3DSegmentationAndCenterline(app);
                    return;

                case 3  % pick start/end points, then tune and calculate
                    currSeg_pick = app.getCurrentSeg(app.SegTimeframeSpinner.Value);
                    currSeg_sm   = smooth3(double(currSeg_pick));

                    % Build figure matching reset3DSegmentationAndCenterline style
                    fig_pick = figure('Name','Pick centerline: click START then END, press Enter when done', ...
                        'Color','w', 'NumberTitle','off');
                    ax_pick = axes(fig_pick);
                    hold(ax_pick,'on');

                    hpatch_pick = patch(ax_pick, isosurface(currSeg_sm, 0.5), 'FaceAlpha', 0.20);
                    reducepatch(hpatch_pick, 0.6);
                    set(hpatch_pick, 'FaceColor',[0.7 0.7 0.7], 'EdgeColor','none', 'PickableParts','none');

                    axis(ax_pick,'vis3d','off');
                    colormap(ax_pick,'colorcube');
                    camlight(ax_pick); lighting(ax_pick,'gouraud');
                    view(ax_pick, [0 0 -1]);
                    daspect(ax_pick, [1 1 1]);
                    camorbit(ax_pick, app.rotAngles(2), app.rotAngles(1), [1 1 0]);
                    title(ax_pick, 'Building skeleton...');
                    drawnow;

                    % Build skeleton first so we can snap clicks to it immediately
                    skel = bwskel(logical(currSeg_pick));
                    [idx_x, idx_y, idx_z] = ind2sub(size(skel), find(skel));
                    skel_pts = [idx_x, idx_y, idx_z];

                    if isempty(skel_pts)
                        close(fig_pick);
                        msgbox('Skeleton is empty — try a larger/smoother segmentation.','Error','error');
                        return;
                    end

                    % Collect clicks one at a time using ax.CurrentPoint for 3D snapping.
                    % ax.CurrentPoint is a 2x3 matrix [near; far] in TRUE 3D data
                    % coordinates, updated on every click regardless of camorbit rotation.
                    % We find the skeleton point with minimum distance to this pick ray.
                    disp('Click START point, then END point...');
                    clicks_idx = zeros(1,2);
                    hClickPts = gobjects(2,1);
                    clr        = [0 1 1; 1 0 1];   % cyan = start, magenta = end

                    % skel_pts is [row col slice] = [plot-Y plot-X plot-Z]
                    % convert to plot-space for ray distance: [X Y Z] = [col row slice]
                    skel_XYZ = [skel_pts(:,2), skel_pts(:,1), skel_pts(:,3)];

                    for nClick = 1:2
                        if nClick == 1
                            title(ax_pick, 'Click START point (cyan)...');
                        else
                            title(ax_pick, 'Click END point (magenta)...');
                        end
                        drawnow;

                        % ginput(1) blocks until the user clicks; we discard its
                        % 2D return values and use ax.CurrentPoint instead.
                        ginput(1);
                        cp = ax_pick.CurrentPoint;   % [2 x 3]: near and far plane points

                        % Ray from near to far in 3D data (plot) coordinates
                        ray_origin = cp(1,:);              % [X Y Z] of near point
                        ray_dir    = cp(2,:) - cp(1,:);    % direction vector

                        % Find skeleton point with minimum distance to this ray
                        % dist = ||(p - o) - ((p-o)·d/|d|²)·d||
                        diff_pts = skel_XYZ - ray_origin;
                        t_vals   = (diff_pts * ray_dir') / (ray_dir * ray_dir');
                        closest  = ray_origin + t_vals .* ray_dir;
                        dist3d   = sqrt(sum((skel_XYZ - closest).^2, 2));
                        [~, nearest] = min(dist3d);
                        clicks_idx(nClick) = nearest;

                        % Show snapped marker at its true 3D position
                        sp = skel_pts(nearest,:);   % [row, col, slice]
                        hClickPts(nClick) = scatter3(ax_pick, ...
                            sp(2), sp(1), sp(3), ...   % [col, row, slice] = [X, Y, Z]
                            120, clr(nClick,:), 'filled', 'MarkerEdgeColor','k');
                        drawnow;
                    end

                    start_idx = clicks_idx(1);
                    end_idx   = clicks_idx(2);

                    % Build graph over skeleton voxels
                    offsets = [];
                    for dx = -1:1;
                        for dy = -1:1;
                            for dz = -1:1
                                if ~(dx==0 && dy==0 && dz==0)
                                    offsets = [offsets; dx dy dz]; %#ok<AGROW>
                                end
                            end
                        end
                    end

                    lin_idx  = sub2ind(size(skel), skel_pts(:,1), skel_pts(:,2), skel_pts(:,3));
                    node_map = containers.Map(lin_idx, 1:length(lin_idx));
                    edges_i = []; edges_j = []; weights = [];
                    for i = 1:length(lin_idx)
                        pt = skel_pts(i,:);
                        for k = 1:size(offsets,1)
                            nb = pt + offsets(k,:);
                            if all(nb >= 1) && nb(1)<=size(skel,1) && ...
                                    nb(2)<=size(skel,2) && nb(3)<=size(skel,3)
                                if skel(nb(1),nb(2),nb(3))
                                    n_lin = sub2ind(size(skel),nb(1),nb(2),nb(3));
                                    if isKey(node_map, n_lin)
                                        edges_i(end+1) = i;    %#ok<AGROW>
                                        edges_j(end+1) = node_map(n_lin); %#ok<AGROW>
                                        weights(end+1) = norm(offsets(k,:)); %#ok<AGROW>
                                    end
                                end
                            end
                        end
                    end
                    G = graph(edges_i, edges_j, weights);
                    path_nodes  = shortestpath(G, start_idx, end_idx);
                    centerline  = skel_pts(path_nodes, :);

                    if isempty(centerline) || size(centerline,1) < 3
                        close(fig_pick);
                        msgbox('Could not find a path between points — try different locations.','Error','error');
                        return;
                    end

                    % Smooth via spline then let user tune interactively
                    [app.branchActual, Tangent_V] = app.fitCenterlineSpline(centerline, 10);
                    [app.branchActual, Tangent_V, accepted] = ...
                        app.tuneSplineInteractive(centerline, app.branchActual, Tangent_V, planeWidth);

                    if ~accepted
                        close(fig_pick);
                        reset3DSegmentationAndCenterline(app);
                        return;
                    end
                    close(fig_pick);

                    % Update the 3D view then run flow calculation
                    reset3DSegmentationAndCenterline(app);
                    line(app.View3D_2, app.branchActual(:,2), app.branchActual(:,1), app.branchActual(:,3), ...
                        'Color','g','Marker','*','MarkerSize',12,'LineStyle','none');
                    app.runFlowCalculation(Tangent_V, planeWidth);
                    return;

                case 1
                    % Let user tune the smoothing before committing
                    [app.branchActual, Tangent_V, accepted] = ...
                        app.tuneSplineInteractive(tmpBranch, app.branchActual, Tangent_V, planeWidth);
                    if ~accepted
                        reset3DSegmentationAndCenterline(app);
                        return;
                    end
                    app.runFlowCalculation(Tangent_V, planeWidth);
                    return;
            end
        end

        % -----------------------------------------------------------------
        % HELPER: fit a cubic spline to raw branch points.
        % percSpacing controls how many knots are used (1=dense, 50=coarse).
        % -----------------------------------------------------------------
        function [branchOut, tangentOut] = fitCenterlineSpline(app, rawPts, percSpacing) %#ok<INUSL>
            if size(rawPts,1) > 25 && percSpacing < 100
                nKnots = max(2, round(size(rawPts,1) * percSpacing / 100));
                ptSkip = round(linspace(1, size(rawPts,1), nKnots));
                curve  = cscvn(rawPts(ptSkip,:)');
            else
                curve  = cscvn(rawPts');
            end
            t        = linspace(0, curve.breaks(end), size(rawPts,1));
            branchOut  = fnval(curve, t)';
            tangentOut = normalize(fnval(fnder(curve), t)', 2, 'norm');
        end

        % -----------------------------------------------------------------
        % INTERACTIVE SPLINE TUNER
        % Shows the 3D surface, spline fit, and cross-sectional planes.
        % The user moves a slider to adjust smoothing and clicks Accept.
        % Returns the accepted branchActual, Tangent_V, and a flag.
        % -----------------------------------------------------------------
        function [branchOut, tangentOut, accepted] = ...
                tuneSplineInteractive(app, rawPts, branchIn, tangentIn, planeWidth)

            branchOut  = branchIn;
            tangentOut = tangentIn;
            accepted   = false;

            currSeg = app.getCurrentSeg(1);

            % --- build figure -------------------------------------------
            fig = figure('Name', 'Adjust spline smoothing — then Accept or Cancel', ...
                'Color','w', 'NumberTitle','off', ...
                'Position', [100 100 900 780]);

            % 3D axes — slightly taller to make room for two sliders
            ax3d = axes(fig, 'Units','normalized', 'Position',[0.05 0.22 0.90 0.75]);
            hold(ax3d,'on');

            % Segmentation surface (background, static)
            hSurf = patch(ax3d, isosurface(smooth3(double(currSeg)), 0.5));
            isonormals(smooth3(double(currSeg)), hSurf);
            hSurf.FaceColor = [0.7 0.7 0.7];
            hSurf.EdgeColor = 'none';
            hSurf.FaceAlpha = 0.15;
            hSurf.PickableParts = 'none';

            % Centerline line (updated on slider change)
            hLine  = plot3(ax3d, branchIn(:,2), branchIn(:,1), branchIn(:,3), 'g-', 'LineWidth', 2.5);
            hStart = scatter3(ax3d, branchIn(1,2),   branchIn(1,1),   branchIn(1,3),   80,'c','filled');
            hEnd   = scatter3(ax3d, branchIn(end,2), branchIn(end,1), branchIn(end,3), 80,'m','filled');

            daspect(ax3d,[1 1 1]); axis(ax3d,'tight','off');
            camlight(ax3d); lighting(ax3d,'gouraud');
            view(ax3d,[0 0 -1]);
            camorbit(ax3d,app.rotAngles(2),app.rotAngles(1),[1 1 0]);
            legend(ax3d, {'Surface','Centerline','Start','End'}, 'Location','best');
            title(ax3d, 'Adjust sliders, then click Accept');

            % --- slider row 1: smoothing --------------------------------
            uicontrol(fig, 'Style','text', 'Units','normalized', ...
                'Position',[0.05 0.14 0.20 0.05], 'String','Smoothing (%):', ...
                'FontSize',12, 'BackgroundColor','w', 'HorizontalAlignment','right');
            curSmooth = 10;
            hSliderSmooth = uicontrol(fig, 'Style','slider', 'Units','normalized', ...
                'Position',[0.26 0.14 0.50 0.05], ...
                'Min',1, 'Max',50, 'Value',curSmooth, 'SliderStep',[1/49, 5/49]);
            hSmoothLbl = uicontrol(fig, 'Style','text', 'Units','normalized', ...
                'Position',[0.77 0.14 0.10 0.05], ...
                'String',sprintf('%d%%', curSmooth), 'FontSize',12, 'BackgroundColor','w');

            % --- slider row 2: plane spacing ----------------------------
            uicontrol(fig, 'Style','text', 'Units','normalized', ...
                'Position',[0.05 0.07 0.20 0.05], 'String','Plane spacing:', ...
                'FontSize',12, 'BackgroundColor','w', 'HorizontalAlignment','right');
            curStep = 5;
            hSliderStep = uicontrol(fig, 'Style','slider', 'Units','normalized', ...
                'Position',[0.26 0.07 0.50 0.05], ...
                'Min',1, 'Max',20, 'Value',curStep, 'SliderStep',[1/19, 3/19]);
            hStepLbl = uicontrol(fig, 'Style','text', 'Units','normalized', ...
                'Position',[0.77 0.07 0.10 0.05], ...
                'String',sprintf('every %d', curStep), 'FontSize',12, 'BackgroundColor','w');

            % --- Accept / Cancel buttons --------------------------------
            hAccept = uicontrol(fig, 'Style','pushbutton', 'Units','normalized', ...
                'Position',[0.60 0.01 0.18 0.06], 'String','Accept', ...
                'FontSize',14, 'FontWeight','bold', 'BackgroundColor',[0.3 0.8 0.3]);
            hCancel = uicontrol(fig, 'Style','pushbutton', 'Units','normalized', ...
                'Position',[0.80 0.01 0.15 0.06], 'String','Cancel', ...
                'FontSize',14, 'BackgroundColor',[0.9 0.4 0.4]);

            % State
            state.branch       = branchIn;
            state.tangent      = tangentIn;
            state.accepted     = false;
            state.planeHandles = gobjects(0);

            % Draw initial planes
            state = redrawPlanes(state, branchIn, tangentIn, curStep);
            legend(ax3d, {'Surface','Centerline','Start','End'}, 'Location','best');

            % Callbacks
            hSliderSmooth.Callback = @(src,~) onSmoothChanged(src);
            hSliderStep.Callback   = @(src,~) onStepChanged(src);
            hAccept.Callback       = @(~,~)   setDone(true);
            hCancel.Callback       = @(~,~)   setDone(false);

            function onSmoothChanged(src)
                perc = round(src.Value);
                hSmoothLbl.String = sprintf('%d%%', perc);
                [b, tv] = app.fitCenterlineSpline(rawPts, perc);
                state.branch  = b;
                state.tangent = tv;
                set(hLine, 'XData',b(:,2), 'YData',b(:,1), 'ZData',b(:,3));
                set(hStart,'XData',b(1,2),   'YData',b(1,1),   'ZData',b(1,3));
                set(hEnd,  'XData',b(end,2), 'YData',b(end,1), 'ZData',b(end,3));
                state = redrawPlanes(state, b, tv, round(hSliderStep.Value));
                legend(ax3d, {'Surface','Centerline','Start','End'}, 'Location','best');
                drawnow;
                end

            function onStepChanged(src)
                step = round(src.Value);
                hStepLbl.String = sprintf('every %d', step);
                state = redrawPlanes(state, state.branch, state.tangent, step);
                legend(ax3d, {'Surface','Centerline','Start','End'}, 'Location','best');
                drawnow;
            end

            function st = redrawPlanes(st, b, tv, step)
                if ~isempty(st.planeHandles)
                    delete(st.planeHandles(isvalid(st.planeHandles)));
                end
                childBefore = ax3d.Children;
                viewPlanesIn3D(ax3d, tv, planeWidth, b, step);
                st.planeHandles = setdiff(ax3d.Children, childBefore);
            end

            function setDone(ok)
                state.accepted = ok;
                uiresume(fig);
            end

            uiwait(fig);

            if ishandle(fig)
                branchOut  = state.branch;
                tangentOut = state.tangent;
                accepted   = state.accepted;
                close(fig);
            end
        end

        % -----------------------------------------------------------------
        % HELPER: run flow calculation after centerline is finalised.
        % Shared by case 1 (accept) and case 3 (point-picked centerline).
        % -----------------------------------------------------------------
        function runFlowCalculation(app, Tangent_V, planeWidth)
            clc;
            % calculate aorta segmentation, if not already available
            if ~app.isSegmentationLoaded
                x = round(app.branchActual(:,1));
                y = round(app.branchActual(:,2));
                z = round(app.branchActual(:,3));
                index = sub2ind(size(app.segment),x,y,z);
                g = zeros(size(app.segment));
                g(index) = 1;

                se = strel('sphere',4);
                app.aorta_seg = smooth3(imdilate(g,se));
            end

            % Build time-resolved segmentation
            if app.isTimeResolvedSeg
                aortaSeg_timeResolved = app.aorta_seg;
            else
                aortaSeg_timeResolved = zeros([size(app.angio) app.nframes]);
                currSeg = app.getCurrentSeg(1);
                if ~app.isSegmentationLoaded
                    currSeg = app.segment;
                end
                for j = 1:app.nframes
                    aortaSeg_timeResolved(:,:,:,j) = currSeg;
                end
            end

            % Calculate flow
            displayWaitBar = true;
            % Store the vessel tangent (plane normal)
            app.vesselTangent = Tangent_V;

            [app.flowPerHeartCycle_vol, app.flowPulsatile_vol, app.contours, app.tangent_V, app.area_val, ...
                xf, yf, zf] = ...
                params_timeResolved(app.branchActual, app.angio, app.MAG, app.v, app.nframes, app.pixdim, ...
                aortaSeg_timeResolved, app.isSegmentationLoaded, app.isTimeResolvedSeg, ...
                Tangent_V, planeWidth, displayWaitBar);
            % Store plane coordinates for reuse in visualization (avoids re-running obliqueslice)
            app.contourCoords.x = xf;
            app.contourCoords.y = yf;
            app.contourCoords.z = zf;
            app.contourCoords.planeWidth = planeWidth;
            % Also store frame-1 segmentation mask at each plane for seed point extraction
            app.contourCoords.seg       = app.contours(:,:,1);
            app.flowPerHeartCycle_vol = app.flowPerHeartCycle_vol*app.timeres/1000;

            % Enable flow-dependent UI
            app.DisplayDistanceCheckbox.Enable = true;
            app.DisplayDistanceCheckbox.Visible = 'on';
            app.ParameterDropDown.Enable = true;
            app.ParameterDropDown.Visible = 'on';
            app.ParameterLabel.Visible = 'on';

            % Calculate cumulative distance along centerline
            branch = app.branchActual;
            vox = mean(app.pixdim);
            dist_vec = zeros(1, size(branch,1)-1);
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
            CalculatePWVButtonPushed(app, []);

            % View results
            view3D_wParams(app);
            plotWaveforms(app);

            % Update maps tab
            app.VisOptionsDropDown.Items = {'segmentation','slice-wise','centerline contours'};
            app.VisOptionsApp.VisPts.Value = ['5:10:' num2str(length(app.branchActual)-4)];
            app.VisOptionsApp.VisPts_Label.Text = sprintf('contour points\n[1:%i]',length(app.branchActual));
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
                ptRange = str2num(str);
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
            netflows = app.flowPerHeartCycle_vol(index);
            str = app.PWVPoints.Value;
            if app.DisplayDistanceCheckbox.Value
                out = textscan(str,'%f %f','Delimiter',':');
                [~, minIdx] = min(abs(app.FullBranchDistance-out{1}));
                [~, minIdx2] = min(abs(app.FullBranchDistance-out{2}));
                ptRange = minIdx:minIdx2;
            else
                ptRange = str2num(str);
            end

            % save sheet with ptRange and distance
            tbl = array2table(cat(2,nan,app.FullBranchDistance(ptRange)));
            tbl.Properties.VariableNames = ["point number",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','distance (mm)','WriteMode','overwritesheet');

            waveforms = waveforms(ptRange,:);
            netflows = netflows(ptRange);
            card_time = (0:app.nframes-1)*app.timeres;
            tbl = array2table(cat(2,([card_time nan])',cat(2,waveforms,netflows)'));
            tbl.Properties.VariableNames = ["cardiac time(ms)",string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','flow(ml per s)','WriteMode','overwritesheet');
            tbl = array2table(netflows');
            tbl.Properties.VariableNames = [string(ptRange)];
            writetable(tbl,[saveName '.xlsx'],'Sheet','net flow(ml per cycle)','WriteMode','overwritesheet');

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
                app.FramesToUse.Enable = 'off';
            end
            View3DSegmentation(app);
        end

        % Button pushed function: RotateLeft
        function RotateLeftButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if app.maskHandles{ii}.Value
                        ctr = size(app.segment)/2; rotate(app.patchMasks{ii},[0 1 0],10,[ctr(2) ctr(1) ctr(3)]);
                    end
                end
            else
                ctr = size(app.segment)/2; rotate(app.hpatch1,[0 1 0],10,[ctr(2) ctr(1) ctr(3)])
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)+10];
            app.rotateOriAxis(app.oriAxis_View3D, [0 1 0], 10);
        end

        % Button pushed function: RotateRight
        function RotateRightButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if app.maskHandles{ii}.Value
                        ctr = size(app.segment)/2; rotate(app.patchMasks{ii},[0 1 0],-10,[ctr(2) ctr(1) ctr(3)]);
                    end
                end
            else
                ctr = size(app.segment)/2; rotate(app.hpatch1,[0 1 0],-10,[ctr(2) ctr(1) ctr(3)])
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1) app.rotAngles(2)-10];
            app.rotateOriAxis(app.oriAxis_View3D, [0 1 0], -10);
        end

        % Button pushed function: RotateDown
        function RotateDownButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if app.maskHandles{ii}.Value
                        ctr = size(app.segment)/2; rotate(app.patchMasks{ii},[1 0 0],10,[ctr(2) ctr(1) ctr(3)]);
                    end
                end
            else
                ctr = size(app.segment)/2; rotate(app.hpatch1,[1 0 0],10,[ctr(2) ctr(1) ctr(3)])
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)+10 app.rotAngles(2)];
            app.rotateOriAxis(app.oriAxis_View3D, [1 0 0], 10);
        end

        % Button pushed function: RotateUp
        function RotateUpButtonPushed(app, ~)
            if (app.isSegmentationLoaded)
                for ii = 1:size(app.aorta_seg,4)
                    if app.maskHandles{ii}.Value
                        ctr = size(app.segment)/2; rotate(app.patchMasks{ii},[1 0 0],-10,[ctr(2) ctr(1) ctr(3)]);
                    end
                end
            else
                ctr = size(app.segment)/2; rotate(app.hpatch1,[1 0 0],-10,[ctr(2) ctr(1) ctr(3)])
            end
            % update rotate angles
            app.rotAngles = [app.rotAngles(1)-10 app.rotAngles(2)];
            app.rotateOriAxis(app.oriAxis_View3D, [1 0 0], -10);
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
            app.is3DChanged = 1;

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
                ptRange = str2num(str);
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
            % Use fast path when only the timeframe changed – skips all
            % appearance/geometry work that hasn't changed.
            updateVisualizationData(app);
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
            app.visParams.minMap = str2double(app.VisOptionsApp.minMapEditField.Value);
            app.visParams.maxMap = str2double(app.VisOptionsApp.maxMapEditField.Value);
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

                    currSeg = app.getCurrentSeg(t);

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

            [file,path] = uiputfile([app.directory '\*.gif'],'Selection file name and location');
            filename = fullfile(path,file);

            % user selection of FPS
            prompt = {'output frame/s (1 to 30)):'};
            dlgtitle = 'Select frames per second';
            dims = [1 65];
            definput = {'5'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            delay = 1/str2double(answer{1});
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
            app.rotAngles2 = [0 0 0];
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

            [file,path] = uiputfile([app.directory '\*.gif'],'Selection file name and location');
            filename = fullfile(path,file);

            % --- PRE-LOOP: render frame 1 at zero rotation to establish
            % stable limits BEFORE freezing them. axis tight is still active here.
            app.TimeframeSpinner.Value = 1;
            updateVisualization(app);
            drawnow;

            % Capture the stable limits from the neutral render
            veclim_x = app.VisualizationPlot.XLim;
            veclim_y = app.VisualizationPlot.YLim;
            veclim_z = app.VisualizationPlot.ZLim;
            maplim_x = app.MapPlot.XLim;
            maplim_y = app.MapPlot.YLim;

            % Freeze limits and suppress axis tight for the entire loop
            app.VisualizationPlot.XLim = veclim_x;
            app.VisualizationPlot.YLim = veclim_y;
            app.VisualizationPlot.ZLim = veclim_z;
            app.VisualizationPlot.XLimMode = 'manual';
            app.VisualizationPlot.YLimMode = 'manual';
            app.VisualizationPlot.ZLimMode = 'manual';
            app.MapPlot.XLim = maplim_x;
            app.MapPlot.YLim = maplim_y;
            axis(app.VisualizationPlot, 'vis3d');   % lock aspect ratio for rotation

            app.isAnimating = true;  % suppresses axis tight inside update functions

            ct_time = 1;
            ct_rotation = 0;
            for t = 1:180
                app.TimeframeSpinner.Value = ct_time;
                updateVisualizationData(app);   % fast path – data only, no axis reset

                % Apply current rotation
                view(app.VisualizationPlot, [0 0 1]);
                camorbit(app.VisualizationPlot, 4*ct_rotation, 0, [1 1 0]);

                % Re-apply frozen limits (vis3d may relax them slightly)
                app.VisualizationPlot.XLim = veclim_x;
                app.VisualizationPlot.YLim = veclim_y;
                app.VisualizationPlot.ZLim = veclim_z;
                app.MapPlot.XLim = maplim_x;
                app.MapPlot.YLim = maplim_y;

                drawnow;

                % Capture and write frame
                ff = getframe(app.FlowProcessingUIFigure, [1 25 475 690]);
                im = frame2im(ff);
                im = insertText(im, [100 1], sprintf('t = %2.2f s', (ct_time-1)*(app.timeres/1000)), ...
                    'BoxColor','white','FontSize',18);
                [imind,cm] = rgb2ind(im(1:673,:,:),256);
                delay = 1/(5*2);
                if t == 1
                    imwrite(imind,cm,filename,'gif', 'WriteMode','overwrite','DelayTime', delay, 'LoopCount', Inf);
                else
                    imwrite(imind,cm, filename,'gif','WriteMode','append','DelayTime',delay);
                end

                if mod(t,2) == 1
                    ct_rotation = ct_rotation + 1;
                else
                    ct_time = ct_time + 1;
                    if ct_time > app.nframes, ct_time = 1; end
                end
            end

            % Restore state
            app.isAnimating = false;
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
            % turn off smoothing (it resizes outImg, breaking idx alignment)
            app.VisOptionsApp.smoothMap_checkbox.Value = 0;
            viewMap(app);
            clc; close(figure(700));
            choice = 2;
            while choice == 2
                close(figure(700));
                disp('Draw ROI in map image to check results')
                app.MapPlot.Toolbar.Visible = 'off';
                h = drawpolygon(app.MapPlot,'color', ...
                    app.VisOptionsApp.TextcolorDropDown_2.Value,'FaceAlpha',0);
                BW = createMask(h); idx = find(BW);
                ff = getframe(app.FlowProcessingUIFigure, [476 25 475 690]);
                im = frame2im(ff);
                app.MapPlot.Toolbar.Visible = 'on';
                saveFrame = app.TimeframeSpinner.Value;

                % Pre-compute map for all frames — avoids calling viewMap
                % (which re-renders everything) once per frame.
                map_var = app.computeMapROI(idx);

                card_time = (0:app.nframes-1) * app.timeres;
                [fig, paramString, saveString] = app.plotROIresult( ...
                    700, im, card_time, map_var, app.MapType.Value);

                app.TimeframeSpinner.Value = saveFrame;
                choice = choosedialog_2;

                if choice == 1
                    prompt = {'save name:'}; dims = [1 50];
                    answer = inputdlg(prompt,'set save name ROI analysis',dims,{'vessel'});
                    savePrefix = strcat(answer{1},'_',saveString);
                    saveFolder = fullfile(app.directory,'map_results');
                    mkdir(saveFolder);
                    saveName = fullfile(saveFolder,'mapROI_results');
                    tbl = array2table(cat(2,card_time', ...
                        mean(map_var,1,'omitnan')',max(map_var,[],1,'omitnan')'));
                    tbl.Properties.VariableNames = ...
                        ["cardiac time(ms)","ROI_average","ROI_max"];
                    writetable(tbl,[saveName '.xlsx'], ...
                        'Sheet',savePrefix,'WriteMode','overwritesheet');
                    imwrite(frame2im(getframe(fig)), ...
                        [saveName '_' savePrefix '.tiff']);

                    answer2 = questdlg( ...
                        'Re-use ROI for other params and save results?', ...
                        'Re-use Map ROI','Yes','No','Yes');
                    if strcmp(answer2,'Yes')
                        mapTypes = {'peak velocity','mean velocity', ...
                            'kinetic energy','energy loss','vorticity'};
                        mapTypes(contains(mapTypes,app.MapType.Value)) = [];
                        % Save user's current map scale to restore at the end
                        savedMinMap = app.visParams.minMap;
                        savedMaxMap = app.visParams.maxMap;
                        for mt = 1:length(mapTypes)
                            app.MapType.Value = mapTypes{mt};
                            % Apply the default scale for this map type
                            [defMin, defMax] = app.defaultMapScale(mapTypes{mt});
                            app.visParams.minMap = defMin;
                            app.visParams.maxMap = defMax;
                            app.VisOptionsApp.minMapEditField.Value = num2str(defMin);
                            app.VisOptionsApp.maxMapEditField.Value = num2str(defMax);
                            % Render the new map type so the screenshot reflects it
                            viewMap(app);
                            drawnow;
                            ff2 = getframe(app.FlowProcessingUIFigure, [476 25 475 690]);
                            im2 = frame2im(ff2);
                            map_var2 = app.computeMapROI(idx);
                            [fig2,~,ss2] = app.plotROIresult( ...
                                700,im2,card_time,map_var2,mapTypes{mt});
                            sp2 = strcat(answer{1},'_',ss2);
                            tbl2 = array2table(cat(2,card_time', ...
                                mean(map_var2,1,'omitnan')', ...
                                max(map_var2,[],1,'omitnan')'));
                            tbl2.Properties.VariableNames = ...
                                ["cardiac time(ms)","ROI_average","ROI_max"];
                            writetable(tbl2,[saveName '.xlsx'], ...
                                'Sheet',sp2,'WriteMode','overwritesheet');
                            imwrite(frame2im(getframe(fig2)), ...
                                [saveName '_' sp2 '.tiff']);
                        end
                        % Restore user's original scale
                        app.visParams.minMap = savedMinMap;
                        app.visParams.maxMap = savedMaxMap;
                        app.VisOptionsApp.minMapEditField.Value = num2str(savedMinMap);
                        app.VisOptionsApp.maxMapEditField.Value = num2str(savedMaxMap);
                    end
                    msgbox(['results saved to ' saveName '.xlsx'], ...
                        'Saving complete','replace');
                    break;
                elseif choice == 0
                    close(figure(700));
                    disp('ROI analysis cancelled')
                end
            end
        end

        % -----------------------------------------------------------------
        % HELPER: return the default [min, max] scale for each map type.
        % Matches the scaletmp values defined inside viewMap.
        % -----------------------------------------------------------------
        function [minVal, maxVal] = defaultMapScale(app, mapType)
            switch mapType
                case 'wall shear stress';  minVal = 0;      maxVal = 4;
                case 'peak velocity';      minVal = 0;      maxVal = round(app.VENC/10);
                case 'mean velocity';      minVal = 0;      maxVal = round(app.VENC/50);
                case 'kinetic energy';     minVal = 0;      maxVal = 20;
                case 'energy loss';        minVal = -0.001; maxVal = 4;
                case 'vorticity';          minVal = 0;      maxVal = 250;
                otherwise;                minVal = 0;      maxVal = 1;
            end
        end

        % -----------------------------------------------------------------
        % HELPER: pre-compute 2D projected map values at ROI pixels for
        % all timeframes without re-rendering the axis each iteration.
        % -----------------------------------------------------------------
        function map_var = computeMapROI(app, idx)
            nf = app.nframes;
            t0 = app.TimeframeSpinner.Value;

            % Rotate velocity once (rotation fixed for all frames)
            [~, currV_rot1, ~] = app.rotateVol3D( ...
                app.segment, app.v(:,:,:,:,1)/10, ...
                app.MAG(:,:,:,1), app.rotAngles2);
            sz_full = size(currV_rot1, 1:3);

            % Rotate segmentation
            currSeg0 = app.getCurrentSeg(t0);
            tmp = imrotate3(double(currSeg0),app.rotAngles2(2),[0 -1 0],'nearest');
            tmp = imrotate3(tmp,             app.rotAngles2(1),[-1 0 0],'nearest');
            currSeg = logical(imrotate3(tmp, app.rotAngles2(3),[0  0 1],'nearest'));
            if ~isequal(sz_full, size(currSeg))
                pad = false(sz_full);
                r=min(sz_full(1),size(currSeg,1));
                c=min(sz_full(2),size(currSeg,2));
                s=min(sz_full(3),size(currSeg,3));
                pad(1:r,1:c,1:s)=currSeg(1:r,1:c,1:s);
                currSeg=pad;
            end
            if app.VisOptionsApp.mask_erosion_checkbox.Value
                currSeg = mask_erosion(currSeg,0);
            end

            % Build rotated velocity for all frames
            if contains(app.MapTime.Value,'resolved')
                currV = zeros([sz_full,3,nf],'like',app.v);
                for tt = 1:nf
                    [~,vtt,~] = app.rotateVol3D( ...
                        app.segment,app.v(:,:,:,:,tt)/10, ...
                        app.MAG(:,:,:,1),app.rotAngles2);
                    currV(:,:,:,:,tt) = vtt;
                end
            else
                currV = repmat(currV_rot1,[1 1 1 1 nf]);
            end
            vx = currSeg.*currV(:,:,:,1,:);
            vy = currSeg.*currV(:,:,:,2,:);
            vz = currSeg.*currV(:,:,:,3,:);

            % Compute 4D outVol for all frames at once
            switch app.MapType.Value
                case {'peak velocity','mean velocity'}
                    outVol = squeeze(currSeg.*sqrt(vx.^2+vy.^2+vz.^2));
                case 'kinetic energy'
                    rho=1.060; vv=prod(app.pixdim/1000)*1000;
                    vel=(vx/100).^2+(vy/100).^2+(vz/100).^2;
                    outVol=squeeze(1e6*0.5*rho*vv*currSeg.*vel);
                case 'energy loss'
                    v1=squeeze(vx);v2=squeeze(vy);v3=squeeze(vz);
                    [v11,v12,v13]=gradient(v1);
                    [v21,v22,v23]=gradient(v2);
                    [v31,v32,v33]=gradient(v3);
                    div=zeros(size(v1));
                    for tt=1:nf
                        div(:,:,:,tt)=divergence(v1(:,:,:,tt),v2(:,:,:,tt),v3(:,:,:,tt));
                    end
                    gV={v11,v12,v13;v21,v22,v23;v31,v32,v33};
                    th=0;
                    for ii=1:3; for jj=1:3
                            d=double(ii==jj);
                            th=th+(gV{ii,jj}+gV{jj,ii}-(2/3)*div.*d).^2;
                    end; end
                outVol=squeeze(currSeg.*0.004.*(th/2)*prod(app.pixdim)/1000);
                case 'vorticity'
                    px=app.pixdim./1000;
                    [X,Y,Z]=meshgrid((1:sz_full(2))*px(2), ...
                        (1:sz_full(1))*px(1), ...
                        (1:sz_full(3))*px(3));
                    vxs=squeeze(vx)/100; vys=squeeze(vy)/100; vzs=squeeze(vz)/100;
                    cx=zeros(size(vxs));cy=cx;cz=cx;
                    for tt=1:nf
                        [cx(:,:,:,tt),cy(:,:,:,tt),cz(:,:,:,tt)]=...
                            curl(X,Y,Z,vxs(:,:,:,tt),vys(:,:,:,tt),vzs(:,:,:,tt));
                    end
                    outVol=squeeze(currSeg.*sqrt(cx.^2+cy.^2+cz.^2));
                otherwise
                    outVol=zeros([sz_full,nf]);
            end
            outVol(repmat(~currSeg,[1 1 1 nf]))=NaN;

            % Project and extract ROI values
            isSW = contains(app.VisOptionsDropDown.Value,'slice-wise');
            map_var = zeros(length(idx),nf);
            for t = 1:nf
                vol_t = outVol(:,:,:,t);
                if isSW
                    img_t = vol_t(:,:,app.SliceSpinner_2.Value);
                elseif contains(app.VisOptionsApp.projectionDropDown.Value,'mean') || contains(app.MapType.Value, 'mean velocity')
                    img_t = mean(vol_t,3,'omitnan');
                else
                    img_t = max(vol_t,[],3,'omitnan');
                end
                map_var(:,t) = img_t(idx);
            end
        end

        % -----------------------------------------------------------------
        % HELPER: plot ROI waveform result, return figure + label strings
        % -----------------------------------------------------------------
        function [fig, paramString, saveString] = plotROIresult( ...
                ~, figNum, im, card_time, map_var, mapType)
            switch mapType
                case 'peak velocity';   paramString='peak velocity (cm/s)'; saveString='peak_velocity';
                case 'mean velocity';   paramString='mean velocity (cm/s)'; saveString='mean_velocity';
                case 'kinetic energy';  paramString='Max KE (\muJ)';        saveString='KE';
                case 'energy loss';     paramString='EL (mW)';              saveString='EL';
                case 'vorticity';       paramString='vorticity (rad)';      saveString='vorticity';
                otherwise;              paramString=mapType;                 saveString=mapType;
            end
            fig=figure(figNum); clf;
            set(fig,'Name','ROI analysis','position',[2 42 958 684],'color','w');
            subplot(121); image(im); axis off;
            subplot(122);
            plot(card_time,mean(map_var,1,'omitnan'),'*-k','linewidth',2); hold on;
            plot(card_time,max(map_var,[],1,'omitnan'),'square-b','linewidth',2);
            xlabel('cardiac time (ms)'); ylabel(paramString);
            legend('ROI average','ROI max');
            box off; set(gca,'fontsize',16); hold off; drawnow;
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
                    [~, outVol, idx_currSeg] = viewMap(app);
                    % outVol already contains all time frames, so
                    % simply grab the values now
                    tmp = reshape(outVol,[prod(size(outVol,1:3)) app.nframes]);
                    map_var = tmp(idx_currSeg,:); clear tmp;
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
                tbl = array2table(cat(2,mean(map_var,1),max(map_var,[],1)));
                tbl.Properties.VariableNames = ["Vol_average","Vol_max"];
                writetable(tbl,[saveName '.xlsx'],'Sheet','volumetric_WSS_peakSystole','WriteMode','overwritesheet');
            else
                tbl = array2table(cat(2,card_time',mean(map_var,1)',max(map_var,[],1)',sum(map_var,1)'*app.timeres/1000));
                tbl.Properties.VariableNames = ["cardiac time(ms)","Vol_average","Vol_max","Vol_AUC"];
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
                app.FramesToUse.Enable = 'off';
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
                        currSeg = app.getCurrentSeg(1); % frame-independent static seg
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
                app.FramesToUse.Enable = 'off';
            end

            h = waitbar(0, sprintf('Performing divergence free correction...'));
            for t = 1:app.nframes
                % original noisy data
                vxN = double(app.v(:,:,:,1,t));
                vyN = double(app.v(:,:,:,2,t));
                vzN = double(app.v(:,:,:,3,t));

                if app.isSegmentationLoaded
                    currSeg = app.getCurrentSeg(t);
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
                app.FramesToUse.Enable = 'off';
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

            currSeg = app.getCurrentSeg(t);
            tmpV = app.v(:,:,:,:,tf-1:tf).*repmat(currSeg, [1 1 1 3 2]);
            tmpV = squeeze(tmpV(:,:,sl,:,:));
            venc = app.VENC;
            vOut = unaliasSlice(tmpV,venc);

            % assign values back to app.v
            app.v(:,:,sl,:,tf) = permute(vOut,[1 2 4 3 5]);

            plotVelocities(app);
        end

        % Window button down function: FlowProcessingUIFigure
        function FlowProcessingUIFigureWindowButtonDown(app, event)
            if (app.TabGroup.SelectedTab == app.VelocityUnwrappingTab) && ...
                    ~isempty(event.Source.CurrentObject) && isequal(event.Source.CurrentObject.Type,'image') && ...
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
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateVisualization(app);
        end

        % Value changed function: flipvy
        function flipvyValueChanged(app, ~)
            app.v(:,:,:,2,:) = -app.v(:,:,:,2,:);
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            updateVisualization(app);
        end

        % Value changed function: flipvz
        function flipvzValueChanged(app, ~)
            app.v(:,:,:,3,:) = -app.v(:,:,:,3,:);
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
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
            app.pathlineInterp = [];  % invalidate 4D interpolant cache

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
                case 'Pathlines'
                    app.VisOptionsApp.cutoffvaluesLabel.Text = 'min velocity';
                    app.VisOptionsApp.toXEditFieldLabel.Position = [73 180+162 40 22];
                    app.VisOptionsApp.toXEditFieldLabel.Text = 'cm/s';
                    app.VisOptionsApp.maxQuiverEditField.Enable = 'off';
                    app.VisOptionsApp.maxQuiverEditField.Visible = 'off';
                    % Clean up streamline surfaces when switching to pathlines
                    if ~isempty(app.streamPatch)
                        try; delete(app.streamPatch); catch; end
                        app.streamPatch = [];
                    end
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
                    app.VisOptionsApp.show_planes_checkbox.Visible = 'off';
                    app.VisOptionsApp.show_planes_checkbox.Enable = 'off';
                    app.VisOptionsApp.PathlineLengthLabel.Visible = 'off';
                    app.VisOptionsApp.PathlineLengthLabel.Enable = 'off';
                    app.VisOptionsApp.PathlineLengthEditField.Visible = 'off';
                    app.VisOptionsApp.PathlineLengthEditField.Enable = 'off';
                    app.VisOptionsApp.PathlineReleaseLabel.Visible = 'off';
                    app.VisOptionsApp.PathlineReleaseLabel.Enable = 'off';
                    app.VisOptionsApp.PathlineReleaseEditField.Visible = 'off';
                    app.VisOptionsApp.PathlineReleaseEditField.Enable = 'off';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Visible = 'off';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Enable = 'off';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Value = 0;
                    app.VisTypeDropDown.Value = 'Vectors';
                case 'segmentation'
                    if ~isempty(app.sliceImg)
                        delete(findall(app.VisualizationPlot,'Type','image'))
                        app.sliceImg = [];
                    end
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
                    app.VisOptionsApp.show_planes_checkbox.Visible = 'off';
                    app.VisOptionsApp.show_planes_checkbox.Enable = 'off';
                    app.VisOptionsApp.PathlineLengthLabel.Visible = 'off';
                    app.VisOptionsApp.PathlineLengthLabel.Enable = 'off';
                    app.VisOptionsApp.PathlineLengthEditField.Visible = 'off';
                    app.VisOptionsApp.PathlineLengthEditField.Enable = 'off';
                    app.VisOptionsApp.PathlineReleaseLabel.Visible = 'off';
                    app.VisOptionsApp.PathlineReleaseLabel.Enable = 'off';
                    app.VisOptionsApp.PathlineReleaseEditField.Visible = 'off';
                    app.VisOptionsApp.PathlineReleaseEditField.Enable = 'off';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Visible = 'on';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Enable = 'on';
                    app.VisTypeDropDown.Items = {'Vectors','Streamlines'};
                    % Pathlines not available in segmentation mode
                    if strcmp(app.VisTypeDropDown.Value,'Pathlines')
                        app.VisTypeDropDown.Value = 'Vectors';
                    end
                case 'centerline contours'
                    if ~isempty(app.sliceImg)
                        delete(findall(app.VisualizationPlot,'Type','image'))
                        app.sliceImg = [];
                    end
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
                    app.VisOptionsApp.show_planes_checkbox.Visible = 'on';
                    app.VisOptionsApp.show_planes_checkbox.Enable = 'on';
                    app.VisOptionsApp.PathlineLengthLabel.Visible = 'on';
                    app.VisOptionsApp.PathlineLengthLabel.Enable = 'on';
                    app.VisOptionsApp.PathlineLengthEditField.Visible = 'on';
                    app.VisOptionsApp.PathlineLengthEditField.Enable = 'on';
                    app.VisOptionsApp.PathlineReleaseLabel.Visible = 'on';
                    app.VisOptionsApp.PathlineReleaseLabel.Enable = 'on';
                    app.VisOptionsApp.PathlineReleaseEditField.Visible = 'on';
                    app.VisOptionsApp.PathlineReleaseEditField.Enable = 'on';
                    app.VisOptionsApp.VisPts_Label.Text = sprintf('contour points\n[1:%i]',length(app.branchActual));
                    app.VisOptionsApp.view_3Dpatch_checkbox.Visible = 'on';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Enable = 'on';
                    app.VisOptionsApp.view_3Dpatch_checkbox.Value = 1;
                    app.VisTypeDropDown.Items = {'Vectors','Streamlines','Pathlines'};
            end
            app.isStreamsChanged.Value = 1;
            app.isPathlinesChanged.Value = 1;
            % Delete existing streamPatch surfaces — the new mode will produce
            % a different padded length so the old surface dimensions are invalid.
            if ~isempty(app.streamPatch)
                try; delete(app.streamPatch); catch; end
                app.streamPatch = [];
            end
            % Delete existing pathline patches on mode switch
            if ~isempty(app.pathlinePatch)
                try; delete(app.pathlinePatch); catch; end
                app.pathlinePatch = [];
            end
            % Invalidate interpolant cache when vis source changes
            app.pathlineInterp = [];
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
                    activeIdx = app.getActiveMaskIndices();
                    currSeg = currSeg(:,:,:,activeIdx);
                end
            else
                currSeg = app.segment;
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
                    for ii = 1:length(activeIdx)
                        if activeIdx(ii)
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

            % Create ViewDataButton
            app.ViewDataButton = uibutton(app.LoadDataPanel, 'push');
            app.ViewDataButton.ButtonPushedFcn = createCallbackFcn(app, @ViewDataButtonPushed, true);
            app.ViewDataButton.FontName = 'SansSerif';
            app.ViewDataButton.FontSize = 16;
            app.ViewDataButton.Tooltip = {'view loaded 4D flow (mag, velocity) reconstructed data'};
            app.ViewDataButton.Position = [430 180 120 28];
            app.ViewDataButton.Enable = 'off';
            app.ViewDataButton.Text = 'View Data';

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

            % Create FramesToUseLabel
            app.FramesToUseLabel = uilabel(app.LoadDataPanel);
            app.FramesToUseLabel.HorizontalAlignment = 'right';
            app.FramesToUseLabel.FontName = 'SansSerif';
            app.FramesToUseLabel.FontSize = 14;
            app.FramesToUseLabel.Position = [284 1 106 22];
            app.FramesToUseLabel.Text = 'frames to use: ';

            % Create FramesToUse
            app.FramesToUse = uieditfield(app.LoadDataPanel, 'text');
            app.FramesToUse.FontName = 'SansSerif';
            app.FramesToUse.ValueChangedFcn = createCallbackFcn(app, @FramesToUseValueChanged, true);
            app.FramesToUse.FontSize = 14;
            app.FramesToUse.Tooltip = {'manually set the frames to use for processing'};
            app.FramesToUse.Enable = 'off';
            app.FramesToUse.Position = [411 1 150 22];

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
            app.RotateLeft.VerticalAlignment = 'center';
            app.RotateLeft.HorizontalAlignment = 'center';
            app.RotateLeft.BackgroundColor = [1 1 1];
            app.RotateLeft.FontName = 'SansSerif';
            app.RotateLeft.FontSize = 24;
            app.RotateLeft.FontWeight = 'bold';
            app.RotateLeft.Tooltip = {'shortcut ''a'''};
            app.RotateLeft.Position = [9 710-58 28 28];
            app.RotateLeft.Text = '<';

            % Create RotateRight
            app.RotateRight = uibutton(app.DVisualizationPanel, 'push');
            app.RotateRight.ButtonPushedFcn = createCallbackFcn(app, @RotateRightButtonPushed, true);
            app.RotateRight.IconAlignment = 'center';
            app.RotateRight.VerticalAlignment = 'center';
            app.RotateRight.HorizontalAlignment = 'center';
            app.RotateRight.BackgroundColor = [1 1 1];
            app.RotateRight.FontName = 'SansSerif';
            app.RotateRight.FontSize = 24;
            app.RotateRight.FontWeight = 'bold';
            app.RotateRight.Tooltip = {'shortcut ''d'''};
            app.RotateRight.Position = [88 710-58 28 28];
            app.RotateRight.Text = '>';

            % Create Rotate
            app.Rotate = uilabel(app.DVisualizationPanel);
            app.Rotate.HorizontalAlignment = 'center';
            app.Rotate.FontName = 'SansSerif';
            app.Rotate.FontSize = 16;
            app.Rotate.Position = [36 710-58 53 22];
            app.Rotate.Text = 'Rotate';

            % Create RotateDown
            app.RotateDown = uibutton(app.DVisualizationPanel, 'push');
            app.RotateDown.ButtonPushedFcn = createCallbackFcn(app, @RotateDownButtonPushed, true);
            app.RotateDown.IconAlignment = 'center';
            app.RotateDown.VerticalAlignment = 'center';
            app.RotateDown.HorizontalAlignment = 'center';
            app.RotateDown.BackgroundColor = [1 1 1];
            app.RotateDown.FontName = 'SansSerif';
            app.RotateDown.FontSize = 24;
            app.RotateDown.FontWeight = 'bold';
            app.RotateDown.Tooltip = {'shortcut ''s'''};
            app.RotateDown.Position = [49 710-84 28 28];
            app.RotateDown.Text = '▼';

            % Create RotateUp
            app.RotateUp = uibutton(app.DVisualizationPanel, 'push');
            app.RotateUp.ButtonPushedFcn = createCallbackFcn(app, @RotateUpButtonPushed, true);
            app.RotateUp.IconAlignment = 'center';
            app.RotateUp.VerticalAlignment = 'center';
            app.RotateUp.HorizontalAlignment = 'center';
            app.RotateUp.BackgroundColor = [1 1 1];
            app.RotateUp.FontName = 'SansSerif';
            app.RotateUp.FontSize = 24;
            app.RotateUp.FontWeight = 'bold';
            app.RotateUp.Tooltip = {'shortcut ''w'''};
            app.RotateUp.Position = [49 710-33 28 28];
            app.RotateUp.Text = '▲';

            % Create ResetRotation
            app.ResetRotation = uibutton(app.DVisualizationPanel, 'push');
            app.ResetRotation.ButtonPushedFcn = createCallbackFcn(app, @ResetRotationButtonPushed, true);
            app.ResetRotation.IconAlignment = 'center';
            app.ResetRotation.FontName = 'SansSerif';
            app.ResetRotation.FontSize = 16;
            app.ResetRotation.Tooltip = {'Reset rotation to original view'; 'shortcut ''r'''};
            app.ResetRotation.Position = [9 710-115 107 28];
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

            % Create isStreamsChanged checkbox (always hidden)
            app.isStreamsChanged = uicheckbox(app.Maps);
            app.isStreamsChanged.Text = '';
            app.isStreamsChanged.FontName = 'SansSerif';
            app.isStreamsChanged.FontSize = 1;
            app.isStreamsChanged.Position = [1162 270 2 2];
            app.isStreamsChanged.Value = 1;

            % Create isPathlinesChanged checkbox (always hidden)
            app.isPathlinesChanged = uicheckbox(app.Maps);
            app.isPathlinesChanged.Text = '';
            app.isPathlinesChanged.FontName = 'SansSerif';
            app.isPathlinesChanged.FontSize = 1;
            app.isPathlinesChanged.Position = [1162 270 2 2];
            app.isPathlinesChanged.Value = 1;

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
            app.ManageWorkspace = uitab(app.TabGroup);
            app.ManageWorkspace.Title = 'Manage Workspace';

            % Create CleardataandrestartanalysisButton
            app.ClearAppAndRestartButton = uibutton(app.ManageWorkspace, 'push');
            app.ClearAppAndRestartButton.ButtonPushedFcn = createCallbackFcn(app, @ClearAppAndRestartButtonPushed, true);
            app.ClearAppAndRestartButton.FontName = 'SansSerif';
            app.ClearAppAndRestartButton.Position = [101 550 178 22];
            app.ClearAppAndRestartButton.Text = 'Clear app and restart';
            app.ClearAppAndRestartButton.Tooltip = 'Clear all data and restart analysis';

            % Create RestoreAppStateButton
            app.RestoreAppStateButton = uibutton(app.ManageWorkspace, 'push');
            app.RestoreAppStateButton.ButtonPushedFcn = createCallbackFcn(app, @RestoreAppStateButtonPushed, true);
            app.RestoreAppStateButton.FontName = 'SansSerif';
            app.RestoreAppStateButton.Position = [101 588 178 22];
            app.RestoreAppStateButton.Text = 'Restore app state';
            app.RestoreAppStateButton.Tooltip = 'Restore app to a previously saved state';

            % Create SaveAppStateButton
            app.SaveAppStateButton = uibutton(app.ManageWorkspace, 'push');
            app.SaveAppStateButton.ButtonPushedFcn = createCallbackFcn(app, @SaveAppStateButtonPushed, true);
            app.SaveAppStateButton.FontName = 'SansSerif';
            app.SaveAppStateButton.Position = [101 626 178 22];
            app.SaveAppStateButton.Text = 'Save app state';
            app.SaveAppStateButton.Tooltip = 'Save app state and all data for later loading';

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