#!/usr/local/bin/parallel --shebang-wrap /bin/bash
#
# Usage: ./download_dataset.sh <input_directory> <output_directory> <xnat_central_username>
# input_directory: contains CSVs of subject IDs in different age groups
# output_directory: will contain directories of subjects grouped by age range

if [ $# -ne 3 ]
then
	echo "Usage: "$0" <input_directory> <output_directory> <xnat_central_username>"
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
 	bash dataset_download_scripts/download_oasis_scans_wget.sh $1"/"$i $2"/"$(echo $i| cut -d'_' -f 2| cut -d'.' -f 1| tr '[:lower:]' '[:upper:]') $3 $4 
done 

rm .password_tempfile

# SESSION_DIRS=$2"/*/*"

# for session_dir in $SESSION_DIRS; do
# 	# echo "session_dir: "$session_dir
# 	BOLD_SCANS=`ls -d "$session_dir"/func* 2>/dev/null`
# 	T2STAR_SCANS=`ls -d "$session_dir"/anat* 2>/dev/null`

# 	if [ -z "$T2STAR_SCANS" ]
# 	then
# 		SCAN_NUM=`echo $session_dir|cut -d'/' -f3`
# 		echo $SCAN_NUM" has no T2star scan"
# 	fi

# 	if [ -z "$BOLD_SCANS" ]
# 	then
# 		SCAN_NUM=`echo $session_dir|cut -d'/' -f3`
# 		echo $SCAN_NUM" has no BOLD scan"
# 	fi
# done