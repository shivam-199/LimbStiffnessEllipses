function [Tension] = cableTension(RESTING_CABLE_LENGTH, M, Kc, Q1, Q2, L1, L2)
%CABLELENGTH This function will calculate the initial length of the cable
%and the tension from infinitely small change in cable length.
%   Detailed explanation goes here

%% Computing new points for cable attachment
L1P2 = [L1 * cosd(Q1), L1 * sind(Q1)];
L2P2 = [L1 * cosd(Q1) + L2 * cosd(Q1 + Q2), L1 * sind(Q1) + L2 * sind(Q1 + Q2)];
NEW_CABLE_POINTS = [L2P2; L1P2; L2P2];

%% Computing new cable lengths
NEW_CABLE_LENGTH = zeros(3, 1);
for i=1:length(M)
    NEW_CABLE_LENGTH(i) = pdist([M(i, :); NEW_CABLE_POINTS(i, :)], "euclidean");
end
Tension = Kc * (NEW_CABLE_LENGTH - RESTING_CABLE_LENGTH);
Tension(Tension < 0) = 0;
end

