domains
	num = integer.

predicates
	fac(num, num).
	fac_r(num, num, num, num).

	fibonacci(num, num).
	fib(num, num, num, num).
	
clauses   		      
	fac(N, Res) :- fac_r(N, 1, Res, 1).
	
	fac_r(N, N, Res, Res) :- !.

	fac_r(N, ResN, Res, Cur) :- ResN2 = ResN + 1,
				    Cur2 = Cur * ResN2, 
				    fac_r(N, ResN2, Res, Cur2).
	
	
	fib(N, Res, Cur, _) :- N < 3, Res = Cur, !.
	fib(N, Res, Cur, Prev) :- N2 = N - 1, 
			    	  Cur2 = Cur + Prev,
			    	  fib(N2, Res, Cur2, Cur).
	
	fibonacci(N, Res) :- fib(N, Res, 1, 1).
	
	
	
goal
	%factorial(1, Res).
	%fibonacci(3, Res).
	%max_2_2(3, 2, 1, Max).
	fac(5, Res),fac(Res2,120).
