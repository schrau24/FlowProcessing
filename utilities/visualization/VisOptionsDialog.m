classdef VisOptionsDialog < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        VisOptionsDialogUIFigure        matlab.ui.Figure
        MapPlotPanel                    matlab.ui.container.Panel
        mask_erosion_checkbox           matlab.ui.control.CheckBox
        smoothMap_checkbox              matlab.ui.control.CheckBox
        projectionDropDown_Label        matlab.ui.control.Label
        projectionDropDown              matlab.ui.control.DropDown
        backgroundDropDown_2            matlab.ui.control.DropDown
        backgroundDropDown_2Label       matlab.ui.control.Label
        TextcolorDropDown_2             matlab.ui.control.DropDown
        TextcolorDropDown_2Label        matlab.ui.control.Label
        ColormapDropDown_2              matlab.ui.control.DropDown
        ColormapDropDown_2Label         matlab.ui.control.Label
        LocationDropDown_2              matlab.ui.control.DropDown
        LocationDropDown_2Label         matlab.ui.control.Label
        MapColorbarEditFieldLabel       matlab.ui.control.Label
        maxMapEditField                 matlab.ui.control.EditField
        MaptoEditFieldLabel             matlab.ui.control.Label
        minMapEditField                 matlab.ui.control.EditField
        MapEditFieldLabel               matlab.ui.control.Label
        VisPlotPanel                    matlab.ui.container.Panel
        SubsampleSlider                 matlab.ui.control.Slider
        SubsampleLabel                  matlab.ui.control.Label
        VisPts_Label                    matlab.ui.control.Label
        VisPts                          matlab.ui.control.EditField
        backgroundDropDown              matlab.ui.control.DropDown
        backgroundDropDownLabel         matlab.ui.control.Label
        TextcolorDropDown               matlab.ui.control.DropDown
        TextcolorDropDownLabel          matlab.ui.control.Label
        ColormapDropDown                matlab.ui.control.DropDown
        ColormapDropDownLabel           matlab.ui.control.Label
        LocationDropDown                matlab.ui.control.DropDown
        LocationDropDownLabel           matlab.ui.control.Label
        velocityVisEditFieldLabel_2     matlab.ui.control.Label
        maxQuiverEditField              matlab.ui.control.EditField
        toXEditFieldLabel               matlab.ui.control.Label
        minQuiverEditField              matlab.ui.control.EditField
        cutoffvaluesLabel               matlab.ui.control.Label
        maxVelocityVisEditField         matlab.ui.control.EditField
        velocityVistoEditFieldLabel     matlab.ui.control.Label
        minVelocityVisEditField         matlab.ui.control.EditField
        velocityVisEditFieldLabel       matlab.ui.control.Label
        view_3Dpatch_checkbox           matlab.ui.control.CheckBox
        view_3DSegpatch_checkbox        matlab.ui.control.CheckBox
    end


    properties (Access = private)
        CallingApp   % Main app object
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function StartupFcn(app, mainapp, vecVel)

            % Store main app in property for CloseRequestFcn to use
            app.CallingApp = mainapp;

            % try to move just to the left of the FlowProcessing tool,
            % otherwise set to bottom left
            pos = app.CallingApp.FlowProcessingUIFigure.Position;
            newPos = app.VisOptionsDialogUIFigure.Position(3:4) - pos(1:2);
            if newPos(1)<0 || newPos(2)<44
                newPos = [1 45];
            end
            app.VisOptionsDialogUIFigure.Position(1:2) = newPos;

            % Update UI with input values
            app.maxVelocityVisEditField.Value = num2str(vecVel);

            figure(app.VisOptionsDialogUIFigure);
        end

        % Close request function: VisOptionsDialogUIFigure
        function VisOptionsDialogCloseRequest(app, event)
            % hide figure
            app.VisOptionsDialogUIFigure.Visible = 'off';
        end

        % Value changed function: minVelocityVisEditField
        function minVelocityVisEditFieldValueChanged(app, event)
            app.CallingApp.VisualizationPlot.CLim = [str2double(app.minVelocityVisEditField.Value) str2double(app.maxVelocityVisEditField.Value)];
        end

        % Value changed function: maxVelocityVisEditField
        function maxVelocityVisEditFieldValueChanged(app, event)
            app.CallingApp.VisualizationPlot.CLim = [str2double(app.minVelocityVisEditField.Value) str2double(app.maxVelocityVisEditField.Value)];
        end

        % Value changed function: minQuiverEditField
        function minQuiverEditFieldValueChanged(app, event)
            updateVisualization(app.CallingApp);
        end

        % Value changed function: maxQuiverEditField
        function maxQuiverEditFieldValueChanged(app, event)
            updateVisualization(app.CallingApp);
        end

        % Value changed function: SubsampleSlider
        function SubsampleSliderValueChanged(app, event)
            app.CallingApp.isStreamsChanged.Value = 1;
            updateVisualization(app.CallingApp);
        end

        % Value changed function: view_3Dpatch_checkboxChanged
        function view_3Dpatch_checkboxChanged(app, event)
            updateVisualization(app.CallingApp);
        end

        % Value changed function: view_3DSegpatch_checkboxChanged
        function view_3DSegpatch_checkboxChanged(app, event)
            updateVisualization(app.CallingApp);
        end

        % Value changed function: VisPts
        function VisPtsValueChanged(app, ~)
            app.CallingApp.isStreamsChanged.Value = 1;
            updateVisualization(app.CallingApp);
        end

        % Value changed function: LocationDropDown
        function LocationDropDownValueChanged(app, event)
            currCbar = app.CallingApp.VisualizationPlot.Colorbar;
            cbarLoc = app.LocationDropDown.Value;
            pos = get(currCbar,'position');
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
            set(currCbar,'position',pos);
        end

        % Value changed function: ColormapDropDown
        function ColormapDropDownValueChanged(app, event)
            cmap = app.ColormapDropDown.Value;
            if contains(app.ColormapDropDown.Value,'inverse')
                eval(['cmap=' erase(app.ColormapDropDown.Value,'inverse ') '(256);']);
                cmap = flip(cmap,1);
            else
                eval(['cmap=' app.ColormapDropDown.Value '(256);']);
            end
            colormap(app.CallingApp.VisualizationPlot,cmap);
        end

        % Value changed function: TextcolorDropDown
        function TextcolorDropDownValueChanged(app, event)
            axisText = [0 0 0];
            if strcmp(app.TextcolorDropDown.Value,'white')
                axisText = [1 1 1];
            end
            app.CallingApp.VisualizationGroup.ForegroundColor = axisText;
            currCbar = app.CallingApp.VisualizationPlot.Colorbar;
            currCbar.Color = axisText;
        end

        % Value changed function: backgroundDropDown
        function backgroundDropDownValueChanged(app, event)
            backgroundC = [1 1 1];
            if strcmp(app.backgroundDropDown.Value,'black')
                backgroundC = [0 0 0];
            end
            app.CallingApp.VisualizationGroup.BackgroundColor = backgroundC;
        end

        % Value changed function: minMapEditField
        function minMapEditFieldValueChanged(app, event)
            app.CallingApp.MapPlot.CLim = [str2double(app.minMapEditField.Value) str2double(app.maxMapEditField.Value)];
        end

        % Value changed function: maxMapEditField
        function maxMapEditFieldValueChanged(app, event)
            app.CallingApp.MapPlot.CLim = [str2double(app.minMapEditField.Value) str2double(app.maxMapEditField.Value)];
        end

        % Value changed function: LocationDropDown_2
        function LocationDropDown_2ValueChanged(app, event)
            currCbar = app.CallingApp.MapPlot.Colorbar;
            cbarLoc = app.LocationDropDown_2.Value;
            pos = get(currCbar,'position');
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
            set(currCbar,'position',pos);
        end

        % Value changed function: ColormapDropDown_2
        function ColormapDropDown_2ValueChanged(app, event)
            cmap = app.ColormapDropDown_2.Value;
            if contains(app.ColormapDropDown_2.Value,'inverse')
                eval(['cmap=' erase(app.ColormapDropDown_2.Value,'inverse ') '(256);']);
                cmap = flip(cmap,1);
            else
                eval(['cmap=' app.ColormapDropDown_2.Value '(256);']);
            end
            colormap(app.CallingApp.MapPlot,cmap);
        end

        % Value changed function: TextcolorDropDown_2
        function TextcolorDropDown_2ValueChanged(app, event)
            axisText = [0 0 0];
            if strcmp(app.TextcolorDropDown_2.Value,'white')
                axisText = [1 1 1];
            end
            app.CallingApp.MapGroup.ForegroundColor = axisText;
            currCbar = app.CallingApp.MapPlot.Colorbar;
            currCbar.Color = axisText;
        end

        % Value changed function: mask_erosion_checkboxChanged
        function mask_erosion_checkboxChanged(app, event)
            viewMap(app.CallingApp);
        end

        % Value changed function: mask_erosion_checkboxChanged
        function smoothMap_checkboxChanged(app, event)
            viewMap(app.CallingApp);
        end

        % Value changed function: projectionDropDownValueChanged
        function projectionDropDownValueChanged(app, event)
            if contains(app.CallingApp.MapType.Value,'mean velocity')
                app.projectionDropDown.Value = 'mean';  % force to mean with mean velocity
            elseif contains(app.CallingApp.MapType.Value,'peak velocity')
                app.projectionDropDown.Value = 'max';  % force to max with peak velocity
            end
            viewMap(app.CallingApp);
        end

        % Value changed function: backgroundDropDown_2
        function backgroundDropDown_2ValueChanged(app, event)
            backgroundC = [1 1 1];
            if strcmp(app.backgroundDropDown_2.Value,'black')
                backgroundC = [0 0 0];
            end
            app.CallingApp.MapGroup.BackgroundColor = backgroundC;

        end
    end

    % Component initialization
    methods (Access = private)

        % Create VisOptionsDialogUIFigure and components
        function createComponents(app)

            % Create VisOptionsDialogUIFigure and hide until all components are created
            app.VisOptionsDialogUIFigure = uifigure('Visible', 'off');
            app.VisOptionsDialogUIFigure.Position = [600 100 369 450];
            app.VisOptionsDialogUIFigure.Name = 'Options';
            app.VisOptionsDialogUIFigure.CloseRequestFcn = createCallbackFcn(app, @VisOptionsDialogCloseRequest, true);

            % Create VisPlotPanel
            app.VisPlotPanel = uipanel(app.VisOptionsDialogUIFigure);
            app.VisPlotPanel.TitlePosition = 'centertop';
            app.VisPlotPanel.Title = 'Visualization';
            app.VisPlotPanel.BackgroundColor = [1 1 1];
            app.VisPlotPanel.FontName = 'SansSerif';
            app.VisPlotPanel.FontWeight = 'bold';
            app.VisPlotPanel.FontSize = 16;
            app.VisPlotPanel.Position = [1 1 185 450];

            % Create velocityVisEditFieldLabel
            app.velocityVisEditFieldLabel = uilabel(app.VisPlotPanel);
            app.velocityVisEditFieldLabel.HorizontalAlignment = 'right';
            app.velocityVisEditFieldLabel.FontName = 'SansSerif';
            app.velocityVisEditFieldLabel.Position = [32 245+162 114 22];
            app.velocityVisEditFieldLabel.Text = 'velocity scale (cm/s)';

            % Create minVelocityVisEditField
            app.minVelocityVisEditField = uieditfield(app.VisPlotPanel, 'text');
            app.minVelocityVisEditField.ValueChangedFcn = createCallbackFcn(app, @minVelocityVisEditFieldValueChanged, true);
            app.minVelocityVisEditField.HorizontalAlignment = 'right';
            app.minVelocityVisEditField.FontName = 'SansSerif';
            app.minVelocityVisEditField.Position = [43 224+162 30 22];
            app.minVelocityVisEditField.Value = '0';

            % Create velocityVistoEditFieldLabel
            app.velocityVistoEditFieldLabel = uilabel(app.VisPlotPanel);
            app.velocityVistoEditFieldLabel.HorizontalAlignment = 'center';
            app.velocityVistoEditFieldLabel.FontName = 'SansSerif';
            app.velocityVistoEditFieldLabel.Position = [73 224+162 25 22];
            app.velocityVistoEditFieldLabel.Text = 'to';

            % Create maxVelocityVisEditField
            app.maxVelocityVisEditField = uieditfield(app.VisPlotPanel, 'text');
            app.maxVelocityVisEditField.ValueChangedFcn = createCallbackFcn(app, @maxVelocityVisEditFieldValueChanged, true);
            app.maxVelocityVisEditField.HorizontalAlignment = 'right';
            app.maxVelocityVisEditField.FontName = 'SansSerif';
            app.maxVelocityVisEditField.Position = [99 224+162 30 22];
            app.maxVelocityVisEditField.Value = 'max';

            % Create cutoffvaluesLabel
            app.cutoffvaluesLabel = uilabel(app.VisPlotPanel);
            app.cutoffvaluesLabel.HorizontalAlignment = 'left';
            app.cutoffvaluesLabel.FontName = 'SansSerif';
            app.cutoffvaluesLabel.Position = [52 201+162 90 22];
            app.cutoffvaluesLabel.Text = 'vector scale';

            % Create minQuiverEditField
            app.minQuiverEditField = uieditfield(app.VisPlotPanel, 'text');
            app.minQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @minQuiverEditFieldValueChanged, true);
            app.minQuiverEditField.HorizontalAlignment = 'right';
            app.minQuiverEditField.FontName = 'SansSerif';
            app.minQuiverEditField.Position = [43 180+162 30 22];
            app.minQuiverEditField.Value = '2';

            % Create toXEditFieldLabel
            app.toXEditFieldLabel = uilabel(app.VisPlotPanel);
            app.toXEditFieldLabel.HorizontalAlignment = 'center';
            app.toXEditFieldLabel.FontName = 'SansSerif';
            app.toXEditFieldLabel.Position = [73 180+162 25 22];
            app.toXEditFieldLabel.Text = 'to';

            % Create maxQuiverEditField
            app.maxQuiverEditField = uieditfield(app.VisPlotPanel, 'text');
            app.maxQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @maxQuiverEditFieldValueChanged, true);
            app.maxQuiverEditField.HorizontalAlignment = 'right';
            app.maxQuiverEditField.FontName = 'SansSerif';
            app.maxQuiverEditField.Position = [99 180+162 30 22];
            app.maxQuiverEditField.Value = '10';

            % Create SubsampleLabel
            app.SubsampleLabel = uilabel(app.VisPlotPanel);
            app.SubsampleLabel.HorizontalAlignment = 'right';
            app.SubsampleLabel.WordWrap = 'on';
            app.SubsampleLabel.FontName = 'SansSerif';
            app.SubsampleLabel.Position = [3 128+162 59 43];
            app.SubsampleLabel.Text = 'subsample';

            % Create SubsampleSlider
            app.SubsampleSlider = uislider(app.VisPlotPanel);
            app.SubsampleSlider.ValueChangedFcn = createCallbackFcn(app, @SubsampleSliderValueChanged, true);
            app.SubsampleSlider.FontName = 'SansSerif';
            app.SubsampleSlider.Limits = [1 5];
            app.SubsampleSlider.MajorTicks = [1 2 3 4 5];
            app.SubsampleSlider.MinorTicks = [];
            app.SubsampleSlider.Position = [71 158+162 101 3];
            app.SubsampleSlider.Value = 1;

            % Create view_3Dpatch_checkbox
            app.view_3Dpatch_checkbox = uicheckbox(app.VisPlotPanel);
            app.view_3Dpatch_checkbox.ValueChangedFcn = createCallbackFcn(app, @view_3Dpatch_checkboxChanged, true);
            app.view_3Dpatch_checkbox.Tooltip = {'toggle viewing the thresholded 3D isosurface'};
            app.view_3Dpatch_checkbox.Text = '3D surface';
            app.view_3Dpatch_checkbox.FontName = 'SansSerif';
            app.view_3Dpatch_checkbox.Position = [16 98+162 146 22];

            % Create view_3DSegpatch_checkbox
            app.view_3DSegpatch_checkbox = uicheckbox(app.VisPlotPanel);
            app.view_3DSegpatch_checkbox.ValueChangedFcn = createCallbackFcn(app, @view_3DSegpatch_checkboxChanged, true);
            app.view_3DSegpatch_checkbox.Tooltip = {'toggle viewing the loaded segmentation 3D isosurface'};
            app.view_3DSegpatch_checkbox.Text = 'segmentation surface';
            app.view_3DSegpatch_checkbox.FontName = 'SansSerif';
            app.view_3DSegpatch_checkbox.Position = [16 76+162 146 22];

            % Create VisPts_Label
            app.VisPts_Label = uilabel(app.VisPlotPanel);
            app.VisPts_Label.HorizontalAlignment = 'right';
            app.VisPts_Label.FontName = 'SansSerif';
            app.VisPts_Label.FontSize = 10;
            app.VisPts_Label.Enable = 'off';
            app.VisPts_Label.Visible = 'off';
            app.VisPts_Label.Position = [3 56+162 70 22];
            app.VisPts_Label.Text = 'contour points';

            % Create VisPts
            app.VisPts = uieditfield(app.VisPlotPanel, 'text');
            app.VisPts.ValueChangedFcn = createCallbackFcn(app, @VisPtsValueChanged, true);
            app.VisPts.FontName = 'SansSerif';
            app.VisPts.FontSize = 12;
            app.VisPts.Enable = 'off';
            app.VisPts.Visible = 'off';
            app.VisPts.Tooltip = {'Centerline point labels used for visualization. '};
            app.VisPts.Position = [73 56+162 70 22];

            % Create velocityVisEditFieldLabel_2
            app.velocityVisEditFieldLabel_2 = uilabel(app.VisPlotPanel);
            app.velocityVisEditFieldLabel_2.HorizontalAlignment = 'right';
            app.velocityVisEditFieldLabel_2.FontName = 'SansSerif';
            app.velocityVisEditFieldLabel_2.FontWeight = 'bold';
            app.velocityVisEditFieldLabel_2.Position = [73 52 54 22];
            app.velocityVisEditFieldLabel_2.Text = 'colorbar';

            % Create LocationDropDownLabel
            app.LocationDropDownLabel = uilabel(app.VisPlotPanel);
            app.LocationDropDownLabel.FontName = 'SansSerif';
            app.LocationDropDownLabel.Position = [4 29 65 22];
            app.LocationDropDownLabel.Text = 'Location';

            % Create LocationDropDown
            app.LocationDropDown = uidropdown(app.VisPlotPanel);
            app.LocationDropDown.Items = {'bottom-left', 'mid-left', 'upper-left', 'bottom-right', 'mid-right', 'upper-right'};
            app.LocationDropDown.ValueChangedFcn = createCallbackFcn(app, @LocationDropDownValueChanged, true);
            app.LocationDropDown.FontName = 'SansSerif';
            app.LocationDropDown.Position = [73 29 110 22];
            app.LocationDropDown.Value = 'bottom-left';

            % Create ColormapDropDownLabel
            app.ColormapDropDownLabel = uilabel(app.VisPlotPanel);
            app.ColormapDropDownLabel.FontName = 'SansSerif';
            app.ColormapDropDownLabel.Position = [4 3 65 22];
            app.ColormapDropDownLabel.Text = 'Colormap';

            % Create ColormapDropDown
            app.ColormapDropDown = uidropdown(app.VisPlotPanel);
            app.ColormapDropDown.Items = {'jet', 'parula', 'hot', 'spring', 'summer', 'autumn', 'winter', 'gray'};
            app.ColormapDropDown.ValueChangedFcn = createCallbackFcn(app, @ColormapDropDownValueChanged, true);
            app.ColormapDropDown.FontName = 'SansSerif';
            app.ColormapDropDown.Position = [73 3 110 22];
            app.ColormapDropDown.Value = 'jet';

            % Create TextcolorDropDownLabel
            app.TextcolorDropDownLabel = uilabel(app.VisPlotPanel);
            app.TextcolorDropDownLabel.FontName = 'SansSerif';
            app.TextcolorDropDownLabel.Position = [4 72 65 22];
            app.TextcolorDropDownLabel.Text = 'Text color';

            % Create TextcolorDropDown
            app.TextcolorDropDown = uidropdown(app.VisPlotPanel);
            app.TextcolorDropDown.Items = {'black', 'white'};
            app.TextcolorDropDown.ValueChangedFcn = createCallbackFcn(app, @TextcolorDropDownValueChanged, true);
            app.TextcolorDropDown.FontName = 'SansSerif';
            app.TextcolorDropDown.Position = [73 72 110 22];
            app.TextcolorDropDown.Value = 'black';

            % Create backgroundDropDownLabel
            app.backgroundDropDownLabel = uilabel(app.VisPlotPanel);
            app.backgroundDropDownLabel.FontName = 'SansSerif';
            app.backgroundDropDownLabel.Position = [4 98 68 22];
            app.backgroundDropDownLabel.Text = 'background';

            % Create backgroundDropDown
            app.backgroundDropDown = uidropdown(app.VisPlotPanel);
            app.backgroundDropDown.Items = {'black', 'white'};
            app.backgroundDropDown.ValueChangedFcn = createCallbackFcn(app, @backgroundDropDownValueChanged, true);
            app.backgroundDropDown.FontName = 'SansSerif';
            app.backgroundDropDown.Position = [73 98 110 22];
            app.backgroundDropDown.Value = 'white';

            % Create MapPlotPanel
            app.MapPlotPanel = uipanel(app.VisOptionsDialogUIFigure);
            app.MapPlotPanel.TitlePosition = 'centertop';
            app.MapPlotPanel.Title = 'Map Plot';
            app.MapPlotPanel.BackgroundColor = [1 1 1];
            app.MapPlotPanel.FontName = 'SansSerif';
            app.MapPlotPanel.FontWeight = 'bold';
            app.MapPlotPanel.FontSize = 16;
            app.MapPlotPanel.Position = [185 1 185 450];

            % Create MapEditFieldLabel
            app.MapEditFieldLabel = uilabel(app.MapPlotPanel);
            app.MapEditFieldLabel.HorizontalAlignment = 'center';
            app.MapEditFieldLabel.FontName = 'SansSerif';
            app.MapEditFieldLabel.Position = [46 245+162 93 22];
            app.MapEditFieldLabel.Text = 'map scale';

            % Create minMapEditField
            app.minMapEditField = uieditfield(app.MapPlotPanel, 'text');
            app.minMapEditField.ValueChangedFcn = createCallbackFcn(app, @minMapEditFieldValueChanged, true);
            app.minMapEditField.HorizontalAlignment = 'right';
            app.minMapEditField.FontName = 'SansSerif';
            app.minMapEditField.Position = [46 224+162 30 22];
            app.minMapEditField.Value = '0';

            % Create MaptoEditFieldLabel
            app.MaptoEditFieldLabel = uilabel(app.MapPlotPanel);
            app.MaptoEditFieldLabel.HorizontalAlignment = 'center';
            app.MaptoEditFieldLabel.FontName = 'SansSerif';
            app.MaptoEditFieldLabel.Position = [76 224+162 25 22];
            app.MaptoEditFieldLabel.Text = 'to';

            % Create maxMapEditField
            app.maxMapEditField = uieditfield(app.MapPlotPanel, 'text');
            app.maxMapEditField.ValueChangedFcn = createCallbackFcn(app, @maxMapEditFieldValueChanged, true);
            app.maxMapEditField.HorizontalAlignment = 'right';
            app.maxMapEditField.FontName = 'SansSerif';
            app.maxMapEditField.Position = [102 224+162 37 22];
            app.maxMapEditField.Value = 'max';

            % Create MapColorbarEditFieldLabel
            app.MapColorbarEditFieldLabel = uilabel(app.MapPlotPanel);
            app.MapColorbarEditFieldLabel.HorizontalAlignment = 'right';
            app.MapColorbarEditFieldLabel.FontName = 'SansSerif';
            app.MapColorbarEditFieldLabel.FontWeight = 'bold';
            app.MapColorbarEditFieldLabel.Position = [68 54 54 22];
            app.MapColorbarEditFieldLabel.Text = 'colorbar';

            % Create LocationDropDown_2Label
            app.LocationDropDown_2Label = uilabel(app.MapPlotPanel);
            app.LocationDropDown_2Label.FontName = 'SansSerif';
            app.LocationDropDown_2Label.Position = [4 31 65 22];
            app.LocationDropDown_2Label.Text = 'Location';

            % Create LocationDropDown_2
            app.LocationDropDown_2 = uidropdown(app.MapPlotPanel);
            app.LocationDropDown_2.Items = {'bottom-left', 'mid-left', 'upper-left', 'bottom-right', 'mid-right', 'upper-right'};
            app.LocationDropDown_2.ValueChangedFcn = createCallbackFcn(app, @LocationDropDown_2ValueChanged, true);
            app.LocationDropDown_2.FontName = 'SansSerif';
            app.LocationDropDown_2.Position = [74 31 110 22];
            app.LocationDropDown_2.Value = 'bottom-left';

            % Create ColormapDropDown_2Label
            app.ColormapDropDown_2Label = uilabel(app.MapPlotPanel);
            app.ColormapDropDown_2Label.FontName = 'SansSerif';
            app.ColormapDropDown_2Label.Position = [4 5 65 22];
            app.ColormapDropDown_2Label.Text = 'Colormap';

            % Create ColormapDropDown_2
            app.ColormapDropDown_2 = uidropdown(app.MapPlotPanel);
            app.ColormapDropDown_2.Items = {'jet', 'parula', 'hot', 'spring', 'summer', 'autumn', 'winter', 'gray','inverse jet'};
            app.ColormapDropDown_2.ValueChangedFcn = createCallbackFcn(app, @ColormapDropDown_2ValueChanged, true);
            app.ColormapDropDown_2.FontName = 'SansSerif';
            app.ColormapDropDown_2.Position = [74 5 110 22];
            app.ColormapDropDown_2.Value = 'jet';

            % Create TextcolorDropDown_2Label
            app.TextcolorDropDown_2Label = uilabel(app.MapPlotPanel);
            app.TextcolorDropDown_2Label.FontName = 'SansSerif';
            app.TextcolorDropDown_2Label.Position = [4 74 65 22];
            app.TextcolorDropDown_2Label.Text = 'Text color';

            % Create TextcolorDropDown_2
            app.TextcolorDropDown_2 = uidropdown(app.MapPlotPanel);
            app.TextcolorDropDown_2.Items = {'black', 'white'};
            app.TextcolorDropDown_2.ValueChangedFcn = createCallbackFcn(app, @TextcolorDropDown_2ValueChanged, true);
            app.TextcolorDropDown_2.FontName = 'SansSerif';
            app.TextcolorDropDown_2.Position = [74 74 110 22];
            app.TextcolorDropDown_2.Value = 'black';

            % Create mask_erosion_checkbox
            app.mask_erosion_checkbox = uicheckbox(app.MapPlotPanel);
            app.mask_erosion_checkbox.ValueChangedFcn = createCallbackFcn(app, @mask_erosion_checkboxChanged, true);
            app.mask_erosion_checkbox.Tooltip = {'erode mask 1 voxel for selected map'};
            app.mask_erosion_checkbox.Text = 'mask erosion';
            app.mask_erosion_checkbox.FontName = 'SansSerif';
            app.mask_erosion_checkbox.Position = [46 180+162 146 22];

            % Create projectionDropDown_Label
            app.projectionDropDown_Label = uilabel(app.MapPlotPanel);
            app.projectionDropDown_Label.WordWrap = 'on';
            app.projectionDropDown_Label.FontName = 'SansSerif';
            app.projectionDropDown_Label.Position = [2 140+162 68 30];
            app.projectionDropDown_Label.Text = 'map slice projection';

            % Create projectionDropDown
            app.projectionDropDown = uidropdown(app.MapPlotPanel);
            app.projectionDropDown.Items = {'mean', 'max'};
            app.projectionDropDown.ValueChangedFcn = createCallbackFcn(app, @projectionDropDownValueChanged, true);
            app.projectionDropDown.FontName = 'SansSerif';
            app.projectionDropDown.Position = [74 140+162 110 22];
            app.projectionDropDown.Value = 'max';

            % Create smoothMap_checkbox
            app.smoothMap_checkbox = uicheckbox(app.MapPlotPanel);
            app.smoothMap_checkbox.ValueChangedFcn = createCallbackFcn(app, @smoothMap_checkboxChanged, true);
            app.smoothMap_checkbox.Tooltip = {'2x bicubic interpolation for a smooth map'};
            app.smoothMap_checkbox.Text = 'smooth map';
            app.smoothMap_checkbox.FontName = 'SansSerif';
            app.smoothMap_checkbox.Position = [46 98+162 146 22];

            % Create backgroundDropDown_2Label
            app.backgroundDropDown_2Label = uilabel(app.MapPlotPanel);
            app.backgroundDropDown_2Label.FontName = 'SansSerif';
            app.backgroundDropDown_2Label.Position = [2 100 68 22];
            app.backgroundDropDown_2Label.Text = 'background';

            % Create backgroundDropDown_2
            app.backgroundDropDown_2 = uidropdown(app.MapPlotPanel);
            app.backgroundDropDown_2.Items = {'black', 'white'};
            app.backgroundDropDown_2.ValueChangedFcn = createCallbackFcn(app, @backgroundDropDown_2ValueChanged, true);
            app.backgroundDropDown_2.FontName = 'SansSerif';
            app.backgroundDropDown_2.Position = [74 100 110 22];
            app.backgroundDropDown_2.Value = 'white';

            % Show the figure after all components are created
            app.VisOptionsDialogUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = VisOptionsDialog(varargin)

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create VisOptionsDialogUIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.VisOptionsDialogUIFigure)

                % Execute the startup function
                runStartupFcn(app, @(app)StartupFcn(app, varargin{:}))
            else

                % Focus the running singleton app
                figure(runningApp.VisOptionsDialogUIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end

        end

        % Code that executes before app deletion
        function delete(app)

            % Delete VisOptionsDialogUIFigure when app is deleted
            delete(app.VisOptionsDialogUIFigure)
        end
    end
end