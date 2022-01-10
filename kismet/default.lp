

person(null).
location(null).
event(null).


is(action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION),TAG) :- 
    did(INITIATOR,action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION)),
    is(NAME,TAG).
event(Action) :- did(Initiator,Action).