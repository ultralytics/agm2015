function [refvec, R] = refvecworld(z,RasterInterpretation)
if nargin==1;  RasterInterpretation = 'postings';  end
rastersize = size(z);

a = rastersize(1);
b = 90/a;
switch RasterInterpretation
    case 'postings'
       refvec = [a/180,  90-b,  -180+b];
    case 'cells'
       refvec = [a/180,  90-0,  -180+0];
end
R = refvecToGeoRasterReference(refvec, rastersize, RasterInterpretation);

%i.e. for 360x720 'postings', R = [2 89.75 -180.75];
%i.e. for 360x720 'cells',    R = [2 90.00 -180.00];
