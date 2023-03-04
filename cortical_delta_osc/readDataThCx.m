% The script file plots the membrane potential traces of single thalamic cells.

clc
close all
clear all %#ok<CLALL>
format longG
AreaCx3(1) = area(5.644, 5.644);
AreaCx3(2) = area(5.644, 160*5.644);
AreaTC = area(60, 90);
AreaNRT = area(42, 63);

multiDisp = 0;

list = dir('*dat');
%iList = 1:length(list);
%iList = 001:1:005;
%iList = 001:1:030;
%iList = 031:1:060;
%iList = 061:1:90;
%iList = 091:1:120;
%iList = 121:1:150;
%iList = 151:1:180;
%iList = 181:1:210;
%iList = 211:1:240;
%iList = 241:1:270;
%iList = 271:1:300;
%iList = 301:1:330;
%iList = 331:1:360;
%iList = 361:1:390;
%iList = 391:1:420;
%iList = 421:1:470;
%iList = 471:1:500;
%iList = 501:1:550;
%iList = 551:1:600;
%iList = 901:1:950;
%iList = 951:1:1000;
%iList = 200:10:1200;
iList = 010:30:590;
%iList = 010:20:590;
%iList = 010:20:890;
%iList = [301 338 398 549]+1;
%iList = [148 431 448 598]+1;
%iList = 315:2:385;
%iList = [315:5:385 410:5:440];
%iList = 410:5:440;
%iList = 20:40:600;
%iList = 10:10:300;
%iList = 300:10:700;
%iList = 601:650;
%iList = [700 701 702 708 717 718 720 727 729 731 741 742 744 748]-99;
%iList = 651:700;
%iList = 701:750;
%iList = 751:800;
%iList = [699 664 661 656 634]+101;
%iList = 801:900;
%iList = 40:40:900;
%iList = 605:5:695; % NRT
%iList = 751:1:800; % TC FO
%iList = 815:10:885; % TC HO
%iList = 811:820; % TC HO
%iList = 605:5:695;
%iList = [715:5:785 815:5:885];
%iList = 801:840;
%iList = 895:1:900;
%iList = [605:10:695 715:10:785 815:10:885];
%iList = [315:20:385 605:20:695 715:20:785 815:20:885];
%iList = [315:10:385 410:5:440 605:10:695 715:10:785 815:10:885];

for i = iList
    
    % Load:
    fileName = list(i).name;
    if i <= 600
        [~, data, cellType] = loadFile(fileName, AreaCx3, 'Cx3');
    elseif i <= 700
         [~, data, cellType] = loadFile(fileName, AreaNRT, 'NRT');
    elseif i <= 900
       [~, data, cellType] = loadFile(fileName, AreaTC, 'TC');
    end
    
    % Plot:
    %if strcmp('TC', cellType)
        f1 = figure('Units', 'normalized', 'Position', [0, .01, .98, .89]);
        if multiDisp %&& i <= 600
            subplot(2,1,1) %#ok<*UNRCH>
        end
        plot(data.t*1e-3, data.v)
        titleStr = sprintf('Membrane Potential Trace - file: %s', fileName);
        set(f1,'name',titleStr)
        title(titleStr, 'Interpreter', 'none')
        xlabel('Time (s)')
        %xlim([0 10])
        ylabel('Membrane potential (mV)')
        ylim([-90 50])

        if multiDisp %&& i <= 600
            subplot(2,1,2)
            hold on
    %         q10 = 2.3^((37 - 23) / 10);
    %         if strcmpi(cellType,'RS')
    %             gkbar = 0.0015;
    %         elseif strcmpi(cellType,'EF')
    %             gkbar = 0.0015;
    %         elseif strcmpi(cellType,'IB')
    %             gkbar = 0.0001;
    %         elseif strcmpi(cellType,'RIB') || strcmpi(cellType,'SIB')
    %             gkbar = 0.0001;
    %         elseif strcmpi(cellType,'ND')
    %             gkbar = 0.009;
    %         elseif strcmpi(cellType,'FS')
    %             gkbar = 0.0015;
    %         end
    %         ikca = 1e6*AreaCx3(2)*q10*gkbar*data.IKCanD.*(data.vD+90);
    %         plot(data.t*1e-3, ikca, 'g')
    %         q10 = 2.3^((37 - 37) / 10);
    %         w_inf = 1./(1 + (38.7./data.NaiS).^3.5);
    %         iknas = 1e6*AreaCx3(1)*q10*0.00007*w_inf.*(data.v+90);
    %         plot(data.t*1e-3, iknas, 'r')
    %         iknad = 1e6*AreaCx3(2)*q10*0.00007*w_inf.*(data.vD+90);
    %         plot(data.t*1e-3, iknad, 'Color', [255 128 0]/255)
    %         plot(data.t*1e-3, data.IGABAa, 'b')
    %         plot(data.t*1e-3, data.IGABAb, 'c')
    %         titleStr = sprintf('Hyperpolarising currents');
    %         title(titleStr)
    %         xlabel('Time (s)')
    %         %xlim([0 5])
    %         ylabel('Current (nA)')
    %         legend('I_{KCa}', 'I_{KNaS}', 'I_{KNaD}', 'I_{GABAa}', 'I_{GABAb}')
            ca = 1;
            if ~ca
                %plot(data.t*1e-3, data.ICANp1, 'g')
                %plot(data.t*1e-3, data.ICANo, 'b')
                %plot(data.t*1e-3, data.ICANp1.*data.ICANo, 'r')
                plot(data.t*1e-3, data.ICAN*1e3, 'm')
                titleStr = sprintf('TC pacemaker currents');
                %ylabel('Current (mA/cm^2)')
                ylabel('Current (pA)')
            else
                plot(data.t*1e-3, data.Cai, 'm')
                %plot(data.t*1e-3, data.IHVAm, 'm')
                titleStr = sprintf('[Ca^{2+}]_i dynamics');
                ylabel('[Ca^{2+}]_i (nM)')
            end
            %xlim([0 10])
            title(titleStr)
            xlabel('Time (s)')
            hold off
        end
    %end
end

% inds = findRange(data.t*1e-3, [2.5 7.5]);
% [~,locs] = findpeaks(data.v(inds(1):inds(end)),'NPeaks',77,'SortStr','descend');
% locs = sort(locs);
% pks = data.v(inds(1)-1+locs);
% hold on
% plot(data.t(inds(1)-1+locs)*1e-3,pks,'.r','MarkerSize',5)
% hold off
% 
% inds = findRange(data.t*1e-3, [2.5 3]);
% baseline = min(data.v(inds(1):inds(end)));
% pksNormalised = abs(pks-baseline);
% pksNormalised = pksNormalised./pksNormalised(1);
% f2 = figure('Units', 'normalized', 'Position', [0, .01, .98, .89]);
% plot((1:length(pksNormalised))-1,pksNormalised,'.r','MarkerSize',20)

% inds = findRange(data.t*1e-3, [2.5 7.5]);
% [~,locs] = findpeaks(-data.v(inds(1):inds(end)),'NPeaks',77,'SortStr','descend');
% locs = sort(locs);
% pks = data.v(inds(1)-1+locs);
% hold on
% plot(data.t(inds(1)-1+locs)*1e-3,pks,'.r','MarkerSize',5)
% hold off
% 
% inds = findRange(data.t*1e-3, [2.5 3]);
% baseline = min(-data.v(inds(1):inds(end)));
% pksNormalised = abs(-pks-baseline);
% pksNormalised = pksNormalised./pksNormalised(1);
% f2 = figure('Units', 'normalized', 'Position', [0, .01, .98, .89]);
% plot((1:length(pksNormalised))-1,pksNormalised,'.r','MarkerSize',20)