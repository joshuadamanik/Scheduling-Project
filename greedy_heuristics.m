clear, clc, close all
addpath('problems');

instance11;

num_candidate = num_task;

[p_sorted, p_idx] = sort(p, 'desc');

p = [p 0 0];
s(num_task+1:num_task+2,:) = zeros(2, num_task);
s(:, num_task+1:num_task+2) = zeros(num_task+2, 2);

J = 1:num_task;
J0 = num_task+1;
Jf = num_task+2;
K = 1:num_machine;

best_max_span = 1e10;

for iter = 1:100000
    task_list = p_idx;
    sequence(1:num_machine) = {[J0 Jf]};
    span = zeros(1, num_machine);

    task_candidate = task_list(1:num_candidate);
    machine_candidate = K;
    
    get_best_sequence;
    
    if max_span < best_max_span
        best_span = span;
        best_k_longest = k_longest;
        best_max_span = max_span;
        best_sequence = sequence;
        fprintf('#%d: Better sequence found with max span %d\n', iter, max_span);
        
        for k = K
            fprintf('>>');
            for n = 1:length(best_sequence{k})
                fprintf(' %d', best_sequence{k}(n));
            end
            fprintf('\n');
        end
    end
end