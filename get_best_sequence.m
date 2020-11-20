while ~isempty(task_candidate)
    while true
        j = task_candidate(randi(min(num_candidate, length(task_candidate))));
        
        available_machine = machine_candidate;
        if ~isempty(compat{j})
            available_machine = available_machine(ismember(available_machine, compat{j}));
        end
        if ~isempty(available_machine)
            break;
        end
    end
    
    new_sequence = cell(1, length(available_machine));
    new_increment = zeros(1, length(available_machine));
    
    for k = available_machine
        get_best_position;
    end
    
    [~, k_star] = min(span(available_machine) + new_increment(available_machine));
    sequence{available_machine(k_star)} = new_sequence{available_machine(k_star)};
    
    j_idx = (task_list == j);
    task_list(j_idx) = [];
    
    task_candidate = task_list(1:min(num_candidate,length(task_list)));
    get_span;
end