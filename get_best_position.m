curr_sequence = sequence{k};

temp_sequence = {};
temp_increment = [];
temp_sequence(1:length(curr_sequence)-1) = {curr_sequence};
i_seq = 1;
for q = 1:length(curr_sequence)-1
    temp_sequence{i_seq} = [curr_sequence(1:q) j curr_sequence(q+1:end)];
    temp_increment(i_seq) = s(curr_sequence(q), j) + s(j, curr_sequence(q+1)) - s(curr_sequence(q), curr_sequence(q+1)) + p(j);
    i_seq = i_seq + 1;
end
[min_increment, i_min] = min(temp_increment);
new_sequence{k} = temp_sequence{i_min};
new_increment(k) = temp_increment(i_min);