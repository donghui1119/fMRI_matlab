%The script was used to calculate voxel-wise correlation coefficient
%between two map
%The script was written according to edition of Da Chang by DonghuiSong(https://scholar.google.com/citations?hl=en&user=ObUL2-MAAAAJ&view_op=list_works&sortby=pubdate)
%Aug,2018; Hangzhou,China

clear
clc
maskimg='G:\T1ImgSegment\VBM\mask.nii';%mask file
maskimg=spm_vol(maskimg);
V=maskimg;
maskimg=spm_read_vols(maskimg);

Xdim=size(maskimg,1);
Ydim=size(maskimg,2);
Zdim=size(maskimg,3);

img1file='G:\T1ImgSegment\VBM\SN_BEN';%image1 file path
img1subfolder=dir(img1file);
img1subfolder=img1subfolder(3:end);

img2file='G:\T1ImgSegment\VBM\SN_HAND\srwc1';%image2 file path
img2subfolder=dir(img2file);
img2subfolder=img2subfolder(3:end);

img1=zeros(length(img1subfolder),Xdim*Ydim*Zdim);
img2=zeros(length(img1subfolder),Xdim*Ydim*Zdim);

for i=1:length(img1subfolder)
    img1sub=[img1file,'\',img1subfolder(i).name];
    img1sub=spm_vol(img1sub);
    img1sub=spm_read_vols(img1sub);
    img1sub=img1sub.*maskimg;
    
    img2sub=[img2file,'\',img2subfolder(i).name];
    img2sub=spm_vol(img2sub);
    img2sub=spm_read_vols(img2sub);
    img2sub=img2sub.*maskimg;   
    
    img1(i,:)=reshape(img1sub,1,Xdim*Ydim*Zdim);
    img2(i,:)=reshape(img2sub,1,Xdim*Ydim*Zdim);
end

cor_r=squeeze(zeros(1,Xdim*Ydim*Zdim));
cov=textread('G:\T1ImgSegment\VBM\SN_edu.txt')
for j=1:Xdim*Ydim*Zdim
    [cor_r(j),p(j)]=partialcorr(img2(:,j),img1(:,j),cov);
end

cor_r(find(isnan(cor_r)))=0;
p(find(isnan(p)))=0;
cor_r=reshape(cor_r,Xdim,Ydim,Zdim);
p=reshape(p,Xdim,Ydim,Zdim);
VV=V(1);
VV.fname=['G:\T1ImgSegment\VBM\cSN_BEN_c1_r.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,cor_r);
V=V(1);
V.dt=[16 1];
V.fname=['G:\T1ImgSegment\VBM\cSN_BEN_c1_p.nii'];
V = spm_write_vol(V,p);