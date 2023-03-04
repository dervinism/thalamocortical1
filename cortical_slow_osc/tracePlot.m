function f = tracePlot(titleStr, t, v, xRange, yRange, lineWidth)
f = figProperties(titleStr, 'normalized', [0, .005, .97, .90], 'w', 'on');
plot(t, v, 'Color', 'k', 'LineWidth', lineWidth)
hold on
markerSize = 10;
plot([xRange(1) xRange(1)], [yRange(1) yRange(2)], 'k.', 'MarkerSize', markerSize)
if ~(yRange(1) > 0)
    plot(xRange(1), 0, 'k.', 'MarkerSize', markerSize)
    if ~(yRange(1) > -50)
        plot(xRange(1), -50, 'k.', 'MarkerSize', markerSize)
        if ~(yRange(1) > -60)
            plot(xRange(1), -60, 'k.', 'MarkerSize', markerSize)
            if ~(yRange(1) > -70)
                plot(xRange(1), -70, 'k.', 'MarkerSize', markerSize)
                if ~(yRange(1) > -80)
                    plot(xRange(1), -80, 'k.', 'MarkerSize', markerSize)
                    if ~(yRange(1) > -90)
                        plot(xRange(1), -90, 'k.', 'MarkerSize', markerSize)
                    end
                end
            end
        end
    end
end
hold off
axesProperties({}, 1, 'normal', 'off', 'w', 'Calibri', 30, 4/3, 0.5, [0 0.025], 'out', 'off', 'k', {}, xRange, [], 'off', 'w', {}, yRange, []);