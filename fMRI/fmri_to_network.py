# This script converts each session's images into a functional network

import nibabel as nib
import numpy as np
import os
import argparse
import glob

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

def time_series_to_matrix(subject_time_series,parcel_path,fisher=False,out_file=None):
	"""
	Makes correlation matrix from parcel
	"""
	parcel = nib.load(parcel_path).get_fdata().astype(int)
	g = np.zeros((np.max(parcel),subject_time_series.shape[-1]))
	for i in range(np.max(parcel)):
		g[i,:] = np.nanmean(subject_time_series[parcel==i+1],axis = 0)
	g = np.corrcoef(g)
	if fisher == True:
		g = np.arctanh(g)
	if out_file != None:
		np.save(out_file,g)
	del subject_time_series
	return g

sessions_paths = glob.glob(args['dataset']+"/*/*")

parcel_path = FSLDIR+"/data/atlases/Talairach/Talairach-labels-2mm.nii.gz"

for path in sessions_paths:
	if len(glob.glob(path+"/mni.nii.gz")) is 0:
		continue
	subject_time_series = nib.load(path+"/mni.nii.gz").get_fdata()
	matrix = time_series_to_matrix(subject_time_series, parcel_path)
	session_name = path.split('/')[-1]
	np.save(path+"/"+session_name+"_matrix.npy", matrix)

