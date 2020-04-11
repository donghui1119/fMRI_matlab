%The script can be used to extract mean value in MASK
%Written by Donghui Song,10/04/2020,Baltimore,MD,USA(https://scholar.google.com/citations?user=ObUL2-MAAAAJ&hl=en)
close all;
clear;
clc
maskimg='C:\Users\DonghuiSong\Desktop\AlphaSim_voxelsize294_p0.005_spmF_0002_mask.nii';
maskimg=spm_vol(maskimg);
V=maskimg;
 maskimg=spm_read_vols(maskimg);
 maskimg=maskimg>0;
 Xdim=size(maskimg,1);
 Ydim=size(maskimg,2);
 Zdim=size(maskimg,3);
file='C:\Users\DonghuiSong\Desktop\HIV_Normal';%imge folder path
filefolder=dir(file);
newfilefolder=filefolder(3:end);
mm=[-21,-66,42];%input MNI(mm)coordinates
V='C:\Users\DonghuiSong\Desktop\HIV_HAND\swBEN_060042_F04_S0_D3_r0.600000.nii';%structure containing Image information (e.g., use the MNI template) -
vox=mm2vox(mm, V);
xyz=[vox(1,1);vox(1,2);vox(1,3)];%you can also comment out function mm2vox, then find the mm to vox coordicate by spm gui display

for i=1:length(newfilefolder);
  img=[file,'\',newfilefolder(i).name];
  V=spm_vol(img);
  Y=spm_read_vols(V);
  Mean_BEN=mean(Y(maskimg(:)));
  M=Mean_BEN;
  value{i}=M;
end
value=value'
xlswrite('C:\Users\DonghuiSong\Desktop\Mean_BEN.xlsx',value,'BEN1','A2')

