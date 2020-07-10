%The script was used to voxel-wise regreesion analysis for MRI img and
%behavior,(Y(img1)~X(img2,behavior1,behavior2));
%Donghui Song; July,2020;MD,USA

clear
clc
maskimg='E:\test\mask.nii';%mask file
maskimg=spm_vol(maskimg);
V=maskimg;
 maskimg=spm_read_vols(maskimg);
 Xdim=size(maskimg,1);
 Ydim=size(maskimg,2);
 Zdim=size(maskimg,3);

Img1dir='E:\test\CBF_swPVE';%'img1 direct';
Img1folder=dir(Img1dir);
Img1folder=Img1folder(3:end);
Img2dir='E:\test\T1_smwrc1';%'img2 direct';
Img2folder=dir(Img2dir);
Img2folder=Img2folder(3:end);
Img1=zeros(length(Img1folder),Xdim*Ydim*Zdim);
Img2=zeros(length(Img2folder),Xdim*Ydim*Zdim);
age=textread('.\age.txt');% behavior variates
sex=textread('.\sex.txt');% behavior variates

for i=1:length(Img1folder);

    Img1file=[Img1dir,'\',Img1folder(i).name];
    Img1file=spm_vol(Img1file);
    Img1file=spm_read_vols(Img1file);
    Img1file=Img1file.*maskimg;
    Img1(i,:)=reshape(Img1file,1,Xdim*Ydim*Zdim);
end
for i=1:length(Img2folder);
    Img2file=[Img2dir,'\',Img2folder(i).name];
    Img2file=spm_vol(Img2file);
    Img2file=spm_read_vols(Img2file);
    Img2file=Img2file.*maskimg;
    Img2(i,:)=reshape(Img2file,1,Xdim*Ydim*Zdim);
    
end

    
for j=1:Xdim*Ydim*Zdim;
       one=ones(size(age));
       X=[one,Img2(:,j),age];
       Y=[Img1(:,j)];

      [B,BINT,R,RINT,STATS] = regress(Y,X);
     
       STATS1(j)=STATS(1);%storing  R-square
       STATS2(j)=STATS(2);%storing  F-value
       STATS3(j)=STATS(3);%storing P-value
       STATS4(j)=STATS(4);%storing an estimate of the error variance
end

STATS1(find(isnan(STATS1)))=0;
STATS2(find(isnan(STATS2)))=0;
STATS3(find(isnan(STATS3)))=0;
STATS4(find(isnan(STATS4)))=0;

STATS1=reshape(STATS1,Xdim,Ydim,Zdim);
STATS2=reshape(STATS2,Xdim,Ydim,Zdim);
STATS3=reshape(STATS3,Xdim,Ydim,Zdim);
STATS4=reshape(STATS4,Xdim,Ydim,Zdim);
VV=V(1);
VV.fname=['E:\test\img1_img2_STATS1.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS1);
VV=V(1);
VV.fname=['E:\test\img1_img2_STATS2.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS2);
VV=V(1);
VV.fname=['E:\test\img1_img2_STATS3.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS3);
VV=V(1);
VV.fname=['E:\test\img1_img2_STATS4.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS4);

