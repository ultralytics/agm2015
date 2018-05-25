function [] = fcncylindrical2geotiff(z,fname,clims)
%cmin = min3(z);
%cmax = cmin*5;
%cmin = 8.2;
%cmax = 9;
if nargin==2;  clims = fcnminmax(z); end

a = floorandceil(z,clims) - clims(1);
ind = uint8( a./max3(a)*255 );

%[refvec, R] = refvecworld(z,'postings');
%RGB = uint8( ind2rgb(ind,jet(256))*255 );  geotiffwrite(sprintf('%s.tif',fname),RGB,R)
%geotiffwrite(sprintf('%s gray postings R.tif',fname),ind,R)
%geotiffwrite(sprintf('%s color postings R.tif',fname),ind,jet(256),R)
%geotiffwrite(sprintf('%s color postings refvec.tif',fname),ind,jet(256),refvec)

[refvec, R] = refvecworld(z,'cells');
%geotiffwrite(sprintf('%s color cells R.tif',fname),ind,parula(256),R)
%geotiffwrite(sprintf('%s color cells refvec.tif',fname),ind,jet(256),refvec)

