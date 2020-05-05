#!/usr/local/bin/parallel --shebang-wrap /bin/bash
#
# Usage: ./full_pipeline.sh desired/path/to/dataset path/to/pet/scan/csv path/to/adrc/csv window_size xnat_central_username

if [[ $# -ne 5 ]]; then
	echo "Usage: "$0" desired/path/to/dataset path/to/pet/scan/csv path/to/adrc/csv window_size xnat_central_username"
	exit 1
fi
 
echo '#########################################################################'
echo 'STAGE 1: Getting subjects'
echo '#########################################################################'

./obtain_pet_subjects.py -c $2

# SCAN_CSVS={'AV45.csv', 'FDG.csv', 'PIB.csv'}

for SCAN_CSV in 'AV45.csv' 'FDG.csv' 'PIB.csv'; do
	if [[ -f "$SCAN_CSV" ]]; then
		Rscript oasis_data_matchup.R $SCAN_CSV $3 $4 $4 "matched_pet_adrc_"`echo $SCAN_CSV | tr '[:upper:]' '[:lower:]'`
	fi
done

./get_eligible_subjects.py

echo '#########################################################################'
echo 'STAGE 2: Downloading dataset'
echo '#########################################################################'

./dataset_download_scripts/download_dataset.sh ./dataset_download_scripts/input_dir $1 $5

echo '#########################################################################'
echo 'STAGE 3: Preprocessing dataset'
echo '#########################################################################'

./preprocessing.sh $1

echo '#########################################################################'
echo 'STAGE 4: Constructing networks'
echo '#########################################################################'

./pet_to_network.r -d $1

echo '#########################################################################'
echo 'STAGE 5: Analyzing networks'
echo '#########################################################################'

./pet_graph_analysis.py -d $1

