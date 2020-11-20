% exampleNLPSymbolic (similar to exampleNLP1 but with symbolic expressions)

%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a Matlab model using symbolic expressions.
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

% Specify the symbolic variables
syms x1 x2 x3

% Definition of parameters
alpha = 1000;
beta = 2;
gamma = 25;
parameters = struct('alpha', alpha, 'beta', beta, 'gamma', gamma);

% Definition of objective function and constraints
[f,g] = get_objective(x1,x2,x3,parameters);
[c,ceq,Gc,Gceq]= get_constraints(x1,x2,x3,parameters);

% Specify some model characteristics.
A = []; b = [];
Aeq = [8 14 7];
beq = 56;
lb = [0;0;0];
ub = [10;10;10];

% Specify an initial point.
x0 = [2;2;2];

% Call Knitro to solve the optimization model.
[x,fval,exitflag,output,lambda,grad,hess] = ...
   knitro_nlp(@(x) objfun(x,f,g),x0,A,b,Aeq,beq,lb,ub,@(x) constfun(x,c,ceq,Gc,Gceq),[],[],[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, g] = objfun(x,f_function,g_function)

f = feval(f_function,x);
g = feval(g_function,x);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,ceq,Gc,Gceq]= constfun(x,c_function,ceq_empty,Gc_function,Gceq_empty)
ceq = ceq_empty;
c = feval(c_function,x);

if nargout > 2
    Gc = feval(Gc_function,x);
    Gceq = Gceq_empty;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, g]= get_objective(x1,x2,x3,parameters)
%syms x1 x2 x3
x_var=[x1;x2;x3];
alpha = parameters.alpha;
beta = parameters.beta;

% objective expression using symbolic variables and parameters
f_expression = alpha - x1^2 - beta*x2^2 - x3^2 - x1*x2 - x1*x3;

% jacobian of the objective function
g_expression = jacobian(f_expression,x_var).';

f = matlabFunction(f_expression,'vars',{x_var});
g = matlabFunction(g_expression,'vars',{x_var});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,ceq,Gc,Gceq]= get_constraints(x1,x2,x3,parameters)
%syms x1 x2 x3
x_var=[x1;x2;x3];
gamma = parameters.gamma;

% constraint expression using symbolic variables and parameters
c_expression = -(x1^2 + x2^2 + x3^2 - gamma);
c = matlabFunction(c_expression,'vars',{x_var});
ceq = [];

% Gradients of the constraint functions wrt. x_var
Gc_expression = jacobian(c_expression,x_var).';
Gc = matlabFunction(Gc_expression,'vars',{x_var});
Gceq=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
