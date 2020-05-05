# Table of contents
- [Overview](#overview)
- [The fMRI pipeline](#the-fmri-pipeline)
	* [Downloading the dataset](#1-downloading-the-dataset)
	* [Preprocessing](#2-preprocessing)
	* [Conversion to networks](#3-conversion-to-networks)
- [The PET pipeline](#the-pet-pipeline)
	* [Getting subjects](#getting-subjects)
	* [Downloading](#downloading)
	* [Image preprocessing](#image-preprocessing)
	* [Network construction](#network-construction)
	* [Network analysis](#network-analysis)

# The fMRI pipeline
The fMRI pipeline consists of 3 stages.

### 1. Downloading the dataset
Within the `fMRI/dataset_download_scripts` directory you will find scripts designed to download and organize your image files into a neat directory structure arranged by age groups  
**Dependencies required:** `wget`  

**Usage:**
`./download_dataset.sh <input_dir> <output_dir> <xnat_central_username> <scan_type(s)>`  

**Inputs required:**  
* `input_dir` - A directory path (absolute or relative) which contains CSVs of the subjects according to the age ranges. The format of the file name of the CSV is as follows: `download_<age range lower limit>_<age range upper limit>.csv`. For example, the subjects in the range 42-47 years old will be listed in the file named `download_42_47.csv`. You may refer to the sample `input_dir` provided in the `fMRI/dataset_download_scripts` directory.  
* `output_dir` - A directory path (absolute or relative) to where you wish the dataset to be downloaded to. If the directory doesn't exist, it will be created.  
* `xnat_central_username` - Your XNAT Central username used for accessing OASIS data on central.xnat.org (you will be prompted for your password before downloading)
* `scan_type` - (Optional) The scan type of the scan you want to download. (E.g. T1w, angio, bold, fieldmap, FLAIR) You can also enter multiple scan types separated by a comma with no whitespace (e.g. T2w,swi,bold). Without this argument, all scans for the given experiment_id will be downloaded.

The script will organize the dataset as follows:  
```
output_dir/42_47/OAS30001_MR_d0129/anat1/file.json
output_dir/42_47/OAS30001_MR_d0129/anat1/file.nii.gz
output_dir/62_67/OAS30285_MR_d0129/anat4/file.json
output_dir/62_67/OAS30285_MR_d0129/anat4/file.nii.gz
```

### 2. Preprocessing
`preprocessing.py` performs the following:  
<img src="images/Preprocessing%20pipeline.png" width=500 align="middle">  
And finally outputs a `.nii.gz` file registered to standard space in each session directory.  

**Usage:**
`python preprocessing.py -d <input_dir>`

**Inputs required:**  
* `input_dir` - A directory path (absolute or relative) to the dataset.

### 3. Conversion to networks
**Usage:**
`python fmri_to_network.py -d <input_dir>`


**Inputs required:**
* `input_dir` - A directory path (absolute or relative) to the dataset.  

This produces a `.npy` file in each session directory, containing the adjacency matrix of the network constructed from the fMRI data.

# The PET pipeline
The PET pipeline is made up of the following stages

### Getting subjects
Obtaining the subjects and their respective scans is achieved in a 3-step process:
1. Segmentation of entire OASIS3 PET scan database into **AV45**, **FDG** and **PIB** scans
2. Using the aforementioned segmented CSVs in conjunction **ADRC Clinical data** as inputs to the [oasis_data_matchup.R](https://github.com/NrgXnat/oasis-scripts#matching-up-session-data-by-days-from-entry). This produces a resultant CSV which maps PET scans to ADRC Clinical data IDs, given a certain time window (within which the matching is to occur)
3. Using the outputs from step 2, we apply two criteria to obtain eligible subjects:
	- **Condition 1:** The subject must have at least 2 scans
	- **Condition 2:** Of these multiple scans, there must be at least two scans corresponding to different diagnoses (out of **Cognitively normal**, **Uncertain dementia** and **AD dementia**)
This yields a list of scans which is sent to the next stage of the pipeline

### Downloading
The scripts to download the dataset have been obtained from the [XNAT Central GitHub repository](https://github.com/NrgXnat/oasis-scripts#downloading-mr-and-pet-scan-files). These scripts have been augmented by a master script which partitions the dataset into 3 cohorts based on the 3 tracers being used in the OASIS3 database.

### Image preprocessing
Image preprocessing is being done in 2 steps:
1. **Registration to MNI space**<sup>[\[1\]](https://link.springer.com/article/10.1007/s13721-013-0035-9#Sec2)</sup>
2. **Smoothing<sup>[\[1\]](https://link.springer.com/article/10.1007/s13721-013-0035-9#Sec2)</sup>** The smoothing constant was chosen to be FWHM @ 1cm = 4.6 mm according to the [technical specifications of the scanner](https://www.siemens-healthineers.com/en-in/magnetic-resonance-imaging/mr-pet-scanner/biograph-mmr#TECHNICAL_DETAILS) being used.  
Image preprocessing was done using [FreeSurfer](https://surfer.nmr.mgh.harvard.edu/) in conjunction with [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL)  
The preprocessing of PET images is a computationally intensive task and would have been very hard to accomplish within a reasonable amount of time had it not been for the use of [GNU Parallel](https://www.gnu.org/software/parallel/). The usage of GNU Parallel resulted in a speedup of **71%**

### Network construction
Constructing networks from the preprocessed images required the generation of adjacency matrices. This was accomplished by computing the partial correlation values of intensities in the PET images. These partial correlation values serve as edge weights and constitute the values in the adjacency matrices. This is achieved by `pet_to_network.r` in conjunction with `pet_helper_funcs.py`  
The calculation of partial correlations is a computationally intensive task, mainly due to the pre-calculation of residuals before computing cross-correlation. This calculation was made many times faster with the use of the [ppcor](https://cran.r-project.org/web/packages/ppcor/ppcor.pdf) package for R

### Network analysis
Network analysis is done using the [NetworkX](https://networkx.github.io/) Python library, which enabled the construction of complex brain networks from the adjacency matrices generated by the previous pipeline stage, at a default threshold value of **0.4**  
Next, the global mean percolation centrality value is calculated for each network using the inbuilt function in NetworkX. This has a complexity of **O(n<sup>3</sup>)** and hence had to be parallelized in order to achieve good throughput throughput.  
`pet_graph_analysis.py` executes this stage of the pipeline  



The PET pipeline can be executed as follows `./full_pipeline.sh <desired/path/to/dataset> <path/to/pet/scan/db/csv> <path/to/adrc/csv> <window_size> <xnat_central_username>`  
A sample execution would be:  
<div align="center" style="font-family: monospace">./full_pipeline.sh dataset PET_DB.csv adrc_clinical_cleaned.csv 913 raghavprasad13</div>