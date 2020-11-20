for k = K
    ieq_const = ieq_const + 1;
    for j = [J Jf]
        idx = sub2ind(dim_x, J0, j, k);
        Aeq(ieq_const, start_x + idx) = 1;
    end
    beq(ieq_const, 1) = 1;
end

for k = K
    ieq_const = ieq_const + 1;
    for i = [J J0]
        idx = sub2ind(dim_x, i, Jf, k);
        Aeq(ieq_const, start_x + idx) = 1;
    end
    beq(ieq_const, 1) = 1;
end