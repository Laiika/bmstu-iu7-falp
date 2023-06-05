domains
	num = integer.

predicates
	max_1_1(num, num, num).
	max_1_2(num, num, num).
	max_2_1(num, num, num, num).
	max_2_2(num, num, num, num).
	
clauses
	max_1_1(N1, N2, N2) :- N2 >= N1.
	max_1_1(N1, N2, N1) :- N1 > N2.
	
	max_1_2(N1, N2, N2) :- N2 >= N1, !.
	max_1_2(N1, _, N1).
	
	max_2_1(N1, N2, N3, N1) :- N1 >= N2, N1 >= N3.
	max_2_1(N1, N2, N3, N2) :- N2 >= N1, N2 >= N3.
	max_2_1(N1, N2, N3, N3) :- N3 >= N1, N3 >= N2.
	
	max_2_2(N1, N2, N3, N1) :- N1 >= N2, N1 >= N3, !.
	max_2_2(_, N2, N3, N2) :- N2 >= N3, !.
	max_2_2(_, _, N3, N3).
	
goal
	%max_1_1(1, 3, Max).
	%max_1_1(3, 1, Max).
	
	%max_1_2(1, 3, Max).
	%max_1_2(3, 1, Max).
	
	%max_2_1(1, 2, 3, Max).
	%max_2_1(1, 3, 2, Max).
	%max_2_1(3, 2, 1, Max).
	
	%max_2_2(1, 2, 3, Max).
	%max_2_2(1, 3, 2, Max).
	max_2_2(3, 2, 1, Max).
	