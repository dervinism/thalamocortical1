function ca = axesProperties(titleStr, titleSzMult, titleWeight, boxStr, col, font, fontSz, labelSzMult, width, tickLength, tickDir, xVisible, xCol, xLab, xRange, xTicks, yVisible, yCol, yLab, yRange, yTicks)
ca = gca;
set(gca, 'Box', boxStr);
set(gca, 'Color', col);
set(gca, 'FontName', font);
set(gca, 'FontSize', fontSz);
set(gca, 'LabelFontSizeMultiplier', labelSzMult);
set(gca, 'LineWidth', width);
set(gca, 'TickLength', tickLength);
set(gca, 'TickDir', tickDir);
title(titleStr);
set(gca, 'TitleFontSizeMultiplier', titleSzMult);
set(gca, 'TitleFontWeight', titleWeight);
ca.XRuler.Axle.Visible = xVisible;
set(gca, 'XColor', xCol);
xlabel(xLab);
if ~isempty(xRange)
    xlim(xRange);
end
set(gca, 'XTick', xTicks);
ca.YRuler.Axle.Visible = yVisible;
set(gca, 'YColor', yCol);
ylabel(yLab);
if ~isempty(yRange)
    ylim(yRange);
end
set(gca, 'YTick', yTicks);