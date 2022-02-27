function [A] = structureMatrixSym(M)
%STRUCTUREMATRIX This function returna a structure matrix A. Given the
%number of joints and cables used. Here we have 2 joints and 3 or 4 cables,
%given by NUMBER_OF_CABLES.
%   In case of 2 joints and 3 cables: we will have a 2 * 3 structure matrix.
%   In case of 2 joints and 3 cables: we will have 2 * 4 structure matrix.
%   Detailed explanation goes here

syms Q1 Q2 A L1 L2 real;

%% Derive r as a function of q;
r1 = [(L1 * cos(Q1)) (L1 * sin(Q1))];
r2 = [(L1 * cos(Q1) + L2 * cos(Q1 + Q2)) (L1 * sin(Q1) + L2 * sin(Q1 + Q2))];
r3 = [(L1 * cos(Q1) + L2 * cos(Q1 + Q2)) (L1 * sin(Q1) + L2 * sin(Q1 + Q2))];

%% Calculating cables direction unit vector
x1 = sym(M(2, :)) - r1;
l1_cap = (x1) / (sqrt(x1(1) ^ 2 + x1(2) ^ 2));

x2 = sym(M(1, :)) - r2;
l2_cap = (x2) / (sqrt(x2(1) ^ 2 + x2(2) ^ 2));

x3 = sym(M(3, :)) - r3;
l3_cap = (x3) / (sqrt(x3(1) ^ 2 + x3(2) ^ 2));

%% Defining the partial derivatives for Structure Matrix
A = [dot(l1_cap, diff(r1, Q1)) dot(l2_cap, diff(r2, Q1)) dot(l3_cap, diff(r3, Q1));
    dot(l1_cap, diff(r1, Q2)) dot(l2_cap, diff(r2, Q2)) dot(l3_cap, diff(r3, Q2))];
end

