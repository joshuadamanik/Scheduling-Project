function exampleNLP3
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_nlp to solve
% a nonlinear program (NLP).
%
%   Source: problem MAXTPH in
%   Vasko and Stott
%   "Optimizing continuous caster product dimensions:
%    an example of a nonlinear design problem in the steel industry"
%   SIAM Review, Vol 37 No, 1 pp.82-84, 1995
%
%   Parameters:
%   param density := 0.284;
%   param lenmax := 60.0;
%   param maxaspr := 2.0;
%   param minthick := 7.0;
%   param minarea := 200.0;
%   param maxarea := 250.0;
%   param k := 1.0;
%
%   Variables
%   var x1: thick >= minthick, := 0.5;
%   var x2: wid >= 0.0, := 0.5;
%   var x3: len <= lenmax,  >= 0.0, := 0.5;
%   var x4: tph >= 0.0, := 0.5;
%   var x5: ipm >= 0.0, := 0.5;
%
%   minimize f:  -tph;
%
%   subject to c_lin:   wid - thick*maxaspr           <= 0;
%   subject to c1:     -thick*wid + minarea           <= 0;
%   subject to c2:     thick*wid  - maxarea           <= 0;
%   subject to ceq1:   117.370892*tph - ipm*wid*thick = 0.0;
%   subject to ceq2:   thick^2*ipm/48.0 - len         = 0.0;
%
% and has optimal objective value -49.0752.
%--------------------------------------------------------------------------

% Set some problem sizes
n = 5; % # of variables

% Get the Jacobian sparsity pattern using an evaluation at a random point.
% Note that Knitro requires the STRUCTURAL sparsity pattern so we use an
% evaluation at a random point to try to ensure that none of the non-zero
% Jacobian elements evaluate to 0 by chance (if this happens the Jpattern
% will not be correct, but this should not occur using a random point).
x = rand(n,1);
[c,ceq,Gc,Gceq] = nonlconstr(x);
% Note the gradient matrices Gc and Gceq are transposed and the gradient
% matrix for the inequality constraints is first.
Jpattern = sparse([Gc';Gceq']);

% Set the Jacobian sparsity pattern in Knitro's extended features
extendedFeatures.JacobPattern = Jpattern;

% Specify an initial point.
x0 = [0.5; 0.5; 0.5; 0.5; 0.5];

% Specify some model characteristics.
A = [-2 1 0 0 0];
A = sparse(A);
b = [0];
Aeq = []; beq = [];
lb = [7;0;0;0;0];
ub = [inf;inf;60;inf;inf];

% Call Knitro to solve the optimization model.
% Specify some options in "csfi1.opt".  Any Knitro
% options can be specified by passing in a Knitro options file.
[x,fval,exitflag,output,lambda,grad,hess] = ...
   knitro_nlp(@objfun,x0,A,b,Aeq,beq,lb,ub,@nonlconstr,extendedFeatures,[],'nlp3options.opt');

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
   f = -x(4);
end

% its derivative wrt. x (objective function not needed)
if nargout > 1
   g(1)=0;
   g(2)=0;
   g(3)=0;
   g(4)=-1;
   g(5)=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,ceq,Gc,Gceq]= nonlconstr(x)

% Always initialize "c" and "ceq" to something.  They are only needed when
% Knitro requests the constraint functions (nargout<=2), but not when Knitro
% requests the constraint gradients (nargout>2).
c = [];
ceq = [];

% Nonlinear constraint functions
if nargout <= 2
   c(1) = -x(1)*x(2) + 200;
   c(2) = x(1)*x(2) - 250;
   ceq(1) = 117.370892*x(4) - x(5)*x(2)*x(1);
   ceq(2) = x(1)^2*x(5)/48.0 - x(3);
end

% Gradients of the constraint functions wrt. x
% (constraint function evaluations not needed)
if nargout > 2

   % Set gradient matrix dimensions
   Gc = sparse(5,2);
   Gceq = sparse(5,2);

   % Gradient of c(1)
   Gc(1,1)=-x(2);
   Gc(2,1)=-x(1);
   % Gradient of c(2)
   Gc(1,2)=x(2);
   Gc(2,2)=x(1);

   % Gradient of ceq(1)
   Gceq(1,1) = -x(5)*x(2);
   Gceq(2,1) = -x(5)*x(1);
   Gceq(4,1) = 117.370892;
   Gceq(5,1) = -x(2)*x(1);
   % Gradient of ceq(2)
   Gceq(1,2) = 2*x(1)*x(5)/48.0;
   Gceq(3,2) = -1;
   Gceq(5,2) = x(1)^2/48.0;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
