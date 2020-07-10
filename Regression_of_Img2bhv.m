clear
clc

maskimg='E:\test\mask.nii';%mask file
maskimg=spm_vol(maskimg);
V=maskimg;
maskimg=spm_read_vols(maskimg);
 
Xdim=size(maskimg,1);
Ydim=size(maskimg,2);
Zdim=size(maskimg,3);

Imgdir='E:\test\Img';
Imgfolder=dir(Imgdir);
Imgfolder=Imgfolder(3:end);
Img=zeros(length(Imgfolder),Xdim*Ydim*Zdim);

behavior1=textread('E:\test\age.txt');
behavior2=textread('E:\test\sex.txt');
%behavior3=xxx
%behavior4=xxx
%······
%behavior(n)=xxx


for i=1:length(Imgfolder);

    Imgfile=[Imgdir,'\',Imgfolder(i).name];
    Imgfile=spm_vol(Imgfile);
    Imgfile=spm_read_vols(Imgfile);
    Imgfile=Imgfile.*maskimg;
    Img(i,:)=reshape(Imgfile,1,Xdim*Ydim*Zdim);
    
end

    
for j=1:Xdim*Ydim*Zdim;
    
      X=[ones(size(behavior1)) behavior1 behavior2];%X=[ones(size(behavior1)) behavior1 behavior2 ··· behavior(n)]
      Y=[Img(:,j)];
      [B,BINT,R,RINT,STATS] = regress(Y,X);
      STATS1(j)=STATS(1);
      STATS2(j)=STATS(2);
      STATS3(j)=STATS(3);
      STATS4(j)=STATS(4);
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
VV.fname=['E:\test\STATS1.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS1);
VV=V(1);
VV.fname=['E:\test\STATS2.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS2);
VV=V(1);
VV.fname=['E:\test\STATS3.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS3);
VV=V(1);
VV.fname=['E:\test\STATS4.nii'];
VV.dt=[16 1];
VV = spm_write_vol(VV,STATS4);
