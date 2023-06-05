domains
	surname, phone = string.
	color = string.
	cost, num = integer.
	city, street = string.
	house, flat = integer.
	address = address_struct(city, street, house, flat).
	bank = string.
	account, sum = integer.
	name, type = string.
	
	own = car(name, color, cost);
	      building(name, cost);
	      sector(name, cost);
	      water_transport(name, cost). 

predicates
	phone_dir(surname, phone, address).
	owner(surname, own).
	bank_depositor(surname, bank, account, sum).
	
	own_name_and_cost(surname, type, name, cost).
	own_name(surname, type, name).
	own_type(surname, type, cost).
	own_sum_cost(surname, cost).
	
clauses
	phone_dir("Kozlov", "+79876576000", address_struct("Saint-Petersburg", "Mira", 4, 12)).
	phone_dir("Sabirova", "+79800006533", address_struct("Kazan", "Leninskaya", 31, 33)).
	phone_dir("Orehov", "+79876589577", address_struct("Saint-Petersburg", "Annikova", 23, 4)).
	phone_dir("Malkov", "+79876576444", address_struct("Nizhny Novgorod", "Annikova", 48, 1)).
	
	owner("Kozlov", car("mersedes", "yellow", 30000)).
	owner("Kozlov", building("house", 100000)).
	owner("Sabirova", car("lada", "black", 3000)).
	owner("Sabirova", building("castle", 300000)).
	owner("Sabirova", sector("region", 400000)).
	owner("Sabirova", water_transport("plot", 4000)).
	owner("Orehov", car("tesla", "black", 100000)).
	owner("Malkov", car("mersedes", "yellow", 1200)).
	owner("Malkov", water_transport("boat", 10000)).
	
	bank_depositor("Kozlov", "VTB", 1234, 100000).
	bank_depositor("Sabirova", "VTB", 51234, 500000).
	bank_depositor("Sabirova", "Sber", 5123, 700000).
	bank_depositor("Orehov", "Tinkoff", 456, 500000).
	bank_depositor("Malkov", "Sber", 45556, 400000).
	
	own_name_and_cost(Surname, "car", Name, Cost) :- owner(Surname, car(Name, _, Cost)).
	own_name_and_cost(Surname, "building", Name, Cost) :- owner(Surname, building(Name, Cost)).
	own_name_and_cost(Surname, "sector", Name, Cost) :- owner(Surname, sector(Name, Cost)).
	own_name_and_cost(Surname, "water_transport", Name, Cost) :- owner(Surname, water_transport(Name, Cost)).
	
	own_name(Surname, Type, Name) :- own_name_and_cost(Surname, Type, Name, _).
	
	own_type(Surname, "car", Cost) :- owner(Surname, car(_, _, Cost)), !.
	own_type(Surname, "building", Cost) :- owner(Surname, building(_, Cost)), !.
	own_type(Surname, "sector", Cost) :- owner(Surname, sector(_, Cost)), !.
	own_type(Surname, "water_transport", Cost) :- owner(Surname, water_transport(_, Cost)), !.
	own_type(_, _, 0).
	
	own_sum_cost(Surname, Cost) :- own_type(Surname, "car", Cost1),
				       own_type(Surname, "building", Cost2),
				       own_type(Surname, "sector", Cost3),
				       own_type(Surname, "water_transport", Cost4),
				       Cost = Cost1 + Cost2 + Cost3 + Cost4.
				       
goal
	%own_name("Kozlov", Type, Name).
	%own_name_and_cost("Sabirova", Type, Name, Cost).
	own_sum_cost("Sabirova", Cost).

