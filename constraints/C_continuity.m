for k = K
    for j = J
        ieq_const = ieq_const + 1;
        for i = [J J0]
            if i == j
                continue
            end
            
            idx = sub2ind(dim_x, i, j, k);
            Aeq(ieq_const, start_x + idx) = 1;
        end
        for i = [J Jf]
            if i == j
                continue
            end
            
            idx = sub2ind(dim_x, j, i, k);
            Aeq(ieq_const, start_x + idx) = -1;
        end
        beq(ieq_const, 1) = 0;
    end
end