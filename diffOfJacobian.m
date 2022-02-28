function [d2J] = diffOfJacobian(L1, L2, Q1, Q2, Fext)
%TASKSTIFFNESS Summary of this function goes here
%   Detailed explanation goes here

d2J1 = [(-L1 * cosd(Q1) - L2 * cosd(Q1 + Q2)) (-L1 * sind(Q1) - L2 * sind(Q1 + Q2));
        (-L2 * cosd(Q1 + Q2)) (-L2 * sind(Q1 + Q2))];

d2J2 = [-L2 * cosd(Q1 + Q2) (-L2 * sind(Q1 + Q2));
    (-L2 * cosd(Q1 + Q2)) (-L2 * sind(Q1 + Q2))];

d2J = [d2J1 * Fext d2J2 * Fext];

end

