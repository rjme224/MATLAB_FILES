function lmcosi = readgrace(filein)

%%This function takes raw grace data after the header is stripped.  It takes two arguments
%%and is called "readgrace(grace data filename)

% Open the raw grace data and scan it into a cell
fileId = fopen(sprintf('D:/Grace/Grace/%s',filein));
File = textscan(fileId, '%*s %f %f %f %f %*[^\n]');

% Convert the cell to matrix
lmcosi = cell2mat(File);
% 
% 
% % Create a new, writable text file in another directory
% Newfile = sprintf('%s/%s',saveloc,filein);
% fileID = fopen(Newfile,'w');
% 
% % Save the array as a csv file in the new file and close it
% csvwrite(Newfile,Data);
fclose(fileId);

end
    
    

