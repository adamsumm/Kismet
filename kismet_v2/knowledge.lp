

knows(Person, Action) :- received(Person,Action).
knows(Person, Action) :- did(Person,Action).
knows(Person, Action) :- saw(Person,Action).
knows(Person, Action) :- heard(Person,Action).
