pattern(dislikes_friend,Self, Disliker, Friend) :-
	is(Self,likes,Friend,V_Self_likes_Friend), V_Self_likes_Friend >= 3,
	is(Disliker,likes,Friend,V_Disliker_likes_Friend), V_Disliker_likes_Friend <= -3,
	Self != Disliker,
	Self != Friend,
	Disliker != Friend.

pattern(non_joker,Character) :-
	is(Character, critical).

pattern(non_joker,Character) :-
	is(Character, stern).

pattern(non_joker,Character) :-
	is(Character, gruff).

pattern(has_connection,PersonA, PersonB) :-
	is(PersonA,likes,PersonB,V_PersonA_likes_PersonB), V_PersonA_likes_PersonB != 0,
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_connection,PersonA, PersonB) :-
	is(PersonA,loves,PersonB,V_PersonA_loves_PersonB), V_PersonA_loves_PersonB != 0,
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_connection,PersonA, PersonB) :-
	pattern(has_connection,PersonB,PersonA),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(lacking_connection,PersonA, PersonB) :-
	not pattern(has_connection,PersonA,PersonB),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_connection,PersonA,PersonB),
	pattern(has_connection,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_connection,PersonA,PersonB),
	pattern(has_path,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_path,PersonA,PersonB),
	pattern(has_connection,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_path,PersonA,PersonB),
	pattern(has_path,PersonB,PersonC),
	PersonA != PersonC.

pattern(lacking_path,PersonA, PersonB) :-
	not pattern(has_path,PersonA,PersonB),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.