% Ultralytics 🚀 AGPL-3.0 License - https://ultralytics.com/license

function [ output_args ] = fcnupscale4x()


load('AGM1Apr2015 720x1440x1100')
geo=reshape(geo,[1440 720 3]);
for i=1:3
    geo2(:,:,i) = interp2(cm',rm',geo(:,:,i)',cm0',rm0','spline')';
end
geo=reshape(geo2,[1440*720*4^2 3]); 
rm=rm0; cm=cm0; nkr=nkr0;
clear geo2 cm0 rm0 nrk0
