# FlowProcessing User Manual

## Information  <a name="information"></a>
Date: May 22, 2025\
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
      2. [Siemens dicom](#siemens-dicom)   
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
      1. [Save animation](#save-animation)
      2. [Map ROI analysis](#map-roi-analysis)
      3. [Map volume analysis](#map-volume-analysis)
6. [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab)
      1. [Flow results](#flow-results)
      2. [PWV calculation](#pwv-calculation)
      3. [Save results](#save)

## Getting started  <a name="getting-started"></a>
### Installation  <a name="installation"></a>
This tool is built using Matlab's appdesigner functionality. It was built using Matlab version 2021a; it is therefore recommended to use this version or **newer** for running this tool. Download and unzip the files. All functionality is built into FlowProcessing.m file and the corresponding utilities/subfolder.

Additionally, the use of this software requires the following Matlab toolboxes:
- Signal Processing Toolbox
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox
- Computer Vision Toolbox

### Data needed  <a name="data-needed"></a>
The tool optionally works on 4D flow in different formats, listed and explained below. For other formats, please contact e.m.schrauben@amsterdamumc.nl to update functionality.
#### Philips .par / .rec <a name="philips-parrec"></a> 
Reconstructed .par / .rec files from a Philips 4D flow acquisition can be directly loaded in. All files shouled be located within a single folder. The files needed are as follows:\
SUBJECTID or other identifier_1.par, SUBJECTID or other identifier_1.rec\
SUBJECTID or other identifier_2.par, SUBJECTID or other identifier_2.rec\
SUBJECTID or other identifier_3.par, SUBJECTID or other identifier_3.rec
#### Siemens dicom <a name="siemens-dicom"></a> 
Reconstructed Siemens .dcm files can be recursively loaded in (note, this option can be time-consuming). All files shouled be located within 4 folders with the following format:\
one folder with the magnitude dicoms, and 3 folders with the separate velocity directions\
note the naming of these folders does not matter as velocity information is gathered directly from the dicom headers

### Starting the tool  <a name="starting-the-tool"></a>
Within Matlab, navigate to the folder containing FlowProcessing.m. Type this into your command window:\
`FlowProcessing`

## Loading and Preprocessing Tab  <a name="loading-preprocessing"></a>
### Load Data  <a name="load-data"></a>
<img src="img2.png?raw=true" width="450px">

Click `Load 4D Flow Data` \
You will be prompted to find one of the reconstructed .rec files in order to locate the correct data folder.

After loading completion, the tool 4D flow acquisition image information is displayed, as well as axial, coronal, and sagittal maximum intensity projections using a calculated angiographic image. An automated thresh-holding of the angiogram is used to display a 3D isosurface within the field of view:

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
Clicking the `Maps` button opens the [Maps tab](#maps-tab), and generates an initial view of 3D velocity vectors within the segmentation as well as an options dialog for viewing:

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
This tab is used for visualization purposes, offering both vectors and calculated maps.

The left panel displays 3D velocity vectors in one of 3 options:
- 'segmentation': vectors are displayed over the whole 3D isosurface
- 'slice-wise': vectors within a single slice are overlaid on the magnitude image
- 'centerline contours': vectors from the centerline contours are displayed. Note flow must have been previously calculated in the [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab) for this option

<img src="vecs.png?raw=true" width="600px">

The right panel allows for visualization of several maps derived for the 4D flow data:
- [wall shear stress](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4329118/): needs to be calculated using the `(Re)Calculate Map' button, result is WSS over whole 3D isosurface
- peak velocity: projected through the current slice orientation
- mean velocity: projected through the current slice orientation
- kinetic energy: projected through the current slice orientation
- [energy loss](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4051863/): projected through the current slice orientation
- [vorticity](https://www.sciencedirect.com/science/article/pii/S1936878X23001493#bib21): projected through the current slice orientation

<img src="maps.png?raw=true" width="900px">

### Save animation  <a name="save-animation"></a>
Clicking the `Save animation` button saves a corresponding .gif of the velocity vectors and selected map (if applicable).

### Map ROI analysis <a name="map-roi-analysis"></a>
Clicking the `Map ROI analysis` button allows the user to draw an ROI in the current selected map (displayed on the current time frame). Within the ROI all time frames are analyzed and an output image is shown. The user has the option to save this figure and corresponding summary statistics to an xlsx spreadsheet.

<img src="ROI.png?raw=true" width="600px">

### Map volume analysis <a name="map-volume-analysis"></a>
Similar to the Map ROI analysis, clicking the `Map volume analysis` button displays volumetric time-resolved results for the current selected map. Note this uses all voxels within the current segmentation. An output image and summary statistics are automatically saved to the corresponding xlsx spreadsheet.

<img src="map_volume.png?raw=true" width="600px">

#### note on map summary statistics:
Due to the nature of interpolation upon rotation, map summary statistics (quantitative volumetric parameters) are recommended only for orthogonal views (Axial, Sagittal, Coronal). Non-orthogonal views/quantitative volumetric parameters should be used with caution.

## Flow and Pulse Wave Velocity Tab  <a name="flow-and-pulse-wave-velocity-tab"></a>
To segment the vessel of interest, individual branches need to be selected. Input the corresponding branch numbers in Set branches for vessel, adding or removing branches when necessary. Add branches from most distal (downstream) to most proximal (upstream). 

Then click `Check centerline, calculate flow`. At each centerline point, an orthogonal cross section is calculated (using the norm of the centerline). Flow is calculated within each cross section over all cardiac time frames. Resulting cross section segmentations are displayed for certain distances along the vessel for visual inspection:

<img src="img9.png?raw=true" width="450px">

### Flow results  <a name="flow-results"></a>
Resulting flow waveforms and values are shown for each centerline point. Subsets of points can be selected and shown using the PWV Points input and `Examine flow waveforms` button.

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
