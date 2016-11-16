clear
clc

mainFolder = '~/Grace/Files';
newFolder = '~/Grace/Files/newfile';
files = dir(mainFolder);

%This filters out all the items in the main folder that are not directories

%files(~[subdirs.isdir]) = [];
%And this filters out the parent and current directory '.' and '..'
tf = ismember( {files.name}, {'.', '..','newfile'});
files(tf) = [];

% for i = 1:length(files);
%     readgrace(files(i).name);
% end


% Create Matrix of data named for the month of the file

for i = 1:12
    mat1{i} = readgrace(files(i+1).name);
end
Jan = cell2mat(mat1(1));
Feb = cell2mat(mat1(2));
Mar = cell2mat(mat1(3));
Apr = cell2mat(mat1(4));
May = cell2mat(mat1(5));
Jun = cell2mat(mat1(6));
Jul = cell2mat(mat1(7));
Aug = cell2mat(mat1(8));
Sep = cell2mat(mat1(9));
Oct = cell2mat(mat1(10));
Nov = cell2mat(mat1(11));
Dec = cell2mat(mat1(12));

%%% Take the month matrix (jan, feb, mar,....etc) and sort by the degree
%%% then order and set columns 4 and 5 to zero for the degree values less
%%% than 2


months = [Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec]
% annual = zeros(size(Jan));

for m = months
    filtergrace(m)

end
[r,lat,long] = plm2xyz(m,1);
figure()
plotonearth(r,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
%Average the 12 months of data

% Plot the filtered data on a mercator plot






