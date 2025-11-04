% View4DDemo - load demo data and call View4D.
%
% See comments below about modes of operation in the demo.
% Type 'help View4D' to get help on the View4D function usage.
%
% See also: View4D, DisplayPixelCurve

% By Ran Klein, The Ottawa Hospital, 2017-10-17

%% Change mode of operation:
% false - Do not stop and wait. Just generate display and finish execution.
% true -  Stop and wait for user to close View4D. Returns the time frames
%         selected to generate the last display.

waitForClose = false;

%% Load demo data
load('View4DDemoData.mat')

% Saved data as int16 to make file meet Matlab Community file size 
% requirements of <20MB.
PETvol = double(PETvol);
for i=1:length(quantPETvol)
	PETvol(:,:,:,i) = PETvol(:,:,:,i) * quantPETvol(i);
end

CTVolStruct = struct('vol',double(CTvol),...
	                 'pixelDimensions',[CTxdim, CTydim, CTzdim],...
					 'offset',[0 0 0],...
					 'colormap','bone',...
					 'clim',[0 300],...
					 'alpha',0.3);

switch 1
	case 1 % Call View4D with all options
		frames = View4D(PETvol,... % 4D volume data
			'13-15',... % time frames to display at startup
			'PixelDimensions',[xdim, ydim, zdim],... % pixel spacial dimension sizes
			'Time',time,'TimeUnits',timeUnits,... frame times and units
			'TimeOp','Sum',...
			'Units',uptakeUnits,... image units name
			'TAC',TAC,... % Time-activity-curves to add to the time axis
			'Secondvolume', CTVolStruct,...
			'ExtraSurface',ROIdata,... % contours/surface data to add to the slices
			'Position','north',... figure position
			'FigureName','View4D Demo',... % Name of the figure
			'AxisNames',{'Coronal','Sagittal','Transaxial'},... axis labels
			'Colormap','HotMetal',... The image colormap
			'WaitForClose',waitForClose,...
			'PointerCallback','DisplayPixelCurve',...  The callback function used to generate a live display when a new intersection pixel is selected
			'KeyPressFunc', 'SphereKeyPressFunc'); % Add a callback to draw sphere at intersect point when pressing s key.
		
	case 2 % Call View4D with default options with a single volume image
		frames = View4D(PETvol,... % 4D volume data
			[],... % time frames to display at startup
			'WaitForClose',waitForClose);
		
	case 3 % Call View4D with defined scale limits
		frames = View4D(PETvol,... % 4D volume data
			[],... % time frames to display at startup
			'PixelDimensions',[xdim, ydim, zdim],... % pixel spacial dimension sizes
			'Units',uptakeUnits,... image units name
			'ScaleLimitsMode',[0 50],... Color scale mode. Other options is '[-min max]' or '[0 max]'.
			'Secondvolume', CTVolStruct,...
			'Position','north',... figure position
			'FigureName','View4D Demo',... % Name of the figure
			'AxisNames',{'Coronal','Sagittal','Transaxial'},... axis labels
			'Colormap','HotMetal',... The image colormap
			'WaitForClose',waitForClose);
end

disp('Done View4D call');

%% Display results
if waitForClose
	disp(['Frames ' frames ' were last used in View4D']);
end