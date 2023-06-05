domains
	surname, phone = string.
	brand, color = string.
	cost, num = integer.
	city, street = string.
	house, flat = integer.
	address = address_struct(city, street, house, flat).

predicates
	cars(surname, brand, color, cost, num).
	phone_dir(surname, phone, address).
	get_by_brand_and_color(brand, color, surname, phone, city).

clauses
	cars("Kozlov", "mersedes", "yellow", 30000, 545).
	cars("Sabirova", "lada", "black", 3000, 432).
	cars("Orehov", "tesla", "black", 100000, 133).
	cars("Malkov", "mersedes", "yellow", 1200, 333).
	
	phone_dir("Kozlov", "+79876576000", address_struct("Saint-Petersburg", "Mira", 4, 12)).
	phone_dir("Sabirova", "+79800006533", address_struct("Kazan", "Leninskaya", 31, 33)).
	phone_dir("Orehov", "+79876589577", address_struct("Saint-Petersburg", "Annikova", 23, 4)).
	phone_dir("Malkov", "+79876576444", address_struct("Nizhny Novgorod", "Annikova", 48, 1)).
	
	get_by_brand_and_color(Brand, Color, Surname, Phone, City) :- cars(Surname, Brand, Color, _, _), phone_dir(Surname, Phone, address_struct(City, _, _, _)).

goal
	%get_by_brand_and_color("lada", "red", Surname, Phone, City).
	%get_by_brand_and_color("mersedes", "yellow", Surname, Phone, City).
	
	get_by_brand_and_color(Brand, _, _, Phone, _).
	%get_by_brand_and_color("mersedes", _, Surname, _, City).
	%get_by_brand_and_color(_, "black", _, Phone, _).

