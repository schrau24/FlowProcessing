# FlowProcessing User Manual

## Information  <a name="information"></a>
Date: November 23, 2026\
Author: Eric M. Schrauben, PhD\
e.m.schrauben@amsterdamumc.nl

This software builds from previous work, and the use of this tool should be associated and cited with the following references:\
[E. Schrauben, et al. “Fast 4D flow MRI intracranial segmentation and quantification in tortuous arteries.” JMRI 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4592372/)\
[E. Schrauben, et al. “A Pulse Wave Velocity Calculation Tool for 4D flow MRI – Data Requirements and Application in Marfan Patients.” ISMRM 2021](https://cds.ismrm.org/protected/21MProceedings/PDFfiles/2091.html)\
<img src="img1.png?raw=true" width="900px">

# Table of Contents
1. [Information](#information)
2. [Getting started](#getting-started)
   1. [Installation](#installation)
   2. [Data needed](#data-needed)
      1. [Philips par/rec](#philips-parrec)
      2. [Philips dicom](#philips-dicom)
      3. [Siemens dicom](#siemens-dicom)
      4. [mrStruct](#mrstruct) 
   3. [Starting the tool](#starting-the-tool)
3. [Loading and Preprocessing tab](#loading-preprocessing)
   1. [Load Data](#load-data)
   2. [Load Segmentation](#load-segmentation)
      1. [Manual segmentation update](#manual-segmentation-update)
   3.  [Crop Data](#crop-data)
   4.  [Corrections](#corrections)
      1. [Velocity Unwrapping](#velocity-unwrapping)
      2. [Divergence Free](#divergence-free)
   5. [Processing](#processing)
      1. [Maps](#maps)
      2. [Pulse Wave Velocity](#pulse-wave-velocity)
4. [Velocity Unwrapping tab](#velocity-unwrapping-tab)
5. [Maps tab](#maps-tab)
      1. [What can be visualized and quantified](#overview)
      2. [Navigating the 3D viewers](#viewer-navigation)
      3. [Vector, streamline and pathline display](#vis-panel)
      4. [Visualization options dialog](#vis-options)
      5. [Maps](#map-panel)
      6. [Time frames and playback](#playback)
      7. [Save animation](#save-animation)
      8. [Map ROI analysis](#map-roi-analysis)
      9. [Map volume analysis](#map-volume-analysis)
6. [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab)
      1. [Flow results](#flow-results)
      2. [Inspecting a centerline point](#flow-click)
      3. [PWV calculation](#pwv-calculation)
      4. [Save results](#save)
7. [Manage Workspace tab](#manage-workspace-tab)
      1. [Save data/settings](#save-tool)
      2. [Restore data/settings](#restore-tool)
      3. [Reset tool](#reset-tool)

## Getting started  <a name="getting-started"></a>
### Installation  <a name="installation"></a>
This tool is built using Matlab's appdesigner functionality. It was built using Matlab version 2021a; it is therefore recommended to use this version or **newer** for running this tool. Download and unzip the files. All functionality is built into FlowProcessing.m file and the corresponding utilities/subfolder.

Additionally, the use of this software requires the following Matlab toolboxes:
- Signal Processing Toolbox
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox
- Computer Vision Toolbox

### Data needed  <a name="data-needed"></a>
The tool optionally works on 4D flow in different formats, listed and explained below (Philips .rec, Philips dicom, Siemens dicom, GE dicom, United Imaging dicom, mrStruct). For other formats, please contact e.m.schrauben@amsterdamumc.nl to update functionality.
#### Philips .par / .rec <a name="philips-parrec"></a> 
Reconstructed .par / .rec files from a Philips 4D flow acquisition can be directly loaded in. All files shouled be located within a single folder. The typical fileordering would be as follows as follows:\
SUBJECTID or other identifier_1.par, SUBJECTID or other identifier_1.rec\
SUBJECTID or other identifier_2.par, SUBJECTID or other identifier_2.rec\
SUBJECTID or other identifier_3.par, SUBJECTID or other identifier_3.rec

Note: some delayed reconstructed Philips .par / .rec data does not fit this data structure. The tool will try to parse the different .par files and load them accordingly.

#### Philips dicom <a name="philips-dicom"></a> 
Reconstructed Philips .dcm files can be recursively loaded in (note, this option can be time-consuming). All files should be located within 4 folders with the following format:\
one folder with the magnitude dicoms, and 3 folders with the separate velocity directions\
note the naming of these folders does not matter as velocity information is gathered directly from the dicom headers

#### Siemens dicom <a name="siemens-dicom"></a> 
Reconstructed Siemens .dcm files can be recursively loaded in (note, this option can be time-consuming). All files should be located within 4 folders with the following format:\
one folder with the magnitude dicoms, and 3 folders with the separate velocity directions\
note the naming of these folders does not matter as velocity information is gathered directly from the dicom headers

#### GE dicom <a name="ge-dicom"></a> 
Reconstructed GE .dcm files are loaded in the same way as Siemens dicom: one parent folder containing 4 subfolders (magnitude plus the 3 velocity directions).

#### United Imaging dicom <a name="ui-dicom"></a> 
Reconstructed United Imaging .dcm files are loaded in the same way as Siemens dicom: one parent folder containing 4 subfolders (magnitude plus the 3 velocity directions).

#### Pre-processed mrStruct files <a name="mrstruct"></a> 
Pre-processed mrStruct files, which are exported from the Northwestern Matlab based tool, consist of a mag_struct.mat and vel_struct.mat, which load directly into this tool.\
Note this data does not contain orientation information.

### Starting the tool  <a name="starting-the-tool"></a>
Within Matlab, navigate to the folder containing FlowProcessing.m. Type this into your command window:\
`FlowProcessing`

## Loading and Preprocessing Tab  <a name="loading-preprocessing"></a>
### Load Data  <a name="load-data"></a>
<img src="img2.png?raw=true" width="450px">

Click `Load 4D Flow Data` \
You will be prompted: first to select the file type to load, and second to select either the file (Philips - one of the reconstructed .rec files, mrStruct files) or folder (Philips dicom, Siemens dicom).

After loading completion, the tool 4D flow acquisition image information is displayed, as well as axial, coronal, and sagittal maximum intensity projections using a calculated angiographic image. An automated thresh-holding of the angiogram is used to display a 3D isosurface within the field of view. The 3D view can be rotated by dragging with the mouse, zoomed with the scroll wheel, and reset with the `Reset view` button (or the `r` key); see [Navigating the 3D viewers](#viewer-navigation):

<img src="img3.png?raw=true" width="450px">

#### Load Segmentation  <a name="load-segmentation"></a>
Using the `Load Segmentation` button, pre-segmented PC angiograms can be loaded in one of three formats: 
- dicoms, .dcm suffix
- nifti, .nii suffix
- nifti, .nii.gz suffix
  
<img src="img4.png?raw=true" width="450px">

##### Manual segmentation update  <a name="manual-segmentation-update"></a>
The user can manually update the thresh-holded or manually segmentated isosurface with the `Manual segmentation update` button.\
An external 3D viewer, [imtool3d](https://github.com/tanguyduval/imtool3D_td), loads the current segmentation and angiogram:

<img src="img5.png?raw=true" width="600px">

### Crop Data  <a name="crop-data"></a>
Cropping of data to include only the vessels of interest is recommended and can be performed using the individual `Crop button` above each MIP.
#### Optional cropping in time
Using the 'View Data' button, the user can check data quality (magnitude plus 3 velocity directions over time). The user can also crop the data in time (e.g. only saving systolic phases) by setting the ‘frames to use’ field. The MIP is updated accordingly.

### Corrections  <a name="corrections"></a>
#### Velocity Unwrapping <a name="velocity-unwrapping"></a>
Clicking the `Velocity Unwrapping` button opens the [Velocity Unwrapping tab](#velocity-unwrapping-tab), and generates an initial display of 3 velocity directions within the current segmentation, per slice and time frame:

<img src="img8.png?raw=true" width="600px">

#### Divergence Free <a name="divergence-free"></a>
Clicking the `Divergence Free` button automatically performs a [divergence-free wavelet denoising](https://onlinelibrary.wiley.com/doi/full/10.1002/mrm.25176) on the 4D flow velocity field within the current segmentation. This denoising code was adapted from open source [software](https://frankong.com/).

NOTE: Matlab mex files for DFW are system (Windows, Linux, Mac) dependent. Thus upon first usage, mex files need to be compiled. This is accomplished using the following commands in the Matlab command window:
```
cd utilities\corrections\DFW\
mexMake
cd ..\..\..
```

### Processing  <a name="processing"></a>
#### Maps <a name="maps"></a>
Clicking the `Maps` button opens the [Maps tab](#maps-tab), and generates an initial view of 3D velocity vectors within the segmentation as well as an options dialog for viewing (see the [Maps tab](#maps-tab) for everything that can be visualized and quantified here):

<img src="img6.png?raw=true" width="600px">

#### Pulse Wave Velocity <a name="pulse-wave-velocity"></a>
Clicking the `Pulse Wave Velocity` button opens the [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab). The current segmentation is used to extract centerlines for all vascular branches. The initial view shows these branches in 3D with their corresponding branch numbers:

<img src="img7.png?raw=true" width="150px">

## Velocity Unwrapping Tab  <a name="velocity-unwrapping-tab"></a>
Velocity unwrapping can be performed in three ways:
- (automatic) [Laplacian unwrapping](https://onlinelibrary.wiley.com/doi/10.1002/jmri.25045): this is recommended as a first step
- (semi-automatic) using the `Automatic unwrap slice`: assumes previous time frame in current slice is not wrapped, and identifies pixels that are wrapped in the current frame automatically
- Manual unwrap: if `Unwrap manually` checkbox is on, clicking in the corresponding velocity direction will manually unwrap the selected pixel

## Maps Tab  <a name="maps-tab"></a>
This tab is used for visualization and quantification of the 4D flow data. It has two 3D/2D viewers side by side:
- the **left panel** (the *visualization* viewer) shows velocity vectors, streamlines or pathlines together with the vessel surface
- the **right panel** (the *map* viewer) shows a calculated map (e.g. wall shear stress or peak velocity)

Both panels follow the same time frame, which is controlled with the time frame spinner. A separate [Visualization options dialog](#vis-options) controls colors, scales and other display settings.

### What can be visualized and quantified  <a name="overview"></a>
| Visualization (left panel) | Display types | Notes |
|---|---|---|
| 'None' | - | the left viewer is switched off entirely (useful when only a map is of interest, and faster) |
| 'segmentation' | vectors, streamlines | whole segmented vessel |
| 'slice-wise' | vectors | a single slice, overlaid on the magnitude image |
| 'centerline contours' | vectors, streamlines, pathlines | seeded from selected centerline cross sections (flow must be calculated first) |

| Map (right panel) | Units | Display | Quantification |
|---|---|---|---|
| wall shear stress | Pa | on the 3D vessel surface | ROI (projected onto the surface), volume |
| peak velocity | cm/s | projected through the current slice orientation | ROI, volume |
| mean velocity | cm/s | projected through the current slice orientation | ROI, volume |
| kinetic energy | µJ | projected through the current slice orientation | ROI, volume |
| energy loss | mW | projected through the current slice orientation | ROI, volume |
| vorticity | as labeled in the output plots | projected through the current slice orientation | ROI, volume |

For every map the time behavior can be chosen with the `MapTime` dropdown: 'time-resolved' (follows the current time frame), 'time-averaged' or 'peak'. Quantitative results over the cardiac cycle are obtained with [Map ROI analysis](#map-roi-analysis) and [Map volume analysis](#map-volume-analysis), and are written to spreadsheets in a `map_results` folder.

### Navigating the 3D viewers  <a name="viewer-navigation"></a>
All 3D viewers in the tool (Loading tab, Maps tab and Flow and Pulse Wave Velocity tab) are used in the same way:

| Action | Result |
|---|---|
| click and drag in the viewer | rotate the 3D view |
| scroll wheel | zoom in/out |
| `Reset view` button, or `r` key | return to the default view (rotation and zoom) |
| `Axial`, `Sagittal`, `Coronal` buttons (Maps tab) | show the map in the chosen standard orientation |
| left/right arrow keys (Maps tab) | previous/next time frame |
| up/down arrow keys (Maps tab, slice-wise vectors) | previous/next slice |
| space bar (Maps tab) | start/stop [playback](#playback) |

Zoom on the Maps tab is shared by the two panels, so both stay at the same scale.

<img src="viewer_interaction.png?raw=true" width="600px">

### Vector, streamline and pathline display  <a name="vis-panel"></a>
The left panel is set by two dropdown menus. The first menu selects where in the vessel the flow is displayed:
- 'None': no 3D display is shown in the left panel
- 'segmentation': vectors/streamlines are displayed over the whole 3D vessel surface. Note for streamlines the segmentation is automatically subsampled at 5x to reduce computational burden
- 'slice-wise': vectors within a single slice are overlaid on the magnitude image (vectors only; use the slice spinner or up/down arrow keys to change slice)
- 'centerline contours': vectors/streamlines/pathlines are seeded from the chosen centerline contours. Note flow must have been previously calculated in the [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab) for this option. The contours to use are set in the [Visualization options dialog](#vis-options)

The second menu selects the display type:
- **Vectors**: arrows showing the velocity direction and magnitude at the current time frame
- **Streamlines**: lines tangent to the instantaneous velocity field at the current time frame (a "snapshot" of the flow, as if time were frozen)
- **Pathlines** (only with 'centerline contours'): the trajectory that a virtual particle follows over time as it is carried along by the time-varying flow. Particles are released from the selected centerline contours and tracked through all time frames until they leave the vessel segmentation. Pathlines are calculated once (a progress bar is shown) and then displayed per time frame. The length of time particles are tracked, and the time frame at which they are released, are set in the visualization options

Streamlines and pathlines are colored by velocity magnitude. Streamlines are drawn more transparent where velocity is low.

<img src="vecs.png?raw=true" width="600px">

<img src="streamlines.png?raw=true" width="400px">

<img src="pathlines.png?raw=true" width="200px">

### Visualization options dialog  <a name="vis-options"></a>
The `Visualization options` button opens a dialog with the display settings of both viewers. Changes are applied directly. The most important settings:

**Visualization panel (left)**
- *velocity scale (cm/s)*: minimum/maximum velocity of the color scale; velocities below the minimum are not shown
- *vector scale* and *subsample*: arrow size and how many vectors/streamlines/seed points are displayed
- *surface*: choose one of 'none', '3D surface' (isosurface of the angiogram) or 'segmentation surface'. Only one is shown at a time
- *surface color* and *opacity*: color of the surface (light gray, gray, white, black, light blue, yellow, red, blue) and its transparency (0 to 1), useful to see vectors or pathlines inside of the vessel
- *contour points* and *show planes*: for 'centerline contours', the centerline point numbers (e.g. `10:5:60`) whose contours are used as seeds, and whether to draw these planes
- *path length (s)*: for pathlines, the duration each particle is tracked in seconds. Leave blank to track for the full cardiac cycle
- *release frame*: for pathlines, the cardiac time frame at which particles are released (1 = start of the cycle)
- *orientation marker*: shows/hides the anatomical orientation marker
- *colorbar Location*, *Colormap* (jet, parula, hot, spring, summer, autumn, winter, gray), *Text color* and *background color*: general appearance. The time frame label and spinner are automatically switched between white and black to stay readable on the chosen background

**Map panel (right)**
- *map scale*: minimum/maximum of the color scale of the selected map (defaults are chosen per map type)
- *erode mask 1 voxel*: erodes the segmentation by one voxel for the selected map, to exclude voxels at the vessel wall
- *map slice projection*: how the 3D map is projected to the 2D display: 'mean' or 'max' through the slice direction
- *smooth map*: 2x bicubic interpolation for a smoother-looking map. Smoothing is switched off automatically during ROI analysis
- *colorbar Location*, *Colormap* (also 'inverse jet'), *Text color* and *background color*


### Maps  <a name="map-panel"></a>
The map dropdown (right panel) selects the quantity to display: 'None' (hides the map viewer), wall shear stress, peak velocity, mean velocity, kinetic energy, energy loss or vorticity.
- [wall shear stress](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4329118/): needs to be calculated using the `(Re)Calculate Map` button, result is WSS over the whole 3D vessel surface. You will be asked for:
  - the frames to calculate: peak systole only (0) or all frames (1). Calculating all frames takes longer but enables time-resolved WSS and WSS analyses over the cardiac cycle
  - whether to use wall effects (0 or 1)
  - the blood viscosity in Pa·s (default 0.0032)
- peak velocity: projected through the current slice orientation
- mean velocity: projected through the current slice orientation
- kinetic energy: projected through the current slice orientation
- [energy loss](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4051863/): projected through the current slice orientation
- [vorticity](https://www.sciencedirect.com/science/article/pii/S1936878X23001493#bib21): projected through the current slice orientation

The projected maps can be viewed in the axial, sagittal or coronal orientation with the corresponding buttons. WSS is displayed on the 3D surface and can be freely rotated and zoomed.

<img src="maps.png?raw=true" width="600px">

### Time frames and playback  <a name="playback"></a>
The time frame spinner (or left/right arrow keys) steps through the cardiac cycle. The `Play` button (or the space bar) plays the time frames continuously in both panels; press again to pause. The playback speed is set with the frames-per-second box next to the button (1 to 10 fps, default 5).

Note that updating 3D graphics in Matlab is relatively slow. If the viewers cannot keep up with the requested rate (typically when whole-vessel streamlines or maps are shown), frames are skipped so the animation keeps its real speed. When playback stops, the achieved frame rate and the time spent per frame are printed in the Matlab command window. To speed up playback, switch the left or right panel off ('None'), reduce the subsampling, or avoid the 'smooth map' option.


### Save animation  <a name="save-animation"></a>
Clicking the `Save animation` button saves a .gif of all time frames of the velocity vectors/streamlines/pathlines and the selected map (if applicable). You are prompted for a file name and for the output frame rate (frames per second). The animation uses the current view (rotation and zoom) of the viewers, so rotate and zoom to the view of interest first.

The `Save rotated animation` button saves a .gif in which the 3D visualization makes one full 360° turn while the time frames cycle (180 frames at 10 fps). The zoom is set automatically so the vessel stays in view for the whole rotation. This option requires the visualization viewer to be showing the whole segmentation or centerline contours (it is not available for 'slice-wise' or 'None').

### Map ROI analysis <a name="map-roi-analysis"></a>
Clicking the `Map ROI analysis` button allows the user to draw an ROI (polygon) in the current selected map (displayed on the current time frame). Within the ROI all time frames are analyzed and an output image is shown with the ROI average and maximum over the cardiac cycle. The user has the option to save this figure and the corresponding summary statistics: they are written to `map_results/mapROI_results.xlsx` (one sheet per map, with columns for cardiac time, ROI average and ROI maximum) and to a .tiff image.

After saving, the same ROI can be re-used for the other maps (peak velocity, mean velocity, kinetic energy, energy loss and vorticity) with a single click, so these are all analysed on the identical region. If wall shear stress has been calculated, the ROI is also applied to the WSS map: the ROI is projected through the 3D volume onto the vessel surface, and the WSS values of the surface where the ROI projects are analyzed (WSS is skipped if the ROI does not overlap the WSS surface). Selected surface points are marked in the 3D view.

<img src="ROI.png?raw=true" width="600px">

### Map volume analysis <a name="map-volume-analysis"></a>
Similar to the Map ROI analysis, clicking the `Map volume analysis` button displays volumetric time-resolved results for the current selected map. Note this uses all voxels within the current segmentation. An output image and summary statistics are automatically saved to `map_results/mapVol_results.xlsx` (volume average, maximum and area under the curve per time frame; plus the integral and peak of the volume-average curve over the cardiac cycle) and a .tiff image. For wall shear stress calculated at peak systole only, the volume average and maximum are given but no time curve is shown.

#### note on map summary statistics:
Due to the nature of interpolation upon rotation, map summary statistics (quantitative volumetric parameters) are recommended only for orthogonal views (Axial, Sagittal, Coronal). Non-orthogonal views/quantitative volumetric parameters should be used with caution.

## Flow and Pulse Wave Velocity Tab  <a name="flow-and-pulse-wave-velocity-tab"></a>
To segment the vessel of interest, individual branches need to be selected. Input the corresponding branch numbers in Set branches for vessel, adding or removing branches when necessary. Add branches from most distal (downstream) to most proximal (upstream). 

Then click `Check centerline, calculate flow`. At each centerline point, an orthogonal cross section is calculated (using the norm of the centerline). Flow is calculated within each cross section over all cardiac time frames. Resulting cross section segmentations are displayed for certain distances along the vessel for visual inspection:

<img src="img9.png?raw=true" width="450px">

### Flow results  <a name="flow-results"></a>
Resulting flow waveforms and values are shown for each centerline point. Subsets of points can be selected and shown using the PWV Points input and `Examine flow waveforms` button.

### Inspecting a centerline point  <a name="flow-click"></a>
The 3D view of the vessel on this tab uses the same mouse controls as the other viewers (drag to rotate, scroll to zoom, `Reset view` button or `r` key). To inspect a single location, click (without dragging) on the vessel centerline: the nearest centerline point is marked in the 3D view and its waveform is drawn as a thick black line over the other waveforms. The point number is also printed in the Matlab command window, which makes it easy to find the point number of a location of interest when choosing the PWV Points.

<img src="flow_click.png?raw=true" width="600px">

### PWV calculation  <a name="pwv-calculation"></a>
For the subset of PWV points selected, PWV can be calculated using the `Calculate PWV` button. This calculation will use the dropdown menu selected calculation method. The following is an overview of available methods:
- [Wavelet](https://jcmr-online.biomedcentral.com/articles/10.1186/s12968-015-0164-7): wavelet cross-spectrum analysis to find waveform delays
- [XCorr](https://pubmed.ncbi.nlm.nih.gov/18504758/): cross correlation to find waveform delays
- [Maximum likelihood](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8504412/): best fit of a model of a velocity waveform and phase shifts depending on vascular depth and PWV as described in Björnfot et al.
- [Jarvis XCorr](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9387532/): cross correlation with mean/median values and 4 mm spacing as described in Jarvis et al.

### Save  <a name="save"></a>
Resulting flow and pulse wave velocity can be saved via the `Save` button. This will create a 'PWV_results' folder and the following outputs:
- an .xlsx spreadsheet with the calculated pulse wave velocity, all flow waveforms, velocity waveforms, and area waveforms over PWV points
- a Matlab .mat file with a 'results' struct containing scan information and outputs listed above
- a screenshot of the Flow and Pulse Wave Velocity tab

Below is an example screenshot:

<img src="img10.png?raw=true" width="600px">

## Manage Workspace tab <a name="manage-workspace-tab"></a>
This tab allows the user to save or restore the data/settings, or to reset the entire workspace

### Save data/settings <a name="save-tool"></a>
To save the entire app/tool data/settings into a Matlab struct, press the `Save app state` button.

### Restore data/settings <a name="restore-tool"></a>
Restore the app/tool data/settings by pressing the `Restore app state` button. This will prompt selection of a pre-saved .mat file.

### Reset tool <a name="reset-tool"></a>
The `Clear app and restart` button resets all settings and clears the workspace. It is recommended to do this before starting any new analysis.