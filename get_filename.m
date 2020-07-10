%%%the script to get all  filenames from a filefolder
%%%Donghui Song,03/07/2020
file='E:\test';%file direct
filefolder=dir(file);
filefolder=filefolder(3:end);
for i=1:length(filefolder);
filename=[filefolder(i).name];
filenames{i}=filename;
end
value=filenames';
xlswrite('E:\test\filename.xlsx',filenames,'group1','A2');
