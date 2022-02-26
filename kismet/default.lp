

person(null).
location(null).
event(null).

not_missing(Person, Status) :- person(Person), status(Status), isPerson(Status,N), N > 0.
not_missing(Person, Status) :- person(Person), status(Status), isPerson(Status,N), N < 0.
is(Person, Status, 0) :- person(Person), status(Status), not not_missing(Person,Status).

is(action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION),TAG) :- 
    did(INITIATOR,action(NAME, INITIATOR,TARGET,SUBJECT,ACTION,LOCATION)),
    is(NAME,TAG).
event(Action) :- did(Initiator,Action).