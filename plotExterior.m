function [] = plotExterior(L1, L2, Q1, Q2, CENTER, RADIUS_PATH, M)
%PLOTPOINTS This function is used to plot the TaskSpace, links and the selected point.

%% Figure Properties
% Plot the center of the circle
viscircles(CENTER, 0.1, 'Color',"black", "LineWidth", 3);
hold on;

% Fix the axis limits.
xlim([-2 4]);
ylim([-2 4]);

xlabel("X Axis");
ylabel("Y Axis");

% Set the axis aspect ratio to 1:1.
axis square;

% Set the grid on
grid on;

% Set a title.
title("Ellipsoid of Two Link SCM - 1 Redundancy");

% Final Path of the end-point
viscircles([1.25,0], RADIUS_PATH, 'Color', "red", "LineWidth", 1);

%% Computing the initial and end points for links
% Link 1: Point 1 and Point 2
L1P1 = [0, 0];
% Link 2: Point 1 and Point 2
L1P2 = [L1 * cosd(Q1), L1 * sind(Q1)];

% Plotting Link 1
line([L1P1(1), L1P2(1)], [L1P1(2), L1P2(2)], "Color", "blue", "LineWidth", 2);

%% Final Point of Link 1 will be initial point of Link 2
L2P1 = L1P2;
L2P2 = [L1 * cosd(Q1) + L2 * cosd(Q1 + Q2), L1 * sind(Q1) + L2 * sind(Q1 + Q2)];

% Plot a circle on link joints
viscircles(L2P1, 0.1, 'Color',"black", "LineWidth", 3);

% Plotting Link 2
line([L2P1(1), L2P2(1)], [L2P1(2), L2P2(2)], "Color", "green", "LineWidth", 2);

% Plot a circle at the end of link 2
viscircles(L2P2, 0.1, 'Color',"black", "LineWidth", 3);

%% Plotting the Cables

% Cable 1 to end-effector
line([M(1, 1), L2P2(1)], [M(1, 2), L2P2(2)], "Color", "cyan", "LineWidth", 1);
% Cable 2 to end of link 1
line([M(2, 1), L2P1(1)], [M(2, 2), L2P1(2)], "Color", "cyan", "LineWidth", 1);
% Cable 3 to end-effector
line([M(3, 1), L2P2(1)], [M(3, 2), L2P2(2)], "Color", "cyan", "LineWidth", 1);

end