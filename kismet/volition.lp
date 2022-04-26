#show likelihood/2.

#const single_null = 1000.
#const no_null = 200.

non_null(INITIATOR) :- action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION), TARGET != null.

likelihood(action(NAME, INITIATOR,null,null,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,null,null,ACTION,LOCATION )}, action(NAME, INITIATOR,null,null,ACTION,LOCATION), INITIATOR != null, not non_null(INITIATOR).

likelihood(action(NAME, INITIATOR,null,null,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,null,null,ACTION,LOCATION )}, action(NAME, INITIATOR,null,null,ACTION,LOCATION), INITIATOR != null, is(NAME,role_specific).

likelihood(action(NAME, INITIATOR,null,SUBJECT,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,null,SUBJECT,ACTION,LOCATION )}, action(NAME, INITIATOR,null,SUBJECT,ACTION,LOCATION), INITIATOR != null,
          hashed(NAME,HN), hashed_1(INITIATOR,HI), hashed_2(null,HT), hashed_3(SUBJECT,HS), hashed(time,HTime),hashed(LOCATION,HL),
          | HN + HI + HT + HS + HTime + HL | \ 10000 < single_null.
          
likelihood(action(NAME, INITIATOR,TARGET,null,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,TARGET,null,ACTION,LOCATION )}, action(NAME, INITIATOR,TARGET,null,ACTION,LOCATION), INITIATOR != null,
          hashed(NAME,HN), hashed_1(INITIATOR,HI), hashed_2(TARGET,HT), hashed_3(null,HS), hashed(time,HTime),hashed(LOCATION,HL),
          | HN + HI + HT + HS + HTime + HL | \ 10000 < single_null.
          
likelihood(action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION),N) :-
  N =  #sum{ C,Tag :
          is(NAME,Tag) ,
          propensity(Tag, C, _, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION )}, action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION), INITIATOR != null,
          hashed(NAME,HN), hashed_1(INITIATOR,HI), hashed_2(TARGET,HT), hashed_3(SUBJECT,HS), hashed(time,HTime),hashed(LOCATION,HL),
          | HN + HI + HT + HS + HTime + HL | \ 10000 < no_null.