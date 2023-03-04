nai = 0:0.1:100;
w_inf = 1./(1 + (38.7./nai).^3.5);

figure('Units', 'normalized', 'Position', [0, .01, .48, .89]);
plot(nai, w_inf);
hold on

%p = 1./(1 + ((50 + 0)./nai).^2.5);
p = 1./(1 + (nai./(50 + 0)).^5);
plot(nai, p, 'r');
hold off