num_machine = 3;
num_task = 20;

p = [127	70	56	72	68	54	126	59	102	128	53	137	131	148	108	134	147	70	133	68];

s = [0	49	25	94	52	34	53	32	98	76	66	8	82	89	69	35	46	94	91	95
12	0	22	100	38	43	5	30	21	41	16	53	40	84	28	50	59	36	82	49
27	90	0	90	64	62	59	84	99	4	55	49	67	11	28	63	19	79	60	84
12	21	82	0	94	11	50	33	52	100	36	8	25	17	18	1	95	94	26	72
15	18	64	77	0	9	35	19	54	17	58	93	37	44	1	64	13	75	51	50
68	67	76	76	30	0	83	28	41	71	63	98	84	82	40	60	22	90	35	46
78	49	59	44	82	84	0	76	100	61	74	6	79	96	89	79	21	93	67	15
14	90	41	37	44	86	84	0	97	21	79	26	87	94	38	12	43	58	45	19
30	8	60	6	48	57	95	46	0	9	10	26	88	13	56	6	24	35	37	76
28	66	60	41	71	27	5	99	50	0	23	30	8	34	82	77	89	89	12	35
53	27	58	64	47	46	19	70	17	14	0	50	97	25	36	30	40	22	27	74
8	61	25	21	16	24	19	77	27	46	53	0	52	40	49	86	93	54	73	64
15	55	27	90	19	66	6	53	33	97	6	47	0	31	48	96	83	69	3	93
63	48	20	25	28	87	44	27	14	1	90	82	77	0	92	27	68	100	57	45
87	100	72	12	55	54	53	64	82	69	8	49	12	80	0	52	83	3	91	27
49	5	93	39	45	51	55	72	92	35	97	19	41	70	89	0	14	61	47	35
23	47	22	33	94	22	73	68	44	39	46	24	73	12	52	9	0	13	95	59
29	60	26	14	23	39	15	2	78	6	93	53	24	73	63	83	53	0	62	35
83	7	42	38	97	29	24	25	75	52	17	100	83	11	38	32	97	88	0	43
52	78	73	11	18	84	22	90	65	73	66	77	91	74	64	13	2	52	43	0];

compat = cell(num_task, 1);
compat{1} = 1;
compat{4} = 1;
compat{10} = 1;
compat{14} = 1;
compat{20} = 1;

compat{2} = [2,3];
compat{3} = [2,3];
compat{5} = [2,3];
compat{17} = [2,3];
compat{18} = [2,3];

compat{11} = [1, 3];
compat{12} = [1, 3];