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

propensity(talk, -3, introvert,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, introvert),
		is(ACTION_NAME,talk).

trait(introvert).

propensity(talk, 3, extrovert, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, extrovert),
		is(ACTION_NAME,talk).

trait(extrovert).

propensity(risky, 3, curious,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, curious),
		is(ACTION_NAME,risky).

trait(curious).

propensity(risky, -3, cautious, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, cautious),
		is(ACTION_NAME,risky).

trait(cautious).

propensity(mean, 3, bully,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, bully),
		is(ACTION_NAME,mean).

propensity(kind, -3, bully,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, bully),
		is(ACTION_NAME,kind).

trait(bully).

propensity(mean, -3, carer, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, carer),
		is(ACTION_NAME,mean).

propensity(kind, 3, carer, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, carer),
		is(ACTION_NAME,kind).

trait(carer).

propensity(scholarly, 3, scholar,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, scholar),
		is(ACTION_NAME,scholarly).

trait(scholar).

propensity(scholarly, -3, ignoramus, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, ignoramus),
		is(ACTION_NAME,scholarly).

trait(ignoramus).

propensity(thoughtful, 3, conscientious,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, conscientious),
		is(ACTION_NAME,thoughtful).

propensity(careless, -3, conscientious,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, conscientious),
		is(ACTION_NAME,careless).

trait(conscientious).

propensity(thoughtful, -3, careless, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, careless),
		is(ACTION_NAME,thoughtful).

propensity(careless, 3, careless, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, careless),
		is(ACTION_NAME,careless).

trait(careless).

propensity(agree, 3, agreeable,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, agreeable),
		is(ACTION_NAME,agree).

propensity(critical, -3, agreeable,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, agreeable),
		is(ACTION_NAME,critical).

trait(agreeable).

propensity(agree, -3, critical, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, critical),
		is(ACTION_NAME,agree).

propensity(critical, 3, critical, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, critical),
		is(ACTION_NAME,critical).

trait(critical).

propensity(thoughtful, 3, compassionate,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, compassionate),
		is(ACTION_NAME,thoughtful).

propensity(kind, 3, compassionate,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, compassionate),
		is(ACTION_NAME,kind).

propensity(mean, -3, compassionate,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, compassionate),
		is(ACTION_NAME,mean).

trait(compassionate).

propensity(thoughtful, -3, indifferent, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, indifferent),
		is(ACTION_NAME,thoughtful).

propensity(kind, -3, indifferent, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, indifferent),
		is(ACTION_NAME,kind).

propensity(mean, 3, indifferent, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, indifferent),
		is(ACTION_NAME,mean).

trait(indifferent).

propensity(worry, 3, neurotic,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, neurotic),
		is(ACTION_NAME,worry).

propensity(bold, -3, neurotic,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, neurotic),
		is(ACTION_NAME,bold).

trait(neurotic).

propensity(worry, -3, confident, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, confident),
		is(ACTION_NAME,worry).

propensity(bold, 3, confident, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, confident),
		is(ACTION_NAME,bold).

trait(confident).

propensity(thoughtful, 3, family_oriented,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_oriented),
		is(Self,related_to,Other),
		is(ACTION_NAME,thoughtful).

propensity(kind, 3, family_oriented,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_oriented),
		is(Self,related_to,Other),
		is(ACTION_NAME,kind).

propensity(mean, -3, family_oriented,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_oriented),
		is(Self,related_to,Other),
		is(ACTION_NAME,mean).

trait(family_oriented).

propensity(duty, 3, duty_bound,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, duty_bound),
		is(ACTION_NAME,duty).

propensity(free, -3, duty_bound,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, duty_bound),
		is(ACTION_NAME,free).

trait(duty_bound).

propensity(duty, -3, free_spirited, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, free_spirited),
		is(ACTION_NAME,duty).

propensity(free, 3, free_spirited, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, free_spirited),
		is(ACTION_NAME,free).

trait(free_spirited).

propensity(romance, 3, romantic,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, romantic),
		is(ACTION_NAME,romance).

trait(romantic).

propensity(critical, 3, gruff,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, gruff),
		is(ACTION_NAME,critical).

propensity(agree, 3, gruff,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, gruff),
		is(Self,likes,Other),
		is(ACTION_NAME,agree).

trait(gruff).

propensity(talk, -4, feral,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, feral),
		is(ACTION_NAME,talk).

propensity(risky, 3, feral,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, feral),
		is(ACTION_NAME,risky).

propensity(religious, -2, feral,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, feral),
		is(ACTION_NAME,religious).

trait(feral).

propensity(silly, 3, comic,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, comic),
		is(ACTION_NAME,silly).

propensity(thoughtful, -1, comic,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, comic),
		is(ACTION_NAME,thoughtful).

trait(comic).

propensity(silly, -3, stern, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, stern),
		is(ACTION_NAME,silly).

propensity(thoughtful, 1, stern, Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, stern),
		is(ACTION_NAME,thoughtful).

trait(stern).

propensity(rare, -3, rare_things_rare,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, rare_things_rare),
		is(ACTION_NAME,rare).

trait(rare_things_rare).

propensity(extremely_rare, -5, xrare_things_xrare,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, xrare_things_xrare),
		is(ACTION_NAME,extremely_rare).

trait(xrare_things_xrare).

propensity(specific, 3, do_more_specific_things,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, do_more_specific_things),
		is(ACTION_NAME,specific).

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

propensity(romance, 3, romantic_towards_crush,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, romantic_towards_crush),
		is(Self,crushing_on,Other),
		is(ACTION_NAME,romance).

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

propensity(tag_agnostic, 28, chosen_ones_are_connected,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, chosen_ones_are_connected),
		is(Self, chosen_one),
		is(Other, chosen_one),
		is(ACTION_NAME,tag_agnostic).

trait(chosen_ones_are_connected).

propensity(role_specific, 4, do_role_specific_actions,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, do_role_specific_actions),
		is(ACTION_NAME,role_specific).

trait(do_role_specific_actions).

go_to_propensity(go_to_location, 5, go_to_locations_you_have_connection_with,Self, null, null, null, Location )  :- 
		location(Location),
		is(Self, go_to_locations_you_have_connection_with),
		is(Self,connected,Location).

trait(go_to_locations_you_have_connection_with).

propensity(romance, -7, no_pedophilia,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, no_pedophilia),
		is(Self,age,V_Self_age), V_Self_age >= 18,
		is(Other,age,V_Other_age), V_Other_age <= 17,
		is(ACTION_NAME,romance).

trait(no_pedophilia).

propensity(thoughtful, 1, family_ties,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_ties),
		is(Self,related_to,Other),
		is(ACTION_NAME,thoughtful).

propensity(kind, 1, family_ties,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_ties),
		is(Self,related_to,Other),
		is(ACTION_NAME,kind).

propensity(mean, -1, family_ties,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_ties),
		is(Self,related_to,Other),
		is(ACTION_NAME,mean).

propensity(critical, 1, family_ties,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_ties),
		is(Self,related_to,Other),
		is(ACTION_NAME,critical).

propensity(romance, -7, family_ties,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, family_ties),
		is(Self,related_to,Other),
		is(ACTION_NAME,romance).

trait(family_ties).

propensity(mean, 3, abusive_if_abusive,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, abusive_if_abusive),
		is(Self,abusiveness,V_Self_abusiveness), V_Self_abusiveness >= 0,
		is(ACTION_NAME,mean).

propensity(abusive, 3, abusive_if_abusive,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, abusive_if_abusive),
		is(Self,abusivenss,V_Self_abusivenss), V_Self_abusivenss >= 0,
		is(ACTION_NAME,abusive).

trait(abusive_if_abusive).

propensity(mean, 1, mean_to_people_you_dislike1,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, mean_to_people_you_dislike1),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other <= -1,
		is(ACTION_NAME,mean).

trait(mean_to_people_you_dislike1).

propensity(mean, -2, mean_to_people_you_dislike2,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, mean_to_people_you_dislike2),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 3,
		is(ACTION_NAME,mean).

trait(mean_to_people_you_dislike2).

propensity(mean, -3, mean_to_people_you_dislike3,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, mean_to_people_you_dislike3),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 5,
		is(ACTION_NAME,mean).

trait(mean_to_people_you_dislike3).

propensity(mean, -1, nice_to_people_you_like1,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, nice_to_people_you_like1),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 1,
		is(ACTION_NAME,mean).

trait(nice_to_people_you_like1).

propensity(silly, -1, people_are_usually_serious,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, people_are_usually_serious),
		is(ACTION_NAME,silly).

trait(people_are_usually_serious).

propensity(failure, 1, fail_when_interactin_with_person_who_dislikes_you1,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, fail_when_interactin_with_person_who_dislikes_you1),
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self <= -1,
		is(ACTION_NAME,failure).

trait(fail_when_interactin_with_person_who_dislikes_you1).

propensity(failure, 2, fail_when_interactin_with_person_who_dislikes_you2,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, fail_when_interactin_with_person_who_dislikes_you2),
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self <= -3,
		is(ACTION_NAME,failure).

trait(fail_when_interactin_with_person_who_dislikes_you2).

propensity(silly, 1, people_joke_with_joker,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, people_joke_with_joker),
		is(Other, comic),
		is(ACTION_NAME,silly).

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

pattern(dislikes_friend,Self, Disliker, Friend) :-
	is(Self,likes,Friend,V_Self_likes_Friend), V_Self_likes_Friend >= 3,
	is(Disliker,likes,Friend,V_Disliker_likes_Friend), V_Disliker_likes_Friend <= -3,
	Self != Disliker,
	Self != Friend,
	Disliker != Friend.

pattern(non_joker,Character) :-
	is(Character, critical).

pattern(non_joker,Character) :-
	is(Character, stern).

pattern(non_joker,Character) :-
	is(Character, gruff).

pattern(has_connection,PersonA, PersonB) :-
	is(PersonA,likes,PersonB,V_PersonA_likes_PersonB), V_PersonA_likes_PersonB != 0,
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_connection,PersonA, PersonB) :-
	is(PersonA,loves,PersonB,V_PersonA_loves_PersonB), V_PersonA_loves_PersonB != 0,
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_connection,PersonA, PersonB) :-
	pattern(has_connection,PersonB,PersonA),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(lacking_connection,PersonA, PersonB) :-
	not pattern(has_connection,PersonA,PersonB),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_connection,PersonA,PersonB),
	pattern(has_connection,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_connection,PersonA,PersonB),
	pattern(has_path,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_path,PersonA,PersonB),
	pattern(has_connection,PersonB,PersonC),
	PersonA != PersonC.

pattern(has_path,PersonA, PersonC) :-
	pattern(has_path,PersonA,PersonB),
	pattern(has_path,PersonB,PersonC),
	PersonA != PersonC.

pattern(lacking_path,PersonA, PersonB) :-
	not pattern(has_path,PersonA,PersonB),
	is(PersonA, chosen_one),
	is(PersonB, chosen_one),
	PersonA != PersonB.