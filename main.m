%%
% Topic: Representing a Limb's Resistance to Sudden Movement
% Author: Shivam Chaudhary
%         Indian Institute of Technology Gandhinagar
%         shivamchaudhary@iitgn.ac.in
% Date: 23 Feb 2022

%% Activities
% Consider a two-link planar representation of the limb with one actuation 
% redundancy, i.e., n = 2 and m = 3, to work out the following points.
%   1. Consider a mechanical extension spring model of the muscle and 
%      develop expressions for the muscle space stiffness matrix. Develop 
%      the joint-space stiffness matrix Kq and task-space stiffness matrix Kx.
%   2. Using some numerical values for stiffness offered by each mechanical 
%      spring (say 1000), compute the task space and joint space stiffness matrices 
%      when no external force is applied at the limb. I will compute task 
%      and joint space ellipses when the arm is performing a cricular motion
%      and create an animation out of the movement.
%% Clearing all variables
clear

%% Defining the constants
syms L1 L2 Q1 Q2;
L1 = 1;
L2 = 1;
CENTER = [0, 0];
NUMBER_OF_CABLES = 3;
M = [0 1; 0, 0.5; 0 -1];
RESTING_CABLE_END_POINT = [2 0; 1 0; 2 0];
RADIUS_OF_PATH = 0.75;
KC = 1;  % Stiffness of the cable
Kc = diag([KC KC KC]);  % Stiffness Matrix
n = 1; % number of times the circle is traversed
Fext = [0; 0];

% For GIF
filename = 'EllipsoidPlotV3.gif';

%% Find resting position cable length
RESTING_CABLE_LENGTH = zeros(3, 1);

for i=1:length(RESTING_CABLE_END_POINT)
    RESTING_CABLE_LENGTH(i) = pdist([M(i, :); RESTING_CABLE_END_POINT(i, :)], "euclidean");
end

%% Symbolic expression for structure Matrix and muscle tension stiffness
A_sym = structureMatrixSym(M);

J_sym = getJacobian();

%% Defining path of end-point and iterating through it
for t=1:n
    for theta=1:2:360
        x = RADIUS_OF_PATH * cosd(theta) + 1.25;
        y = RADIUS_OF_PATH * sind(theta);
        point = [x, y];
        %point = [1.95 0.25];
        
        %% Finding joint angles using Inverse Kinematics
        % There are multiple values for Q1 and Q2
        [Q11, Q12, Q21, Q22] = findJointAngles(point, L1, L2); 
        
        Q1 = sym(Q11);
        Q2 = sym(Q21);
        
        %% Finding the Structure Matrix
        A = eval(eval(subs(A_sym, [Q1 Q2 L1 L2], [Q1 Q2 L1 L2])));
        A(isnan(A)) = 0;
        
        %% Finding Initial Cable Length Values when the SCM is fully stretched
        [Tension] = cableTension(RESTING_CABLE_LENGTH, M, Kc, Q11, Q21, L1, L2);
        
        %% Finding Joint Space Stiffness matrix [2 * 2]
        Kd_sym = muscleTensionStiffness(A_sym, Tension);
        Kd = eval(subs(Kd_sym, [Q1 Q2], [Q1 Q2]));
        Kq = Kd - (A * Kc * A.');
        Kq(isinf(Kq)) = 0;
        Kq(isnan(Kq)) = 0;
        
        %% Finding Task Space Stiffness Matrix [2 * 2]
        J = eval(eval(subs(J_sym, [Q1 Q2 L1 L2], [Q1 Q2 L1 L2])));
        d2J = diffOfJacobian(L1, L2, Q1, Q2, Fext);
        Jt = transpose(J);
        Kx = inv(Jt) \ (Kq - (d2J)) * inv(J);
        Kx(isinf(Kx)) = 0;
        Kx(isnan(Kx)) = 0;
        
        %% Calculating the ellipsoid
        %[V, D] = eig(Kx)
        plotEllipse(eval(Kx), eval(Kq));
        
        %% Plotting links, cables and animation
        plotExterior(L1, L2, Q11, Q21, CENTER, RADIUS_OF_PATH, M, filename, theta);
        pause(0.001);
    end
end
