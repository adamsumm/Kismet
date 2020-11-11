

action_type(fuck;marry;kill;chat;slap).

people(1..50).

timesteps(1..50).

1 {action(Action,P1,P2,T) : action_type(Action), people(P2)} 1 :- people(P1), timesteps(T).

:- 50*25 {action(Action,P1,P2,T)}, action_type(Action).
