#show go_to_propensity/8.
#show go_to/3.
go_to(NAME,LOCATION,N) :-
  N =  #sum{ C, thing :
          go_to_propensity(Tag, C,_, NAME, _,_,_,LOCATION)},
          go_to_propensity(_,_,_, NAME, _,_,_,LOCATION).
          
          
{go_to(NAME,LOCATION,0)} :- location(LOCATION), person(NAME).

:- 2 {go_to(NAME,LOCATION,_)},location(LOCATION), person(NAME).
:-  {go_to(NAME,LOCATION,_)} 0,location(LOCATION), person(NAME).