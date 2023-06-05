domains
	list = integer*.
	num = integer.

predicates
	len_r(list, num, num).
	len(list, num).
	
	sum_r(list, num, num).
	sum(list, num).
	
	sum2_r(list, num, num).
	sum2(list, num).
	
	els_large_r(list, list, num, list).
	els_large(list, list, num).
	
	del_el_r(list, list, num, list).
	del_el(list, list, num).
	
	merge(list, list, list).
	
	
clauses
	% 1
	len_r([], Res, Res) :- !.
	len_r([_|T], Res, Cur) :- Cur2 = Cur + 1, 
			   	  len_r(T, Res, Cur2).
	
	len(L, Res) :- len_r(L, Res, 0).
	
	%2
	sum_r([], Res, Res) :- !.
	sum_r([H|T], Res, Cur) :- Cur2 = Cur + H,
				  sum_r(T, Res, Cur2).
				  
	sum(L, Res) :- sum_r(L, Res, 0).
	
	%3
	sum2_r([], Res, Res) :- !.
	
	sum2_r([_], Res, Res) :- !.
	
	sum2_r([_, H|T], Res, Cur) :- Cur2 = Cur + H,
				      sum2_r(T, Res, Cur2).
				  
	sum2(L, Res) :- sum2_r(L, Res, 0).
	
	%4
	els_large_r([], Res, _, Res) :- !.
	
	els_large_r([H|T], Res, N, Cur) :- H > N, !,
				  	   els_large_r(T, Res, N, [H|Cur]).
				  	   
	els_large_r([_|T], Res, N, Cur) :- els_large_r(T, Res, N, Cur).
				  	   
				  
	els_large(L, Res, N) :- els_large_r(L, Res, N, []).
	
	%5
	del_el_r([], Res, _, Res) :- !.
	
	del_el_r([H|T], Res, N, Cur) :- H <> N, !,
				  	del_el_r(T, Res, N, [H|Cur]).
				  	   
	del_el_r([_|T], Res, N, Cur) :- del_el_r(T, Res, N, Cur).
				  	   
				  
	del_el(L, Res, N) :- del_el_r(L, Res, N, []).
	
	%6
	merge([], L2, L2) :- !.
	merge([H|T], L2, [H|T3]):- merge(T, L2, T3).
	
goal
	%len([1, 2, 3, 4, 5], Res).
	%sum([1, 2, 3, 4, 5], Res).
	%sum2([1, 2, 3, 4, 5], Res).
	%els_large([3, 4, 5, 1, 0], Res, 2).
	%del_el([3, 4, 5, 1, 0, 4], Res, 4).
	merge([3, 4, 5], [1, 0], Res).

