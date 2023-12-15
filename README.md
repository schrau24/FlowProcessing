# Amsterdam UMC Flow Processing Tool
a Matlab-based app for all-in-one 4D flow MRI processing, measurements, and visualizations

This tool is based off a previously published post-processing software. Use of this tool should be associated and cited with the following reference: 
E. Schrauben, A. Wåhlin, K. Ambarki, E. Spaak, J. Malm, O. Wieben, A. Eklund. “Fast 4D flow MRI intracranial segmentation and quantification in tortuous arteries.” JMRI 2015, doi: 10.1002/jmri.24900.

**Installation:**
This app is built using Matlab's appdesigner functionality. It was built using Matlab version 2019a; it is therefore recommended to use this version or **newer** for running this app. Download and unzip the files. All functionality of the app is built into PulseWaveVelocityTool.mlapp and the corresponding utilities/ subfolder.

Additionally, the use of this software requires the following Matlab toolboxes:
- Signal Processing Toolbox
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox

**Data needed:**
The app works directly on reconstructed .par / .rec files from a Philips 4D flow acquisition. It assumes these are all located within a single folder. The files needed are as follows: 
SUBJECTID or other identifier_1.par, SUBJECTID or other identifier_1.rec 
SUBJECTID or other identifier_2.par, SUBJECTID or other identifier_2.rec
SUBJECTID or other identifier_3.par, SUBJECTID or other identifier_3.rec

**Getting Started:**
Within Matlab, navigate to the folder containing FlowProcessing.mlapp. Type this into your command window:
FlowProcessing
