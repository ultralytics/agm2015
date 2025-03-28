% Ultralytics 🚀 AGPL-3.0 License - https://ultralytics.com/license

function [] = fcnrunAGM(input, table, flags)
startclock=clock;
%FOR THIS TO WORK RIGHT:
%1. IN FCNOSCTABLES.M MAKE SURE THE TRUE OSC PARAMETERS ARE USED (flags.smearosc=0)!
%2. IN FCNMEANSPECTRA.M MAKE SURE THE REACTOR SPECTRA ARE NOT SMEARED!
%3. MAKE SURE YOU SELECT KAMLAND FROM THE DETECTOR MENU

flags.status.SeaMenuDetectorFloat=1;
flags.status.SeaMenuEGM96=1;
flags.status.SeaMenuWGS84=0;

multiple=4;
nr = 180*multiple; %must be odd number so we don't land directly on a crust2.0 tile!!
nc = 360*multiple;
rv = midspace(90,-90,nr);
cv = midspace(-180,180,nc);
[rm,cm] = meshgrid(rv,cv);
rmv = rm(:);
cmv = cm(:);
zmv = fcnGetAltitude(input, flags, rmv, cmv);
ecefall = lla2ecef([rmv cmv zmv]);

% kr = zh.eros(nr*nc,table.mev.ne);
% geo = zeros(nr*nc,table.mev.ne,3);
kr = zeros(nr*nc,1);  kr3 = kr;
geo = zeros(nr*nc,3);

table.mev.smeared.geonu{1} = interp1(table.mev.uranium.e',  table.mev.uranium.pdf',  table.mev.egeo,'linear',0)'; %flux spectrum including osc (#/MeV)
table.mev.smeared.geonu{2} = interp1(table.mev.thorium.e',  table.mev.thorium.pdf',  table.mev.egeo,'linear',0)';
table.mev.smeared.geonu{3} = interp1(table.mev.potassium.e',table.mev.potassium.pdf',table.mev.egeo,'linear',0)';
table.mev.pdf0  = fcnspecreactoremission(table.mev.e)/(24*60*60); % (#/s/GWth) Reactor emission spectra

%REACTORS -----------------------------------------------------------------
rtable = linspace(.001, max(table.mev.r),30000);
%s = fcnspec1s(table.mev.e,          rtable, table.osc.u, 1, 1E32, 365.25); %TNU
%s = fcnspec1s(table.mev.e,  rtable, [],           0,  1,  1, table.mev.pdf0, interp1(table.mev.r,table.mev.fs,rtable(:))); %flux
s = fcnspec1s(table.mev.e(300:301),  rtable, [],  0,  1,  1, table.mev.pdf0(300:301), interp1(table.mev.r,table.mev.fs(:,300:301),rtable(:))); %flux

skr = input.reactor.IAEAdata.unique; %struct known reactors
nkr = zeros(nr*nc,1);
for i = 1:skr.n
    r = rangec(skr.ecef(i,:),ecefall); %radius squared
    nkr = nkr + interp1c(rtable,s.n,r)*(skr.GWth(i)/table.mev.de); %TNU or flux
    %kr = kr + s.s(fcnindex1c(rtable, r),:)*skr.GWth(i); %TNU or flux
    fprintf('Reactor %.0f of %.0f\n',i,skr.n);
end
%nkr = sum(kr, 2);
%survivalfraction = fcnspec1f(table.mev.r, table.mev.e);
%rm0 = rm; cm0=cm; nkr0=nkr;


% %TOTAL LUMINOSITY ---------------------------------------------------------
% L = zeros(3,4); clc; above1p8=false;
% if above1p8
%     f18 = [0.067656   0.042059  0]; %fractions above E=1.7823MeV
%     E = linspace(1.7823,11,1E4);
% else
%     f18 = [1 1 1]; %fractions above E=1.7823MeV
%     E = linspace(0,11,1E4);
% end
% dE = E(2)-E(1); Lr = sum3(fcnspecreactoremission(E))*dE * sum3(input.reactor.IAEAdata.GWth)/24/60/60 / 1E25
% L(1,1:3)=f18.*sum(table.crust.all.flux);%CRUST
% L(2,1:3)=f18.*sum(table.mantle.flux);%MANTLE
% L(3,1:3)=f18.*(sum(table.crust.all.flux) + sum(table.mantle.flux));%ALL GEO
% L(:,end) = sum(L(:,1:end-1),2); L=L/1E25
% L(end,end)+Lr
% 
% 
% %CRUST --------------------------------------------------------------------
% parfor i = 1:(nr*nc);
%     di = fcn1location(input,table,flags,ecefall(i,:));
%     kr(i,:) = di.epdf.kr;
%     geo(i,:,:) = (di.epdf.crustv + di.epdf.mantlev)';
%     %kr(i) = sum(di.epdf.kr);
%     %geo(i,:) = sum(di.epdf.crustv + di.epdf.mantlev,2)';
%     
%     kr3(i) = di.epdf.kr(300);
%     fprintf('Location %.0f of %.0f\n',i,nr*nc);
% end
% di = fcn1location(input,table,flags,ecefall(1,:));  mantle = di.epdf.mantlev'; %#ok<NASGU>
% fprintf('Done in %.2fmins',etime(clock,startclock)/60)
% 
% %SAVE
% [~,monthstr] = month(now);  ne=table.mev.ne;
% fname = sprintf('AGM%g%s%g %gx%gx%g',day(now),monthstr,year(now),nr,nc,ne);   fprintf('\n\nSaving ''%s.mat''...',fname); tic
% %save([fname '.mat'],'fname','nc','nr','ne','rv','cv','rm','cm','kr','kr3','mantle','geo','-v7.3'); 
% save(['/Users/glennjocher/desktop/' fname '.mat'],'fname','nc','nr','ne','rv','cv','rm','cm','kr','kr3','mantle','geo','-v7.3');  
% % save([fname ' kr.txt'],'kr','-ascii','-tabs'); %1.2GB at 180x360x1100!!
% % save([fname ' geo.txt'],'geo','-ascii','-tabs');
% %save([fname ' mantle.txt'],'mantle','-ascii','-tabs');-
% fprintf('Done (%.1fs).\n',toc);

kr = sum(kr,2);
if ndims(geo)<3; geo = reshape(geo,[size(geo,1) 1 3]); else; geo = sum(geo,2); end %#ok<ISMAT> %if 720x1440; else 360x720
allgeo = sum(geo(:,:,1:2),3);
U = sum(geo(:,:,1),2);
Th = sum(geo(:,:,2),2);




%COMBINE SOURCES ----------------------------------------------------------
total = kr + allgeo;
ntotal = sum(total, 2);
%nkr = sum(kr, 2);
ngeo = sum(allgeo, 2);

%PLOT MAPS ----------------------------------------------------------------
ceiling = max3([ngeo nkr])*.9/100;
zdata = {nkr, U, Th, sum(geo(:,:,3),2), ngeo, ntotal,kr3,Th./U};
titles = {'reactor','238U','232Th','40K','geological','all','3.00-3.01MeV reactor','Th:U'};
logflag = [1 1 1 1 1 1 1 0];    
c1 = [1 1 1];
%fig(1,2,3,3);
P = maps('idlist');
Q = maps('namelist'); %#ok<*NASGU>
nP = size(P,1);
P = {'winkel','pcarree','mollweid','ortho-north','ortho-south','werner','goode','tranmerc','wetch','lambert','cassini','eqaazim','boggs'};
for i=1 %[1 4 5 6 7 8]
    for j=1:1
        %proj = strtrim(P(j,:));
        proj = strtrim(P{j});
        prettyname = proj; %strtrim(Q(j,:));
        fname = sprintf('AGM2016 %s %s',titles{i},prettyname);
        fig(1,1,3,8);
        z = reshape(zdata{i},nc,nr);  z = flipud(z');  if i~=8; z=z/100; end
        if logflag(i); z = log10(z); end
        
        if any(regexpi(proj,'north')); el=90; elseif any(regexpi(proj,'south')); el=-90; else; el=0; end
        if any(regexpi(proj,'ortho')); proj = 'ortho'; end
        
        geoidrefvec = refvecworld(z,'cells');
        axesm(proj,'Origin',[el 0 0],'FontColor',[1 1 1]*.8,'FontSize',3,'FFill',1000,'LabelRotation','on'); %Origin [elevation 0 azimuth] (deg)
        geoshow(z,geoidrefvec,'DisplayType','texturemap');
        
        
        %if ~strcmp(proj,'pcarree')
            %a=load('coast');  plotm(a.lat,a.long,'-','linewidth',1,'color',[1 1 1]) %.5
            lw=.4;
            mlabel(1);
            plabel(180);
            if ~any(regexpi(proj,'ortho')); set(handlem('PLabel'),'Tag',''); plabel(-180); end
            if any(regexpi(proj,'mollweid')); mlabel(2); deleteh(findobj(gcf,'String',' 90^{\circ} N')); deleteh(findobj(gcf,'String',' 90^{\circ} S')); end
            
            h=gridm('-'); set(h,'color',c1,'Clipping','off','linewidth',lw*.6); %.3
            h=framem('-'); set(h,'edgecolor',[1 1 1]*.9,'linewidth',20)
            deleteh(findobj(gcf,'String','  0^{\circ}  ')); deleteh(findobj(gcf,'String','  0^{\circ}'));
            fcnfontsize(12)
            
            %scaleruler('RulerStyle','patches','XLoc',0,'YLoc',-1.04,'MajorTick', 0:1000:3000,'MinorTick', 0:500:3000,'MajorTickLength',120,'MinorTickLength',120,...
            %'label','Scale at Equator','Color',[1 1 1]*.99,'FontSize',8,'linewidth',.2);  ha=findobj(handlem('scaleruler1'),'-property','edgecolor'); set(ha,'EdgeColor','none');
            
            coasts(gca);
            %displaym(wlo.PPpoint);  h = displaym(PPtext); trimcart(h)
            
            %     skr = input.reactor.IAEAdata.unique;
            %     skr.sitename = cellfun(@(x) sprintf('  %s',x),skr.sitename,'UniformOutput',false);
            %     rstr = struct('string',skr.sitename,'lat',num2cell(skr.lla(:,1)),'long',num2cell(skr.lla(:,2)),'tag','','altitude',[],'type','text','otherproperty','');
            %     h = displaym(rstr); set(h,'color',c1,'fontsize',2)
            %     geoshow(skr.lla(:,1),skr.lla(:,2),'DisplayType','point','MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0],'Marker','.','MarkerSize',3);
        %end
        axis equal tight off;
        
        clims = log10(ceiling)+[-.75 0];
        %fcncylindrical2geotiff(z,fname,clims)
        
        %picfname = [fname '.png'];
        %fcnGenerateKMLoverlayPNG(input, picfname, rm, cm, z', [-90 90 -180 180])
        %fcnGenerateKMLoverlay(input,'Reactor Background Overlay.kml',picfname,'Reactor Background Overlay',[-90 90 -180 180])
        
        if logflag(i)
            caxis(clims)
            if i==1; caxis([3.5 6]); end
            if i==7; caxis([1   3]); end %title(sprintf('%s electron antineutrino flux log_{10}(\\nu/cm^2/s)',titles{i}))
        else
            caxis([0 ceiling]);
            if i==8; fcntight('c'); end
        end
        fcntight('csigma');
        h=colorbar; set(h,'color',c1*.7,'Location','East');  
        %if logflag(i); set(h,'yticklabel',num2str(str2double(get(h,'yticklabel')),'10^{%.1f}'));  h.Label.String='\nu_e/cm^2/s'; end
        %h.FontSize = 35;  h.Label.Position(1)=h.Label.Position(1)+5.5; h.Label.Position(2)=h.Label.Position(2)-.9;
        
        if logflag(i); set(h,'yticklabel',num2str(str2double(get(h,'yticklabel')),'10^{%.1f}'));  h.Label.String='\nu_e/cm^2/s/keV @ 3MeV'; end
        h.FontSize = 35;  h.Label.Position(1)=h.Label.Position(1)+5.5; h.Label.Position(2)=h.Label.Position(2)-.8;
                
        
        
        %export_fig(gcf,'-q90','-r150','-a1',[cd '/TESTS/AGM/AGM2016 Figures/' fname '.png'],'-transparent');
        %close(gcf)

        %export_fig(gcf,'-q90','-r150','-a1',[cd '/TESTS/AGM/' fname '.jpg']);%,'-transparent');
        %fcnGenerateKMLoverlay(input,'Reactor Background Overlay.kml',fname,'Reactor Background Overlay',[-90 90 -180 180])
        %close(gcf);
    end
end
return
%fcnaddwatermarks(['/Users/glennjocher/Google Drive/MATLAB/neutrinos/nSimGUI/TESTS/AGM/' 'f1.jpg']);


%ENERGY LAYER MAPS --------------------------------------------------------
%LOAD .mat FILE AGAIN!
flaglayers = 1;
total = geo(:,:,1)+geo(:,:,2)+kr;
if flaglayers
    e = midspace(0,11,1100);
    fig(1,1,3,3); fcnplot3;
    for i=.5:.5:3
        j = i*1.5;
        z = total(:,fcnindex1(e,i));
        z = reshape(z,nc,nr)/10/100;
        surf(cm,-rm,z*0-j,z); shading flat;
        a=load('coast');  a.long(a.long>180)=nan;
        plot3(a.long,-a.lat,ones(size(a.long))*(-j-.002),'-','linewidth',.3,'color',[1 1 1])
        text(-180,-90,-j,sprintf('%.1fMeV ',i),'color',[1 1 1]*.5,'HorizontalAlignment','right','fontsize',16)
    end

    caxis([0 1000])
    daspect([1 1 1/80]);
    h=colorbar; set(h,'color',c1*.5,'Location','SouthOutside');  set(h,'fontsize',16); h.Label.String='{\phv $\bar{\nu}_e/cm^2/s/keV$}'; h.Label.Interpreter='latex';
    fcncolorbar(.8)
    view(-20,19);    
    axis tight off
    alpha(.8)
    set(gcf,'units','centimeters','Position',[3 10 25 25]);
    
%     fig(1,1,1.5)
%     a={kr,geo(:,:,1),geo(:,:,2),geo(:,:,3)};
%     floor = min(sum(kr,1));
%     for i=1:4
%         b=a{i};
%         b=sum(b,1);
%         b(b<floor)=0;
%         b(find(b==0,1,'first'))=floor;
%         plot(e,b*100,'color',fcndefaultcolors(i)); 
%     end
%     xyzlabel('E (MeV)','flux (\nu/cm^2/s)','','total AGM electron antineutrino flux')
%     legend('reactors','^{238}U','^{238}Th','^{40}K')
%     set(gca,'yscale','log'); fcnlinewidth(2)
end


%STEVE AGU MAP
flagAGU = 0;
if flagAGU
    reactorflux = reshape(nkr,nc,nr)';
    lat = rv;
    lng = cv;
    save AGUreactorflux.mat reactorflux lat lng
    save AGUreactorflux.txt reactorflux -ascii -tabs
    fig(1,1,3,1.5)
    pcolor(cv,rv,reactorflux); hold on; shading flat; ch=colorbar('East'); set(ch,'YColor',[.7 .7 .7]); view(0,90)
    caxis([0 100])
    title(sprintf('%s antineutrino flux (TNU)','reactor'))
    a=load('coast');  plot(a.long,a.lat,'w-','linewidth',.75)
    fcnfontsize(12)
    axis equal tight off
end


%GENERATE GOOGLE EARTH OVERLAY --------------------------------------------
flagGE = 0;
if flagGE
    %z = sum(kr(:,300),2);
    z = nkr;
    z = reshape(z,nc,nr);
    %z = min(z,7E8);  z(1,1)=0;  z(end,end)=7E8;  %ceiling at 7E8 nu/s/cm^2;
    minmax3(z)
    z = log10(z);  
    
    
    picfname = 'reactor.png';get
    fcnGenerateKMLoverlayPNG(input, picfname, rm, cm, z, [-90 90 -180 180])
    fcnGenerateKMLoverlay(input,'Reactor Background Overlay.kml',picfname,'Reactor Background Overlay',[-90 90 -180 180])
    
%     %ADD GOOGLE EARTH OVERLAY CONTEXT MENU %-----------------------------------
%     hcmenu = uicontextmenu;
%     hcb1 = 'winopen([input.directory ''/GEfiles/KML/Reactor Background Overlay.kml'']); winopen([input.directory ''/GEfiles/KML/Cylinders.kml''])';
%     uimenu(hcmenu, 'Label', 'View in Google Earth', 'Callback', hcb1); %item1
%     set(pch,'uicontextmenu',hcmenu)
end



%VIDEO
flagVid = 1;
if flagVid
   total = log10((kr + geo(:,:,1)+geo(:,:,2))/1000); %per kev
    
    [ha,hf]=fig(1,1,3,6); hf.Units='pixels'; hf.Position(3:4) = [1920 1080];
    vid=VideoWriter(fcnincrementfname('flux uncompressed'),'Uncompressed AVI');  vid.FrameRate=30;    open(vid);  import java.awt.Robot;  mouse=Robot;
    open(vid);
    hp=[];
    for ie=1:1100   
        z = reshape(total(:,ie),nc,nr);
        if ie==1
            axis equal tight off;
            coasts(gca);
            hp=pcolor(cm,rm,z); shading flat;         

            caxis([0 3.5]);
            ch=colorbar; ch.FontSize=45; set(ch,'yticklabel',num2str(str2double(get(ch,'yticklabel')),'10^{%.1f}'))
            ch.Color = [1 1 1];  ch.Position = [0.91 0.12 0.02 0.77];
            
            ha.Position=[0 0 1 1];
        end
        hp.CData=z;
        ht=title(sprintf('%.2f Mev antineutrino flux log_{10}(\\nu/cm^2/s/keV)',table.mev.e(ie))); ht.FontSize=40; ht.Position(2)=-90; ht.Color=[1 1 1];
        drawnow
        %rect = [50,75,1920-50,1080-75];
        writeVideo(vid,getframe);
    end
    close(vid); clear vid
end


%PREM DENSITY AND BSE ABUNDANCE PROFILES
r = linspace(0,6500,1000)';
density = fcnPREM(r);
[fluxdensity, abundanceTable] = compute_geoneutrinos_mulliss2(r);

fig(2,1,1.5);
sca; plot(r,density,'b'); xyzlabel('radius (km)','density (g/cm^3)','','PREM Earth Density Profile')
sca; plot(r,abundanceTable); set(gca,'yscale','log'); xyzlabel('radius (km)','elemental abundance','','Mantle Elemental Abundances')
legend('U','Th','K'); fcnlinewidth(2)
fcntight('jointx')
end


function di = fcn1location(input,table,flags,ecef)
di.crustBrokenDownFlag = 0;
di.dutycycle.all = 1;

lla=ecef2lla(ecef);

%     di.positionECEF = ecef;
%     [di, npeuranium]  = fcnintegratecrust(di, table, 0, .0001, 20);
%     ncrust(i)         = npeuranium + sum(table.mev.thorium.ns(di.crust.ri).*di.crust.flux(:,2).*di.crust.sa); %number of poisson mean events from each tile

m=1;
di.enabledFlag = true;
di.crustBrokenDownFlag = false;
di.positionLLA = lla;
di.positionECEF = ecef;
di.DCM_NED2ECEF = fcnLLA2DCM_NED2ECEF(lla*pi/180);

[~, di.waterdepth] = fcnGetAltitude(input, flags, lla(1), lla(2));
di.waterdepth = min(di.waterdepth, 0);
if flags.status.SeaMenuEGM96 || flags.status.SeaMenuEGM2008
    di.sealevelaltitude = egm1(lla(1),lla(2),input.EGM); %altitude at sea level
elseif flags.status.SeaMenuWGS84
    di.sealevelaltitude = 0;
end
di.detectordepth = min(di.positionLLA(3) - di.sealevelaltitude, 0); %meters

di.fakeflag = 0;
di.fake.waterdepth = -4000;
di.fake.detectordepth = -3500;
di.fake.sealevelaltitude = 0;
if di.fakeflag    %FAKE DEPTH -> ADD TO 'updateDetectors.m' ALSO!!!!
    di.waterdepth         = di.fake.waterdepth;
    di.detectordepth      = di.fake.detectordepth;
    di.sealevelaltitude   = di.fake.sealevelaltitude;
end

di.dutycycle = [];
di.range = norm(ecef - input.reactor.positionECEF);
di.number = m;
di.mass = input.detectorMass;
di.nprotons = input.detectorProtons; %scale from kamland
di.z = [];
di.ztruth = [];
di.zsigma = [];
di.est = [];
di.reactors = []; [r, dx] = fcnrange(ecef, [input.reactor.IAEAdata.unique.ecef; input.reactor.positionECEF]); di.reactors.udxecef=fcnvec2uvec(dx, r); di.reactors.r=r;
di.kr = []; [r, dx] = fcnrange(ecef, input.reactor.IAEAdata.unique.ecef); di.kr.udxecef=fcnvec2uvec(dx, r); di.kr.r=r; di.kr.ni=numel(r);
%dj.crust = [];
di.mantle.udxecef=table.udx.ned*di.DCM_NED2ECEF';  [r, dx, rs]=fcnrange([-norm(ecef) 0 0], table.mantle.ecef);
di.mantle.r = r;
di.mantle.ri = uint16(fcnindex1(table.mev.r, r));
di.mantle.eli = fcnindex1(table.udx.el, asind(-dx(:,1)./r)); %elevation indices
di.mantle.sa = cm2km^2./rs;
di.nonneutrinos = [];
di.epdf = [];
di.aepdf = [];
di.n = [];
di.snr = [];

%NONNEUTRINO BACKGROUNDS
di = fcngetnonneutrinos(di, input, table);
di.dutycycle.all = 1;
di = fcnintegratecrust(di, table, 0, 0.0001, 20);
[di.n, di.epdf] = fcnmeanspectra(input, table, di, false);
end