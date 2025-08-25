clc; clear; close all;

% --- Parameters ---
x = linspace(-2, 2, 400);
A = 0.3;
numPoints = length(x);  % number of points for animation

% --- Load and play song ---
try
    [y_audio, Fs] = audioread('song.wav');
    player = audioplayer(y_audio, Fs);
    play(player);  % play asynchronously
    pause(0.1);   % tiny pause to initialize audio
catch
    warning('Could not find song.wav. Please put it in the same folder.');
end

% --- Create figure ---
fig = figure('Color','w');
ax = gca;
hold on;
axis([-2 2 -2 2]);
axis manual;
xlabel('x'); ylabel('y');

% --- Animation stages ---
for stage = 1:5
    cla;  % clear previous plot but keep axes
    hold on;

    if stage == 1
        y = x.^2;
        h = plot(NaN, NaN, 'b', 'LineWidth', 2);
        title('y = x^2', 'FontSize', 14);
        for i = 1:numPoints
            if ~ishandle(fig)
                stop(player); return
            end
            set(h, 'XData', x(1:i), 'YData', y(1:i));
            drawnow;
            pause(0.01);  % animation speed
        end

    elseif stage == 2
        y = x.^2;
        h1 = plot(NaN, NaN, 'b', 'LineWidth', 2);  % positive branch
        h2 = plot(NaN, NaN, 'b', 'LineWidth', 2);  % negative branch
        title('y = ± x^2', 'FontSize', 14);
        for i = 1:numPoints
            if ~ishandle(fig)
                stop(player); return
            end
            set(h1, 'XData', x(1:i), 'YData', y(1:i));
            set(h2, 'XData', x(1:i), 'YData', -y(1:i));
            drawnow;
            pause(0.01);
        end

    elseif stage == 3
        y = abs(x).^(2/3);
        h = plot(NaN, NaN, 'b', 'LineWidth', 2);
        title('y = |x|^{2/3}', 'FontSize', 14);
        for i = 1:numPoints
            if ~ishandle(fig)
                stop(player); return
            end
            set(h, 'XData', x(1:i), 'YData', y(1:i));
            drawnow;
            pause(0.01);
        end

    elseif stage == 4
        k = 3;
        y = abs(x).^(2/3) + A*sin(k*x);
        h = plot(NaN, NaN, 'b', 'LineWidth', 2);
        title(sprintf('y = |x|^{2/3} + %.1f sin(%dx)', A, k), 'FontSize', 14);
        for i = 1:numPoints
            if ~ishandle(fig)
                stop(player); return
            end
            set(h, 'XData', x(1:i), 'YData', y(1:i));
            drawnow;
            pause(0.05);
        end

    elseif stage == 5
        % Stage 5: Oscillating Love
        k_values = [linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200), ...
                    linspace(0,100,200), linspace(100,0,200), linspace(0,100,200)];
        for k = k_values
            if ~ishandle(fig)
                stop(player); return
            end
            cla;
            y = abs(x).^(2/3) + 2.0*A*sin(k*x).*sqrt(max(0, 3 - x.^2));
            plot(x, y, 'r', 'LineWidth', 2);
            title(sprintf('Oscillating Love: k = %.1f', k), 'FontSize', 14);
            drawnow;
            pause(0.01);  % control speed
        end
    end
end

% --- Stop the song at the end ---
if exist('player','var')
    stop(player);
end

