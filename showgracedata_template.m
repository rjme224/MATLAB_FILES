function showgracedata

% Modified by Dr. Keely OFarrell, Prof, UKy, September 2016
% Modified by Dr. David Bailey, Prof, UofT, January 2007

% This execise is to introduce you to matlab, in particular the use of
% functions and subfunctions, and the complexities of reading formatted data
% files. The routines you write you will re-use later.

% Read and plot a  GRACE spherical harmonic coefficient file, preferably with the header lines stripped
% out already (Do the stripping with a text editor).
% These are the top 7 lines of the GSM files and the top 5 of the GSM*.txt files

% Suitable data files are at
% ftp://podaac.jpl.nasa.gov/GeodeticsGravity/grace/L2/CSR/RL05/
% and have names like
% GSM-2_00nn_yyyyddd-yyyyddd_UTCSR_0000_0001.gz
% Where yyyyddd's are actually start and end dates of the data that was
% averaged to make that dataset.  The nn's are 2 digit numbers.  
%
% You have to download these files, which are ".gz" compressed files.
% The file can be uncompressed, either as part of the download if you have
% a smart downloader, or after downloading using the command gunzip on a
% unix machine, or an unzipper such as Winzip or WinRaR on a windows
% machine.
%
% Then you need to remove all the lines (6?) before the actual data lines,
% so that the matlab function textread will not stumble over these
% differently formatted lines.  
% Whatever name you have given the data file after unzipping, give that
% value to the 'filename' variable below, and run this program. (For a 
% fancier approach, use the MATLAB uigetfile function).

filename = 'GSM-2_0030_2004153-2004182_UTCSR_0000_0001_stripped.txt'
% Rather than clutter your code with the details of reading, write a
% function (to go below; call it "readgrace") to read in the coefficient
% data, and call it here as
[n,m,cs,ss] = readgrace(filename);
% Each line has, in order,
% A textword, n, m, cs, ss, and other stuff following.
% There will be stuff (e.g. the textword) on each line that readgrace has to discard.  
% The returned values from should be:
% n = L in math notation; the first spherical harmonic index (the "degree")
% m = the second index; the "order"
% cs = the cosine coefficient for harmonic (n,m)
% ss = the sine coefficient for harmonic (n,m)
%Warning: writing readgrace will be the hardest part of this code.

% It is a good idea to get these all into a standard data matrix.  I
% suggest:
lmcosi = [n m cs ss];  % L,M, COS_COEFF, SIN_COEFF, each as a column in 2Darray lmcosi
% However, these will not be in canonical order (as required by the function 
% plm2xyz below), so sort them by degree first and then order.  This can be done 
% with a one-line call to the
% MATLAB function sortrows.

% Because the geoid is dominated by the equatorial bulge (The degree 2
% harmonics), which has no information of interest to us, remove it
% by setting all coefficients for order 2 or less to zero.

% To visualize this data, we need to do an "inverse spherical harmonic
% transform" with the provided function plm2xyz, as follows:
[r,lon,lat]=plm2xyz(lmcosi);  
% This transforms the data to an actual function r on a lat-long grid.
% Without a second argument, it assumes a default lat-long grid (see the
% comments in plm2xyz for details).  plm2xyz itself calls a number of
% function m-files which must be present on your matlab path, spcifically
% defval, addmup, shcos, shsin.  Warning: inverse spherical harmonic
% transforms are NOT fast like Fast Fourier Transforms. Expect this to take
% at least several seconds.

% You can then plot this function "r", either as a flat projection (I leave the details
% to you), or on the surface of a sphere using the provided function
% plotonearth, as in
plotonearth(r,conts);
% To get a continent outline, set "conts"  equal to 1.  
% Otherwise to zero.
% This will load in the coast.mat file for plotting

% Add title, labels and a colour scale.

% That is your deliverable.  But try to decide if it looks approximately
% right before relaxing.
