

person(null).
location(null).
event(null).


different(null,null).

different(P1,P2) :- person(P1),person(P2), P1 != P2.

is(action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION),TAG) :- 
    did(INITIATOR,action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION)),
    is(NAME,TAG).
event(Action) :- did(Initiator,Action).