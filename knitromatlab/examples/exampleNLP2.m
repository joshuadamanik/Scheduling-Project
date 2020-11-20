function exampleNLP2
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_nlp to solve
% a nonlinear program (NLP).
%
% The problem is
%
%     minimize    1000 - x1^2 - 2*x2^2 - x3^2 - x1*x2 - x1*x3
%     subject to  8*x1 + 14*x2 + 7*x3         = 56
%                 -(x1^2 + x2^2 + x3^2 - 25) <= 0
%                 0 <= (x1, x2, x3) <= 10
%
% and has two local solutions:
%   the point (0,0,8) with objective 936.0, and
%   the point (7,0,0) with objective 951.0
%--------------------------------------------------------------------------

% Define the Jacobian sparsity pattern.
Jac = [1, 1, 1];
Jpattern = sparse(Jac);

% Define the Hessian sparsity pattern.
Hess = [1, 1, 1; 1, 1, 0; 1, 0, 1];
Hpattern = sparse(Hess);

% Set the sparsity patterns and Hessian function handle in Knitro's extended features
extendedFeatures.JacobPattern = Jpattern;
extendedFeatures.HessPattern = Hpattern;
extendedFeatures.HessFcn = @hessfun;

% Specify an initial point.
x0 = [2;2;2];

% Specify some model characteristics.
A = []; b = [];
Aeq = [8 14 7];
beq = 56;
lb = [0;0;0];
ub = [10;10;10];

% Call Knitro to solve the optimization model.
% Specify some options in "nlp2options.opt".  Any Knitro
% options can be specified by passing in a Knitro options file.
[x,fval,exitflag,output,lambda,grad,hess] = ...
   knitro_nlp(@objfun,x0,A,b,Aeq,beq,lb,ub,@constfun,extendedFeatures,[],'nlp2options.opt');

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
