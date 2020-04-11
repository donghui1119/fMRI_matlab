%The script was used to compare two correlation coefficient maps by Z test
%Written by Donghui Song(https://scholar.google.com/citations?hl=en&user=ObUL2-MAAAAJ&view_op=list_works&sortby=pubdate)
%Aug,2018; Hangzhou,China
close all;
clear;
clc
maskimg='F:\Xin_Xiang_Depression\brainmaskSep28.nii';%mak file
maskimg=spm_vol(maskimg);
V=maskimg;
 maskimg=spm_read_vols(maskimg);
 maskimg=maskimg>0;
 Xdim=size(maskimg,1);
 Ydim=size(maskimg,2);
 Zdim=size(maskimg,3);
rmap1='F:\rTMS_CBF_corr\bigdata_BEN_CBF_ALFF_ReHo_correlation_result\BEN_ALFF_correlation\ALFF_BEN_D2_r0.3Corr.nii';%spm_select(1,'image','chose the image');
rmap2='F:\rTMS_CBF_corr\bigdata_BEN_CBF_ALFF_ReHo_correlation_result\BEN_ALFF_correlation\ALFF_BEN_D3_r0.6Corr.nii';%spm_select(1,'image','chose the image');
V1=spm_vol(rmap1);
V2=spm_vol(rmap2);
Y1=spm_read_vols(V1);
Y2=spm_read_vols(V2);
z1=0.5.*log((1+Y1)./(1-Y1));
z2=0.5.*log((1+Y2)./(1-Y2));
V1=V1(1);
V2=V2(1);
V1.dt=[16 1];
V2.dt=[16 1];
V1.fname=['C:\Users\DonghuiSong\Desktop\BEN_ALFF_z1.nii'];%Output first correlation coefficient(r) Fisher z-transformation map
V2.fname=['C:\Users\DonghuiSong\Desktop\BEN_ALFF_z2.nii'];%Output second correlation coefficient(r) Fisher z-transformation map
V1 = spm_write_vol(V1,z1);
V2 = spm_write_vol(V2,z2);
n1=107;%The first group sample size
n2=107;%The second group sample size
Z=(z1-z2)./(sqrt(1/n1+1/n2));
V3=V(1);
V3.dt=[16 1];
V3.fname=['C:\Users\DonghuiSong\Desktop\BEN_ALFF_Z.nii'];%output Z test map
V3 = spm_write_vol(V3,Z);