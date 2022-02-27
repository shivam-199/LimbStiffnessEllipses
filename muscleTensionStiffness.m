function [Kd_sym] = muscleTensionStiffness(A_sym)
%MUSCLETENSIONSTIFFNESS This function takes in symbolic structure matrix
%and gives muscle tension stiffness equation.

syms Q1 Q2 T1 T2 T3;
T = [T1; T2; T3];
Kd_sym = [diff(A_sym, Q1) * T diff(A_sym, Q2) * T];
end

