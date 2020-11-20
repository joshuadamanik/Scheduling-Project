for i = J
	for j = J
        if i == j
            continue
        end
        for k = K
            i_const = i_const + 1;
            idx = sub2ind(dim_c, i);
            A(i_const, start_c + idx) = 1;
            idx = sub2ind(dim_c, j);
            A(i_const, start_c + idx) = -1;
            idx = sub2ind(dim_x, i, j, k);
            A(i_const, start_x + idx) = 10*num_task;
            
            b(i_const, 1) = 10*num_task - 1;
        end
	end
end
% 
