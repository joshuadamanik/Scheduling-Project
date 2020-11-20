num_machine = 3;
num_task = 30;

rng(1);

min_p = 50;
max_p = 150;

p = min_p + randi(max_p-min_p, 1, num_task);

min_s = 1;
max_s = 150;

s = min_s + randi(max_s-min_s, num_task, num_task);
s = s .* (ones(num_task) - eye(num_task));

compat = cell(num_task, 1);

for i = 1:num_task
    compat{i} = randi(num_machine, 1, randi(num_machine)-1);
end

rng shuffle