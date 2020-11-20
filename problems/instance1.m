num_machine = 2;
num_task = 6;

p = [129	67	80	92	75	72];

s = [0	58	38	12	5	37
72	0	28	91	32	67
65	9	0	7	84	19
19	43	56	0	46	100
49	25	44	97	0	5
38	3	72	2	82	0];

compat = cell(num_task, 1);
compat{1} = 1;
compat{6} = 1;
compat{2} = 2;
compat{3} = 2;