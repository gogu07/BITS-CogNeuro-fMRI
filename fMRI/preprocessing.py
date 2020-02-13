import os
import argparse
import glob
from tqdm import tqdm
import subprocess

ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=True, help="path to dataset directory")
args = vars(ap.parse_args())

try:
	FSLDIR = os.environ['FSLDIR']
except KeyError as e:
	print("Seems like you don't have FSL installed")
	exit()

if args['dataset'][-1] is '/':
	args['dataset'] = args['dataset'][:len(args['dataset'])-1]

sessions_paths = glob.glob(args['dataset']+"/*/*")

for sessions_path in tqdm(sessions_paths, desc="Scans preprocessed"):
	t2star_scan_name = glob.glob(sessions_path+"/anat*/*.nii.gz")[0].split('/')[-1].split('.')[-3]
	anat_dir_name = glob.glob(sessions_path+"/anat*/*.nii.gz")[0].split('/')[-2]
	# print(t2star_scan_name)
	brain_extraction_command = FSLDIR+"/bin/bet "+sessions_path+"/"+anat_dir_name+"/*.nii.gz "+sessions_path+"/"+anat_dir_name+"/"+t2star_scan_name+"_brain.nii.gz -R 2>/dev/null"
	os.system(brain_extraction_command)

	funcs = glob.glob(sessions_path+"/func*/*.nii.gz")

	if len(funcs) is 0:
		continue
	
	list_of_vols = [int(subprocess.Popen(['fslnvols', x], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0].decode('utf-8')[::-1][1:][::-1]) for x in funcs]
	res = max(list_of_vols)
	func_to_use = funcs[[i for i, j in enumerate(list_of_vols) if j is res][0]]
	# print(func_to_use)
	
	registration_cmd_1 = FSLDIR+"/bin/flirt -in "+sessions_path+"/"+anat_dir_name+"/"+t2star_scan_name+"_brain.nii.gz"+" -ref "+FSLDIR+"/data/standard/MNI152_T1_2mm_brain -omat "+sessions_path+"/mni1.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12"
	registration_cmd_2 = FSLDIR+"/bin/flirt -in "+func_to_use+" -ref "+sessions_path+"/"+anat_dir_name+"/"+t2star_scan_name+"_brain.nii.gz"+" -omat "+sessions_path+"/mni2.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12 2>/dev/null"
	registration_cmd_3 = FSLDIR+"/bin/convert_xfm -concat "+sessions_path+"/mni1.mat -omat "+sessions_path+"/mni.mat "+sessions_path+"/mni2.mat"
	registration_cmd_4 = FSLDIR+"/bin/flirt -in "+func_to_use+" -ref "+FSLDIR+"/data/standard/MNI152_T1_2mm_brain -out "+sessions_path+"/mni.nii.gz -applyxfm -init "+sessions_path+"/mni.mat -interp trilinear"

	os.system(registration_cmd_1)
	os.system(registration_cmd_2)
	os.system(registration_cmd_3)
	os.system(registration_cmd_4)

