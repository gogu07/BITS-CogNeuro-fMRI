#!/bin/bash
#
# Usage: ./download_dataset.sh <input_directory> <output_directory> <xnat_central_username> <scan_type(s)>
# input_directory: contains CSVs of subject IDs in different age groups
# output_directory: will contain directories of subjects grouped by age range

if [ $# -lt 4 ]
then
	echo "Usage: "$0" <input_directory> <output_directory> <xnat_central_username> <scan_type(s)>"
	exit 1
fi

read -s -p "Enter your password for accessing OASIS data on XNAT Central:" PASSWORD
echo $PASSWORD > ".password_tempfile"

CSV_FILES=`ls $1`

if [ ! -d $2 ]
then
    mkdir $2
fi

for i in $CSV_FILES; do
	# cat $1"/"$i >> $TEMPFILENAME
 	bash download_oasis_scans_wget.sh $1"/"$i $2"/"${i:9:5} $3 $4 
done 

rm .password_tempfile