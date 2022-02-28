function [] = plotEllipse(Kx, Kq)
%PLOTELLIPSE Summary of this function goes here
%   Detailed explanation goes here
cla
hold on
syms x y;
taskSpace = [x y] * (Kx') * Kx * [x y]' - 1;
jointSpace = [x y] * (Kq') * Kq * [x y]' - 1;
fimplicit(taskSpace, "--r", "LineWidth", 1)
fimplicit(jointSpace, "--g", "LineWidth", 1)

hold on
end