castable(monarch,throne_room).

castable(chancellor,throne_room).

castable(royalty,throne_room).

castable(citizen,throne_room).

hashed(throne_room,1151859843).

castable(shipping_foreman,docks).

castable(dockworker,docks).

castable(prostitute,docks).

castable(fisher,docks).

castable(visitor,docks).

hashed(docks,3488801281).

castable(curator,auction_house).

castable(auctioneer,auction_house).

castable(patron,auction_house).

hashed(auction_house,2098318236).

castable(guest,ballroom).

castable(owner,ballroom).

castable(artist,ballroom).

hashed(ballroom,4185941308).

castable(visitor,quad).

hashed(quad,1178793832).

castable(miner,mine).

castable(foreman,mine).

hashed(mine,4202707991).

castable(elder,elders_house).

castable(visitor,elders_house).

hashed(elders_house,1129166583).

castable(guard,dungeon).

castable(prisoner,dungeon).

hashed(dungeon,655486548).

castable(impresario,opera_house).

castable(diva,opera_house).

castable(tourist,opera_house).

castable(bard,opera_house).

castable(patron,opera_house).

hashed(opera_house,717817927).

castable(smith_apprentice,smith).

castable(smithy,smith).

castable(patron,smith).

hashed(smith,825564703).

castable(sailor,boat).

castable(captain,boat).

castable(passenger,boat).

hashed(boat,4198294352).

castable(spy,thieves_den).

castable(thief,thieves_den).

castable(spy_master,thieves_den).

castable(master_thief,thieves_den).

hashed(thieves_den,1551725841).

castable(librarian,library).

castable(tutor,library).

castable(student,library).

castable(researcher,library).

castable(visitor,library).

hashed(library,8360774).

castable(guest,kitchen).

castable(chef,kitchen).

castable(worker,kitchen).

castable(owner,kitchen).

hashed(kitchen,1213312051).

castable(tourist,amphitheatre).

castable(bard,amphitheatre).

hashed(amphitheatre,2634253136).

castable(owner,shipyard).

castable(engineer,shipyard).

castable(ship_builder,shipyard).

castable(visitor,shipyard).

hashed(shipyard,1582998607).

castable(archaelogist,ruins).

castable(treasure_hunter,ruins).

castable(visitor,ruins).

hashed(ruins,4262036409).

castable(priest,temple).

castable(follower,temple).

castable(monk,temple).

castable(high_priest,temple).

castable(parishioner,temple).

hashed(temple,879915311).

castable(vendor,marketplace).

castable(enforcer,marketplace).

castable(pickpocket,marketplace).

castable(racketeer,marketplace).

castable(patron,marketplace).

hashed(marketplace,3230048862).

castable(regular,tavern).

castable(owner,tavern).

castable(barkeep,tavern).

castable(patron,tavern).

hashed(tavern,3315537531).

castable(student,classroom).

castable(professor,classroom).

castable(dean,classroom).

hashed(classroom,4155164408).

castable(guest,garden).

castable(gardener,garden).

castable(owner,garden).

castable(visitor,garden).

hashed(garden,2187367946).

trait(introvert).

trait(extrovert).

trait(curious).

trait(cautious).

trait(bully).

trait(carer).

trait(scholar).

trait(ignoramus).

trait(conscientious).

trait(careless).

trait(agreeable).

trait(critical).

trait(compassionate).

trait(indifferent).

trait(neurotic).

trait(confident).

trait(family_oriented).

trait(duty_bound).

trait(free_spirited).

trait(romantic).

trait(gruff).

trait(feral).

trait(comic).

trait(stern).

trait(rare_things_rare).

trait(xrare_things_xrare).

trait(do_more_specific_things).

go_to_propensity(go_to_location, 6, stay_in_confinement,Self, null, null, null, Location )  :- 
		is(Self, stay_in_confinement),
		is(Self,confined,Location).

trait(stay_in_confinement).

go_to_propensity(go_to_location, 1, visiting_places_you_like,Self, null, null, null, Location )  :- 
		is(Self, visiting_places_you_like),
		is(Self,tourist,Location).

trait(visiting_places_you_like).

go_to_propensity(go_to_location, 3, visiting_as_regular,Self, null, null, null, Location )  :- 
		is(Self, visiting_as_regular),
		is(Self,regular,Location).

trait(visiting_as_regular).

trait(romantic_towards_crush).

go_to_propensity(go_to_location, 3, stay_at_hometown,Self, null, null, null, Location )  :- 
		is(Self, stay_at_hometown),
		is(Self,hometown,V_Self_hometown), is(Location,hometown,V_Location_hometown), V_Self_hometown == V_Location_hometown.

trait(stay_at_hometown).

trait(do_role_specific_actions).

go_to_propensity(go_to_location, 5, go_to_locations_you_have_connection_with,Self, null, null, null, Location )  :- 
		is(Self, go_to_locations_you_have_connection_with),
		is(Self,connected,Location).

trait(go_to_locations_you_have_connection_with).

trait(no_pedophilia).

trait(family_ties).

trait(abusive_if_abusive).

trait(mean_to_people_you_dislike1).

trait(mean_to_people_you_dislike2).

trait(mean_to_people_you_dislike3).

trait(nice_to_people_you_like1).

trait(people_are_usually_serious).

trait(fail_when_interactin_with_person_who_dislikes_you1).

trait(fail_when_interactin_with_person_who_dislikes_you2).

trait(people_joke_with_joker).

status(likes).

is(Person,likes,Other,0) :- person(Person), person(Other), Person != Other, not is(Person,likes,Other,N), non_zero(N).

status(loves).

is(Person,loves,Other,0) :- person(Person), person(Other), Person != Other, not is(Person,loves,Other,N), non_zero(N).

status(respects).

is(Person,respects,Other,0) :- person(Person), person(Other), Person != Other, not is(Person,respects,Other,N), non_zero(N).

status(rivalry).

is(Person,rivalry,Other,0) :- person(Person), person(Other), Person != Other, not is(Person,rivalry,Other,N), non_zero(N).

status(dissapointed_in).

status(proud_of).

status(embarrassed_by).

status(protective_of).

status(friends_with).

status(abusiveness).

is(Person,abusiveness,0) :- person(Person), not is(Person,abusiveness,N), non_zero(N).

status(happiness).

is(Person,happiness,0) :- person(Person), not is(Person,happiness,N), non_zero(N).

status(anger).

is(Person,anger,0) :- person(Person), not is(Person,anger,N), non_zero(N).

status(tiredness).

is(Person,tiredness,0) :- person(Person), not is(Person,tiredness,N), non_zero(N).

status(sadness).

is(Person,sadness,0) :- person(Person), not is(Person,sadness,N), non_zero(N).

status(guilt).

is(Person,guilt,0) :- person(Person), not is(Person,guilt,N), non_zero(N).

status(shame).

is(Person,shame,0) :- person(Person), not is(Person,shame,N), non_zero(N).

status(self_worth).

is(Person,self_worth,0) :- person(Person), not is(Person,self_worth,N), non_zero(N).