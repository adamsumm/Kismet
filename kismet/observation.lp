

observability(Name,Initiator,Target,Subject,Action,Location, Observer,Loc, Value) :-
						   at(Observer,Loc),
						   at(Initiator,Loc),
						   occurred(action(Name,Initiator,Target,Subject,Action,Location)),
						   Observer != Initiator,
						   visibility(Name,Value),
						   Observer != null.


#show observability/9.