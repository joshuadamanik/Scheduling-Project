for k = K
    curr_sequence = sequence{k};
    span(k) = 0;
    for n = 2:length(curr_sequence)
        span(k) = span(k) + s(curr_sequence(n-1), curr_sequence(n)) + p(curr_sequence(n));
    end
    [max_span, k_longest] = max(span);
end