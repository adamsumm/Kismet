%#show likelihood/2.

binding(person(INITIATOR),person(TARGET),person(SUBJECT),event(ACTION),location(LOCATION)) :- action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION).

:- binding(A,B,C), not different(A,B), not different(B,C), not different(A,C).

likelihood(action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION )}, action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION), INITIATOR != null.

