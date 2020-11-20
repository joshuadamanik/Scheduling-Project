function exampleLSQ2
%--------------------------------------------------------------------------
% Copyright (c) 2019 by Artelys
% All Rights Reserved.
%
% This example is based on the example in the Mathworks documentation for lsqnonlin
% The problem is to minimize sum {k in 1..10} (2 + 2*k - exp(k*x(1)) - exp(k*x(2)))
%--------------------------------------------------------------------------

options = knitro_options('outlev',4,'gradopt',1,'derivcheck',1, ...
            'algorithm',2);

x0 = [0;0];
[x,resnorm] = knitro_nlnlsq(@myfunlsq,x0,[],[],[],options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [F, g] = myfunlsq(x)

% The command below ensures that the Knitro output is flushed to
% the screen regularly (depending on the Display/outlev setting).  This
% may be desirable on large, difficult problems that take a while to solve.
disp '';

% Always initialize "F" to something.  It is only needed when Knitro
% requests the residual functions (nargout=1), but not when Knitro requests
% the residual gradients (nargout=2).
F = [];
k = 1:10;

% Residual functions
if nargout <= 1
    F = 2 + 2*k - exp(k*x(1)) - exp(k*x(2));
end

% Residual gradients (functions not needed)
if nargout > 1
    g1 = -k.*exp(k*x(1));
    g2 = -k.*exp(k*x(2));
    g = [g1;g2]';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
