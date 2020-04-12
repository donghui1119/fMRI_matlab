%The script was used to convert 4D nifti to 3D nifiti
%Written by Donghui Song(https://scholar.google.com/citations?hl=en&user=ObUL2-MAAAAJ&view_op=list_works&sortby=pubdate)
%Apiral,11,2020; Baltimore,MD,USA
clc
clear all

file='D:\test\Conver';
filepath=dir(file);
filepath=filepath(3:end);

for i=1:length(filepath)
    img=[file,'\',filepath(i).name,'\','RSFMRI.nii'];
    mkdir(['D:\test\','3D\',filepath(i).name]);%make a new file to store the 3D files
    writepath=fullfile('D:\test\3D',filepath(i).name);
    spm_file_split(img,writepath) 
end
