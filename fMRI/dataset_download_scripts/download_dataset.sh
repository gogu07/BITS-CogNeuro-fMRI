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

SESSION_DIRS=`ls -d $2"/*/*/"`

for session_dir in $SESSION_DIRS; do
	NUM_BOLD_SCANS=`ls $session_dir"func*" 2>"/dev/null" | wc -l`
	NUM_T2STAR_SCANS=`ls $session_dir"anat*" 2>"/dev/null" | wc -l`

	if [ $NUM_BOLD_SCANS -eq 0 ]; then
		SCAN_NUM=`$session_dir| cut -d'\' -f2`
		echo $SCAN_NUM" has no T2star scan"
	fi

	if [ $NUM_T2STAR_SCANS -eq 0 ]; then
		SCAN_NUM=`$session_dir| cut -d'\' -f2`
		echo $SCAN_NUM" has no BOLD scan"
	fi
done
