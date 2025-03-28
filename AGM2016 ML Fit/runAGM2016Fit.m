% Ultralytics 🚀 AGPL-3.0 License - https://ultralytics.com/license

function [wm, wsu, wsl,mu] = runAGM2016Fit(vp,M,P,TEMP,OC,latm,lngm)
%call from fcncrust1p0.m
M(OC==1)=0;  wm=0; wsu=0; wsl=0; mu=0;

vf = [6.34 6.52]';  vfs = [0.16 0.19]'; %(km/s) [MC LC] vp
vm = [6.98 7.21]';  vms = [0.20 0.20]';
vcorr = (TEMP-25)*-4E-4 + (P-600)*2E-4; %(km/s) T and P corrections


af = [2.89*.83 8.27 1.37; 2.71*.83 3.87 0.42];  afs = [1.81*.83 8.12 1.03; 2.05*.83 7.35 0.41];  %(abundance) [MC(K Th U); LC(K Th U]]
am = [0.50*.83 0.58 0.37; 0.39*.83 0.30 0.10];  ams = [0.41*.83 0.57 0.39; 0.31*.83 0.46 0.14];
afs = log(af+afs)-log(af); %sigma in logspace
ams = log(am+ams)-log(am);

nmc=2500;  ao=cell(2,3,nmc); %SET nmc=1 for mean evaluation
for i=1:2 %layer [MC LC]
    vpa = vp(:,:,i+6); %MC and LC are layers 7 and 8 in CRUST1.0
    vcorri = vcorr(:,:,i+6);
    for j=1:3 %element [K Th U]
        vma = max(vm(i) + vcorri,0);
        vfa = max(vf(i) + vcorri,0);
        afa = af(i,j);
        ama = am(i,j);
         
        
        %ii=(vpa>vfa & vpa<vma); mean3(ii(OC(:,:,i+6)==0))
        vpa = min( max(vpa,vfa), vma);

        if nmc>1
            vpk=vp(:,:,i+6);
            for k=1:nmc
                vpa = vpk.*(1 + randn([360 180])*.03);
                vma = max(vm(i) + randn*vms(i) + vcorri,0);
                vfa = max(vf(i) + randn*vfs(i) + vcorri,0);
                
                afa = exp(log(af(i,j)) + randn*afs(i,j));
                ama = exp(log(am(i,j)) + randn*ams(i,j));
                
                %vpa = min( max(vpa,vfa), vma);
                ao{i,j,k} = single( (afa*(vpa-vma) + ama*(vfa-vpa)) ./ (vfa-vma) ); %single
            end
        else
            ao{i,j} = (afa*(vpa-vma) + ama*(vfa-vpa)) ./ (vfa-vma); %single
        end
    end
end
ao=reshape(permute(ao,[2 1 3]),[1 1 6 nmc]);
ao=reshape([ao{:}],[360 180 6 nmc]);  %FASTER THAN: ao=cell2mat(ao);
ao(ao<=0)=nan;  ao=log(ao);
rs = [360*180 6]; w = reshape(M(:,:,[7 7 7 8 8 8]),rs);
layerNames = {'';'';'K_{E-2} MC';'Th_{E-6} MC';'U_{E-6} MC';'K_{E-2} LC';'Th_{E-6} LC';'U_{E-6} LC'};
ocw = OC(:,:,[7 7 7 8 8 8])==1; %OC weight

if nmc==1
    mu=exp(ao);  wsl=zeros(1,6); wsu=wsl;  mu(ocw)=0;  mu(isnan(mu))=0;
else
    mu = exp(nanmean(ao,4));                    mu(ocw)=0;
    sl = mu - exp(-nanstd(ao,[],4)+log(mu));    sl(ocw)=0;
    su = exp(log(mu)+nanstd(ao,[],4)) - mu;     su(ocw)=0;
    
    wsl = weightedMean(reshape(sl,rs),w,1); %weighted sigma
    wsu = weightedMean(reshape(su,rs),w,1); %weighted sigma
end
wm = weightedMean(reshape(mu,rs),w,1); %weighted mean
%disp(wm); disp(wsu); disp(wsl)

%PLOT
xh=linspace(0,10,90);  hav=[1 3 5 2 4 6]; %WHOLE WORLD
fig(3,2); for i=1:6;  sca(hav(i)); h=histogram(exp(ao(:,:,i,:)),xh,'FaceColor',fcndefaultcolors(1));  h.DisplayName=sprintf('%.2g^{ +%.2g}_{ -%.2g}',wm(i),wsu(i),wsl(i)); xlabel(layerNames{i+2}); legend show; end; fcntight('xjoint'); fcnfontsize(16)

if nmc==1
    a=zeros(360,180,9); a(:,:,3:8)=mu;  h=plotcrust1p0(layerNames,latm,lngm,a,'abundance calculation','');  for i=3:8; h(i).Position=h(i).Position+[0 .24 0 0]; end
else
    a=zeros(360,180,9); a(:,:,3:8)=mu;  h=plotcrust1p0(layerNames,latm,lngm,a,'abundance MC \mu','');  for i=3:8; h(i).Position=h(i).Position+[0 .24 0 0]; end
    a=zeros(360,180,9); a(:,:,3:8)=sl;  h=plotcrust1p0(layerNames,latm,lngm,a,'abundance MC -1\sigma','');  for i=3:8; h(i).Position=h(i).Position+[0 .24 0 0]; end; fcntight('jointcsigma');
    a=zeros(360,180,9); a(:,:,3:8)=su;  h=plotcrust1p0(layerNames,latm,lngm,a,'abundance MC +1\sigma','');  for i=3:8; h(i).Position=h(i).Position+[0 .24 0 0]; end; fcntight('jointcsigma');

    %SINGLE TILE
    fig(3,2); for i=1:6;  sca(hav(i)); [~,~,h]=fcnhist(exp(ao(180,80,i,:)),xh,fcndefaultcolors(3));  h.DisplayName=sprintf('%.2g^{ +%.2g}_{ -%.2g}',wm(i),wsu(i),wsl(i));  xlabel(layerNames{i+2}); end; fcntight('xjoint'); fcnfontsize(16)
end
''