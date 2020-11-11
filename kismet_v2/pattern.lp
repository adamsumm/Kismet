

pattern :- action(fuck,P1,P2,T1),
	   action(marry,P1,P2,T2),
	   action(kill,P1,P2,T3),
	   T1 < T2,
	   T2 < T3.

#show pattern/0.