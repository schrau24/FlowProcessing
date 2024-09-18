# FlowProcessing User Manual

## Information  <a name="information"></a>
Date: September 18, 2024\
Author: Eric M. Schrauben, PhD\
e.m.schrauben@amsterdamumc.nl

This software builds from previous work, and the use of this tool should be associated and cited with the following reference:\
[E. Schrauben, et al. “Fast 4D flow MRI intracranial segmentation and quantification in tortuous arteries.” JMRI 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4592372/)

<img src="img1.png?raw=true" width="900px">

# Table of Contents
1. [Information](#information)
2. [Getting started](#getting-started)\
  a. [Installation](#installation)\
  b. [Data needed](#data-needed)\
  c. [Starting the app](#starting-the-app)
3. [Loading and Preprocessing Tab](#loading-preprocessing)\
  a. [Load Data](#load-data)\
  b. [Load Segmentation](#load-segmentation)\
    i. [Manual segmentation update](#manual-segmentation-update)\
  c. [Crop Data](#crop-data)

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

### Starting the app  <a name="starting-the-app"></a>
Within Matlab, navigate to the folder containing FlowProcessing.mlapp. Type this into your command window:\
`FlowProcessing`

## Loading and Preprocessing Tab  <a name="loading-preprocessing"></a>
### Load Data  <a name="load-data"></a>
<img src="img2.png?raw=true" width="450px">

Click `Load 4D Flow Data` \
You will be prompted to find one of the reconstructed .rec files in order to locate the correct data folder.

After loading completion, the tool 4D flow acquisition image information is displayed, as well as axial, coronal, and sagittal maximum intensity projections using a calculated angiographic image. An automated thresh-holding of the angiogram is used to display a 3D isosurface within the field of view:
<img src="img3.png?raw=true" width="450px">

### Load Segmentation  <a name="load-segmentation"></a>
Using the `Load Segmentation` button, pre-segmented PC angiograms can be loaded in one of three formats: 
- dicoms, .dcm suffix
- nifti, .nii suffix
- nifti, .nii.gz suffix
<img src="img4.png?raw=true" width="450px">

#### Manual segmentation update  <a name="manual-segmentation-update"></a>
The user can manually update the thresh-holded or manually segmentated isosurface with the `Manual segmentation update` button.\
An external 3D viewer, [imtool3d](https://github.com/tanguyduval/imtool3D_td), loads the current segmentation and angiogram:
<img src="img5.png?raw=true" width="600px">

### Crop Data  <a name="crop-data"></a>
Cropping of data to include only the vessels of interest is recommended and can be performed using the individual `Crop button` above each MIP.
