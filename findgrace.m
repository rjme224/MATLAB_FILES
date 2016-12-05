clear
clc


%The mainFolder variable will need to be adjusted to reflect where you
%stored the grace data.  

mainFolder = 'D:/Grace/Grace';

files = dir(mainFolder);


% This filters out the parent and current directory '.' and '..'
tf = ismember( {files.name}, {'.', '..'});
files(tf) = [];

% Create Matrix of data named for the month of the file

for i = 1:12
    imcosi{i} = readgrace(files(i).name);
end
Jan = cell2mat(imcosi(1));
Feb = cell2mat(imcosi(2));
Mar = cell2mat(imcosi(3));
Apr = cell2mat(imcosi(4));
May = cell2mat(imcosi(5));
Jun = cell2mat(imcosi(6));
Jul = cell2mat(imcosi(7));
Aug = cell2mat(imcosi(8));
Sep = cell2mat(imcosi(9));
Oct = cell2mat(imcosi(10));
Nov = cell2mat(imcosi(11));
Dec = cell2mat(imcosi(12));
% 
[r,lat,long] = plm2xyz(Jan,1);
figure(1)
plotonearth(r,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('January lightly filtered Geoid')
hold on

%Filter with a light filter and plot
Jan1 = filterlight(Jan);
Feb1 = filterlight(Feb);
Mar1 = filterlight(Mar);
Apr1 = filterlight(Apr);
May1 = filterlight(May);
Jun1 = filterlight(Jun);
Jul1 = filterlight(Jul);
Aug1 = filterlight(Aug);
Sep1 = filterlight(Sep);
Oct1 = filterlight(Oct);
Nov1 = filterlight(Nov);
Dec1 = filterlight(Dec);

[r1,lat,long] = plm2xyz(Jan1,1);
figure(2)
plotonearth(r1,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('January lightly filtered Geoid')
hold on

%Filter with Heavy filter and plot

Jan2 = filterheavy(Jan);
Feb2 = filterheavy(Feb);
Mar2 = filterheavy(Mar);
Apr2 = filterheavy(Apr);
May2 = filterheavy(May);
Jun2 = filterheavy(Jun);
Jul2 = filterheavy(Jul);
Aug2 = filterheavy(Aug);
Sep2 = filterheavy(Sep);
Oct2 = filterheavy(Oct);
Nov2 = filterheavy(Nov);
Dec2 = filterheavy(Dec);


[r2,lat,long] = plm2xyz(Jan2,1);
figure(3)
plotonearth(r2,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('January Heavy filtered Geoid')
hold on

%create Potential
g = 9.80665;
Jan3 = Jan2
Feb3 = Feb2
Mar3 = Mar2
Apr3 = Apr2
May3 = May2
Jun3 = Jun2
Jul3 = Jul2
Aug3 = Aug2
Sep3 = Sep2
Oct3 = Oct2
Nov3 = Nov2
Dec3 = Dec2
% 
% [Jan3(:,3:4)] = Jan3(:,3:4)*g
% [Feb3(:,3:4)] = Feb3(:,3:4)*g
% [Mar3(:,3:4)] = Mar3(:,3:4)*g
% [Apr3(:,3:4)] = Apr3(:,3:4)*g
% [May3(:,3:4)] = May3(:,3:4)*g
% [Jun3(:,3:4)] = Jun3(:,3:4)*g
% [Jul3(:,3:4)] = Jul3(:,3:4)*g
% [Aug3(:,3:4)] = Aug3(:,3:4)*g
% [Sep3(:,3:4)] = Sep3(:,3:4)*g
% [Oct3(:,3:4)] = Oct3(:,3:4)*g
% [Nov3(:,3:4)] = Nov3(:,3:4)*g
% [Dec3(:,3:4)] = Dec3(:,3:4)*g

%Heavyfilter worked best, So I'm plotting it as the "just-right filter"
figure(4)
plotonearth(r2,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('"Just-right" filter')


%Average the 12 months and Plot the average

%I have to average the annual geoid outside here to avoid averaging the 'r'
Annual = (Jan2+Feb2+Mar2+Apr2+May2+Jun2+Jul2+Aug2+Sep2+Oct2+Nov2+Dec2);
avgAnnual = Annual./12



[r3,lat,long] = plm2xyz(avgAnnual,1)
figure(5)
plotonearth(r3,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('Annual Average Geoid')


[Jan3(:,3)] = Jan3(:,3) - avgAnnual(:,3);
[Jan3(:,4)] = Jan3(:,4) - avgAnnual(:,4);

[Feb3(:,3)] = Feb3(:,3) - avgAnnual(:,3);
[Feb3(:,4)] = Feb3(:,4) - avgAnnual(:,4);

[Mar3(:,3)] = Mar3(:,3) - avgAnnual(:,3);
[Mar3(:,4)] = Mar3(:,4) - avgAnnual(:,4);

[Apr3(:,3)] = Apr3(:,3) - avgAnnual(:,3);
[Apr3(:,4)] = Apr3(:,4) - avgAnnual(:,4);

[May3(:,3)] = May3(:,3) - avgAnnual(:,3);
[May3(:,4)] = May3(:,4) - avgAnnual(:,4);

[Jun3(:,3)] = Jun3(:,3) - avgAnnual(:,3);
[Jun3(:,4)] = Jun3(:,4) - avgAnnual(:,4);

[Jul3(:,3)] = Jul3(:,3) - avgAnnual(:,3);
[Jul3(:,4)] = Jul3(:,4) - avgAnnual(:,4);

[Aug3(:,3)] = Aug3(:,3) - avgAnnual(:,3);
[Aug3(:,4)] = Aug3(:,4) - avgAnnual(:,4);

[Sep3(:,3)] = Sep3(:,3) - avgAnnual(:,3);
[Sep3(:,4)] = Sep3(:,4) - avgAnnual(:,4);

[Oct3(:,3)] = Oct3(:,3) - avgAnnual(:,3);
[Oct3(:,4)] = Oct3(:,4) - avgAnnual(:,4);

[Nov3(:,3)] = Nov3(:,3) - avgAnnual(:,3);
[Nov3(:,4)] = Nov3(:,4) - avgAnnual(:,4);

[Dec3(:,3)] = Dec3(:,3) - avgAnnual(:,3);
[Dec3(:,4)] = Dec3(:,4) - avgAnnual(:,4);

January = ESWD(Jan3)

[r4,lat,long] = plm2xyz(January,1);
figure(6)
plotonearth(r4,1,'mercator')
c = colorbar
c.Label.String = 'Meters'
title('January Excess Water')
hold on
