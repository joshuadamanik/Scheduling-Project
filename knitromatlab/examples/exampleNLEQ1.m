function exampleNLEQ1
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% Example nonlinear system of equations formulated as a MATLAB model used
% to demonstate using the Knitro function knitro_nlneqs.
% The problem is
%
%                      sin(x1) - x2^2 = 0
%               cos(x1) + x1 + x3 - 2 = 0
%                     x4^2 + x3^2 - 7 = 0
%     x5*x4^2*5/2 + x5 - 10*x4^2 +  4 = 0
%     x5*x4^2*5/2 - x5 - 10*x4^2 + 11 = 0
%               (x6+x7)/(x6^2) - x4^2 = 0
%                    x6 + x7 - x2 - 8 = 0
%
% One solution is approximately x* = [0;0;1;2.45;3.5;1.15;6.85]
%--------------------------------------------------------------------------

% Set Knitro options
options = knitro_options('derivcheck',1,'gradopt',1,'outlev',4,'algorithm',3);

% Set the sparse Jacobian pattern.
Jpattern = sparse([1 1 0 0 0 0 0;
                   1 0 1 0 0 0 0;
                   0 0 1 1 0 0 0;
                   0 0 0 1 1 0 0;
                   0 0 0 1 1 0 0;
                   0 0 0 1 0 1 1;
                   0 1 0 0 0 1 1]);
extendedFeatures.JacobPattern = Jpattern;

% Call Knitro to solve the problem.
[x,fval] = knitro_nlneqs(@myfun, ones(7,1), extendedFeatures, options);

function [F,g] = myfun(x)

% Uncomment the command below to ensure that Knitro output is flushed to
% the screen regularly (depending on the Display/outlev setting).  This
% may be desirable on large, difficult problems that take a while to solve.
%disp '';

F = [sin(x(1))-x(2)^2; ...
     cos(x(1))+x(1)+x(3)-2; ...
     x(4)^2+x(3)^2-7; ...
     x(5)*x(4)^2*5/2+x(5)-10*x(4)^2+4; ...
     x(5)*x(4)^2*5/2-x(5)-10*x(4)^2+11; ...
     (x(6)+x(7))/(x(6)^2)-x(4)^2; ...
     x(6)+x(7)-x(2)-8];
if nargout > 1
    g = sparse(7);
    g(1,1) = cos(x(1));
    g(1,2) = -2*x(2);
    g(2,1) = -sin(x(1)) + 1;
    g(2,3) = 1;
    g(3,3) = 2*x(3);
    g(3,4) = 2*x(4);
    g(4,4) = 5*x(4)*x(5) - 20*x(4);
    g(4,5) = x(4)^2*5/2 + 1;
    g(5,4) = 5*x(4)*x(5) - 20*x(4);
    g(5,5) = x(4)^2*5/2 - 1;
    g(6,4) = -2*x(4);
    g(6,6) = (x(6)^2 - 2*x(6)*(x(6)+x(7))) / x(6)^4;
    g(6,7) = 1 / x(6)^2;
    g(7,2) = -1;
    g(7,6) = 1;
    g(7,7) = 1;
end
