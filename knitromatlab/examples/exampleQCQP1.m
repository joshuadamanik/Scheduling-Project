function exampleQCQP1
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_qcqp to solve a
% quadratically constrained quadratic program (QCQP).
%
%  We solve a QCQP problem
%
%     minimize      1/2 x' H x  + f'x
%     subject to    1/2 x' Qeq{i} x + Aeq x = beq
%                   1/2 x' Q{i} x   + A x  <= b
%                 lb <= x  <= ub
%
% Note the 1/2 coefficient on the quadratic terms involving H, Qeq and Q.
%
% Here Q and Qeq are cell arrays, where each element of the cell array
% is a (sparse) symmetric nxn matrix (where n is the number of variables).
% Linear constraints are defined by setting Q{i}=[] or Qeq{i}=[].
% Similarly, set H=[] to implement a linear objective function.
%--------------------------------------------------------------------------

% Define the QCQP you want to solve.
%
%  minimize     -x1^2 - 2 x2^2 - x3^2 - x1 x2 - x1 x3
%  ssubject to  8 x1 + 14 x2 + 7 x3 = 56
%               -x1^2 - x2^2 - x3^2 <= -25
%               x1 >= 0, x2 >= 0, x3 >= 0
%
%  The global minimum is at (0, 0, 8), with final objective = -64.0.
%  Depending on the starting point, Knitro may converge to an alternate
%  local solution at (7, 0, 0), with objective = -49.0.

n = 3; % number of variables

% Define lower and upper bounds on x
lb = [0; 0; 0];
ub = [inf; inf; inf];

% Define objective function
f = zeros(n,1);
H  = sparse([-2 -1 -1; -1 -4 0; -1 0 -2]);

% Define linear equality constraint
meq = 1; %number of equality constraints
Qeq = cell(meq,1); %empty cell array
Aeq = [8 14 7];
beq = [56];

% Define quadratic inequality constraint
m = 1; %number of inequality constraints
Q = cell(m,1); %empty cell array
Q{1} = sparse(-2*eye(n)); %note -2 because of the 1/2 factor
A = []; %no linear term
b = [-25];

% Defining the initial point is optional for QCQPs.
x0 = [2; 2; 2];

% Call knitro_qcqp function to solve the QCQP.
[x, fval, exitflag, output, lambda] = knitro_qcqp (H, f, Q, A, b, Qeq, Aeq, beq, lb, ub, x0);
x
fval

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
