function exampleMultiStart
%--------------------------------------------------------------------------
% Copyright (c) 2020 by Artelys
% All Rights Reserved.
%
% Multi-start example applied to exampleNLP1.  The internal parallel 
% multi-start in Knitro does not currently work through the MATLAB 
% interface because of threading issues in the Mex interface. However, 
% this example shows how to use a MATLAB parallel loop as a multi-start
% wrapper to potentially solve a problem instance from many different 
% starting point in parallel using Knitro.
%
% The problem is the same as in exampleNLP1.m
%
%     minimize    1000 - x1^2 - 2*x2^2 - x3^2 - x1*x2 - x1*x3
%     subject to  8*x1 + 14*x2 + 7*x3         = 56
%                 -(x1^2 + x2^2 + x3^2 - 25) <= 0
%                 0 <= (x1, x2, x3) <= 10
%
% and has two local solutions:
%   the point (0,0,8) with objective 936.0, and
%   the point (7,0,0) with objective 951.0
% as well as a locally infeasible point (i.e. an infeasible stationary 
% point) at the point (0,4,0) with objective 968.
%--------------------------------------------------------------------------

% Define the Jacobian sparsity pattern.
Jac = [1, 1, 1];
Jpattern = sparse(Jac);

% Define the Hessian sparsity pattern.
% You can supply the Hessian matrix via extendedFeatures by setting the
% options below and writing a routine such as "hessfun" below.
Hess = [1, 1, 1; 1, 1, 0; 1, 0, 1];
Hpattern = sparse(Hess);

% Set the sparsity patterns and Hessian function handle in Knitro's extended features
extendedFeatures.JacobPattern = Jpattern;
extendedFeatures.HessPattern = Hpattern;
extendedFeatures.HessFcn = @hessfun;

% Specify the user options.  
% Choose the default Interior Point 'algorithm' by choosing algorithm 1 below.
% Choose the Active Set 'algorithm' by setting algorithm 3 below.
% It is highly recommended to try all Knitro algorithms.
options = knitro_options('algorithm', 1, 'outlev', 0, 'gradopt', 1, ...
                         'hessopt', 1, 'maxit', 1000, 'xtol', 1e-15, ...
                         'feastol', 1e-8, 'opttol', 1e-8, ...
                         'bar_maxcrossit', 5);

% Specify an initial point (for first multistart solve).
x0 = [2;2;2];
n = length(x0);

% Specify some model characteristics.
A = []; b = [];
Aeq = [8 14 7];
beq = 56;
lb = [0;0;0];
ub = [10;10;10];

% Enable parallelism and specify max workers
useparallel = 1;
if useparallel
    maxworkers = intmax; %MATLAB will use as many workers as available
else
    maxworkers = 0; %parfor loop will be treated as serial, order does not matter
end

% Print header output for multi-start solve table
fprintf('\n');
fprintf(' Solve#  exitflag   fval  constrviolation  firtsorderopt\n');
fprintf(' -------------------------------------------------------\n');

% Set number of multi-start solves
numsolves = 10; 

% Generate matrix of random initial points.
% Use a seed to get reproducible results each time.
% Probably want to enforce some reasonable range and/or enforce that all
% initial points satisfy finite lower and upper bounds on variables.
% This initial point matrix can be customized as needed.
seed = 0;
rng(seed);
x0all = rand(n,numsolves);
% Overwrite first initial point with user specified initial point.
x0all(:,1) = x0;

% Used to store all solutions
xSolAll = zeros(n,numsolves);
fvalAll = zeros(1,numsolves);
exitflagAll = zeros(1,numsolves);

% Parallel multi-start loop
tstart = tic;
parfor (i=1:numsolves,maxworkers)  
    
    % Call Knitro to solve the optimization model.
    [xSolAll(:,i),fvalAll(1,i),exitflagAll(1,i),output] = ...
        knitro_nlp(@objfun,x0all(:,i),A,b,Aeq,beq,lb,ub,@constfun,extendedFeatures,options);
    
    % Print line of summary output of solve "i"
    fprintf('%6d %6d %14.6e %12.3e %12.3e\n',i,exitflagAll(1,i),fvalAll(1,i),output.constrviolation,output.firstorderopt);    
    
end
telapsed = toc(tstart);

fprintf('\nThe total solve time is %f\n\n',telapsed)

% Look at all solutions
exitflagAll
fvalAll
xSolAll
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f,g] = objfun(x)

% The command below ensures that the Knitro output is flushed to
% the screen regularly (depending on the Display/outlev setting).  This
% may be desirable on large, difficult problems that take a while to solve.
disp '';

% Always initialize "f" to something.  It is only needed when Knitro
% requests the objective function (nargout=1), but not when Knitro requests
% the gradient (nargout=2).
f = [];

% Objective function
if nargout <= 1
   f = 1000 - x(1)^2 - 2*x(2)^2 - x(3)^2 - x(1)*x(2) - x(1)*x(3);
end

% its derivative wrt. x (objective function not needed)
if nargout > 1
   g(1)=-2*x(1)-x(2)-x(3);
   g(2)=-4*x(2)-x(1);
   g(3)=-2*x(3)-x(1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,ceq,Gc,Gceq]= constfun(x)

% Always initialize "c" and "ceq" to something.  They are only needed when
% Knitro requests the constraint functions (nargout<=2), but not when Knitro
% requests the constraint gradients (nargout>2).
c = [];
ceq = [];

% Constraint functions
if nargout <= 2
   c(1)= -(x(1)^2 + x(2)^2 + x(3)^2 - 25);
   ceq=[];
end

% Gradients of the constraint functions wrt. x
% (constraint function evaluations not needed)
if nargout > 2
   Gc(1,1)=-2*x(1);
   Gc(2,1)=-2*x(2);
   Gc(3,1)=-2*x(3);
   Gceq=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [H]= hessfun(x,lambda)
% Hessian function.
% Only need to specify structural non-zero elements of the upper
% triangle (including diagonal)

H(1,1) = -2 + lambda.ineqnonlin*(-2);
H(1,2) = -1;
%H(2,1) = H(1,2);
H(1,3) = -1;
%H(3,1) = H(1,3);
H(2,2) = -4 + lambda.ineqnonlin*(-2);
H(3,3) = -2 + lambda.ineqnonlin*(-2);
H = sparse(H);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
