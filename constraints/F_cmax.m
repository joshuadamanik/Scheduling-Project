for k = K
    i_const = i_const + 1;
    for i = [J J0]
        for j = J
            if j == i
                continue
            end
            idx = sub2ind(dim_x, i, j, k);
            A(i_const, start_x + idx) = s(i,j) + p(j);
        end
    end
    A(i_const, num_vars) = -1;
    b(i_const, 1) = 0;
end