function plot_history(obj, y0, dy)
%PLOT_HISTORY Plot the interval history

% Initialize the fixed height
y = y0;

% Hold subfigure
hold on;

% Plot each interval, each with a fixed height lowered by dy
for i = 1:size(obj.history, 1)
    % Unpack interval borders
    a = obj.history(i, 1);
    b = obj.history(i, 2);

    % Pretty plot interval
    plot([a, b], [y, y], '-b', 'LineWidth', 1);
    plot([a, a], [y - dy/3, y + dy/3], '-b', 'LineWidth', 2);
    plot([b, b], [y - dy/3, y + dy/3], '-b', 'LineWidth', 2);

    % Update fixed height
    y = y + dy;
end

% Stop holding figure
hold off;
end

