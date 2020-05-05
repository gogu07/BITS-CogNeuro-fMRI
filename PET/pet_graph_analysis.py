#!/usr/bin/env python
# coding: utf-8

import numpy as np
import pandas as pd
import networkx as nx
import argparse
from networkx.classes.function import selfloop_edges
from tqdm import tqdm
from glob import glob
import os
from multiprocessing import Pool

def calculate_percolation(matrix, percolation_mat_path, threshold=0.4):
    """
    Returns the global mean percolation centrality of a graph created from an adjacency matrix and nodal percolation
    values
    Parameters
    ----------
    matrix: array-like, shape (n, n)
            Adjacency matrix where each entry is a number between 0 and 1 and represents edge weights
             
    percolation_mat_path: array-like, shape (n,)
                          Array containing percolation values of all the n nodes
    
    threshold: float, optional[default=0.6]
               A thresholding constant which will cause all edge weights < threshold to be reassigned to 0 
    Returns
    -------
    mean_perc_centrality: float
                          Global mean percolation centrality
    """
    
    matrix_copy=matrix.copy()
    matrix_copy[abs(matrix_copy)<threshold]=0
    
    percolation = np.load(percolation_mat_path)
    
    node_percolation_attribs = {i:{'percolation':percolation[i]} for i in range(matrix.shape[0])}
    
    func_net=nx.from_numpy_array(matrix_copy)
    func_net.remove_edges_from(selfloop_edges(func_net))
    nx.set_node_attributes(func_net, node_percolation_attribs)
    
    perc_centrality=nx.percolation_centrality(func_net, weight='weight')
    mean_perc_centrality=np.mean(np.array(list(perc_centrality.values())))
    
    return mean_perc_centrality

def func(num):
	return (num, num**2)

def obtain_stats(scan_path):
    matrix = np.load(scan_path+'adj_mat.npy')
    percolation_mat_path = scan_path+'percolation.npy'
    scan_id = scan_path.split('/')[-3]
    return (scan_id, calculate_percolation(matrix, percolation_mat_path))

ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=True, help="path to dataset directory")
args = vars(ap.parse_args())

if args['dataset'][-1] == '/':
    args['dataset'] = args['dataset'][:len(args['dataset'])-1]

dataset_path = args['dataset']
scan_paths = glob(dataset_path+'/*/*/pet1/')

pool = Pool()
# result = {key:value for key,value in tqdm(pool.map(obtain_stats, scan_paths), total=len(scan_paths), desc='Networks processed')}
result = {key:value for key,value in tqdm(pool.map(obtain_stats, scan_paths), total=len(scan_paths), desc='Networks processed')}

# for scan_path in tqdm(scan_paths, desc='Networks processed'):
#     matrix = np.load(scan_path+'adj_mat.npy')
#     percolation_mat_path = scan_path+'percolation.npy'
#     scan_id = scan_path.split('/')[-3]
#     result.update({scan_id:calculate_percolation(matrix, percolation_mat_path)})


result = dict(sorted(result.items(), key=lambda t: t[0].split('_')[1]))

out_df = pd.DataFrame.from_dict(result, orient='index', columns=['Mean percolation centrality'])
out_df.reset_index(inplace=True)
out_df.rename(columns={'index':'Scan ID'}, inplace=True)

num_of_av45 = len(out_df[out_df['Scan ID'].str.contains('AV45', case=True)])
num_of_fdg = len(out_df[out_df['Scan ID'].str.contains('FDG', case=True)])
num_of_pib = len(out_df[out_df['Scan ID'].str.contains('PIB', case=True)])

df1 = pd.read_csv('matched_pet_adrc_av45.csv')
df1.rename(columns={'list1_id':'Scan ID', df1.columns[1]:'ADRC Clinical Data ID'}, inplace=True)
df1.drop([df1.columns[i] for i in range(len(df1.columns)) if not i in [0, 1]], axis=1, inplace=True)

df2 = pd.read_csv('matched_pet_adrc_fdg.csv')
df2.rename(columns={'list1_id':'Scan ID', df2.columns[1]:'ADRC Clinical Data ID'}, inplace=True)
df2.drop([df2.columns[i] for i in range(len(df2.columns)) if not i in [0, 1]], axis=1, inplace=True)

df3 = pd.read_csv('matched_pet_adrc_pib.csv')
df3.rename(columns={'list1_id':'Scan ID', df3.columns[1]:'ADRC Clinical Data ID'}, inplace=True)
df3.drop([df3.columns[i] for i in range(len(df3.columns)) if not i in [0, 1]], axis=1, inplace=True)

df4 = pd.read_csv('adrc_clinical.csv')
df4.rename(columns={df4.columns[0]:'ADRC Clinical Data ID', 'dx1':'Diagnosis'}, inplace=True)
df4.drop([df4.columns[i] for i in range(len(df4.columns)) if i!=0 and df4.columns[i]!='Diagnosis'], axis=1, inplace=True)
df4

merge_av45 = out_df[:num_of_av45].merge(df1, how='left', on='Scan ID')
merge_av45 = merge_av45.merge(df4, how='left', on='ADRC Clinical Data ID')

merge_fdg = out_df[num_of_av45:num_of_av45+num_of_fdg].merge(df2, how='left', on='Scan ID')
merge_fdg = merge_fdg.merge(df4, how='left', on='ADRC Clinical Data ID')


merge_pib = out_df[num_of_av45+num_of_fdg:].merge(df3, how='left', on='Scan ID')
merge_pib = merge_pib.merge(df4, how='left', on='ADRC Clinical Data ID')

store_dir_path = os.path.join(os.getcwd(), "stats")
os.mkdir(store_dir_path)

merge_av45.to_csv(os.path.join(store_dir_path, 'av45_percolation_stats.csv'), index=False, columns=[merge_av45.columns[i] for i in range(len(merge_av45.columns)) if not i is 2])
merge_fdg.to_csv(os.path.join(store_dir_path, 'fdg_percolation_stats.csv'), index=False, columns=[merge_fdg.columns[i] for i in range(len(merge_fdg.columns)) if not i is 2])
merge_pib.to_csv(os.path.join(store_dir_path, 'pib_percolation_stats.csv'), index=False, columns=[merge_pib.columns[i] for i in range(len(merge_pib.columns)) if not i is 2])


