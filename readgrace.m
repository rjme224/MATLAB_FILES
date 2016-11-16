function Data = readgrace(filein)

%%This function takes raw grace data after the header is stripped and
%%converts column 2:5 into a .csv file with the same name.  It takes two arguments
%%and is called "readgrace(grace data filename, directory where the csv is
%%to be saved without the '/'"


% Open the raw grace data and scan it into a cell
fileId = fopen(sprintf('~/Grace/files/%s',filein));
File = textscan(fileId, '%*s %f %f %f %f %*[^\n]');

% Convert the cell to matrix
Data = cell2mat(File);
% 
% 
% % Create a new, writable text file in another directory
% Newfile = sprintf('%s/%s',saveloc,filein);
% fileID = fopen(Newfile,'w');
% 
% % Save the array as a csv file in the new file and close it
% csvwrite(Newfile,Data);
% fclose(fileID);

end
    
    

