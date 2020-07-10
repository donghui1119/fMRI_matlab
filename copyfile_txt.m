%copy selected file from the all file

 clc
 clear all
 sublistfile='E:\MyCode\test\name.txt';%subject ID in the txt file
 sublist=fopen(sublistfile,'rt');% open the file, rt:txt file
 nsubs=0;% number of file
while 1
    sub_name=fgetl(sublist);%read line excluding newline character
    while (feof(sublist)==0) && (isempty(sub_name))
    end
     if feof(sublist), break;end;
    sub_name=deblank(sub_name);%deblank remove trailling whitespace and null characters from str and return the result as newstr
    [sub_name, rs]=strtok(sub_name);%strtok:using whitespace character as delimiters, and return the remaining text.
    if isempty(sub_name), continue; end
    if sub_name(1)=='#', continue; end
    if isempty(sub_name)==0
        nsubs=nsubs+1; 
        oldpath = 'E:\test\new\';%source path 
        newpath = 'E:\MyCode\test\copy\';% copy to path
        filename=[oldpath, sub_name]
        copyfile (filename,newpath)
  
    end
end

