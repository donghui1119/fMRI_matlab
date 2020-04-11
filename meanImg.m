%The script was used to calculate mean value in mask
%Written by Ze Wang and Donghui Song,May,2018, Hangzhou,China
close all;
clear;
clc
maskimg='G:\brainmaskSep28_64.nii';%mask file
maskimg=spm_vol(maskimg);
V=maskimg;
 maskimg=spm_read_vols(maskimg);
 maskimg=maskimg>0;
 Xdim=size(maskimg,1);
 Ydim=size(maskimg,2);
 Zdim=size(maskimg,3);
filename=spm_select(1,'image','chose the image');%image file
V=spm_vol(filename);
Y=spm_read_vols(V);
meanBEN=mean(Y(maskimg(:)));