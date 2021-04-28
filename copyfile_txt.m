
 sublistfile='H:\test\subname.txt';
 fid=fopen(sublistfile,'rt');
 nsubs=0;
while 1
    text=fgets(fid);
    while (feof(fid)==0) && (isempty(text))
        text=fgets(fid);
    end
    
     if feof(fid), break;end;
    text=deblank(text);
    [text, rs]=strtok(text);
    if isempty(text), continue; end
    if text(1)=='#', continue; end
    if isempty(text)==0
        nsubs=nsubs+1;
%          oPAR.subjects{nsubs}=text;
        SOURCE_PATH_t = 'H:\test\file\';%source path 
        DST_PATH_t = 'H:\test\new\';% copy to path
        filename=['H:\test\file\', text]
        copyfile(filename,DST_PATH_t)
  
    end
end

