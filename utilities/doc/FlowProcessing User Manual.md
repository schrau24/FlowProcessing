# FlowProcessing User Manual

## Information
Date: September 18, 2024\
Author: Eric M. Schrauben, PhD\
e.m.schrauben@amsterdamumc.nl

This software builds from previous work, and the use of this tool should be associated and cited with the following reference:\
[E. Schrauben, et al. “Fast 4D flow MRI intracranial segmentation and quantification in tortuous arteries.” JMRI 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4592372/)

## Getting started
### Installation
This tool is built using Matlab's appdesigner functionality. It was built using Matlab version 2021a; it is therefore recommended to use this version or **newer** for running this tool. Download and unzip the files. All functionality is built into FlowProcessing.m file and the corresponding utilities/ subfolder.

Additionally, the use of this software requires the following Matlab toolboxes:
- Signal Processing Toolbox
- Image Processing Toolbox
- Statistics and Machine Learning Toolbox

### Data needed
The tool works directly on reconstructed .par / .rec files from a Philips 4D flow acquisition. It assumes these are all located within a single folder. The files needed are as follows:\
SUBJECTID or other identifier_1.par, SUBJECTID or other identifier_1.rec\
SUBJECTID or other identifier_2.par, SUBJECTID or other identifier_2.rec\
SUBJECTID or other identifier_3.par, SUBJECTID or other identifier_3.rec

### Getting Started
Within Matlab, navigate to the folder containing FlowProcessing.mlapp. Type this into your command window:\
`FlowProcessing`

