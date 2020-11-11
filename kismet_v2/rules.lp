castable(patron,bar).

castable(bartender,bar).

castable(owner,bar).

action(waste_time, Person, null, null, null, null):-
		person(Person),person(null),person(null),event(null),location(null),
		at(Person,Location),
		different(Person,null),
		different(Person,null),
		different(null,null).

is(waste_time, lazy).

is(waste_time, fun).

visibility(waste_time,0).

action(drink_the_day_away, Person, null, null, null, null):-
		person(Person),person(null),person(null),event(null),location(null),
		is(Location_0,bar),
		at(Person,Location_0),
		different(Person,null),
		different(Person,null),
		different(null,null).

add(Person, drunk) :- occurred(action(drink_the_day_away, Person, null, null, null, null)).

is(drink_the_day_away, lazy).

is(drink_the_day_away, drinking).

visibility(drink_the_day_away,0).

action(sober_up, Person, null, null, null, null):-
		person(Person),person(null),person(null),event(null),location(null),
		is(Person, drunk),
		at(Person,Location),
		different(Person,null),
		different(Person,null),
		different(null,null).

del(Person, drunk) :- occurred(action(sober_up, Person, null, null, null, null)).

visibility(sober_up,0).

action(mingle, Person, Other, null, null, null):-
		person(Person),person(Other),person(null),event(null),location(null),
		at(Person,Location_0),
		at(Other,Location_0),
		different(Person,Other),
		different(Person,null),
		different(Other,null).

add(Other,likes,Person) :- occurred(action(mingle, Person, Other, null, null, null)).

is(mingle, talk).

visibility(mingle,0).

action(mingle_loudly, Person, Other, null, null, null):-
		person(Person),person(Other),person(null),event(null),location(null),
		at(Person,Location_0),
		at(Other,Location_0),
		is(Person, extrovert),
		different(Person,Other),
		different(Person,null),
		different(Other,null).

add(Other,likes,Person) :- occurred(action(mingle_loudly, Person, Other, null, null, null)).

is(mingle_loudly, talk).

visibility(mingle_loudly,0).

action(gossip_about, Gossiper, Gossipee, GossipedAbout, GossipedAction, null):-
		person(Gossiper),person(Gossipee),person(GossipedAbout),event(GossipedAction),location(null),
		at(Gossipee,Location_0),
		knows(Gossiper,GossipedAction),
		at(Gossiper,Location_0),
		not knows(Gossipee,GossipedAction),
		did(GossipedAbout,GossipedAction),
		different(Gossiper,Gossipee),
		different(Gossiper,GossipedAbout),
		different(Gossipee,GossipedAbout).

update(Gossipee,likes,Gossiper,Y) :- state(Gossipee,likes,Gossiper,X), X + 1 = Y, occurred(action(gossip_about, Gossiper, Gossipee, GossipedAbout, GossipedAction, null)).

heard(Gossipee,GossipedAction) :- occurred(action(gossip_about, Gossiper, Gossipee, GossipedAbout, GossipedAction, null)).

is(gossip_about, talk).

visibility(gossip_about,2).

action(flirt, Person, Other, null, null, null):-
		person(Person),person(Other),person(null),event(null),location(null),
		at(Person,Location_0),
		at(Other,Location_0),
		different(Person,Other),
		different(Person,null),
		different(Other,null).

add(Other,likes,Person) :- occurred(action(flirt, Person, Other, null, null, null)).

update(Person,likes,Other,Y) :- state(Person,likes,Other,X), X + 1 = Y, occurred(action(flirt, Person, Other, null, null, null)).

is(flirt, romance).

is(flirt, talk).

visibility(flirt,2).

action(sulk, Person, null, null, null, null):-
		person(Person),person(null),person(null),event(null),location(null),
		is(Person,sadness,V_Person_sadness), V_Person_sadness > 5,
		at(Person,Location),
		different(Person,null),
		different(Person,null),
		different(null,null),
		mode(free).

is(sulk, sad).

visibility(sulk,0).

action(become_bartender, TheTender, null, null, null, null):-
		person(TheTender),person(null),person(null),event(null),location(null),
		is(TheTender,age,V_TheTender_age), V_TheTender_age >= 18,
		at(TheTender,Location),
		not is(TheTender, ur_job),
		different(TheTender,null),
		different(TheTender,null),
		different(null,null).

add(TheTender,ur_job,Location) :- at(TheTender, Location), occurred(action(become_bartender, TheTender, null, null, null, null)).

add(TheTender,bartender,Location) :- at(TheTender, Location), occurred(action(become_bartender, TheTender, null, null, null, null)).

is(become_bartender, work).

is(become_bartender, drinking).

visibility(become_bartender,0).

action(repair_location, Initiator, null, null, null, Location):-
		person(Initiator),person(null),person(null),event(null),location(Location),
		is(Location, damaged),
		at(Initiator,Location),
		different(Initiator,null),
		different(Initiator,null),
		different(null,null).

del(Location, damaged) :- occurred(action(repair_location, Initiator, null, null, null, Location)).

visibility(repair_location,0).

action(tend_bar, Tender, null, null, null, null):-
		person(Tender),person(null),person(null),event(null),location(null),
		at(Tender,Location),
		is(Tender,bartender,RoleLocation),
		at(Tender,RoleLocation),
		different(Tender,null),
		different(Tender,null),
		different(null,null).

is(tend_bar, work).

is(tend_bar, drinking).

visibility(tend_bar,0).

action(be_sneaky, Sneaker, null, null, null, null):-
		person(Sneaker),person(null),person(null),event(null),location(null),
		at(Sneaker,Location),
		different(Sneaker,null),
		different(Sneaker,null),
		different(null,null).

is(be_sneaky, sneaky).

visibility(be_sneaky,-3).

action(barroom_brawl, Initiator, Combatant, null, null, Location):-
		person(Initiator),person(Combatant),person(null),event(null),location(Location),
		at(Combatant,Location),
		is(Initiator,dislikes,Combatant,V_Initiator_dislikes_Combatant), V_Initiator_dislikes_Combatant > 5,
		is(Location, bar),
		is(Initiator, drunk),
		at(Initiator,Location),
		is(Combatant, drunk),
		different(Initiator,Combatant),
		different(Initiator,null),
		different(Combatant,null).

add(Combatant,dislike,Initiator) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

del(Combatant,likes,Initiator) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

update(Combatant,likes,Initiator,Y) :- state(Combatant,likes,Initiator,X), X - 5 = Y,occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

add(Combatant, hurt) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

add(Initiator, hurt) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

add(Location, damaged) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

add(Initiator,dislike,Combatant) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

update(Initiator,likes,Combatant,Y) :- state(Initiator,likes,Combatant,X), X - 5 = Y,occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

del(Initiator,likes,Combatant) :- occurred(action(barroom_brawl, Initiator, Combatant, null, null, Location)).

is(barroom_brawl, fighting).

is(barroom_brawl, angry).

is(barroom_brawl, gossipable).

visibility(barroom_brawl,4).

action(disregard, Person, RudePerson, null, Action, null):-
		person(Person),person(RudePerson),person(null),event(Action),location(null),
		saw(Person,Action),
		at(RudePerson,Location),
		is(Action, gossipable),
		at(Person,Location),
		did(RudePerson,Action),
		different(Person,RudePerson),
		different(Person,null),
		different(RudePerson,null),
		mode(response).

add(Person,dislikes,RudePerson) :- occurred(action(disregard, Person, RudePerson, null, Action, null)).

visibility(disregard,0).

action(cast_ur_job, TheWorker, null, null, null, null):-
		person(TheWorker),person(null),person(null),event(null),location(null),
		castable(ur_job,Location),
		at(TheWorker,Location),
		mode(casting),
		not is(TheWorker, ur_job),
		different(TheWorker,null),
		different(TheWorker,null),
		different(null,null).

add(TheWorker,ur_job,Location) :- at(TheWorker, Location), occurred(action(cast_ur_job, TheWorker, null, null, null, null)).

is(cast_ur_job, work).

visibility(cast_ur_job,0).

action(cast_child_laborer, TheWorker, null, null, null, null):-
		person(TheWorker),person(null),person(null),event(null),location(null),
		mode(casting),
		is(TheWorker,age,V_TheWorker_age), V_TheWorker_age < 16,
		castable(child_laborer,Location),
		at(TheWorker,Location),
		not is(TheWorker, ur_job),
		different(TheWorker,null),
		different(TheWorker,null),
		different(null,null).

add(TheWorker,child_laborer,Location) :- at(TheWorker, Location), occurred(action(cast_child_laborer, TheWorker, null, null, null, null)).

add(TheWorker,ur_job,Location) :- at(TheWorker, Location), occurred(action(cast_child_laborer, TheWorker, null, null, null, null)).

is(cast_child_laborer, work).

visibility(cast_child_laborer,0).

action(cast_bartender, TheWorker, null, null, null, null):-
		person(TheWorker),person(null),person(null),event(null),location(null),
		castable(bartender,Location),
		mode(casting),
		is(TheWorker,age,V_TheWorker_age), V_TheWorker_age >= 18,
		at(TheWorker,Location),
		not is(TheWorker, ur_job),
		different(TheWorker,null),
		different(TheWorker,null),
		different(null,null).

add(TheWorker,bartender,Location) :- at(TheWorker, Location), occurred(action(cast_bartender, TheWorker, null, null, null, null)).

add(TheWorker,ur_job,Location) :- at(TheWorker, Location), occurred(action(cast_bartender, TheWorker, null, null, null, null)).

is(cast_bartender, work).

is(cast_bartender, drinking).

visibility(cast_bartender,0).

status(likes).

propensity(observation, 3, snoopy,Self, DEFAULT_TARGET, DEFAULT_OBJECT, Action, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(Action),location(DEFAULT_LOCATION)),
		is(Self, snoopy),
		is(Action, secretive).

propensity(observation, 1, snoopy,Self, DEFAULT_TARGET, DEFAULT_OBJECT, Action, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(Action),location(DEFAULT_LOCATION)),
		is(Self, snoopy).

trait(snoopy).

propensity(drinking, 3, drunkard,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, drunkard).

go_to_propensity(bar, 1, drunkard,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, drunkard).

trait(drunkard).

propensity(drinking, -3, teetotaler, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, teetotaler).

go_to_propensity(bar, -1, teetotaler, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, teetotaler).

trait(teetotaler).

propensity(impulsive, 3, drunk,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, drunk).

propensity(anger, 3, drunk,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, drunk).

status(drunk).

propensity(sad, 3, sad_drunk,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, sad_drunk),
		is(Self, drunk).

trait(sad_drunk).

propensity(talk, 3, extrovert,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, extrovert).

trait(extrovert).

propensity(talk, -3, introvert, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		binding(person(Self),person(DEFAULT_TARGET),person(DEFAULT_OBJECT),event(DEFAULT_ACTION),location(DEFAULT_LOCATION)),
		is(Self, introvert).

trait(introvert).