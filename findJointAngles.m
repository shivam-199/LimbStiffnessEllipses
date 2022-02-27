function [Q11, Q12, Q21, Q22] = findJointAngles(point,L1, L2)
%FINDJOINTANGLES This fuunction uses inverse kinematics to compute the
%joint angles Q1 and Q2.
%   We are using the algebraic method to compute inverse kinematics to find
%   Q1 and Q2. When doing inverse kinematics to compute Q2 we get 2 values, 
%   since cos has two positive values (in 1st and 4th quadrant).
%   The function takes inputs:
%       Point position P(x, y).
%       Link lengths L1 and L2.
%   It's output:
%       Q11, Q12, Q21, Q22

r = point(1) ^ 2 + point(2) ^ 2;
D = (r - L1^2 - L2^2) / (2 * L1 * L2);  % cos (Q)

Q21_rad = atan2(sqrt(1 - D^2), D);
Q21 = rad2deg(Q21_rad);

Q22_rad = atan2(-sqrt(1 - D^2), D);
Q22 = rad2deg(Q22_rad);

Q11_rad = atan2(point(2), point(1)) - atan2(L2 * sind(Q21), L1 + L2 * cosd(Q21));
Q11 = rad2deg(Q11_rad);
Q12_rad = atan2(point(2), point(1)) - atan2(L2 * sind(Q22), L1 + L2 * cosd(Q22));
Q12 = rad2deg(Q12_rad);


end