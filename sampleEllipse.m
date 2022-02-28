Kx = [6 1; 1 6];
Kq = [1 0.5; 0.5 1];
syms x y;
figure
taskSpace = [x y] * (Kx') * Kx * [x y]' - 1;
jointSpace = [x y] * (Kq') * Kq * [x y]' - 1;
%fimplicit(taskSpace, "--r", "LineWidth", 1)
fimplicit(jointSpace, "r", "LineWidth", 1)