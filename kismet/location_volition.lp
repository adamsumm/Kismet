#show go_to_propensity/8.
#show go_to/3.

go_to_raw(NAME,LOCATION,N) :-
  N =  #sum{ C, thing :
          go_to_propensity(Tag, C,_, NAME, _,_,_,LOCATION)},
          go_to_propensity(_,_,_, NAME, _,_,_,LOCATION), location(LOCATION).
          %,   
          %hashed_1(NAME,HN), hashed(time,HTime),hashed(LOCATION,HL),
          %|HN + HTime + HL| \ 10 < 5.
    
go_to(NAME,LOCATION,N) :- go_to_raw(NAME,LOCATION,N).


{go_to(NAME,LOCATION,0)} :- location(LOCATION), person(NAME), LOCATION != null
, hashed_1(NAME,HN), hashed(time,HTime),hashed(LOCATION,HL),
         |HN + HTime + HL| \ 10 < 5.

created(NAME,LOCATION) :- go_to(NAME,LOCATION,0), not go_to_raw(NAME,LOCATION,0).

:- 3  {created(NAME,_)} , person(NAME), NAME != null.

:- 2 {go_to(NAME,LOCATION,_)},location(LOCATION), person(NAME).
:-  {go_to(NAME,_,_)} 2, person(NAME), NAME != null.
