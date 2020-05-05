#!/usr/bin/python
# coding: utf-8
#
# This script generates, for each tracer, a list of subjects and their corresponding scans that fulfil the following properties:
# * Condition 1: Has at least 2 scans
# * Condition 2: Of these multiple scans, there must be at least two scans corresponding to different diagnoses (out of Cognitively normal, Uncertain dementia and AD dementia)
# 
# The inputs to this script are the CSVs generated as a result of the application
# of oasis_data_matchup.r on AV45.csv, PIB.csv and FDG.csv with
# adrc_clinical_cleaned.csv, which are named matched_pet_adrc_av45.csv,
# matched_pet_adrc_pib.csv and matched_pet_adrc_fdg.csv respectively

import pandas as pd
import os

tracers = ['AV45', 'FDG', 'PIB']
dict_of_matched_dfs = {tracer:pd.read_csv('matched_pet_adrc_'+tracer.lower()+'.csv') for tracer in tracers}

# The function in the cell below is to fulfil Condition 1, to get rid of
# all those subjects who have only one scan since these subjects won't
# showcase the progression of their condition hence making them not that useful to us

def remove_non_duplicates(dict_of_dfs):
    """
    Removes all subjects that do not satisfy Condition 1
    Parameters
    ----------
    dict_of_dfs: dict
                 Dictionary of dataframes. Each dataframe is that of scans using a
                 particular tracer
    """
    dict_of_subjects={key:list(dict_of_dfs[key]['subject_id']) for key in dict_of_dfs}
    dict_of_duplicate_subjects = {key:sorted(list(set([subject for subject in dict_of_subjects[key] if dict_of_subjects[key].count(subject)>1]))) for key in dict_of_subjects}
    
    for key in dict_of_dfs:
        dict_of_dfs[key].drop(dict_of_dfs[key][dict_of_dfs[key]['subject_id'].isin(dict_of_duplicate_subjects[key])==False].index, inplace=True)  


for key in dict_of_matched_dfs:
    dict_of_matched_dfs[key].drop([dict_of_matched_dfs[key].columns[i] for i in range(len(dict_of_matched_dfs[key].columns)) if not i in [0, 2, 6]], axis=1, inplace=True)
    dict_of_matched_dfs[key].rename(columns={'list1_id':'PET_Session_ID', 'list2_id':'ADRC_Clinical_Data_ID'}, inplace=True)

remove_non_duplicates(dict_of_matched_dfs)


# Now in order to fulfil Condition 2, we require the diagnoses
# which are contained in `adrc_clinical.csv`

adrc_df = pd.read_csv('adrc_clinical.csv')
adrc_df = adrc_df[[adrc_df.columns[0], 'dx1']]
adrc_df.rename(columns={adrc_df.columns[0]:'ADRC_Clinical_Data_ID', 'dx1':'Diagnosis'}, inplace=True)

# In order to obtain the mapping of scans and diagnoses, we perform an SQL style
# left join between each of the scan DataFrames and the adrc_df on the
# ADRC_Clinical_Data_ID column

dict_of_matched_dfs.update({key:dict_of_matched_dfs[key].merge(right=adrc_df, how='left', on='ADRC_Clinical_Data_ID') for key in dict_of_matched_dfs})

# We now create a new column by concatenating the values of `subject_id`
# and `Diagnosis` in each row to enforce Condition 2

for key in dict_of_matched_dfs:
    dict_of_matched_dfs[key][dict_of_matched_dfs[key].columns[1]+' '+dict_of_matched_dfs[key].columns[3]] = dict_of_matched_dfs[key][dict_of_matched_dfs[key].columns[1]]+' '+dict_of_matched_dfs[key][dict_of_matched_dfs[key].columns[3]]
 


# Here we discard duplicates in the `subject_id Diagnosis` column
# (except the last occurrence) since they are subjects with multiple scans
# in the same stage of cognitive impairment (out of which we only require one)

for key in dict_of_matched_dfs:
    dict_of_matched_dfs[key].drop_duplicates(subset=dict_of_matched_dfs[key].columns[-1], keep='last', inplace=True)


# After enforcing Condition 2, some scans may have been eliminated resulting
# in subjects which now don't fulfil Condition 1
# Thus, we apply Condition 1 again below 

remove_non_duplicates(dict_of_matched_dfs)

store_csv_path = os.path.join(os.getcwd(), "dataset_download_scripts", "input_dir")

if not os.path.exists(store_csv_path):
    os.mkdir(store_csv_path)

for key in dict_of_matched_dfs:
    dict_of_matched_dfs[key].to_csv(store_csv_path+'/download_'+key.lower()+'.csv', header=False, index=False, columns=['PET_Session_ID',])


