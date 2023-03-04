% Membrane potential ploting function

clc
close all
clear all %#ok<CLALL>
format long
AreaCx3(1) = area(5.644, 5.644);
AreaCx3(2) = area(5.644, 160*5.644);
AreaTC = area(60, 90);
AreaNRT = area(42, 63);

lineWidth = ones(1,7)*2;
width = ones(1,7)*2.8*15;
height = ones(1,11)*(width(1)/(155.675/31.871));
label = [0 0];
margin = [0 0];

files{1} = 'y20_0.000100_NRT0data0.0000100_ 75_0.0000520_0.0500.dat';
files{2} = 'y20_0.000100_NRT0data0.0000100_ 75_0.0000460_0.0500.dat';
files{3} = 'y20_0.000100_NRT0data0.0000100_ 75_0.0000380_0.0500.dat';

xRange(1,1:2) = [9.920 11.556]+[0 1];
xRange(2,1:2) = [9.920 11.556]+[0 1];
xRange(3,1:2) = [9.920 11.556]+[0 1];

yRange(1,1:2) = [-96 33]+3.5;
yRange(2,1:2) = [-96 33]+2.5;
yRange(3,1:2) = [-96 33];

for i = 1:length(files)
%     if i <= 3
%         [~, data] = loadFile(files{i}, AreaCx3, 'Cx3');
%     elseif i == 4 || i == 6
%         [~, data] = loadFile(files{i}, AreaNRT, 'NRT');
%     elseif i == 5 || i == 7
        [~, data] = loadFile(files{i}, AreaTC, 'TC');
%     end
    tracePlot(files{i}, data.t*1e-3, data.v, xRange(i,:), yRange(i,:), lineWidth(i));
    paperSize = resizeFig(gcf, gca, width(i), height(i), label, margin, 0);
    name = files{i};
    exportFig(gcf, [name(1:end-4) '.tif'],'-dtiffnocompression','-r300', paperSize);
end
