# FlowProcessing User Manual

## Information  <a name="information"></a>
Date: September 18, 2024\
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
6. [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab)

## Getting started  <a name="getting-started"></a>
### Installation  <a name="installation"></a>
This tool is built using Matlab's appdesigner functionality. It was built using Matlab version 2021a; it is therefore recommended to use this version or **newer** for running this tool. Download and unzip the files. All functionality is built into FlowProcessing.m file and the corresponding utilities/ subfolder.

Additionally, the use of this software requires the following Matlab toolboxes:
- Signal Processing Toolbox
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox

### Data needed  <a name="data-needed"></a>
The tool works directly on reconstructed .par / .rec files from a Philips 4D flow acquisition. It assumes these are all located within a single folder. The files needed are as follows:\
SUBJECTID or other identifier_1.par, SUBJECTID or other identifier_1.rec\
SUBJECTID or other identifier_2.par, SUBJECTID or other identifier_2.rec\
SUBJECTID or other identifier_3.par, SUBJECTID or other identifier_3.rec

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
Clicking the `Velocity Unwrapping` button opens the [Velocity Unwrapping tab](#velocity-unwrapping-tab)
#### Divergence Free <a name="divergence-free"></a>
Clicking the `Divergence Free` button automatically performs a divergence-free wavelet denoising on the 4D flow velocity field within the current segmentation. This denoising code was adapted from open source software:
[F. Ong et al. "Robust 4D flow denoising using divergence-free wavelet transform" MRM 2014](https://onlinelibrary.wiley.com/doi/full/10.1002/mrm.25176)\
original code is [here](https://frankong.com/)

### Processing  <a name="processing"></a>
#### Maps <a name="maps"></a>
Clicking the `Maps` button opens the [Maps tab](#maps-tab)
#### Pulse Wave Velocity <a name="pulse-wave-velocity"></a>
Clicking the `Pulse Wave Velocity` button opens the [Flow and Pulse Wave Velocity tab](#flow-and-pulse-wave-velocity-tab)

## Velocity Unwrapping Tab  <a name="velocity-unwrapping-tab"></a>

## Maps Tab  <a name="maps-tab"></a>

## Flow and Pulse Wave Velocity Tab  <a name="flow-and-pulse-wave-velocity-tab"></a>

