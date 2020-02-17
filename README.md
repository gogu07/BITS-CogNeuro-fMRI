# BITS-CogNeuro-fMRI

# The fMRI pipeline
The fMRI pipeline consists of 3 stages.

### 1. Downloading the dataset
Within the `fMRI/dataset_download_scripts` directory you will find scripts designed to download and organize your image files into a neat directory structure arranged by age groups  
**Dependencies required:** `wget`  

Usage:
`./download_dataset.sh <input_dir> <output_dir> <xnat_central_username> <scan_type(s)>`  

Inputs required:  
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
