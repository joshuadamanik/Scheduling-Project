function exampleConic1
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to demonstate using
% the Knitro function knitro_qcqp to solve a model with a second order
% cone constraint by modeling the cone constraint as a quadratic inequality
% constraint.
%
%  The knitro_qcqp function requires problems in the form:
%
%     minimize      1/2 x' H x  + f'x
%     subject to    1/2 x' Qeq{i} x + Aeq x = beq
%                   1/2 x' Q{i} x   + A x  <= b
%                   lb <= x  <= ub
%
% Note the 1/2 coefficient on the quadratic terms involving H, Qeq and Q.
%
% Here Q and Qeq are cell arrays, where each element of the cell array
% is a (sparse) symmetric nxn matrix (where n is the number of variables).
% Linear constraints are defined by setting Q{i}=[] or Qeq{i}=[].
% Similarly, set H=[] to implement a linear objective function.
%--------------------------------------------------------------------------

%  We solve the following problem with a second order cone constraint.
%
%  minimize   x3 + x1^2 + x2^2 + (x3+x4)^2
%  subject to sqrt(x1^2 + (2*x3)^2)  - 10*x2 <= 0
%             x4^2 + 5*x1 <= 100
%             2*x2 + 3*x3 <= 100
%             x2 >= 1, x3 <= 1, x4 >= 2
%
%  Note that the first constraint is a second order cone
%  constraint (i.e a constraint of the form: ||Ax+b||<=c'x)
%  This constraint can be written as:
%     sqrt(x1^2 + 4*x3^2)  <= 10*x2
%  and then, since both sides are positive (x2>=1), we can square
%  both sides to re-write it as a quadratic constraint:
%     x1^2 + 4*x3^2 - 100*x2^2  <= 0
%  Internally Knitro will automatically detect this quadratic
%  constraint as a cone constraint.  If using the default interior-
%  point algorithm and the Knitro option "bar_conic_enable=1", Knitro
%  will apply its specialized conic algorithm.  Otherwise, if
%  "bar_conic_enable=0", Knitro will solve it as a standard QCQP with
%  no special treatments for the cone constraint.
%
%  The solution is given by:
%  optimal objective value = -6.010186e+00
%  optimal x = (-2.373097e-02, 2.020373e+00, -1.010186e+01 1.000593e+01)

n = 3; % number of variables

% Define lower and upper bounds on x
lb = [-inf; 1; -inf; 2];
ub = [inf; inf; 1; inf];

% Define objective function
f = [0; 0; 1; 0];
% Note the 2's on the diagonal because of the 1/2 coefficient on x'Hx
H  = sparse([2 0 0 0;
             0 2 0 0;
             0 0 2 2;
             0 0 2 2]);

% Define linear/quadratic inequality constraints
m = 3; %number of inequality constraints
% Add quadratic constraint coefficients
% Note the 1/2 coefficient on the quadratic terms
Q = cell(m,1); %empty cell array
Q{1}  = sparse([2   0  0  0;
                0 -200 0  0;
                0   0  8  0;
                0   0  0  0]);
Q{2}  = sparse([0   0  0  0;
                0   0  0  0;
                0   0  0  0;
                0   0  0  2]);
Q{3} = []; % no quadratic terms in the 3rd constraint
% linear coefficients
A = [0 0 0 0;
     5 0 0 0;
     0 2 3 0];
b = [0; 100; 100];

% There are no linear/quadratic equality constraints
meq = 0; %number of equality constraints
Qeq = cell(meq,1); %empty cell array
Aeq = [];
beq = [];

% Defining the initial point is optional for QCQPs.
x0 = [];

% Specify that we want to use the specialized conic solver in Knitro
options = knitro_options();   % initialize with default options
options.algorithm = 1;        % use default interior-point alg
options.bar_conic_enable = 1; % try both 0 and 1 here

% Call knitro_qcqp function to solve the QCQP.
[x, fval, exitflag, output, lambda] = knitro_qcqp (H, f, Q, A, b, Qeq, Aeq, beq, lb, ub, x0, [], options);
x
fval

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
