function [A] = structureMatrix(M, L1, L2, Q1, Q2)
%STRUCTUREMATRIX This function returna a structure matrix A. Given the
%number of joints and cables used. Here we have 2 joints and 3 or 4 cables,
%given by NUMBER_OF_CABLES.
%   In case of 2 joints and 3 cables: we will have a 2 * 3 structure matrix.
%   In case of 2 joints and 3 cables: we will have 2 * 4 structure matrix.
%   Detailed explanation goes here

%% Derive r as a function of q;
r1 = [(L1 * cosd(Q1)) (L1 * sind(Q1))];
r2 = [(L1 * cosd(Q1) + L2 * cosd(Q1 + Q2)) (L1 * sind(Q1) + L2 * sind(Q1 + Q2))];
r3 = [(L1 * cosd(Q1) + L2 * cosd(Q1 + Q2)) (L1 * sind(Q1) + L2 * sind(Q1 + Q2))];
%% Calculating cables direction unit vector
x1 = M(2, :) - r1;
l1_cap = (x1) / (sqrt(x1(1) ^ 2 + x1(2) ^ 2));

x2 = M(1, :) - r2;
l2_cap = (x2) / (sqrt(x2(1) ^ 2 + x2(2) ^ 2));

x3 = M(3, :) - r3;
l3_cap = (x3) / (sqrt(x3(1) ^ 2 + x3(2) ^ 2));
  

%% Defining the partial derivatives for Structure Matrix
dr1bydq1 = [-L1 * sind(Q1)  L1 * cosd(Q1)];
dr2bydq1 = [(-L1 * sind(Q1) - L2 * sind(Q1 + Q2)) (L1 * cosd(Q1) + L2 * cosd(Q1 + Q2))];
dr3bydq1 = [(-L1 * sind(Q1) - L2 * sind(Q1 + Q2)) (L1 * cosd(Q1) + L2 * cosd(Q1 + Q2))];
dr1bydq2 = [0, 0];
dr2bydq2 = [(-L2 * sind(Q1 + Q2)) (L2 * cos(Q1 + Q2))];
dr3bydq2 = [(-L2 * sind(Q1 + Q2)) (L2 * cos(Q1 + Q2))];

%% Creating the Structure Matrix 2 * 3 (for 3 cables)
A = [dot(l1_cap, dr1bydq1) dot(l2_cap, dr2bydq1) dot(l3_cap, dr3bydq1);
    dot(l1_cap, dr1bydq2) dot(l2_cap, dr2bydq2) dot(l3_cap, dr3bydq2)];
end

