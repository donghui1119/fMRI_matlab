% The script was used to calculate the correlation coefficient  between
% image and behavior data
%Written by Donghui Song,11/04/2020,Baltimore,MD,USA(https://scholar.google.com/citations?user=ObUL2-MAAAAJ&hl=en)
clear
clc
maskimg='C:\Users\DonghuiSong\Desktop\AlphaSim_voxelsize294_p0.005_spmF_0003_mask.nii';%mask file
maskimg=spm_vol(maskimg);
V=maskimg;
 maskimg=spm_read_vols(maskimg);
 Xdim=size(maskimg,1);
 Ydim=size(maskimg,2);
 Zdim=size(maskimg,3);

Img='C:\Users\DonghuiSong\Desktop\HIV_Normal';% image path
Imgsubfolder=dir(Img);
Imgsubfolder=Imgsubfolder(3:end);
imaging=zeros(length(Imgsubfolder),Xdim*Ydim*Zdim);
behavior=xlsread('C:\Users\DonghuiSong\Desktop\new.xlsx','sheet1','A1:A72');% read behavior data

for i=1:length(Imgsubfolder);
    Image=[Img,'\',Imgsubfolder(i).name];
    Image=spm_vol(Image);
    Image=spm_read_vols(Image);
    Image=Image.*maskimg; 
    imaging(i,:)=reshape(Image,1,Xdim*Ydim*Zdim);
end

cor_r=squeeze(zeros(1,Xdim*Ydim*Zdim));

for j=1:Xdim*Ydim*Zdim
    [cor_r(j),p(j)]=corr(behavior,imaging(:,j));
end

cor_r(find(isnan(cor_r)))=0;
p(find(isnan(p)))=0;
cor_r=reshape(cor_r,Xdim,Ydim,Zdim);
p=reshape(p,Xdim,Ydim,Zdim);
VV=V(1);
VV.fname=['C:\Users\DonghuiSong\Desktop\r.nii'];%write r value to nifti file
VV.dt=[16 1];
VV = spm_write_vol(VV,cor_r);
V=V(1);
V.dt=[16 1];
V.fname=['C:\Users\DonghuiSong\Desktop\p.nii'];% write p value to nifti file
V = spm_write_vol(V,p);