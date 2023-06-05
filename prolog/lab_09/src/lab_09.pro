domains 	
	name, sex = string.  
	
predicates 	
	parent(name, name, sex).         
	grandparent(name, name, sex, sex). 
	
clauses 
	parent("child", "mom", "w").
	parent("child", "dad", "m").
	parent("mom", "mom of mom", "w").
	parent("mom", "dad of mom", "m").
	parent("dad", "mom of dad", "w").
	parent("dad", "dad of dad", "m").
	
	grandparent(Child, Grandparent, ParentSex, GrandparentSex) :- parent(Child, Parent, ParentSex), parent(Parent, Grandparent, GrandparentSex).

goal 	
	%grandparent("child", Name, _, "w"). 
	%grandparent("child", Name, _, "m"). 
	%grandparent("child", Name, _, _). 
	%grandparent("child", Name, "w", "w"). 
	grandparent("child", Name, "w", _). 
	