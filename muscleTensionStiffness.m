function [Kd_sym] = muscleTensionStiffness(A_sym, Tension)
%MUSCLETENSIONSTIFFNESS This function takes in symbolic structure matrix
%and gives muscle tension stiffness equation.

syms Q1 Q2;
Kd_sym = [diff(A_sym, Q1) * Tension diff(A_sym, Q2) * Tension];
end

