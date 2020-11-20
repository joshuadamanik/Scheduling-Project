clear, clc, close all;
addpath('knitromatlab');
addpath('constraints');
addpath('problems');

instance4;

p = [p 0 0];
s(num_task+1:num_task+2,:) = zeros(2, num_task);
s(:, num_task+1:num_task+2) = zeros(num_task+2, 2);


J = 1:num_task;
J0 = num_task+1;
Jf = num_task+2;
K = 1:num_machine;

B = 10000;

dim_x = [num_task+2, num_task+2, num_machine];
num_x = prod(dim_x);

dim_c = [num_task, 1];
num_c = prod(dim_c);

dim_cmax = [1, 1];
num_cmax = prod(dim_cmax);

num_vars = num_x + num_c + num_cmax;

start_x = 0;
range_x = start_x+1:start_x+num_x;

start_c = num_x;
range_c = start_c+1:start_c+num_c;

start_cmax = num_x + num_c;
range_cmax = start_cmax+1:start_cmax+num_cmax;


obj = zeros(num_vars, 1);

for i = [J J0 Jf]
    for j = [J J0 Jf]
        if j == i
            continue
        end
        for k = K
            idx = sub2ind(dim_x, i, j, k);
            obj(start_x + idx) = 1;
        end
    end
end
obj(range_cmax) = 0.001;

%% Constraints
Aeq = spalloc(0, num_vars, 0);
A = spalloc(0, num_vars, 0);
beq = [];
b = [];

ieq_const = 0;
i_const = 0;

A_onejob_onemach;
B_start_end;
C_continuity;
D_precedence;
E_compat;
F_cmax;

% fixed_path;


%% Optimization

xType = [ones(num_x, 1); ones(num_c, 1); ones(num_cmax, 1)];
lb = zeros(num_vars, 1);
ub = [ones(num_x, 1); 10*num_task*ones(num_c, 1); B*ones(num_cmax, 1)];
x0 = zeros(num_vars, 1);

[sol,fval,exitflag,output,lambda] = knitro_milp(obj(:), xType, A, b, Aeq, beq, lb, ub, x0);
xijk = round(reshape(sol(range_x), dim_x)) .* (ones(num_task+2) - eye(num_task+2));
cmax = sol(range_cmax);
% dmm = reshape(sol(range_d), dim_d);