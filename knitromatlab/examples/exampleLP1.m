function exampleLP1
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_lp to solve a
% linear program (LP).
%
%  We solve an LP problem of the form
%
%     minimize      f'x
%     subject to   A_eq x = beq
%                     A x  <= b
%                 lb <= x  <= ub
%--------------------------------------------------------------------------

% Define the LP you want to solve.
% (This example from "Numerical Optimization", J. Nocedal and S. Wright)
%
%     minimize     -4*x1 - 2*x2
%     subject to   x1 + x2 + x3        = 5
%                  2*x1 + 0.5*x2 + x4  = 8
%                 0 <= (x1, x2, x3, x4)
% obj=-17.333 x=3.667,1.333,0,0

f = [-4; -2; 0; 0];
lb = [0; 0; 0; 0];
ub = [inf; inf; inf; inf];
Aeq  = [ 1,   1, 1, 0;
         2, 0.5, 0, 1];
beq = [5;
       8];
A = [];
b = [];

% Defining the initial point is optional for LPs. Typically, for LPs,
% when using the default interior-point/barrier algorithm, it is best
% not to supply an initial point, and instead to let Knitro apply its
% own initial point strategy (unless using warm-starts).
x0 = [];

% Set some Knitro options
options = knitro_options('algorithm',3,...  % active-set/simplex algorithm
                         'outlev',4);       % iteration display

% Call knitro_lp function to solve the LP.
[x, fval, exitflag, output, lambda] = knitro_lp (f, A, b, Aeq, beq, lb, ub, x0, [], options);

x
lambda.eqlin
lambda.lower
lambda.upper

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
