function exampleQP1
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_qp to solve a
% quadratic program (QP).
%
%  We solve a QP problem
%
%     minimize      1/2 x' H x  + f'x
%     subject to    Aeq x = beq
%                     A x  <= b
%                 lb <= x  <= ub
%--------------------------------------------------------------------------

% Define the QP you want to solve.
%
%     minimize     0.5*(x1^2+x2^2+x3^2) + 11*x1 + x3
%     subject to   -6*x3  <= 5
%                 0 <= x1
%                 0 <= x2
%                -3 <= x3 <= 2
% obj=-0.4861   x=0,0,-5/6
f = [11; 0; 1];
lb = [0; 0; -3];
ub = [inf; inf; 2];
H  = eye(3);
A = [ 0, 0, -6];
b = [5];
Aeq = [];
beq = [];

% Defining the initial point is optional for QPs. Typically, for
% convex QPs, when using the default interior-point/barrier algorithm,
% it is best not to supply an initial point, and instead to let Knitro
% apply its own initial point strategy (unless using warm-starts).
% Providing a good initial point, however, can be very helpful on
% non-convex QPs or when using the active-set or SQP algorithms.
x0 = [];

% Call knitro_qp function to solve the QP.
[x, fval, exitflag, output, lambda] = knitro_qp (H, f, A, b, Aeq, beq, lb, ub, x0);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
