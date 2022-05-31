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