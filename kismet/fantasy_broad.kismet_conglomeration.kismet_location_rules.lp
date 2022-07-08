castable(person,town).

hashed(town,1847986528).

castable(resident,house).

castable(guest,house).

hashed(house,1525629524).

castable(monarch,throne_room).

castable(chancellor,throne_room).

castable(royalty,throne_room).

castable(citizen,throne_room).

hashed(throne_room,2643431354).

castable(shipping_foreman,docks).

castable(dockworker,docks).

castable(prostitute,docks).

castable(fisher,docks).

castable(visitor,docks).

hashed(docks,2483392761).

castable(curator,auction_house).

castable(auctioneer,auction_house).

castable(patron,auction_house).

hashed(auction_house,251081).

castable(guest,ballroom).

castable(owner,ballroom).

castable(artist,ballroom).

hashed(ballroom,1584520778).

castable(visitor,quad).

hashed(quad,1335126987).

castable(miner,mine).

castable(foreman,mine).

hashed(mine,3320737235).

castable(elder,elders_house).

castable(visitor,elders_house).

hashed(elders_house,362118887).

castable(guard,dungeon).

castable(prisoner,dungeon).

hashed(dungeon,2937053838).

castable(impresario,opera_house).

castable(diva,opera_house).

castable(tourist,opera_house).

castable(bard,opera_house).

castable(patron,opera_house).

hashed(opera_house,3706091142).

castable(smith_apprentice,smith).

castable(smithy,smith).

castable(patron,smith).

hashed(smith,2641100780).

castable(sailor,boat).

castable(captain,boat).

castable(passenger,boat).

hashed(boat,1255492448).

castable(spy,thieves_den).

castable(thief,thieves_den).

castable(spy_master,thieves_den).

castable(master_thief,thieves_den).

hashed(thieves_den,1775384176).

castable(librarian,library).

castable(tutor,library).

castable(student,library).

castable(researcher,library).

castable(visitor,library).

hashed(library,54143779).

castable(guest,kitchen).

castable(chef,kitchen).

castable(worker,kitchen).

castable(owner,kitchen).

hashed(kitchen,2370621531).

castable(tourist,amphitheatre).

castable(bard,amphitheatre).

hashed(amphitheatre,1604642541).

castable(owner,shipyard).

castable(engineer,shipyard).

castable(ship_builder,shipyard).

castable(visitor,shipyard).

hashed(shipyard,2647912198).

castable(archaelogist,ruins).

castable(treasure_hunter,ruins).

castable(visitor,ruins).

hashed(ruins,2625148913).

castable(priest,temple).

castable(follower,temple).

castable(monk,temple).

castable(high_priest,temple).

castable(parishioner,temple).

hashed(temple,1874581559).

castable(vendor,marketplace).

castable(enforcer,marketplace).

castable(pickpocket,marketplace).

castable(racketeer,marketplace).

castable(patron,marketplace).

hashed(marketplace,1364753789).

castable(regular,tavern).

castable(owner,tavern).

castable(barkeep,tavern).

castable(patron,tavern).

hashed(tavern,739457759).

castable(student,classroom).

castable(professor,classroom).

castable(dean,classroom).

hashed(classroom,1300627446).

castable(guest,garden).

castable(gardener,garden).

castable(owner,garden).

castable(visitor,garden).

hashed(garden,1586387945).

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
		location(Location),
		is(Self, stay_in_confinement),
		is(Self,confined,Location).

trait(stay_in_confinement).

go_to_propensity(go_to_location, 1, visiting_places_you_like,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, visiting_places_you_like),
		is(Self,tourist,Location).

trait(visiting_places_you_like).

go_to_propensity(go_to_location, 3, visiting_as_regular,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, visiting_as_regular),
		is(Self,regular,Location).

trait(visiting_as_regular).

go_to_propensity(go_to_location, -3, thieves_go_around,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, thieves_go_around),
		is(Self,thief,Location).

trait(thieves_go_around).

go_to_propensity(go_to_location, -3, spies_go_around,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, spies_go_around),
		is(Self,spy,Location).

trait(spies_go_around).

trait(romantic_towards_crush).

go_to_propensity(go_to_location, 3, stay_at_hometown,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, stay_at_hometown),
		is(Self,hometown,V_Self_hometown), is(Location,hometown,V_Location_hometown), V_Self_hometown == V_Location_hometown.

trait(stay_at_hometown).

go_to_propensity(go_to_location, 3, make_chosen_one_connections_occur,Self, Other, null, null, Location )  :- 
		location(Location),
		is(Self, make_chosen_one_connections_occur),
		is(Self, chosen_one),
		is(Other, chosen_one),
		is(Other,connected,Location).

trait(make_chosen_one_connections_occur).

go_to_propensity(go_to_location, 2, go_where_people_you_like_go,Self, Other, null, null, Location )  :- 
		location(Location),
		is(Self, go_where_people_you_like_go),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 1,
		is(Other,connected,Location).

trait(go_where_people_you_like_go).

trait(chosen_ones_are_connected).

trait(do_role_specific_actions).

go_to_propensity(go_to_location, 5, go_to_locations_you_have_connection_with,Self, null, null, null, Location )  :- 
		location(Location),
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