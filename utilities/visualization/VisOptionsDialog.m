classdef VisOptionsDialog < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
        VisOptionsDialogUIFigure                        matlab.ui.Figure
        MapPlotPanel                    matlab.ui.container.Panel
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
        VectorPlotPanel                 matlab.ui.container.Panel
        VectorsubsampleSlider           matlab.ui.control.Slider
        VectorsubsampleLabel            matlab.ui.control.Label
        backgroundDropDown              matlab.ui.control.DropDown
        backgroundDropDownLabel         matlab.ui.control.Label
        TextcolorDropDown               matlab.ui.control.DropDown
        TextcolorDropDownLabel          matlab.ui.control.Label
        ColormapDropDown                matlab.ui.control.DropDown
        ColormapDropDownLabel           matlab.ui.control.Label
        LocationDropDown                matlab.ui.control.DropDown
        LocationDropDownLabel           matlab.ui.control.Label
        velocityVectorEditFieldLabel_2  matlab.ui.control.Label
        maxQuiverEditField              matlab.ui.control.EditField
        toXEditFieldLabel               matlab.ui.control.Label
        minQuiverEditField              matlab.ui.control.EditField
        vectorscaleLabel                matlab.ui.control.Label
        maxVelocityVectorEditField      matlab.ui.control.EditField
        velocityVectortoEditFieldLabel  matlab.ui.control.Label
        minVelocityVectorEditField      matlab.ui.control.EditField
        velocityVectorEditFieldLabel    matlab.ui.control.Label
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
            app.maxVelocityVectorEditField.Value = num2str(vecVel);
            
            figure(app.VisOptionsDialogUIFigure);
        end
        
        % Close request function: VisOptionsDialogUIFigure
        function VisOptionsDialogCloseRequest(app, event)
            % hide figure
            app.VisOptionsDialogUIFigure.Visible = 'off';
        end
        
        % Value changed function: minVelocityVectorEditField
        function minVelocityVectorEditFieldValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: maxVelocityVectorEditField
        function maxVelocityVectorEditFieldValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: minQuiverEditField
        function minQuiverEditFieldValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: maxQuiverEditField
        function maxQuiverEditFieldValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: VectorsubsampleSlider
        function VectorsubsampleSliderValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: LocationDropDown
        function LocationDropDownValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: ColormapDropDown
        function ColormapDropDownValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: TextcolorDropDown
        function TextcolorDropDownValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: backgroundDropDown
        function backgroundDropDownValueChanged(app, event)
            viewVelocityVectors(app.CallingApp);
        end
        
        % Value changed function: minMapEditField
        function minMapEditFieldValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
        
        % Value changed function: maxMapEditField
        function maxMapEditFieldValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
        
        % Value changed function: LocationDropDown_2
        function LocationDropDown_2ValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
        
        % Value changed function: ColormapDropDown_2
        function ColormapDropDown_2ValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
        
        % Value changed function: TextcolorDropDown_2
        function TextcolorDropDown_2ValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
        
        % Value changed function: backgroundDropDown_2
        function backgroundDropDown_2ValueChanged(app, event)
            switch app.CallingApp.MapType.Value
                case 'None'
                case 'Wall shear stress'
                    app.MapEditFieldLabel.Text = 'wss (Pa)';
                    viewWSS(app.CallingApp);
                case 'Peak velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewPeakVelocity(app.CallingApp);
                case 'Mean velocity'
                    app.MapEditFieldLabel.Text = 'velocity (cm/s)';
                    viewMeanVelocity(app.CallingApp);
                case 'Kinetic energy'
                    app.MapEditFieldLabel.Text = 'KE (mJ)';
                    viewKE(app.CallingApp);
                case 'Energy loss'
                    app.MapEditFieldLabel.Text = 'EL (mW)';
                    viewEL(app.CallingApp);
            end
        end
    end
    
    % Component initialization
    methods (Access = private)
        
        % Create VisOptionsDialogUIFigure and components
        function createComponents(app)
            
            % Create VisOptionsDialogUIFigure and hide until all components are created
            app.VisOptionsDialogUIFigure = uifigure('Visible', 'off');
            app.VisOptionsDialogUIFigure.Position = [600 100 369 288];
            app.VisOptionsDialogUIFigure.Name = 'Options';
            app.VisOptionsDialogUIFigure.CloseRequestFcn = createCallbackFcn(app, @VisOptionsDialogCloseRequest, true);
            
            % Create VectorPlotPanel
            app.VectorPlotPanel = uipanel(app.VisOptionsDialogUIFigure);
            app.VectorPlotPanel.TitlePosition = 'centertop';
            app.VectorPlotPanel.Title = 'Vector Plot';
            app.VectorPlotPanel.BackgroundColor = [1 1 1];
            app.VectorPlotPanel.FontName = 'SansSerif';
            app.VectorPlotPanel.FontWeight = 'bold';
            app.VectorPlotPanel.FontSize = 16;
            app.VectorPlotPanel.Position = [1 1 185 288];
            
            % Create velocityVectorEditFieldLabel
            app.velocityVectorEditFieldLabel = uilabel(app.VectorPlotPanel);
            app.velocityVectorEditFieldLabel.HorizontalAlignment = 'right';
            app.velocityVectorEditFieldLabel.FontName = 'SansSerif';
            app.velocityVectorEditFieldLabel.Position = [32 245 114 22];
            app.velocityVectorEditFieldLabel.Text = 'velocity scale (cm/s)';
            
            % Create minVelocityVectorEditField
            app.minVelocityVectorEditField = uieditfield(app.VectorPlotPanel, 'text');
            app.minVelocityVectorEditField.ValueChangedFcn = createCallbackFcn(app, @minVelocityVectorEditFieldValueChanged, true);
            app.minVelocityVectorEditField.HorizontalAlignment = 'right';
            app.minVelocityVectorEditField.FontName = 'SansSerif';
            app.minVelocityVectorEditField.Position = [43 224 30 22];
            app.minVelocityVectorEditField.Value = '0';
            
            % Create velocityVectortoEditFieldLabel
            app.velocityVectortoEditFieldLabel = uilabel(app.VectorPlotPanel);
            app.velocityVectortoEditFieldLabel.HorizontalAlignment = 'center';
            app.velocityVectortoEditFieldLabel.FontName = 'SansSerif';
            app.velocityVectortoEditFieldLabel.Position = [73 224 25 22];
            app.velocityVectortoEditFieldLabel.Text = 'to';
            
            % Create maxVelocityVectorEditField
            app.maxVelocityVectorEditField = uieditfield(app.VectorPlotPanel, 'text');
            app.maxVelocityVectorEditField.ValueChangedFcn = createCallbackFcn(app, @maxVelocityVectorEditFieldValueChanged, true);
            app.maxVelocityVectorEditField.HorizontalAlignment = 'right';
            app.maxVelocityVectorEditField.FontName = 'SansSerif';
            app.maxVelocityVectorEditField.Position = [99 224 37 22];
            app.maxVelocityVectorEditField.Value = 'max';
            
            % Create vectorscaleLabel
            app.vectorscaleLabel = uilabel(app.VectorPlotPanel);
            app.vectorscaleLabel.HorizontalAlignment = 'right';
            app.vectorscaleLabel.FontName = 'SansSerif';
            app.vectorscaleLabel.Position = [52 201 70 22];
            app.vectorscaleLabel.Text = 'vector scale';
            
            % Create minQuiverEditField
            app.minQuiverEditField = uieditfield(app.VectorPlotPanel, 'text');
            app.minQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @minQuiverEditFieldValueChanged, true);
            app.minQuiverEditField.HorizontalAlignment = 'right';
            app.minQuiverEditField.FontName = 'SansSerif';
            app.minQuiverEditField.Position = [43 180 30 22];
            app.minQuiverEditField.Value = '2';
            
            % Create toXEditFieldLabel
            app.toXEditFieldLabel = uilabel(app.VectorPlotPanel);
            app.toXEditFieldLabel.HorizontalAlignment = 'center';
            app.toXEditFieldLabel.FontName = 'SansSerif';
            app.toXEditFieldLabel.Position = [73 180 25 22];
            app.toXEditFieldLabel.Text = 'to';
            
            % Create maxQuiverEditField
            app.maxQuiverEditField = uieditfield(app.VectorPlotPanel, 'text');
            app.maxQuiverEditField.ValueChangedFcn = createCallbackFcn(app, @maxQuiverEditFieldValueChanged, true);
            app.maxQuiverEditField.HorizontalAlignment = 'right';
            app.maxQuiverEditField.FontName = 'SansSerif';
            app.maxQuiverEditField.Position = [99 180 37 22];
            app.maxQuiverEditField.Value = '10';
            
            % Create VectorsubsampleLabel
            app.VectorsubsampleLabel = uilabel(app.VectorPlotPanel);
            app.VectorsubsampleLabel.HorizontalAlignment = 'right';
            app.VectorsubsampleLabel.WordWrap = 'on';
            app.VectorsubsampleLabel.FontName = 'SansSerif';
            app.VectorsubsampleLabel.Position = [3 128 59 43];
            app.VectorsubsampleLabel.Text = 'Vector subsample';
            
            % Create VectorsubsampleSlider
            app.VectorsubsampleSlider = uislider(app.VectorPlotPanel);
            app.VectorsubsampleSlider.ValueChangedFcn = createCallbackFcn(app, @VectorsubsampleSliderValueChanged, true);
            app.VectorsubsampleSlider.FontName = 'SansSerif';
            app.VectorsubsampleSlider.Limits = [1 5];
            app.VectorsubsampleSlider.MajorTicks = [1 2 3 4 5];
            app.VectorsubsampleSlider.MinorTicks = [];
            app.VectorsubsampleSlider.Position = [71 158 101 3];
            app.VectorsubsampleSlider.Value = 1;
            
            % Create velocityVectorEditFieldLabel_2
            app.velocityVectorEditFieldLabel_2 = uilabel(app.VectorPlotPanel);
            app.velocityVectorEditFieldLabel_2.HorizontalAlignment = 'right';
            app.velocityVectorEditFieldLabel_2.FontName = 'SansSerif';
            app.velocityVectorEditFieldLabel_2.FontWeight = 'bold';
            app.velocityVectorEditFieldLabel_2.Position = [62 52 54 22];
            app.velocityVectorEditFieldLabel_2.Text = 'colorbar';
            
            % Create LocationDropDownLabel
            app.LocationDropDownLabel = uilabel(app.VectorPlotPanel);
            app.LocationDropDownLabel.FontName = 'SansSerif';
            app.LocationDropDownLabel.Position = [4 29 65 22];
            app.LocationDropDownLabel.Text = 'Location';
            
            % Create LocationDropDown
            app.LocationDropDown = uidropdown(app.VectorPlotPanel);
            app.LocationDropDown.Items = {'bottom-left', 'mid-left', 'upper-left', 'bottom-right', 'mid-right', 'upper-right'};
            app.LocationDropDown.ValueChangedFcn = createCallbackFcn(app, @LocationDropDownValueChanged, true);
            app.LocationDropDown.FontName = 'SansSerif';
            app.LocationDropDown.Position = [73 29 110 22];
            app.LocationDropDown.Value = 'bottom-left';
            
            % Create ColormapDropDownLabel
            app.ColormapDropDownLabel = uilabel(app.VectorPlotPanel);
            app.ColormapDropDownLabel.FontName = 'SansSerif';
            app.ColormapDropDownLabel.Position = [4 3 65 22];
            app.ColormapDropDownLabel.Text = 'Colormap';
            
            % Create ColormapDropDown
            app.ColormapDropDown = uidropdown(app.VectorPlotPanel);
            app.ColormapDropDown.Items = {'jet', 'parula', 'hot', 'spring', 'summer', 'autumn', 'winter', 'gray'};
            app.ColormapDropDown.ValueChangedFcn = createCallbackFcn(app, @ColormapDropDownValueChanged, true);
            app.ColormapDropDown.FontName = 'SansSerif';
            app.ColormapDropDown.Position = [73 3 110 22];
            app.ColormapDropDown.Value = 'jet';
            
            % Create TextcolorDropDownLabel
            app.TextcolorDropDownLabel = uilabel(app.VectorPlotPanel);
            app.TextcolorDropDownLabel.FontName = 'SansSerif';
            app.TextcolorDropDownLabel.Position = [4 72 65 22];
            app.TextcolorDropDownLabel.Text = 'Text color';
            
            % Create TextcolorDropDown
            app.TextcolorDropDown = uidropdown(app.VectorPlotPanel);
            app.TextcolorDropDown.Items = {'black', 'white'};
            app.TextcolorDropDown.ValueChangedFcn = createCallbackFcn(app, @TextcolorDropDownValueChanged, true);
            app.TextcolorDropDown.FontName = 'SansSerif';
            app.TextcolorDropDown.Position = [73 72 110 22];
            app.TextcolorDropDown.Value = 'black';
            
            % Create backgroundDropDownLabel
            app.backgroundDropDownLabel = uilabel(app.VectorPlotPanel);
            app.backgroundDropDownLabel.FontName = 'SansSerif';
            app.backgroundDropDownLabel.Position = [4 98 68 22];
            app.backgroundDropDownLabel.Text = 'background';
            
            % Create backgroundDropDown
            app.backgroundDropDown = uidropdown(app.VectorPlotPanel);
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
            app.MapPlotPanel.Position = [185 1 185 288];
            
            % Create MapEditFieldLabel
            app.MapEditFieldLabel = uilabel(app.MapPlotPanel);
            app.MapEditFieldLabel.HorizontalAlignment = 'center';
            app.MapEditFieldLabel.FontName = 'SansSerif';
            app.MapEditFieldLabel.Position = [46 245 93 22];
            app.MapEditFieldLabel.Text = 'map scale';
            
            % Create minMapEditField
            app.minMapEditField = uieditfield(app.MapPlotPanel, 'text');
            app.minMapEditField.ValueChangedFcn = createCallbackFcn(app, @minMapEditFieldValueChanged, true);
            app.minMapEditField.HorizontalAlignment = 'right';
            app.minMapEditField.FontName = 'SansSerif';
            app.minMapEditField.Position = [46 224 30 22];
            app.minMapEditField.Value = '0';
            
            % Create MaptoEditFieldLabel
            app.MaptoEditFieldLabel = uilabel(app.MapPlotPanel);
            app.MaptoEditFieldLabel.HorizontalAlignment = 'center';
            app.MaptoEditFieldLabel.FontName = 'SansSerif';
            app.MaptoEditFieldLabel.Position = [76 224 25 22];
            app.MaptoEditFieldLabel.Text = 'to';
            
            % Create maxMapEditField
            app.maxMapEditField = uieditfield(app.MapPlotPanel, 'text');
            app.maxMapEditField.ValueChangedFcn = createCallbackFcn(app, @maxMapEditFieldValueChanged, true);
            app.maxMapEditField.HorizontalAlignment = 'right';
            app.maxMapEditField.FontName = 'SansSerif';
            app.maxMapEditField.Position = [102 224 37 22];
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
            app.ColormapDropDown_2.Items = {'jet', 'parula', 'hot', 'spring', 'summer', 'autumn', 'winter', 'gray'};
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
            
            % Create VisOptionsDialogUIFigure and components
            createComponents(app)
            
            % Register the app with App Designer
            registerApp(app, app.VisOptionsDialogUIFigure)
            
            % Execute the startup function
            runStartupFcn(app, @(app)StartupFcn(app, varargin{:}))
            
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