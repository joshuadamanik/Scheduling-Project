num_machine = 3;
num_task = 30;

p = [146	117	73	103	130	120	62	118	103	65	96	51	55	73	59	130	142	129	118	94	143	64	53	141	141	70	80	76	127	88];

s = [0	6	41	20	44	8	45	49	16	9	20	47	22	42	20	47	6	40	30	39	10	6	9	37	19	3	27	20	11	12
34	0	24	1	17	17	45	50	39	47	25	7	32	24	10	26	8	11	10	18	18	35	44	14	11	49	23	49	7	15
2	47	0	3	2	46	4	41	12	11	8	11	29	45	50	50	46	8	48	23	3	43	17	3	16	27	22	44	42	30
15	37	17	0	49	22	23	34	27	42	28	32	29	37	23	18	13	9	16	30	12	1	25	15	13	6	41	29	50	28
39	45	9	37	0	36	3	32	23	8	21	2	48	4	43	35	28	14	12	37	17	11	30	31	26	28	2	19	50	36
8	26	19	28	20	0	7	48	36	32	22	23	20	33	31	16	5	2	17	12	5	26	36	33	2	44	5	13	26	34
19	31	6	47	30	32	0	1	3	25	37	1	29	7	28	5	30	19	13	33	18	22	23	36	17	11	9	9	27	33
29	13	30	42	19	28	48	0	11	13	40	46	26	50	48	36	25	46	28	13	11	2	30	11	15	45	45	45	36	34
9	1	38	17	14	33	10	47	0	7	41	15	46	49	49	5	16	3	2	47	17	36	37	10	6	3	26	48	5	37
31	6	29	8	24	29	36	40	34	0	7	43	30	37	33	17	12	19	7	6	19	14	2	18	15	50	31	1	48	24
29	16	27	23	45	20	17	26	2	45	0	30	14	30	39	13	8	13	4	37	45	45	15	31	37	35	48	46	24	43
22	12	47	15	29	45	19	3	45	13	41	0	15	46	2	27	25	8	33	16	21	8	3	26	23	20	35	32	41	28
17	43	27	35	43	18	31	19	48	31	1	33	0	5	20	8	45	36	30	46	3	43	29	15	21	39	9	28	42	24
10	37	17	41	38	11	7	46	49	30	21	3	42	0	10	20	5	24	50	26	44	35	41	47	43	26	3	3	24	41
41	39	3	50	37	17	30	33	25	16	22	22	28	23	0	20	7	46	27	47	8	40	46	9	43	29	2	29	25	15
7	44	16	19	27	19	41	33	15	15	1	18	47	27	2	0	23	46	21	21	17	36	26	7	34	35	2	39	36	11
9	36	14	40	50	2	32	25	22	7	28	21	33	4	33	47	0	39	10	2	9	5	28	29	14	22	6	27	31	22
21	27	3	37	14	12	44	29	40	18	30	13	28	10	19	15	26	0	19	30	18	18	8	24	23	9	50	24	48	28
29	10	26	39	2	38	35	10	15	30	28	44	4	34	41	6	23	14	0	31	23	23	40	1	11	6	24	6	32	38
27	9	16	15	48	16	47	34	14	15	47	20	26	48	13	1	29	41	44	0	22	42	33	14	42	10	22	35	44	3
3	3	44	17	37	27	32	22	5	42	15	16	42	40	21	7	48	10	35	35	0	3	43	23	21	19	32	40	31	3
46	20	14	42	5	44	5	7	9	8	25	44	13	29	34	33	11	40	35	20	6	0	40	16	47	32	16	12	14	26
24	47	8	38	7	19	44	15	22	37	42	38	11	32	5	33	42	28	49	6	7	50	0	4	36	29	47	24	5	27
45	32	32	38	17	42	41	1	5	37	10	33	16	30	28	24	11	26	31	34	17	13	43	0	33	22	32	6	39	50
16	38	49	25	12	24	2	19	50	9	36	28	23	1	49	40	22	2	19	43	7	41	20	12	0	9	10	23	21	30
39	16	42	26	42	19	35	15	18	12	1	29	25	19	34	46	40	7	14	26	23	38	30	41	47	0	42	43	31	4
35	11	9	34	1	36	45	16	22	47	47	11	7	24	17	28	6	3	35	38	29	8	16	35	48	22	0	31	41	35
45	46	20	34	17	1	29	5	9	19	14	27	33	35	18	26	2	17	45	48	48	15	39	22	49	29	15	0	16	34
28	29	23	32	37	13	3	40	36	12	49	50	1	50	19	44	12	28	36	3	15	14	28	32	28	49	39	8	0	16
6	13	20	42	47	13	22	48	13	45	13	42	18	30	1	23	18	45	14	21	35	19	22	49	18	29	6	45	3	0];

compat = cell(num_task, 1);

compat{1} = 1;
compat{2} = 1;
compat{3} = 1;
compat{4} = 1;

compat{10} = [2, 3];
compat{15} = [2, 3];
compat{25} = [2, 3];
compat{30} = [2, 3];

compat{12} = [1, 3];
compat{13} = [1, 3];
compat{17} = [1, 3];
compat{22} = [1, 3];
% compat{25} = [1, 3];
