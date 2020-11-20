clear, clc, close all
addpath('problems');

instance3;

num_candidate = num_task;

[p_sorted, p_idx] = sort(p, 'desc');

p = [p 0 0];
s(num_task+1:num_task+2,:) = zeros(2, num_task);
s(:, num_task+1:num_task+2) = zeros(num_task+2, 2);

J = 1:num_task;
J0 = num_task+1;
Jf = num_task+2;
K = 1:num_machine;

min_max_span = 1e10;

for iter = 1:100000
    task_list = p_idx;
    sequence(1:num_machine) = {[J0 Jf]};
    span = zeros(1, num_machine);

    task_candidate = task_list(1:num_candidate);

    while ~isempty(task_candidate)
        j = task_candidate(randi(min(num_candidate, length(task_candidate))));
        
        available_machine = K;
        
        if ~isempty(compat{j})
            available_machine = compat{j};
        end
        
        new_sequence = cell(1, length(available_machine));
        new_increment = zeros(1, length(available_machine));
        
        for k = available_machine
            best_position;
        end
        
        [~, k_star] = min(span(available_machine) + new_increment(available_machine));
        sequence{available_machine(k_star)} = new_sequence{available_machine(k_star)};

        j_idx = (task_list == j);
        task_list(j_idx) = [];

        task_candidate = task_list(1:min(num_candidate,length(task_list)));
    end

    for k = K
        curr_sequence = sequence{k};
        span(k) = 0;
        for n = 2:length(curr_sequence)
            span(k) = span(k) + s(curr_sequence(n-1), curr_sequence(n)) + p(curr_sequence(n));
        end
        max_span = max(span);
    end
    if max_span < min_max_span
        min_max_span = max_span;
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