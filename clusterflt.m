%function clusterflt(statimg, threshold, clsize, img2bd)
% function for removing small clusters
% clusterflt(statimg, threshold, clsize, img2bd)
%    statimg - the statistical image or other image to be thresholded
%    threshold - voxelwise threshold
%    clsize - cluster size threshold
%    img2bd - image to apply the mask
% Ze Wang 2015
statimg='F:\segementASL\nCorr.nii';
threshold=0.2;
clsize=50;
img2bd='F:\BEN\brainmaskSep28.nii';
v=spm_vol(statimg);
dat=spm_read_vols(v);
mask=(dat>threshold | dat<-threshold);
CC = bwconncomp(mask, 6);
for ni=1:CC.NumObjects
    if length(CC.PixelIdxList{ni})<clsize
        mask(CC.PixelIdxList{ni})=0;
    end
end
% masking out the input
if nargin==4 && ~isempty(img2bd)
    v=spm_vol(img2bd);
    dat=spm_read_vols(v);
end
dat=dat.*mask;
vo=v;
vo.fname=fullfile(spm_str_manip(v.fname, 'H'), ['mask_' num2str(clsize) '_' spm_str_manip(v.fname, 'ts') '.nii']);
vo=spm_write_vol(vo, dat);