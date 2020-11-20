for j = J
    if ~isempty(compat{j})
        ieq_const = ieq_const + 1;
        for k = compat{j}
            for i = [J J0]
                if i == j
                    continue
                end

                idx = sub2ind(dim_x, i, j, k);
                Aeq(ieq_const, start_x + idx) = 1;
            end
        end
        beq(ieq_const, 1) = 1;
    end
end