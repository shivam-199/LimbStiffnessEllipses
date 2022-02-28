function [J] = getJacobian()
%GETJACOBIAN This function will return a symbolic Jacobian Matrix.

syms L1 L2 Q1 Q2;
J = [(-L1 * sin(Q1) - L2 * sin(Q1 + Q2)) (-L2 * sin(Q1 + Q2));
    (L1 * cos(Q1) + L2 * cos(Q1 + Q2)) (L2 * cos(Q1 + Q2))];
end

