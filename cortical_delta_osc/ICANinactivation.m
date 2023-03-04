cai = 0:0.000001:0.001000;
hCa_inf = 1./(1 + (cai./0.0002).^5);

figure('Units', 'normalized', 'Position', [0, .01, .48, .89]);
plot(cai, hCa_inf);