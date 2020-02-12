%clear all
%load('WM_Vaibhavi_04Aug_20160804_114244_fil_seg.mat') % Load EEG Data
%load('WM_01_NC_20160513_042335_fil_1_fil_seg.mat')
load('DASS21 - Hardik - 9th Nov_20161109_050854_fil_1_seg.mat')
main_program_DASS; % Filter data according to different bands
gen_DASS

%load('my_adj_mat.mat')
