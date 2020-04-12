%the script was used to shift fov of resting state fmri image
%Written by Ze
%Wang(https://cfn.upenn.edu/~zewang/),Mar,2020;Baltimore,MD,USA
%updated by Donghui Song

file='D:\test\Conver\shift';
filepath=dir(file);
filepath=filepath(3:end);
for i=1:length(filepath);
    img=[file,'\',filepath(i).name];
    v=spm_vol(img);
  
    data=spm_read_vols(v);
    [sx,sy,sz,st]=size(data);
    idx=([-11:12])+ceil(sx/2);
    cz=ceil(sz/2);
     ND=1;
% shift is empirically found to be 8 voxels
     SH=4;%shift voxel size
          for t=(ND):st
              n=t-ND+1;
              dat=squeeze(data(:,:,:,t));
              tmp=zeros(size(dat));
              tmp(:, 1:SH, :)=dat(:, (sy-SH+1):end,:);
              tmp(:, (SH+1):end, :)=dat(:, 1:(sy-SH),:);
              vo=v(t);
              vo.fname=spm_file(vo.fname, 'prefix', 'fovshift_');
              vo.n=[n 1];
              vo=spm_write_vol(vo, tmp);
          end

end
