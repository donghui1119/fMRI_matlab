% The script was used to change 4D space
%Written by Ze Wang(https://cfn.upenn.edu/~zewang/),2018
%updated by Donghui Song,Apr,11,2020(https://scholar.google.com/citations?hl=en&user=ObUL2-MAAAAJ&view_op=list_works&sortby=pubdate)
clc
clear all

Normal_Img=('D:\test\Conver\1\RSFMRI.nii');%select an image with normal space
Space=spm_get_space(Normal_Img);

Imgpath='D:\test\Conver';
Imgfile=dir(Imgpath);
Imgfile=Imgfile(3:end);
for i=1:length(Imgfile);
    Img=[Imgpath,'\',Imgfile(i).name,'\','RSFMRI.nii']
       for  im=1:size(Img,1),
        spm_get_space(deblank(Img(im,:)), Space);
       end
end

