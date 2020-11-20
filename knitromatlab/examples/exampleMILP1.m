function exampleMILP1

%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example problem formulated as a MATLAB model used to
% demonstate using the Knitro function knitro_milp to solve a
% mixed-integer linear program (MILP).
%
% The model is Example 1.1 on page 4 from "Integer Programming", L. Wolsey.
%
%  min   -x1 - 0.64*x2

%  s.t.   50*x1 + 31*x2 <= 250
%         -3*x1 +  2*x2 <= 4
%         x1,x2>=0 and integer
%
%  The solution is (5, 0).
%--------------------------------------------------------------------------

f = [-1; -0.64];
xType = [1; 1]; % mark variables as integer
A = [50  31;
     -3   2];
b = [250; 4];
Aeq = []; beq = [];
lb = [0; 0];
ub = []; %no upper bounds

%Defining the initial point is optional
x0 = [];

% Call Knitro to solve the optimization model.
[x,fval,exitflag,output,lambda] = ...
    knitro_milp(f,xType,A,b,Aeq,beq,lb,ub,x0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
