castable(person,town).

hashed(town,3800169534).

castable(resident,house).

castable(guest,house).

hashed(house,1411520087).

castable(monarch,throne_room).

castable(chancellor,throne_room).

castable(royalty,throne_room).

castable(citizen,throne_room).

hashed(throne_room,1867351542).

castable(shipping_foreman,docks).

castable(dockworker,docks).

castable(prostitute,docks).

castable(fisher,docks).

castable(visitor,docks).

hashed(docks,3084516114).

castable(curator,auction_house).

castable(auctioneer,auction_house).

castable(patron,auction_house).

hashed(auction_house,1225024184).

castable(guest,ballroom).

castable(owner,ballroom).

castable(artist,ballroom).

hashed(ballroom,1135972631).

castable(visitor,quad).

hashed(quad,3553595830).

castable(miner,mine).

castable(foreman,mine).

hashed(mine,1322758650).

castable(elder,elders_house).

castable(visitor,elders_house).

hashed(elders_house,369019926).

castable(guard,dungeon).

castable(prisoner,dungeon).

hashed(dungeon,2806081013).

castable(impresario,opera_house).

castable(diva,opera_house).

castable(tourist,opera_house).

castable(bard,opera_house).

castable(patron,opera_house).

hashed(opera_house,29699353).

castable(smith_apprentice,smith).

castable(smithy,smith).

castable(patron,smith).

hashed(smith,718066303).

castable(sailor,boat).

castable(captain,boat).

castable(passenger,boat).

hashed(boat,772218658).

castable(spy,thieves_den).

castable(thief,thieves_den).

castable(spy_master,thieves_den).

castable(master_thief,thieves_den).

hashed(thieves_den,3750230703).

castable(librarian,library).

castable(tutor,library).

castable(student,library).

castable(researcher,library).

castable(visitor,library).

hashed(library,3592829081).

castable(guest,kitchen).

castable(chef,kitchen).

castable(worker,kitchen).

castable(owner,kitchen).

hashed(kitchen,2428697072).

castable(tourist,amphitheatre).

castable(bard,amphitheatre).

hashed(amphitheatre,1860998799).

castable(owner,shipyard).

castable(engineer,shipyard).

castable(ship_builder,shipyard).

castable(visitor,shipyard).

hashed(shipyard,2855299008).

castable(archaelogist,ruins).

castable(treasure_hunter,ruins).

castable(visitor,ruins).

hashed(ruins,2324225451).

castable(priest,temple).

castable(follower,temple).

castable(monk,temple).

castable(high_priest,temple).

castable(parishioner,temple).

hashed(temple,4088116777).

castable(vendor,marketplace).

castable(enforcer,marketplace).

castable(pickpocket,marketplace).

castable(racketeer,marketplace).

castable(patron,marketplace).

hashed(marketplace,1140175054).

castable(regular,tavern).

castable(owner,tavern).

castable(barkeep,tavern).

castable(patron,tavern).

hashed(tavern,4025344891).

castable(student,classroom).

castable(professor,classroom).

castable(dean,classroom).

hashed(classroom,4132379938).

castable(guest,garden).

castable(gardener,garden).

castable(owner,garden).

castable(visitor,garden).

hashed(garden,379377716).

action(chit_chat, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(chit_chat,1336574860).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(chit_chat, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(chit_chat, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(chit_chat, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(chit_chat, Self, Other, null, null, null)).

is(chit_chat, talk).

visibility(chit_chat,0).

action(complain_to_and_make_annoyed, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		not is(Other, compassionate),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(complain_to_and_make_annoyed,2381398740).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y, occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

is(complain_to_and_make_annoyed, talk).

is(complain_to_and_make_annoyed, critical).

is(complain_to_and_make_annoyed, failure).

visibility(complain_to_and_make_annoyed,0).

action(complain_to_compassionate, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		not is(Other, compassionate),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(complain_to_compassionate,4214464871).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Other,self_worth,Y) :- is(Other,self_worth,X), X + 1 = Y, occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Other,self_worth,1) :- not is(Other,self_worth,_), occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

is(complain_to_compassionate, talk).

is(complain_to_compassionate, critical).

visibility(complain_to_compassionate,0).

action(flirt_at, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(flirt_at,2140170504).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(flirt_at, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y, occurred(action(flirt_at, Self, Other, null, null, null)).

update(Self,loves,Other,1) :- not is(Self,loves,Other,_), occurred(action(flirt_at, Self, Other, null, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(flirt_at, Self, Other, null, null, null)).

is(flirt_at, talk).

is(flirt_at, romance).

is(flirt_at, failure).

visibility(flirt_at,0).

action(flirt_with, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(flirt_with,3598476358).

update(Self,loves,Other,1) :- not is(Self,loves,Other,_), occurred(action(flirt_with, Self, Other, null, null, null)).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(flirt_with, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(flirt_with, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Other,loves,Self,1) :- not is(Other,loves,Self,_), occurred(action(flirt_with, Self, Other, null, null, null)).

is(flirt_with, talk).

is(flirt_with, romance).

visibility(flirt_with,0).

action(use_humor_to_spark_love, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(use_humor_to_spark_love,3245663595).

update(Self,loves,Other,1) :- not is(Self,loves,Other,_), occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,loves,Self,1) :- not is(Other,loves,Self,_), occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

add(Other,crushing_on,Self) :-occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

is(use_humor_to_spark_love, talk).

is(use_humor_to_spark_love, silly).

is(use_humor_to_spark_love, romance).

visibility(use_humor_to_spark_love,0).

action(be_open_about_crush, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,crushing_on,Other),
		is(Other,loves,Self,V_Other_loves_Self), V_Other_loves_Self >= 1,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(be_open_about_crush,1919687571).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Other,likes,Self,2) :- not is(Other,likes,Self,_), occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,likes,Other,2) :- not is(Self,likes,Other,_), occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,loves,Other,2) :- not is(Self,loves,Other,_), occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Other,loves,Self,2) :- not is(Other,loves,Self,_), occurred(action(be_open_about_crush, Self, Other, null, null, null)).

is(be_open_about_crush, romance).

is(be_open_about_crush, bold).

is(be_open_about_crush, specific).

visibility(be_open_about_crush,0).

action(be_open_about_crush_and_burn, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,crushing_on,Other),
		at(Other,Location),
		is(Other,loves,Self,V_Other_loves_Self), V_Other_loves_Self <= 0,
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(be_open_about_crush_and_burn,2947631759).

update(Self,self_worth,-2) :- not is(Self,self_worth,_), occurred(action(be_open_about_crush_and_burn, Self, Other, null, null, null)).

del(Self,crushing_on,Other) :-occurred(action(be_open_about_crush_and_burn, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 2 = Y, occurred(action(be_open_about_crush_and_burn, Self, Other, null, null, null)).

is(be_open_about_crush_and_burn, romance).

is(be_open_about_crush_and_burn, bold).

is(be_open_about_crush_and_burn, specific).

is(be_open_about_crush_and_burn, failure).

visibility(be_open_about_crush_and_burn,0).

action(develop_crush, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(develop_crush,1922679021).

add(Self,crushing_on,Other) :-occurred(action(develop_crush, Self, Other, null, null, null)).

is(develop_crush, romance).

visibility(develop_crush,0).

action(pine_over, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(pine_over,3873628287).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y, occurred(action(pine_over, Self, Other, null, null, null)).

update(Self,loves,Other,1) :- not is(Self,loves,Other,_), occurred(action(pine_over, Self, Other, null, null, null)).

is(pine_over, romance).

visibility(pine_over,0).

action(make_out_with, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(make_out_with,1804691420).

update(Self,loves,Other,1) :- not is(Self,loves,Other,_), occurred(action(make_out_with, Self, Other, null, null, null)).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(make_out_with, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(make_out_with, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Other,loves,Self,1) :- not is(Other,loves,Self,_), occurred(action(make_out_with, Self, Other, null, null, null)).

is(make_out_with, romance).

visibility(make_out_with,0).

action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null):-
		person(Self),person(Other),person(ThirdWheel),event(null),location(null),
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		at(ThirdWheel,Location),
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		is(Other,loves,ThirdWheel,V_Other_love_ThirdWheel), V_Other_love_ThirdWheel >= 3,
		is(ThirdWheel,loves,Other,V_ThirdWheel_love_Other), V_ThirdWheel_love_Other >= 3,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != ThirdWheel,
		Other != ThirdWheel,
		Self != null,
		Other != null,
		ThirdWheel != null.

hashed(blow_up_love_triangle,387638519).

update(Self,loves,ThirdWheel,-5) :- not is(Self,loves,ThirdWheel,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(ThirdWheel,likes,Self,Y) :- is(ThirdWheel,likes,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(ThirdWheel,loves,Self,-5) :- not is(ThirdWheel,loves,Self,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(ThirdWheel,loves,Self,Y) :- is(ThirdWheel,loves,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,loves,ThirdWheel,Y) :- is(Self,loves,ThirdWheel,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,loves,Self,-5) :- not is(Other,loves,Self,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,likes,Self,-5) :- not is(Other,likes,Self,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,ThirdWheel,Y) :- is(Self,likes,ThirdWheel,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,Other,-5) :- not is(Self,likes,Other,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(ThirdWheel,likes,Self,-5) :- not is(ThirdWheel,likes,Self,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,ThirdWheel,-5) :- not is(Self,likes,ThirdWheel,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,loves,Other,-5) :- not is(Self,loves,Other,_), occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

is(blow_up_love_triangle, talk).

is(blow_up_love_triangle, romance).

is(blow_up_love_triangle, angry).

visibility(blow_up_love_triangle,0).

action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null):-
		person(Self),person(Other),person(ThirdWheel),event(null),location(null),
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		at(ThirdWheel,Location),
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		is(Other,loves,ThirdWheel,V_Other_love_ThirdWheel), V_Other_love_ThirdWheel >= 3,
		is(ThirdWheel,loves,Other,V_ThirdWheel_love_Other), V_ThirdWheel_love_Other >= 3,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != ThirdWheel,
		Other != ThirdWheel,
		Self != null,
		Other != null,
		ThirdWheel != null.

hashed(plot_about_sabotaging_romantic_rival,2835350267).

update(Self,likes,ThirdWheel,-2) :- not is(Self,likes,ThirdWheel,_), occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

update(Self,likes,ThirdWheel,Y) :- is(Self,likes,ThirdWheel,X), X - 2 = Y, occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

update(Self,loves,ThirdWheel,Y) :- is(Self,loves,ThirdWheel,X), X - 2 = Y, occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

update(Self,loves,ThirdWheel,-2) :- not is(Self,loves,ThirdWheel,_), occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

is(plot_about_sabotaging_romantic_rival, talk).

is(plot_about_sabotaging_romantic_rival, romance).

is(plot_about_sabotaging_romantic_rival, angry).

visibility(plot_about_sabotaging_romantic_rival,0).

action(reject_romance, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other <= 0,
		is(Other,loves,Self,V_Other_loves_Self), V_Other_loves_Self >= 5,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(reject_romance,2547115293).

update(Other,shame,1) :- not is(Other,shame,_), occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X - 5 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,loves,Self,-5) :- not is(Other,loves,Self,_), occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,likes,Self,-5) :- not is(Other,likes,Self,_), occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 5 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,shame,Y) :- is(Other,shame,X), X + 1 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,self_worth,Y) :- is(Other,self_worth,X), X - 1 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,self_worth,-1) :- not is(Other,self_worth,_), occurred(action(reject_romance, Self, Other, null, null, null)).

is(reject_romance, talk).

visibility(reject_romance,0).

action(insult_as_bully, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		is(Self, bully),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(insult_as_bully,215336335).

update(Other,likes,Self,-3) :- not is(Other,likes,Self,_), occurred(action(insult_as_bully, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(insult_as_bully, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(insult_as_bully, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 3 = Y, occurred(action(insult_as_bully, Self, Other, null, null, null)).

is(insult_as_bully, talk).

is(insult_as_bully, mean).

is(insult_as_bully, specific).

visibility(insult_as_bully,0).

action(insult, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		not is(Self, bully),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(insult,1603281319).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 1 = Y, occurred(action(insult, Self, Other, null, null, null)).

update(Other,likes,Self,-3) :- not is(Other,likes,Self,_), occurred(action(insult, Self, Other, null, null, null)).

update(Self,self_worth,-1) :- not is(Self,self_worth,_), occurred(action(insult, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 3 = Y, occurred(action(insult, Self, Other, null, null, null)).

is(insult, talk).

is(insult, mean).

visibility(insult,0).

action(sulk, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		is(Self,self_worth,V_Self_self_worth), V_Self_self_worth <= -3,
		at(Self,Location),
		Self != null.

hashed(sulk,775693756).

is(sulk, worry).

visibility(sulk,0).

action(have_catharsis, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		is(Self,self_worth,V_Self_self_worth), V_Self_self_worth <= -3,
		at(Self,Location),
		Self != null.

hashed(have_catharsis,2589427597).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(have_catharsis, Self, null, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(have_catharsis, Self, null, null, null, null)).

is(have_catharsis, thoughtful).

visibility(have_catharsis,0).

action(try_to_help_struggling_friend, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 3,
		at(Other,Location),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -3,
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self >= 3,
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(try_to_help_struggling_friend,3704657214).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

is(try_to_help_struggling_friend, thoughtful).

visibility(try_to_help_struggling_friend,0).

action(help_struggling_friend, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -3,
		is(Other,likes,Self,V_Other_like_Self), V_Other_like_Self >= 3,
		at(Other,Location),
		is(Self,likes,Other,V_Self_like_Other), V_Self_like_Other >= 3,
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(help_struggling_friend,1083074627).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(help_struggling_friend, Self, Other, null, null, null)).

is(help_struggling_friend, kind).

is(help_struggling_friend, thoughtful).

is(help_struggling_friend, specific).

visibility(help_struggling_friend,0).

action(share_personal_info, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(share_personal_info,2076857331).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(share_personal_info, Self, Other, null, null, null)).

add(Other,knows_personal_info_about,Self) :-occurred(action(share_personal_info, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(share_personal_info, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(share_personal_info, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(share_personal_info, Self, Other, null, null, null)).

is(share_personal_info, talk).

is(share_personal_info, bold).

is(share_personal_info, thoughtful).

visibility(share_personal_info,0).

action(help_really_struggling_person, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -5,
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(help_really_struggling_person,3028796889).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

is(help_really_struggling_person, kind).

is(help_really_struggling_person, thoughtful).

visibility(help_really_struggling_person,0).

action(joke_around_with, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(joke_around_with,2892635524).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(joke_around_with, Self, Other, null, null, null)).

update(Other,likes,Self,2) :- not is(Other,likes,Self,_), occurred(action(joke_around_with, Self, Other, null, null, null)).

update(Self,likes,Other,2) :- not is(Self,likes,Other,_), occurred(action(joke_around_with, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 2 = Y,occurred(action(joke_around_with, Self, Other, null, null, null)).

is(joke_around_with, talk).

is(joke_around_with, silly).

visibility(joke_around_with,0).

action(joke_around_with_the_wrong_person, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		pattern(non_joker,Other),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(joke_around_with_the_wrong_person,163203617).

update(Other,likes,Self,-2) :- not is(Other,likes,Self,_), occurred(action(joke_around_with_the_wrong_person, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 2 = Y, occurred(action(joke_around_with_the_wrong_person, Self, Other, null, null, null)).

is(joke_around_with_the_wrong_person, talk).

is(joke_around_with_the_wrong_person, silly).

is(joke_around_with_the_wrong_person, specific).

is(joke_around_with_the_wrong_person, failure).

visibility(joke_around_with_the_wrong_person,0).

action(criticize, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(criticize,355166778).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(criticize, Self, Other, null, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(criticize, Self, Other, null, null, null)).

is(criticize, talk).

is(criticize, critical).

visibility(criticize,0).

action(provide_critical_feedback, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other, agreeable),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(provide_critical_feedback,394681101).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

is(provide_critical_feedback, talk).

is(provide_critical_feedback, critical).

is(provide_critical_feedback, specific).

visibility(provide_critical_feedback,0).

action(get_into_argument, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other <= -1,
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self <= -1,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(get_into_argument,1759995397).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(get_into_argument, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y,occurred(action(get_into_argument, Self, Other, null, null, null)).

update(Self,likes,Other,-1) :- not is(Self,likes,Other,_), occurred(action(get_into_argument, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 1 = Y,occurred(action(get_into_argument, Self, Other, null, null, null)).

is(get_into_argument, talk).

is(get_into_argument, critical).

visibility(get_into_argument,0).

action(impress, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(impress,3684499232).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(impress, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(impress, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(impress, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(impress, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(impress, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(impress, Self, Other, null, null, null)).

is(impress, talk).

is(impress, bold).

visibility(impress,0).

action(try_to_impress_and_fail, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(try_to_impress_and_fail,736206312).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y,occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Self,self_worth,-1) :- not is(Self,self_worth,_), occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 1 = Y,occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Self,likes,Other,-1) :- not is(Self,likes,Other,_), occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 1 = Y, occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

is(try_to_impress_and_fail, talk).

is(try_to_impress_and_fail, bold).

is(try_to_impress_and_fail, failure).

visibility(try_to_impress_and_fail,0).

action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null):-
		person(Self),person(Other),person(Friend),event(null),location(null),
		pattern(dislikes_friend,Self,Other,Friend),
		at(Self,Location_0),
		at(Other,Location_0),
		Self != Other,
		Self != Friend,
		Other != Friend,
		Self != null,
		Other != null,
		Friend != null.

hashed(stand_up_for_friend_and_persuade,2976026792).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Other,likes,Friend,Y) :- is(Other,likes,Friend,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Friend,likes,Self,1) :- not is(Friend,likes,Self,_), occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Friend,likes,Self,Y) :- is(Friend,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Other,likes,Friend,1) :- not is(Other,likes,Friend,_), occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

is(stand_up_for_friend_and_persuade, talk).

is(stand_up_for_friend_and_persuade, bold).

visibility(stand_up_for_friend_and_persuade,0).

action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null):-
		person(Self),person(Other),person(Friend),event(null),location(null),
		pattern(dislikes_friend,Self,Other,Friend),
		at(Self,Location_0),
		at(Other,Location_0),
		Self != Other,
		Self != Friend,
		Other != Friend,
		Self != null,
		Other != null,
		Friend != null.

hashed(stand_up_for_friend_and_fail,2299727178).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Other,likes,Friend,Y) :- is(Other,likes,Friend,X), X - 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Friend,likes,Self,1) :- not is(Friend,likes,Self,_), occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Friend,likes,Self,Y) :- is(Friend,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Other,likes,Friend,-1) :- not is(Other,likes,Friend,_), occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

is(stand_up_for_friend_and_fail, talk).

is(stand_up_for_friend_and_fail, bold).

is(stand_up_for_friend_and_fail, failure).

visibility(stand_up_for_friend_and_fail,0).

action(pray, Monk, null, null, null, null):-
		person(Monk),person(null),person(null),event(null),location(null),
		at(Monk,Location),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		Monk != null.

hashed(pray,3931282229).

update(Monk,devotion,1) :- not is(Monk,devotion,_), occurred(action(pray, Monk, null, null, null, null)).

update(Monk,devotion,Y) :- is(Monk,devotion,X), X + 1 = Y, occurred(action(pray, Monk, null, null, null, null)).

is(pray, religious).

is(pray, role_specific).

visibility(pray,0).

action(pray_with_follower, Monk, Follower, null, null, null):-
		person(Monk),person(Follower),person(null),event(null),location(null),
		is(Monk,monk,RoleLocation),
		at(Follower,RoleLocation),
		at(Follower,Location),
		at(Monk,RoleLocation),
		at(Monk,Location),
		is(Follower,follower,RoleLocation),
		Monk != Follower,
		Monk != null,
		Follower != null.

hashed(pray_with_follower,2796360415).

update(Monk,devotion,1) :- not is(Monk,devotion,_), occurred(action(pray_with_follower, Monk, Follower, null, null, null)).

update(Follower,devotion,1) :- not is(Follower,devotion,_), occurred(action(pray_with_follower, Monk, Follower, null, null, null)).

update(Follower,devotion,Y) :- is(Follower,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Monk, Follower, null, null, null)).

update(Monk,devotion,Y) :- is(Monk,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Monk, Follower, null, null, null)).

is(pray_with_follower, religious).

is(pray_with_follower, role_specific).

visibility(pray_with_follower,0).

action(perform_ritual, Monk, Other, null, null, null):-
		person(Monk),person(Other),person(null),event(null),location(null),
		at(Monk,Location),
		is(Monk,monk,RoleLocation),
		at(Monk,RoleLocation),
		is(Other,monk,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		Monk != Other,
		Monk != null,
		Other != null.

hashed(perform_ritual,2944216161).

update(Other,devotion,Y) :- is(Other,devotion,X), X + 2 = Y, occurred(action(perform_ritual, Monk, Other, null, null, null)).

update(Other,devotion,2) :- not is(Other,devotion,_), occurred(action(perform_ritual, Monk, Other, null, null, null)).

update(Monk,devotion,Y) :- is(Monk,devotion,X), X + 2 = Y, occurred(action(perform_ritual, Monk, Other, null, null, null)).

update(Monk,devotion,2) :- not is(Monk,devotion,_), occurred(action(perform_ritual, Monk, Other, null, null, null)).

is(perform_ritual, religious).

is(perform_ritual, role_specific).

visibility(perform_ritual,0).

action(screw_up_ritual, Monk, Other, null, null, null):-
		person(Monk),person(Other),person(null),event(null),location(null),
		at(Monk,Location),
		is(Monk,monk,RoleLocation),
		at(Monk,RoleLocation),
		is(Other,monk,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		Monk != Other,
		Monk != null,
		Other != null.

hashed(screw_up_ritual,93686947).

update(Other,likes,Monk,Y) :- is(Other,likes,Monk,X), X - 2 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Other,likes,Monk,-2) :- not is(Other,likes,Monk,_), occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Monk,devotion,-1) :- not is(Monk,devotion,_), occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Other,devotion,Y) :- is(Other,devotion,X), X - 1 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Monk,devotion,Y) :- is(Monk,devotion,X), X - 1 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Other,devotion,-1) :- not is(Other,devotion,_), occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

is(screw_up_ritual, religious).

is(screw_up_ritual, failure).

is(screw_up_ritual, role_specific).

visibility(screw_up_ritual,0).

action(have_crisis_of_faith, Monk, null, null, null, null):-
		person(Monk),person(null),person(null),event(null),location(null),
		at(Monk,Location),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		Monk != null.

hashed(have_crisis_of_faith,2277869169).

update(Monk,self_worth,-1) :- not is(Monk,self_worth,_), occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

update(Monk,self_worth,Y) :- is(Monk,self_worth,X), X - 1 = Y, occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

update(Monk,devotion,-2) :- not is(Monk,devotion,_), occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

update(Monk,devotion,Y) :- is(Monk,devotion,X), X - 2 = Y, occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

is(have_crisis_of_faith, religious).

is(have_crisis_of_faith, worry).

is(have_crisis_of_faith, role_specific).

visibility(have_crisis_of_faith,0).

action(manage_mine, Foreman, null, null, null, null):-
		person(Foreman),person(null),person(null),event(null),location(null),
		at(Foreman,Location),
		at(Foreman,RoleLocation),
		is(Foreman,foreman,RoleLocation),
		Foreman != null.

hashed(manage_mine,2688877511).

is(manage_mine, work).

is(manage_mine, role_specific).

visibility(manage_mine,0).

action(boss_miner_around, Foreman, Miner, null, null, null):-
		person(Foreman),person(Miner),person(null),event(null),location(null),
		at(Miner,RoleLocation),
		at(Foreman,Location),
		at(Foreman,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		Foreman != Miner,
		Foreman != null,
		Miner != null.

hashed(boss_miner_around,912733249).

update(Miner,likes,Foreman,-1) :- not is(Miner,likes,Foreman,_), occurred(action(boss_miner_around, Foreman, Miner, null, null, null)).

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X - 1 = Y, occurred(action(boss_miner_around, Foreman, Miner, null, null, null)).

is(boss_miner_around, work).

is(boss_miner_around, critical).

is(boss_miner_around, role_specific).

visibility(boss_miner_around,0).

action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Miner2,Location),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		at(Foreman,Location),
		at(Foreman,RoleLocation),
		is(Miner,miner,RoleLocation),
		is(Miner2,likes,Miner,V_Miner2_likes_Miner), V_Miner2_likes_Miner <= -1,
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		is(Miner,likes,Miner2,V_Miner_likes_Miner2), V_Miner_likes_Miner2 <= -1,
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

hashed(manage_dispute_between_miners,512800837).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X + 1 = Y, occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X + 1 = Y, occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,1) :- not is(Miner,respects,Foreman,_), occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Miner,Y) :- is(Miner2,likes,Miner,X), X + 1 = Y,occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Miner2,Y) :- is(Miner,likes,Miner2,X), X + 1 = Y,occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,1) :- not is(Miner2,respects,Foreman,_), occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Miner2,1) :- not is(Miner,likes,Miner2,_), occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Miner,1) :- not is(Miner2,likes,Miner,_), occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

is(manage_dispute_between_miners, work).

is(manage_dispute_between_miners, thoughtful).

is(manage_dispute_between_miners, kind).

is(manage_dispute_between_miners, role_specific).

visibility(manage_dispute_between_miners,0).

action(endanger_miners, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Miner2,Location),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		at(Foreman,Location),
		at(Foreman,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

hashed(endanger_miners,1704736636).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,-2) :- not is(Miner,respects,Foreman,_), occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Foreman,-2) :- not is(Miner,likes,Foreman,_), occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,Y) :- is(Miner2,likes,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,-2) :- not is(Miner2,respects,Foreman,_), occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,-2) :- not is(Miner2,likes,Foreman,_), occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

is(endanger_miners, work).

is(endanger_miners, risky).

is(endanger_miners, role_specific).

visibility(endanger_miners,0).

action(strike_motherlode, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Miner2,Location),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		at(Foreman,Location),
		at(Foreman,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

hashed(strike_motherlode,39985803).

update(Miner2,respects,Foreman,2) :- not is(Miner2,respects,Foreman,_), occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Foreman,2) :- not is(Miner,likes,Foreman,_), occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,2) :- not is(Miner2,likes,Foreman,_), occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Foreman,self_worth,Y) :- is(Foreman,self_worth,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Foreman,self_worth,2) :- not is(Foreman,self_worth,_), occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,Y) :- is(Miner2,likes,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,2) :- not is(Miner,respects,Foreman,_), occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

is(strike_motherlode, work).

is(strike_motherlode, risky).

is(strike_motherlode, rare).

is(strike_motherlode, role_specific).

visibility(strike_motherlode,0).

action(work_at_mine, Miner, null, null, null, null):-
		person(Miner),person(null),person(null),event(null),location(null),
		at(Miner,RoleLocation),
		at(Miner,Location),
		is(Miner,miner,RoleLocation),
		Miner != null.

hashed(work_at_mine,1856089199).

update(Miner,tiredness,Y) :- is(Miner,tiredness,X), X + 1 = Y, occurred(action(work_at_mine, Miner, null, null, null, null)).

update(Miner,tiredness,1) :- not is(Miner,tiredness,_), occurred(action(work_at_mine, Miner, null, null, null, null)).

is(work_at_mine, work).

is(work_at_mine, role_specific).

visibility(work_at_mine,0).

action(hold_auction, Auctioneer, P1, P2, null, null):-
		person(Auctioneer),person(P1),person(P2),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		at(P1,RoleLocation),
		at(P1,Location),
		at(P2,RoleLocation),
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		is(P1,patron,RoleLocation),
		at(P2,Location),
		is(P2,patron,RoleLocation),
		Auctioneer != P1,
		Auctioneer != P2,
		P1 != P2,
		Auctioneer != null,
		P1 != null,
		P2 != null.

hashed(hold_auction,3841656780).

update(P1,self_worth,1) :- not is(P1,self_worth,_), occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

update(P1,self_worth,Y) :- is(P1,self_worth,X), X + 1 = Y, occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

update(Auctioneer,self_worth,1) :- not is(Auctioneer,self_worth,_), occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

update(Auctioneer,self_worth,Y) :- is(Auctioneer,self_worth,X), X + 1 = Y, occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

is(hold_auction, work).

is(hold_auction, bold).

is(hold_auction, talk).

is(hold_auction, role_specific).

visibility(hold_auction,0).

action(discuss_collection, Auctioneer, Curator, null, null, null):-
		person(Auctioneer),person(Curator),person(null),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		at(Curator,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		at(Curator,Location),
		Auctioneer != Curator,
		Auctioneer != null,
		Curator != null.

hashed(discuss_collection,2577658550).

update(Curator,likes,Auctioneer,1) :- not is(Curator,likes,Auctioneer,_), occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

update(Auctioneer,likes,Curator,1) :- not is(Auctioneer,likes,Curator,_), occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

update(Curator,likes,Auctioneer,Y) :- is(Curator,likes,Auctioneer,X), X + 1 = Y,occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

update(Auctioneer,likes,Curator,Y) :- is(Auctioneer,likes,Curator,X), X + 1 = Y,occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

is(discuss_collection, work).

is(discuss_collection, talk).

is(discuss_collection, thoughtful).

is(discuss_collection, role_specific).

visibility(discuss_collection,0).

action(demand_a_new_piece, Auctioneer, Curator, null, null, null):-
		person(Auctioneer),person(Curator),person(null),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		at(Curator,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		at(Curator,Location),
		Auctioneer != Curator,
		Auctioneer != null,
		Curator != null.

hashed(demand_a_new_piece,1990235508).

update(Auctioneer,likes,Curator,-2) :- not is(Auctioneer,likes,Curator,_), occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

update(Auctioneer,likes,Curator,Y) :- is(Auctioneer,likes,Curator,X), X - 2 = Y,occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

update(Curator,likes,Auctioneer,-2) :- not is(Curator,likes,Auctioneer,_), occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

update(Curator,likes,Auctioneer,Y) :- is(Curator,likes,Auctioneer,X), X - 2 = Y,occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

is(demand_a_new_piece, work).

is(demand_a_new_piece, talk).

is(demand_a_new_piece, mean).

visibility(demand_a_new_piece,0).

action(curate_collection, Curator, null, null, null, null):-
		person(Curator),person(null),person(null),event(null),location(null),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		at(Curator,RoleLocation),
		Curator != null.

hashed(curate_collection,234812890).

is(curate_collection, work).

is(curate_collection, role_specific).

visibility(curate_collection,0).

action(acquire_artifacts, Curator, null, null, null, null):-
		person(Curator),person(null),person(null),event(null),location(null),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		at(Curator,RoleLocation),
		Curator != null.

hashed(acquire_artifacts,161797026).

update(Curator,self_worth,Y) :- is(Curator,self_worth,X), X + 1 = Y, occurred(action(acquire_artifacts, Curator, null, null, null, null)).

update(Curator,self_worth,1) :- not is(Curator,self_worth,_), occurred(action(acquire_artifacts, Curator, null, null, null, null)).

is(acquire_artifacts, work).

is(acquire_artifacts, bold).

is(acquire_artifacts, role_specific).

visibility(acquire_artifacts,0).

action(discuss_collection, Curator, Other, null, null, null):-
		person(Curator),person(Other),person(null),event(null),location(null),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		at(Other,Location),
		at(Curator,RoleLocation),
		Curator != Other,
		Curator != null,
		Other != null.

hashed(discuss_collection,2577658550).

update(Other,respects,Curator,1) :- not is(Other,respects,Curator,_), occurred(action(discuss_collection, Curator, Other, null, null, null)).

update(Other,respects,Curator,Y) :- is(Other,respects,Curator,X), X + 1 = Y, occurred(action(discuss_collection, Curator, Other, null, null, null)).

is(discuss_collection, work).

is(discuss_collection, talk).

is(discuss_collection, role_specific).

visibility(discuss_collection,0).

action(sell_wares, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		Vendor != Other,
		Vendor != null,
		Other != null.

hashed(sell_wares,2669237980).

update(Vendor,likes,Other,Y) :- is(Vendor,likes,Other,X), X + 1 = Y, occurred(action(sell_wares, Vendor, Other, null, null, null)).

update(Vendor,likes,Other,1) :- not is(Vendor,likes,Other,_), occurred(action(sell_wares, Vendor, Other, null, null, null)).

is(sell_wares, work).

is(sell_wares, role_specific).

visibility(sell_wares,0).

action(give_deal_to, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		is(Vendor,vendor,RoleLocation),
		is(Vendor,likes,Other,V_Vendor_likes_Other), V_Vendor_likes_Other >= 3,
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		at(Other,Location),
		Vendor != Other,
		Vendor != null,
		Other != null.

hashed(give_deal_to,518462650).

update(Other,likes,Vendor,Y) :- is(Other,likes,Vendor,X), X + 2 = Y, occurred(action(give_deal_to, Vendor, Other, null, null, null)).

update(Other,likes,Vendor,2) :- not is(Other,likes,Vendor,_), occurred(action(give_deal_to, Vendor, Other, null, null, null)).

is(give_deal_to, work).

is(give_deal_to, kind).

is(give_deal_to, talk).

is(give_deal_to, role_specific).

visibility(give_deal_to,0).

action(hustle, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		is(Vendor,likes,Other,V_Vendor_likes_Other), V_Vendor_likes_Other <= 0,
		Vendor != Other,
		Vendor != null,
		Other != null.

hashed(hustle,1222364103).

update(Other,likes,Vendor,Y) :- is(Other,likes,Vendor,X), X - 1 = Y, occurred(action(hustle, Vendor, Other, null, null, null)).

update(Vendor,self_worth,1) :- not is(Vendor,self_worth,_), occurred(action(hustle, Vendor, Other, null, null, null)).

update(Vendor,self_worth,Y) :- is(Vendor,self_worth,X), X + 1 = Y, occurred(action(hustle, Vendor, Other, null, null, null)).

update(Other,likes,Vendor,-1) :- not is(Other,likes,Vendor,_), occurred(action(hustle, Vendor, Other, null, null, null)).

is(hustle, work).

is(hustle, bold).

is(hustle, mean).

is(hustle, risky).

is(hustle, role_specific).

visibility(hustle,0).

action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null):-
		person(Vendor),person(OtherVendor),person(null),event(null),location(null),
		is(Vendor,vendor,RoleLocation),
		at(OtherVendor,Location),
		at(OtherVendor,RoleLocation),
		at(Vendor,Location),
		at(Vendor,RoleLocation),
		is(OtherVendor,vendor,RoleLocation),
		Vendor != OtherVendor,
		Vendor != null,
		OtherVendor != null.

hashed(commiserate_with_fellow_vendor,3311961919).

update(OtherVendor,likes,Vendor,Y) :- is(OtherVendor,likes,Vendor,X), X + 1 = Y,occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

update(Vendor,likes,OtherVendor,Y) :- is(Vendor,likes,OtherVendor,X), X + 1 = Y,occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

update(OtherVendor,likes,Vendor,1) :- not is(OtherVendor,likes,Vendor,_), occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

update(Vendor,likes,OtherVendor,1) :- not is(Vendor,likes,OtherVendor,_), occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

is(commiserate_with_fellow_vendor, work).

is(commiserate_with_fellow_vendor, talk).

is(commiserate_with_fellow_vendor, thoughtful).

is(commiserate_with_fellow_vendor, kind).

is(commiserate_with_fellow_vendor, role_specific).

visibility(commiserate_with_fellow_vendor,0).

action(undercut, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		is(Vendor,likes,Other,V_Vendor_likes_Other), V_Vendor_likes_Other <= 0,
		at(Other,Location),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		at(Other,RoleLocation),
		is(Other,vendor,RoleLocation),
		Vendor != Other,
		Vendor != null,
		Other != null.

hashed(undercut,3007419630).

update(Other,likes,Vendor,Y) :- is(Other,likes,Vendor,X), X - 1 = Y, occurred(action(undercut, Vendor, Other, null, null, null)).

update(Vendor,self_worth,1) :- not is(Vendor,self_worth,_), occurred(action(undercut, Vendor, Other, null, null, null)).

update(Vendor,self_worth,Y) :- is(Vendor,self_worth,X), X + 1 = Y, occurred(action(undercut, Vendor, Other, null, null, null)).

update(Other,likes,Vendor,-1) :- not is(Other,likes,Vendor,_), occurred(action(undercut, Vendor, Other, null, null, null)).

is(undercut, work).

is(undercut, bold).

is(undercut, mean).

is(undercut, role_specific).

visibility(undercut,0).

action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null):-
		person(Vendor),person(OtherVendor),person(Enforcer),event(null),location(null),
		at(Enforcer,Location),
		is(Vendor,vendor,RoleLocation),
		at(OtherVendor,Location),
		is(Vendor,fears,Enforcer,V_Vendor_fears_Enforcer), V_Vendor_fears_Enforcer >= 6,
		at(OtherVendor,RoleLocation),
		at(Vendor,Location),
		at(Vendor,RoleLocation),
		is(OtherVendor,vendor,RoleLocation),
		is(OtherVendor,fears,Enforcer,V_OtherVendor_fears_Enforcer), V_OtherVendor_fears_Enforcer >= 6,
		Vendor != OtherVendor,
		Vendor != Enforcer,
		OtherVendor != Enforcer,
		Vendor != null,
		OtherVendor != null,
		Enforcer != null.

hashed(standup_to_enforcer_together,560471647).

update(Enforcer,likes,Vendor,-3) :- not is(Enforcer,likes,Vendor,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Vendor,fears,Enforcer,-3) :- not is(Vendor,fears,Enforcer,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,fears,Enforcer,Y) :- is(OtherVendor,fears,Enforcer,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Enforcer,likes,OtherVendor,-3) :- not is(Enforcer,likes,OtherVendor,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Vendor,fears,Enforcer,Y) :- is(Vendor,fears,Enforcer,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Enforcer,likes,OtherVendor,Y) :- is(Enforcer,likes,OtherVendor,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Vendor,likes,OtherVendor,5) :- not is(Vendor,likes,OtherVendor,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Vendor,likes,OtherVendor,Y) :- is(Vendor,likes,OtherVendor,X), X + 5 = Y,occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Enforcer,likes,Vendor,Y) :- is(Enforcer,likes,Vendor,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,fears,Enforcer,-3) :- not is(OtherVendor,fears,Enforcer,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,likes,Vendor,Y) :- is(OtherVendor,likes,Vendor,X), X + 5 = Y,occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,likes,Vendor,5) :- not is(OtherVendor,likes,Vendor,_), occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

is(standup_to_enforcer_together, work).

is(standup_to_enforcer_together, bold).

is(standup_to_enforcer_together, role_specific).

visibility(standup_to_enforcer_together,0).

action(collect_protection_fees, Enforcer, Vendor, null, null, null):-
		person(Enforcer),person(Vendor),person(null),event(null),location(null),
		at(Enforcer,Location),
		is(Vendor,vendor,RoleLocation),
		at(Enforcer,RoleLocation),
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		is(Enforcer,enforcer,RoleLocation),
		Enforcer != Vendor,
		Enforcer != null,
		Vendor != null.

hashed(collect_protection_fees,79564020).

update(Vendor,likes,Enforcer,Y) :- is(Vendor,likes,Enforcer,X), X - 1 = Y, occurred(action(collect_protection_fees, Enforcer, Vendor, null, null, null)).

update(Vendor,likes,Enforcer,-1) :- not is(Vendor,likes,Enforcer,_), occurred(action(collect_protection_fees, Enforcer, Vendor, null, null, null)).

is(collect_protection_fees, work).

is(collect_protection_fees, mean).

is(collect_protection_fees, risky).

is(collect_protection_fees, criminal).

is(collect_protection_fees, role_specific).

visibility(collect_protection_fees,0).

action(rough_up, Enforcer, Vendor, null, null, null):-
		person(Enforcer),person(Vendor),person(null),event(null),location(null),
		at(Enforcer,Location),
		is(Vendor,vendor,RoleLocation),
		at(Enforcer,RoleLocation),
		at(Vendor,RoleLocation),
		at(Vendor,Location),
		is(Enforcer,enforcer,RoleLocation),
		Enforcer != Vendor,
		Enforcer != null,
		Vendor != null.

hashed(rough_up,1628287899).

update(Vendor,fears,Enforcer,2) :- not is(Vendor,fears,Enforcer,_), occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

update(Vendor,fears,Enforcer,Y) :- is(Vendor,fears,Enforcer,X), X + 2 = Y, occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

update(Vendor,likes,Enforcer,-2) :- not is(Vendor,likes,Enforcer,_), occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

update(Vendor,likes,Enforcer,Y) :- is(Vendor,likes,Enforcer,X), X - 2 = Y, occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

is(rough_up, work).

is(rough_up, mean).

is(rough_up, risky).

is(rough_up, criminal).

is(rough_up, role_specific).

visibility(rough_up,0).

action(load_cargo, Dockworker, null, null, null, null):-
		person(Dockworker),person(null),person(null),event(null),location(null),
		at(Dockworker,RoleLocation),
		is(Dockworker,dockworker,RoleLocation),
		at(Dockworker,Location),
		Dockworker != null.

hashed(load_cargo,2347310783).

update(Dockworker,tiredness,1) :- not is(Dockworker,tiredness,_), occurred(action(load_cargo, Dockworker, null, null, null, null)).

update(Dockworker,tiredness,Y) :- is(Dockworker,tiredness,X), X + 1 = Y, occurred(action(load_cargo, Dockworker, null, null, null, null)).

is(load_cargo, work).

is(load_cargo, role_specific).

visibility(load_cargo,0).

action(fight_seagull, Dockworker, null, null, null, null):-
		person(Dockworker),person(null),person(null),event(null),location(null),
		at(Dockworker,RoleLocation),
		is(Dockworker,dockworker,RoleLocation),
		at(Dockworker,Location),
		Dockworker != null.

hashed(fight_seagull,1993617866).

update(Dockworker,anger,Y) :- is(Dockworker,anger,X), X + 1 = Y, occurred(action(fight_seagull, Dockworker, null, null, null, null)).

update(Dockworker,anger,1) :- not is(Dockworker,anger,_), occurred(action(fight_seagull, Dockworker, null, null, null, null)).

is(fight_seagull, angry).

is(fight_seagull, rare).

is(fight_seagull, role_specific).

visibility(fight_seagull,0).

action(stock_books, Librarian, null, null, null, null):-
		person(Librarian),person(null),person(null),event(null),location(null),
		is(Librarian,librarian,RoleLocation),
		at(Librarian,RoleLocation),
		at(Librarian,Location),
		Librarian != null.

hashed(stock_books,1545851660).

update(Librarian,tiredness,Y) :- is(Librarian,tiredness,X), X + 1 = Y, occurred(action(stock_books, Librarian, null, null, null, null)).

update(Librarian,tiredness,1) :- not is(Librarian,tiredness,_), occurred(action(stock_books, Librarian, null, null, null, null)).

is(stock_books, work).

is(stock_books, scholarly).

is(stock_books, role_specific).

visibility(stock_books,0).

action(shush_patron, Librarian, Patron, null, null, null):-
		person(Librarian),person(Patron),person(null),event(null),location(null),
		at(Librarian,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		is(Patron,guest,RoleLocation),
		at(Patron,Location),
		at(Patron,RoleLocation),
		at(Librarian,Location),
		Librarian != Patron,
		Librarian != null,
		Patron != null.

hashed(shush_patron,1837238394).

update(Patron,shame,Y) :- is(Patron,shame,X), X + 1 = Y, occurred(action(shush_patron, Librarian, Patron, null, null, null)).

update(Patron,likes,Librarian,-1) :- not is(Patron,likes,Librarian,_), occurred(action(shush_patron, Librarian, Patron, null, null, null)).

update(Patron,likes,Librarian,Y) :- is(Patron,likes,Librarian,X), X - 1 = Y, occurred(action(shush_patron, Librarian, Patron, null, null, null)).

update(Patron,shame,1) :- not is(Patron,shame,_), occurred(action(shush_patron, Librarian, Patron, null, null, null)).

is(shush_patron, work).

is(shush_patron, mean).

is(shush_patron, bold).

is(shush_patron, role_specific).

visibility(shush_patron,0).

action(assist_research, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Librarian,RoleLocation),
		at(Researcher,RoleLocation),
		is(Researcher,researcher,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		at(Researcher,Location),
		at(Librarian,Location),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

hashed(assist_research,1793780394).

update(Researcher,likes,Librarian,1) :- not is(Researcher,likes,Librarian,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,1) :- not is(Librarian,self_worth,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,1) :- not is(Librarian,likes,Researcher,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

is(assist_research, work).

is(assist_research, scholarly).

is(assist_research, role_specific).

visibility(assist_research,0).

action(assist_research, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Librarian,RoleLocation),
		is(Researcher,guest,RoleLocation),
		at(Researcher,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		at(Researcher,Location),
		is(Researcher, scholar),
		at(Librarian,Location),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

hashed(assist_research,1793780394).

update(Researcher,likes,Librarian,1) :- not is(Researcher,likes,Librarian,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,1) :- not is(Librarian,self_worth,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,1) :- not is(Librarian,likes,Researcher,_), occurred(action(assist_research, Librarian, Researcher, null, null, null)).

is(assist_research, work).

is(assist_research, scholarly).

is(assist_research, role_specific).

visibility(assist_research,0).

action(assist_student, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Librarian,RoleLocation),
		at(Researcher,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		is(Researcher,student,RoleLocation),
		at(Researcher,Location),
		at(Librarian,Location),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

hashed(assist_student,1637575808).

update(Researcher,likes,Librarian,1) :- not is(Researcher,likes,Librarian,_), occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Librarian,self_worth,1) :- not is(Librarian,self_worth,_), occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,1) :- not is(Librarian,likes,Researcher,_), occurred(action(assist_student, Librarian, Researcher, null, null, null)).

is(assist_student, work).

is(assist_student, scholarly).

is(assist_student, role_specific).

visibility(assist_student,0).

action(acquire_ingredients, Chef, ShopOwner, null, null, null):-
		person(Chef),person(ShopOwner),person(null),event(null),location(null),
		is(ShopOwner,vendor,RoleLocation),
		is(Chef, chef),
		at(Chef,Location),
		at(ShopOwner,RoleLocation),
		at(ShopOwner,Location),
		Chef != ShopOwner,
		Chef != null,
		ShopOwner != null.

hashed(acquire_ingredients,1415760881).

update(Chef,likes,ShopOwner,1) :- not is(Chef,likes,ShopOwner,_), occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

update(Chef,likes,ShopOwner,Y) :- is(Chef,likes,ShopOwner,X), X + 1 = Y,occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

update(ShopOwner,likes,Chef,Y) :- is(ShopOwner,likes,Chef,X), X + 1 = Y,occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

update(ShopOwner,likes,Chef,1) :- not is(ShopOwner,likes,Chef,_), occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

is(acquire_ingredients, work).

is(acquire_ingredients, role_specific).

visibility(acquire_ingredients,0).

action(develop_recipe, Chef, null, null, null, null):-
		person(Chef),person(null),person(null),event(null),location(null),
		at(Chef,RoleLocation),
		at(Chef,Location),
		is(Chef,chef,RoleLocation),
		Chef != null.

hashed(develop_recipe,159477229).

update(Chef,self_worth,Y) :- is(Chef,self_worth,X), X + 1 = Y, occurred(action(develop_recipe, Chef, null, null, null, null)).

update(Chef,self_worth,1) :- not is(Chef,self_worth,_), occurred(action(develop_recipe, Chef, null, null, null, null)).

is(develop_recipe, work).

is(develop_recipe, role_specific).

visibility(develop_recipe,0).

action(boss_cooks_around, Chef, Cook, null, null, null):-
		person(Chef),person(Cook),person(null),event(null),location(null),
		at(Chef,Location),
		is(Chef,chef,RoleLocation),
		is(Cook,worker,RoleLocation),
		at(Cook,Location),
		at(Chef,RoleLocation),
		at(Cook,RoleLocation),
		Chef != Cook,
		Chef != null,
		Cook != null.

hashed(boss_cooks_around,2620117546).

update(Cook,likes,Chef,Y) :- is(Cook,likes,Chef,X), X - 1 = Y, occurred(action(boss_cooks_around, Chef, Cook, null, null, null)).

update(Cook,likes,Chef,-1) :- not is(Cook,likes,Chef,_), occurred(action(boss_cooks_around, Chef, Cook, null, null, null)).

is(boss_cooks_around, work).

is(boss_cooks_around, mean).

is(boss_cooks_around, role_specific).

visibility(boss_cooks_around,0).

action(mentor_cook, Chef, Cook, null, null, null):-
		person(Chef),person(Cook),person(null),event(null),location(null),
		at(Chef,Location),
		is(Chef,chef,RoleLocation),
		is(Cook,worker,RoleLocation),
		at(Cook,Location),
		at(Chef,RoleLocation),
		at(Cook,RoleLocation),
		Chef != Cook,
		Chef != null,
		Cook != null.

hashed(mentor_cook,1903836185).

update(Cook,likes,Chef,Y) :- is(Cook,likes,Chef,X), X + 1 = Y, occurred(action(mentor_cook, Chef, Cook, null, null, null)).

update(Cook,likes,Chef,1) :- not is(Cook,likes,Chef,_), occurred(action(mentor_cook, Chef, Cook, null, null, null)).

is(mentor_cook, work).

is(mentor_cook, kind).

is(mentor_cook, role_specific).

visibility(mentor_cook,0).

action(create_culinary_masterpiece, Chef, Guest, null, null, null):-
		person(Chef),person(Guest),person(null),event(null),location(null),
		at(Chef,Location),
		is(Chef,chef,RoleLocation),
		at(Guest,Location),
		is(Guest,guest,RoleLocation),
		at(Guest,RoleLocation),
		at(Chef,RoleLocation),
		Chef != Guest,
		Chef != null,
		Guest != null.

hashed(create_culinary_masterpiece,2905312114).

update(Guest,respects,Chef,3) :- not is(Guest,respects,Chef,_), occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Guest,happiness,Y) :- is(Guest,happiness,X), X + 2 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Chef,self_worth,2) :- not is(Chef,self_worth,_), occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Guest,happiness,2) :- not is(Guest,happiness,_), occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Guest,respects,Chef,Y) :- is(Guest,respects,Chef,X), X + 3 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Chef,self_worth,Y) :- is(Chef,self_worth,X), X + 2 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

is(create_culinary_masterpiece, work).

is(create_culinary_masterpiece, rare).

is(create_culinary_masterpiece, role_specific).

visibility(create_culinary_masterpiece,0).

action(bitch_about_boss, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,coworker,Coworker),
		at(Coworker,Location_0),
		at(Worker,Location_0),
		is(Worker,employee,Boss),
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

hashed(bitch_about_boss,953238720).

update(Worker,likes,Coworker,1) :- not is(Worker,likes,Coworker,_), occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,-1) :- not is(Coworker,likes,Boss,_), occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X + 1 = Y,occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,Y) :- is(Coworker,likes,Boss,X), X - 1 = Y, occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,1) :- not is(Coworker,likes,Worker,_), occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X + 1 = Y,occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

is(bitch_about_boss, work).

is(bitch_about_boss, mean).

is(bitch_about_boss, role_specific).

visibility(bitch_about_boss,0).

action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,employee,Boss),
		at(Coworker,Location_0),
		at(Worker,Location_0),
		is(Worker,coworker,Coworker),
		is(Coworker,likes,Boss,V_Coworker_likes_Boss), V_Coworker_likes_Boss >= 3,
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

hashed(bitch_about_boss_to_resistance,1420029110).

update(Worker,likes,Coworker,-1) :- not is(Worker,likes,Coworker,_), occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X - 1 = Y,occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,-1) :- not is(Coworker,likes,Worker,_), occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X - 1 = Y,occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

is(bitch_about_boss_to_resistance, work).

is(bitch_about_boss_to_resistance, mean).

is(bitch_about_boss_to_resistance, failure).

is(bitch_about_boss_to_resistance, role_specific).

visibility(bitch_about_boss_to_resistance,0).

action(praise_boss, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,employee,Boss),
		at(Coworker,Location_0),
		at(Worker,Location_0),
		is(Worker,coworker,Coworker),
		is(Worker,likes,Boss,V_Worker_likes_Boss), V_Worker_likes_Boss >= 3,
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

hashed(praise_boss,3017362540).

update(Worker,likes,Coworker,1) :- not is(Worker,likes,Coworker,_), occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,1) :- not is(Coworker,likes,Boss,_), occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,Y) :- is(Coworker,likes,Boss,X), X + 1 = Y, occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X + 1 = Y,occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,1) :- not is(Coworker,likes,Worker,_), occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X + 1 = Y,occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

is(praise_boss, work).

is(praise_boss, kind).

is(praise_boss, role_specific).

visibility(praise_boss,0).

action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,employee,Boss),
		at(Coworker,Location_0),
		at(Worker,Location_0),
		is(Worker,coworker,Coworker),
		is(Worker,likes,Boss,V_Worker_likes_Boss), V_Worker_likes_Boss >= 3,
		is(Coworker,likes,Boss,V_Coworker_likes_Boss), V_Coworker_likes_Boss <= -1,
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

hashed(praise_boss_to_resistance,2238819797).

update(Worker,likes,Coworker,-1) :- not is(Worker,likes,Coworker,_), occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X - 1 = Y,occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,-1) :- not is(Coworker,likes,Worker,_), occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X - 1 = Y,occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

is(praise_boss_to_resistance, work).

is(praise_boss_to_resistance, kind).

is(praise_boss_to_resistance, role_specific).

visibility(praise_boss_to_resistance,0).

action(search_for_treasure, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(TreasureHunter,RoleLocation),
		TreasureHunter != null.

hashed(search_for_treasure,2224616716).

update(TreasureHunter,tiredness,1) :- not is(TreasureHunter,tiredness,_), occurred(action(search_for_treasure, TreasureHunter, null, null, null, null)).

update(TreasureHunter,tiredness,Y) :- is(TreasureHunter,tiredness,X), X + 1 = Y, occurred(action(search_for_treasure, TreasureHunter, null, null, null, null)).

is(search_for_treasure, work).

is(search_for_treasure, bold).

is(search_for_treasure, criminal).

is(search_for_treasure, role_specific).

visibility(search_for_treasure,0).

action(find_treasure, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(TreasureHunter,RoleLocation),
		TreasureHunter != null.

hashed(find_treasure,3832620581).

add(TreasureHunter, rich) :- occurred(action(find_treasure, TreasureHunter, null, null, null, null)).

update(TreasureHunter,self_worth,5) :- not is(TreasureHunter,self_worth,_), occurred(action(find_treasure, TreasureHunter, null, null, null, null)).

update(TreasureHunter,self_worth,Y) :- is(TreasureHunter,self_worth,X), X + 5 = Y, occurred(action(find_treasure, TreasureHunter, null, null, null, null)).

is(find_treasure, work).

is(find_treasure, bold).

is(find_treasure, criminal).

is(find_treasure, rare).

is(find_treasure, role_specific).

visibility(find_treasure,0).

action(investigate_ruins, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(TreasureHunter,RoleLocation),
		TreasureHunter != null.

hashed(investigate_ruins,1953297998).

is(investigate_ruins, work).

is(investigate_ruins, scholarly).

is(investigate_ruins, thoughtful).

is(investigate_ruins, role_specific).

visibility(investigate_ruins,0).

action(trigger_trap, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(TreasureHunter,RoleLocation),
		TreasureHunter != null.

hashed(trigger_trap,673406268).

update(TreasureHunter,self_worth,-1) :- not is(TreasureHunter,self_worth,_), occurred(action(trigger_trap, TreasureHunter, null, null, null, null)).

update(TreasureHunter,self_worth,Y) :- is(TreasureHunter,self_worth,X), X - 1 = Y, occurred(action(trigger_trap, TreasureHunter, null, null, null, null)).

is(trigger_trap, work).

is(trigger_trap, careless).

is(trigger_trap, role_specific).

visibility(trigger_trap,0).

action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null):-
		person(TreasureHunter),person(OtherTH),person(null),event(null),location(null),
		at(OtherTH,RoleLocation),
		is(OtherTH,treasure_hunter,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		is(TreasureHunter,rival,OtherTH),
		at(OtherTH,Location),
		TreasureHunter != OtherTH,
		TreasureHunter != null,
		OtherTH != null.

hashed(sabotage_rival_treasure_hunter,4226303219).

update(OtherTH,likes,TreasureHunter,-1) :- not is(OtherTH,likes,TreasureHunter,_), occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

update(OtherTH,likes,TreasureHunter,Y) :- is(OtherTH,likes,TreasureHunter,X), X - 1 = Y, occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

update(OtherTH,respects,TreasureHunter,1) :- not is(OtherTH,respects,TreasureHunter,_), occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

update(OtherTH,respects,TreasureHunter,Y) :- is(OtherTH,respects,TreasureHunter,X), X + 1 = Y, occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

is(sabotage_rival_treasure_hunter, work).

is(sabotage_rival_treasure_hunter, mean).

is(sabotage_rival_treasure_hunter, bold).

is(sabotage_rival_treasure_hunter, role_specific).

visibility(sabotage_rival_treasure_hunter,0).

action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null):-
		person(TreasureHunter),person(OtherTH),person(null),event(null),location(null),
		at(OtherTH,RoleLocation),
		is(OtherTH,treasure_hunter,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		is(TreasureHunter,rival,OtherTH),
		at(OtherTH,Location),
		TreasureHunter != OtherTH,
		TreasureHunter != null,
		OtherTH != null.

hashed(overcome_rivalry_to_work_together,2749001725).

update(OtherTH,likes,TreasureHunter,Y) :- is(OtherTH,likes,TreasureHunter,X), X + 1 = Y,occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

update(TreasureHunter,likes,OtherTH,Y) :- is(TreasureHunter,likes,OtherTH,X), X + 1 = Y,occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

update(OtherTH,likes,TreasureHunter,1) :- not is(OtherTH,likes,TreasureHunter,_), occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

update(TreasureHunter,likes,OtherTH,1) :- not is(TreasureHunter,likes,OtherTH,_), occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

is(overcome_rivalry_to_work_together, work).

is(overcome_rivalry_to_work_together, kind).

is(overcome_rivalry_to_work_together, bold).

is(overcome_rivalry_to_work_together, role_specific).

visibility(overcome_rivalry_to_work_together,0).

action(investigate_ruins, Archaelogist, null, null, null, null):-
		person(Archaelogist),person(null),person(null),event(null),location(null),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		at(Archaelogist,Location),
		Archaelogist != null.

hashed(investigate_ruins,1953297998).

is(investigate_ruins, work).

is(investigate_ruins, scholarly).

is(investigate_ruins, thoughtful).

is(investigate_ruins, role_specific).

visibility(investigate_ruins,0).

action(catalog_findings, Archaelogist, null, null, null, null):-
		person(Archaelogist),person(null),person(null),event(null),location(null),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		at(Archaelogist,Location),
		Archaelogist != null.

hashed(catalog_findings,1459076703).

is(catalog_findings, work).

is(catalog_findings, scholarly).

is(catalog_findings, thoughtful).

is(catalog_findings, role_specific).

visibility(catalog_findings,0).

action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null):-
		person(Archaelogist),person(TreasureHunter),person(null),event(null),location(null),
		is(Archaelogist,rival,TreasureHunter),
		is(Archaelogist,archaelogist,RoleLocation),
		at(Archaelogist,RoleLocation),
		at(TreasureHunter,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(Archaelogist,Location),
		Archaelogist != TreasureHunter,
		Archaelogist != null,
		TreasureHunter != null.

hashed(argue_with_treasure_hunter,1085990299).

update(Archaelogist,likes,TreasureHunter,-1) :- not is(Archaelogist,likes,TreasureHunter,_), occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

update(TreasureHunter,likes,Archaelogist,Y) :- is(TreasureHunter,likes,Archaelogist,X), X - 1 = Y,occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

update(Archaelogist,likes,TreasureHunter,Y) :- is(Archaelogist,likes,TreasureHunter,X), X - 1 = Y,occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

update(TreasureHunter,likes,Archaelogist,-1) :- not is(TreasureHunter,likes,Archaelogist,_), occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

is(argue_with_treasure_hunter, talk).

is(argue_with_treasure_hunter, critical).

is(argue_with_treasure_hunter, role_specific).

visibility(argue_with_treasure_hunter,0).

action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null):-
		person(Archaelogist),person(TreasureHunter),person(null),event(null),location(null),
		is(Archaelogist,rival,TreasureHunter),
		is(Archaelogist,archaelogist,RoleLocation),
		at(Archaelogist,RoleLocation),
		at(TreasureHunter,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,Location),
		at(Archaelogist,Location),
		Archaelogist != TreasureHunter,
		Archaelogist != null,
		TreasureHunter != null.

hashed(develop_begrudging_respect_towards,4021951524).

update(Archaelogist,likes,TreasureHunter,1) :- not is(Archaelogist,likes,TreasureHunter,_), occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

update(Archaelogist,likes,TreasureHunter,Y) :- is(Archaelogist,likes,TreasureHunter,X), X + 1 = Y,occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

update(TreasureHunter,likes,Archaelogist,Y) :- is(TreasureHunter,likes,Archaelogist,X), X + 1 = Y,occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

update(TreasureHunter,likes,Archaelogist,1) :- not is(TreasureHunter,likes,Archaelogist,_), occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

is(develop_begrudging_respect_towards, talk).

is(develop_begrudging_respect_towards, kind).

is(develop_begrudging_respect_towards, role_specific).

visibility(develop_begrudging_respect_towards,0).

action(perform_to_no_effect, Bard, null, null, null, null):-
		person(Bard),person(null),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		at(Bard,Location),
		Bard != null.

hashed(perform_to_no_effect,2296952387).

update(Bard,tiredness,1) :- not is(Bard,tiredness,_), occurred(action(perform_to_no_effect, Bard, null, null, null, null)).

update(Bard,tiredness,Y) :- is(Bard,tiredness,X), X + 1 = Y, occurred(action(perform_to_no_effect, Bard, null, null, null, null)).

is(perform_to_no_effect, work).

is(perform_to_no_effect, talk).

is(perform_to_no_effect, role_specific).

visibility(perform_to_no_effect,0).

action(amuse_with_performance, Bard, Tourist, null, null, null):-
		person(Bard),person(Tourist),person(null),event(null),location(null),
		at(Bard,Location),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Tourist,RoleLocation),
		Bard != Tourist,
		Bard != null,
		Tourist != null.

hashed(amuse_with_performance,450167151).

update(Tourist,likes,Bard,1) :- not is(Tourist,likes,Bard,_), occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

update(Bard,self_worth,Y) :- is(Bard,self_worth,X), X + 1 = Y, occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

update(Bard,self_worth,1) :- not is(Bard,self_worth,_), occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X + 1 = Y, occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

is(amuse_with_performance, work).

is(amuse_with_performance, talk).

is(amuse_with_performance, role_specific).

visibility(amuse_with_performance,0).

action(grouse_backstage, Bard, Other, null, null, null):-
		person(Bard),person(Other),person(null),event(null),location(null),
		at(Bard,Location),
		is(Other,bard,RoleLocation),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		Bard != Other,
		Bard != null,
		Other != null.

hashed(grouse_backstage,3603087718).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X - 1 = Y,occurred(action(grouse_backstage, Bard, Other, null, null, null)).

update(Other,likes,Bard,-1) :- not is(Other,likes,Bard,_), occurred(action(grouse_backstage, Bard, Other, null, null, null)).

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X - 1 = Y,occurred(action(grouse_backstage, Bard, Other, null, null, null)).

update(Bard,likes,Other,-1) :- not is(Bard,likes,Other,_), occurred(action(grouse_backstage, Bard, Other, null, null, null)).

is(grouse_backstage, work).

is(grouse_backstage, criticial).

is(grouse_backstage, role_specific).

visibility(grouse_backstage,0).

action(encourage_fellow_performer, Bard, Other, null, null, null):-
		person(Bard),person(Other),person(null),event(null),location(null),
		at(Bard,Location),
		is(Other,bard,RoleLocation),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		Bard != Other,
		Bard != null,
		Other != null.

hashed(encourage_fellow_performer,780774221).

update(Other,likes,Bard,1) :- not is(Other,likes,Bard,_), occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

update(Bard,likes,Other,1) :- not is(Bard,likes,Other,_), occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X + 1 = Y,occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X + 1 = Y,occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

is(encourage_fellow_performer, work).

is(encourage_fellow_performer, kind).

visibility(encourage_fellow_performer,0).

action(annoy_diva_for_laughs, Bard, Diva, Other, null, null):-
		person(Bard),person(Diva),person(Other),event(null),location(null),
		at(Bard,Location),
		at(Other,Location),
		is(Other,bard,RoleLocation),
		is(Bard,bard,RoleLocation),
		at(Diva,RoleLocation),
		at(Bard,RoleLocation),
		is(Other,likes,Diva,V_Other_likes_Diva), V_Other_likes_Diva <= -1,
		is(Diva,diva,RoleLocation),
		at(Other,RoleLocation),
		at(Diva,Location),
		Bard != Diva,
		Bard != Other,
		Diva != Other,
		Bard != null,
		Diva != null,
		Other != null.

hashed(annoy_diva_for_laughs,1214925201).

update(Bard,self_worth,1) :- not is(Bard,self_worth,_), occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Diva,likes,Bard,Y) :- is(Diva,likes,Bard,X), X - 1 = Y, occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X + 1 = Y,occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Other,likes,Bard,1) :- not is(Other,likes,Bard,_), occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X + 1 = Y,occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Diva,likes,Bard,-1) :- not is(Diva,likes,Bard,_), occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Bard,self_worth,Y) :- is(Bard,self_worth,X), X + 1 = Y, occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Bard,likes,Other,1) :- not is(Bard,likes,Other,_), occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

is(annoy_diva_for_laughs, work).

is(annoy_diva_for_laughs, mean).

is(annoy_diva_for_laughs, silly).

is(annoy_diva_for_laughs, role_specific).

visibility(annoy_diva_for_laughs,0).

action(become_annoyed_with_bard, Tourist, Bard, null, null, null):-
		person(Tourist),person(Bard),person(null),event(null),location(null),
		at(Bard,Location),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Tourist,RoleLocation),
		Tourist != Bard,
		Tourist != null,
		Bard != null.

hashed(become_annoyed_with_bard,623557864).

update(Tourist,likes,Bard,-1) :- not is(Tourist,likes,Bard,_), occurred(action(become_annoyed_with_bard, Tourist, Bard, null, null, null)).

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X - 1 = Y, occurred(action(become_annoyed_with_bard, Tourist, Bard, null, null, null)).

is(become_annoyed_with_bard, critical).

is(become_annoyed_with_bard, role_specific).

visibility(become_annoyed_with_bard,0).

action(be_amused_by_bard, Tourist, Bard, null, null, null):-
		person(Tourist),person(Bard),person(null),event(null),location(null),
		at(Bard,Location),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Tourist,RoleLocation),
		Tourist != Bard,
		Tourist != null,
		Bard != null.

hashed(be_amused_by_bard,2573496944).

update(Tourist,likes,Bard,1) :- not is(Tourist,likes,Bard,_), occurred(action(be_amused_by_bard, Tourist, Bard, null, null, null)).

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X + 1 = Y, occurred(action(be_amused_by_bard, Tourist, Bard, null, null, null)).

is(be_amused_by_bard, silly).

is(be_amused_by_bard, role_specific).

visibility(be_amused_by_bard,0).

action(make_judicious_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(O2,fealty,Monarch),
		at(Monarch,RoleLocation),
		is(O1,fealty,Monarch),
		is(Monarch, monarch),
		at(O2,Location),
		is(Monarch,monarch,RoleLocation),
		at(O1,Location),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

hashed(make_judicious_decree,2943110383).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X + 1 = Y, occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X + 1 = Y, occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,1) :- not is(O1,likes,Monarch,_), occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,1) :- not is(O2,likes,Monarch,_), occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

is(make_judicious_decree, work).

is(make_judicious_decree, thoughtful).

is(make_judicious_decree, role_specific).

visibility(make_judicious_decree,0).

action(make_imprudent_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(O2,fealty,Monarch),
		at(Monarch,RoleLocation),
		is(O1,fealty,Monarch),
		is(Monarch, monarch),
		at(O2,Location),
		is(Monarch,monarch,RoleLocation),
		at(O1,Location),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

hashed(make_imprudent_decree,4116075172).

update(O1,likes,Monarch,-1) :- not is(O1,likes,Monarch,_), occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,-1) :- not is(O2,likes,Monarch,_), occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X - 1 = Y, occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X - 1 = Y, occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

is(make_imprudent_decree, work).

is(make_imprudent_decree, careless).

is(make_imprudent_decree, role_specific).

visibility(make_imprudent_decree,0).

action(make_callous_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(O2,fealty,Monarch),
		at(Monarch,RoleLocation),
		is(O1,fealty,Monarch),
		is(Monarch, monarch),
		at(O2,Location),
		is(Monarch,monarch,RoleLocation),
		at(O1,Location),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

hashed(make_callous_decree,1811696930).

update(O1,likes,Monarch,-1) :- not is(O1,likes,Monarch,_), occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,-1) :- not is(O2,likes,Monarch,_), occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X - 1 = Y, occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X - 1 = Y, occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

is(make_callous_decree, work).

is(make_callous_decree, mean).

is(make_callous_decree, role_specific).

visibility(make_callous_decree,0).

action(make_benevolent_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(O2,fealty,Monarch),
		at(Monarch,RoleLocation),
		is(O1,fealty,Monarch),
		is(Monarch, monarch),
		at(O2,Location),
		is(Monarch,monarch,RoleLocation),
		at(O1,Location),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

hashed(make_benevolent_decree,580338661).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X + 1 = Y, occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X + 1 = Y, occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

update(O1,likes,Monarch,1) :- not is(O1,likes,Monarch,_), occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,1) :- not is(O2,likes,Monarch,_), occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

is(make_benevolent_decree, work).

is(make_benevolent_decree, kind).

is(make_benevolent_decree, role_specific).

visibility(make_benevolent_decree,0).

action(banish_monarchling, Monarch, Child, null, null, null):-
		person(Monarch),person(Child),person(null),event(null),location(null),
		at(Child,Location),
		at(Monarch,Location),
		is(Monarch,likes,Child,V_Monarch_likes_Child), V_Monarch_likes_Child <= -5,
		at(Monarch,RoleLocation),
		is(Child, royalty),
		is(Child,child,Monarch),
		is(Monarch, monarch),
		is(Child,age,V_Child_age), V_Child_age >= 16,
		is(Monarch,monarch,RoleLocation),
		Monarch != Child,
		Monarch != null,
		Child != null.

hashed(banish_monarchling,87890239).

update(Child,likes,Monarch,Y) :- is(Child,likes,Monarch,X), X - 10 = Y, occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

del(Child, royalty) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

update(Child,likes,Monarch,-10) :- not is(Child,likes,Monarch,_), occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

del(Child, hometown) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

add(Child, ex_royalty) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

is(banish_monarchling, mean).

is(banish_monarchling, rare).

is(banish_monarchling, role_specific).

visibility(banish_monarchling,0).

action(consult_with_chancellor, Monarch, Chancellor, null, null, null):-
		person(Monarch),person(Chancellor),person(null),event(null),location(null),
		at(Monarch,Location),
		at(Chancellor,RoleLocation),
		at(Chancellor,Location),
		at(Monarch,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		is(Chancellor,chancellor,RoleLocation),
		Monarch != Chancellor,
		Monarch != null,
		Chancellor != null.

hashed(consult_with_chancellor,2661346323).

update(Chancellor,likes,Monarch,Y) :- is(Chancellor,likes,Monarch,X), X + 1 = Y,occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

update(Chancellor,likes,Monarch,1) :- not is(Chancellor,likes,Monarch,_), occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

update(Monarch,likes,Chancellor,1) :- not is(Monarch,likes,Chancellor,_), occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

update(Monarch,likes,Chancellor,Y) :- is(Monarch,likes,Chancellor,X), X + 1 = Y,occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

is(consult_with_chancellor, work).

is(consult_with_chancellor, thoughtful).

is(consult_with_chancellor, role_specific).

visibility(consult_with_chancellor,0).

action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null):-
		person(Chancellor),person(Monarch),person(null),event(null),location(null),
		at(Monarch,Location),
		at(Chancellor,RoleLocation),
		at(Chancellor,Location),
		at(Monarch,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		is(Chancellor,chancellor,RoleLocation),
		Chancellor != Monarch,
		Chancellor != null,
		Monarch != null.

hashed(sway_monarch_to_kindness,1218358079).

del(Monarch, indifferent) :- occurred(action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null)).

add(Monarch, compassionate) :- occurred(action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null)).

is(sway_monarch_to_kindness, kind).

is(sway_monarch_to_kindness, talk).

is(sway_monarch_to_kindness, bold).

is(sway_monarch_to_kindness, rare).

is(sway_monarch_to_kindness, role_specific).

visibility(sway_monarch_to_kindness,0).

action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null):-
		person(Chancellor),person(Monarch),person(null),event(null),location(null),
		at(Monarch,Location),
		at(Chancellor,RoleLocation),
		at(Chancellor,Location),
		at(Monarch,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		is(Chancellor,chancellor,RoleLocation),
		Chancellor != Monarch,
		Chancellor != null,
		Monarch != null.

hashed(sway_monarch_to_indifference,2089499370).

add(Monarch, indifferent) :- occurred(action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null)).

del(Monarch, compassionate) :- occurred(action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null)).

is(sway_monarch_to_indifference, mean).

is(sway_monarch_to_indifference, talk).

is(sway_monarch_to_indifference, bold).

is(sway_monarch_to_indifference, rare).

is(sway_monarch_to_indifference, role_specific).

visibility(sway_monarch_to_indifference,0).

action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null):-
		person(Monarchling),person(ExMonarchling),person(null),event(null),location(null),
		at(Monarchling,Location),
		is(Monarchling, royalty),
		is(Monarchling,sibling,ExMonarchling),
		is(ExMonarchling, ex_royalty),
		at(ExMonarchling,Location),
		Monarchling != ExMonarchling,
		Monarchling != null,
		ExMonarchling != null.

hashed(support_banished_sibling,2604771547).

update(Monarchling,likes,ExMonarchling,Y) :- is(Monarchling,likes,ExMonarchling,X), X + 1 = Y,occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(ExMonarchling,likes,Monarchling,1) :- not is(ExMonarchling,likes,Monarchling,_), occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(Monarchling,likes,ExMonarchling,1) :- not is(Monarchling,likes,ExMonarchling,_), occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(ExMonarchling,likes,Monarchling,Y) :- is(ExMonarchling,likes,Monarchling,X), X + 1 = Y,occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

is(support_banished_sibling, kind).

is(support_banished_sibling, free).

is(support_banished_sibling, role_specific).

visibility(support_banished_sibling,0).

action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null):-
		person(Monarchling),person(ExMonarchling),person(null),event(null),location(null),
		at(Monarchling,Location),
		is(Monarchling, royalty),
		is(Monarchling,sibling,ExMonarchling),
		is(ExMonarchling, ex_royalty),
		at(ExMonarchling,Location),
		Monarchling != ExMonarchling,
		Monarchling != null,
		ExMonarchling != null.

hashed(shun_banished_sibling,2637492398).

update(ExMonarchling,likes,Monarchling,-1) :- not is(ExMonarchling,likes,Monarchling,_), occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(ExMonarchling,likes,Monarchling,Y) :- is(ExMonarchling,likes,Monarchling,X), X - 1 = Y,occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(Monarchling,likes,ExMonarchling,Y) :- is(Monarchling,likes,ExMonarchling,X), X - 1 = Y,occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(Monarchling,likes,ExMonarchling,-1) :- not is(Monarchling,likes,ExMonarchling,_), occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

is(shun_banished_sibling, mean).

is(shun_banished_sibling, duty).

is(shun_banished_sibling, role_specific).

visibility(shun_banished_sibling,0).

action(play, Child, null, null, null, null):-
		person(Child),person(null),person(null),event(null),location(null),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		at(Child,Location),
		Child != null.

hashed(play,2244934543).

update(Child,happiness,Y) :- is(Child,happiness,X), X + 1 = Y, occurred(action(play, Child, null, null, null, null)).

update(Child,happiness,1) :- not is(Child,happiness,_), occurred(action(play, Child, null, null, null, null)).

is(play, silly).

visibility(play,0).

action(play_together, Child, OtherChild, null, null, null):-
		person(Child),person(OtherChild),person(null),event(null),location(null),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		at(Child,Location),
		is(OtherChild,age,V_OtherChild_age), V_OtherChild_age <= 15,
		at(OtherChild,Location),
		Child != OtherChild,
		Child != null,
		OtherChild != null.

hashed(play_together,1498754300).

update(OtherChild,likes,Child,Y) :- is(OtherChild,likes,Child,X), X + 1 = Y,occurred(action(play_together, Child, OtherChild, null, null, null)).

update(OtherChild,happiness,1) :- not is(OtherChild,happiness,_), occurred(action(play_together, Child, OtherChild, null, null, null)).

update(Child,happiness,Y) :- is(Child,happiness,X), X + 1 = Y, occurred(action(play_together, Child, OtherChild, null, null, null)).

update(OtherChild,likes,Child,1) :- not is(OtherChild,likes,Child,_), occurred(action(play_together, Child, OtherChild, null, null, null)).

update(Child,likes,OtherChild,1) :- not is(Child,likes,OtherChild,_), occurred(action(play_together, Child, OtherChild, null, null, null)).

update(Child,likes,OtherChild,Y) :- is(Child,likes,OtherChild,X), X + 1 = Y,occurred(action(play_together, Child, OtherChild, null, null, null)).

update(Child,happiness,1) :- not is(Child,happiness,_), occurred(action(play_together, Child, OtherChild, null, null, null)).

update(OtherChild,happiness,Y) :- is(OtherChild,happiness,X), X + 1 = Y, occurred(action(play_together, Child, OtherChild, null, null, null)).

is(play_together, silly).

is(play_together, kind).

is(play_together, talk).

visibility(play_together,0).

action(argue_with_playmate, Child, OtherChild, null, null, null):-
		person(Child),person(OtherChild),person(null),event(null),location(null),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		at(Child,Location),
		is(OtherChild,age,V_OtherChild_age), V_OtherChild_age <= 15,
		at(OtherChild,Location),
		Child != OtherChild,
		Child != null,
		OtherChild != null.

hashed(argue_with_playmate,3946999398).

update(OtherChild,happiness,-1) :- not is(OtherChild,happiness,_), occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(OtherChild,likes,Child,-1) :- not is(OtherChild,likes,Child,_), occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(Child,likes,OtherChild,Y) :- is(Child,likes,OtherChild,X), X - 1 = Y,occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(OtherChild,happiness,Y) :- is(OtherChild,happiness,X), X - 1 = Y, occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(OtherChild,likes,Child,Y) :- is(OtherChild,likes,Child,X), X - 1 = Y,occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(Child,happiness,-1) :- not is(Child,happiness,_), occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(Child,happiness,Y) :- is(Child,happiness,X), X - 1 = Y, occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(Child,likes,OtherChild,-1) :- not is(Child,likes,OtherChild,_), occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

is(argue_with_playmate, critical).

is(argue_with_playmate, mean).

visibility(argue_with_playmate,0).

action(worry_about_future, Adult, null, null, null, null):-
		person(Adult),person(null),person(null),event(null),location(null),
		is(Adult,age,V_Adult_age), V_Adult_age >= 35,
		at(Adult,Location),
		Adult != null.

hashed(worry_about_future,3635991241).

update(Adult,tiredness,1) :- not is(Adult,tiredness,_), occurred(action(worry_about_future, Adult, null, null, null, null)).

update(Adult,tiredness,Y) :- is(Adult,tiredness,X), X + 1 = Y, occurred(action(worry_about_future, Adult, null, null, null, null)).

is(worry_about_future, critical).

is(worry_about_future, worry).

visibility(worry_about_future,0).

action(worry_about_mortality, Adult, null, null, null, null):-
		person(Adult),person(null),person(null),event(null),location(null),
		is(Adult,age,V_Adult_age), V_Adult_age >= 55,
		at(Adult,Location),
		Adult != null.

hashed(worry_about_mortality,242848471).

update(Adult,happiness,Y) :- is(Adult,happiness,X), X - 1 = Y, occurred(action(worry_about_mortality, Adult, null, null, null, null)).

update(Adult,tiredness,1) :- not is(Adult,tiredness,_), occurred(action(worry_about_mortality, Adult, null, null, null, null)).

update(Adult,happiness,-1) :- not is(Adult,happiness,_), occurred(action(worry_about_mortality, Adult, null, null, null, null)).

update(Adult,tiredness,Y) :- is(Adult,tiredness,X), X + 1 = Y, occurred(action(worry_about_mortality, Adult, null, null, null, null)).

is(worry_about_mortality, critical).

is(worry_about_mortality, worry).

visibility(worry_about_mortality,0).

action(argue_about_duty, Dutybound, Free, null, null, null):-
		person(Dutybound),person(Free),person(null),event(null),location(null),
		at(Dutybound,Location),
		is(Dutybound, duty_bound),
		is(Free, free_sprited),
		at(Free,Location),
		Dutybound != Free,
		Dutybound != null,
		Free != null.

hashed(argue_about_duty,2858565074).

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X - 1 = Y,occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

update(Free,likes,Dutybound,-1) :- not is(Free,likes,Dutybound,_), occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

update(Dutybound,likes,Free,-1) :- not is(Dutybound,likes,Free,_), occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X - 1 = Y,occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

is(argue_about_duty, critical).

is(argue_about_duty, role_specific).

visibility(argue_about_duty,0).

action(convince_importance_of_duty, Dutybound, Free, null, null, null):-
		person(Dutybound),person(Free),person(null),event(null),location(null),
		at(Dutybound,Location),
		is(Dutybound, duty_bound),
		is(Free, free_sprited),
		at(Free,Location),
		Dutybound != Free,
		Dutybound != null,
		Free != null.

hashed(convince_importance_of_duty,1181209795).

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

update(Dutybound,likes,Free,1) :- not is(Dutybound,likes,Free,_), occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

update(Free,likes,Dutybound,1) :- not is(Free,likes,Dutybound,_), occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

is(convince_importance_of_duty, thoughtful).

is(convince_importance_of_duty, role_specific).

visibility(convince_importance_of_duty,0).

action(argue_about_need_to_be_free, Free, Dutybound, null, null, null):-
		person(Free),person(Dutybound),person(null),event(null),location(null),
		at(Dutybound,Location),
		is(Dutybound, duty_bound),
		is(Free, free_sprited),
		at(Free,Location),
		Free != Dutybound,
		Free != null,
		Dutybound != null.

hashed(argue_about_need_to_be_free,1397023790).

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X - 1 = Y,occurred(action(argue_about_need_to_be_free, Free, Dutybound, null, null, null)).

update(Free,likes,Dutybound,-1) :- not is(Free,likes,Dutybound,_), occurred(action(argue_about_need_to_be_free, Free, Dutybound, null, null, null)).

update(Dutybound,likes,Free,-1) :- not is(Dutybound,likes,Free,_), occurred(action(argue_about_need_to_be_free, Free, Dutybound, null, null, null)).

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X - 1 = Y,occurred(action(argue_about_need_to_be_free, Free, Dutybound, null, null, null)).

is(argue_about_need_to_be_free, critical).

is(argue_about_need_to_be_free, role_specific).

visibility(argue_about_need_to_be_free,0).

action(convince_importance_of_duty, Free, Dutybound, null, null, null):-
		person(Free),person(Dutybound),person(null),event(null),location(null),
		at(Dutybound,Location),
		is(Dutybound, duty_bound),
		is(Free, free_sprited),
		at(Free,Location),
		Free != Dutybound,
		Free != null,
		Dutybound != null.

hashed(convince_importance_of_duty,1181209795).

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Free, Dutybound, null, null, null)).

update(Dutybound,likes,Free,1) :- not is(Dutybound,likes,Free,_), occurred(action(convince_importance_of_duty, Free, Dutybound, null, null, null)).

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Free, Dutybound, null, null, null)).

update(Free,likes,Dutybound,1) :- not is(Free,likes,Dutybound,_), occurred(action(convince_importance_of_duty, Free, Dutybound, null, null, null)).

is(convince_importance_of_duty, thoughtful).

is(convince_importance_of_duty, role_specific).

visibility(convince_importance_of_duty,0).

action(hold_lecture, Professor, Student, null, null, null):-
		person(Professor),person(Student),person(null),event(null),location(null),
		at(Professor,Location),
		is(Professor,professor,RoleLocation),
		at(Student,Location),
		at(Student,RoleLocation),
		is(Student,student,RoleLocation),
		at(Professor,RoleLocation),
		Professor != Student,
		Professor != null,
		Student != null.

hashed(hold_lecture,1551993974).

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X + 1 = Y, occurred(action(hold_lecture, Professor, Student, null, null, null)).

update(Professor,self_worth,1) :- not is(Professor,self_worth,_), occurred(action(hold_lecture, Professor, Student, null, null, null)).

update(Student,likes,Professor,1) :- not is(Student,likes,Professor,_), occurred(action(hold_lecture, Professor, Student, null, null, null)).

update(Student,likes,Professor,Y) :- is(Student,likes,Professor,X), X + 1 = Y, occurred(action(hold_lecture, Professor, Student, null, null, null)).

is(hold_lecture, work).

is(hold_lecture, scholarly).

is(hold_lecture, role_specific).

visibility(hold_lecture,0).

action(hold_boring_lecture, Professor, Student, null, null, null):-
		person(Professor),person(Student),person(null),event(null),location(null),
		at(Professor,Location),
		is(Professor,professor,RoleLocation),
		at(Student,Location),
		at(Student,RoleLocation),
		is(Student,student,RoleLocation),
		at(Professor,RoleLocation),
		Professor != Student,
		Professor != null,
		Student != null.

hashed(hold_boring_lecture,3556535363).

update(Student,likes,Professor,-1) :- not is(Student,likes,Professor,_), occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

update(Professor,self_worth,-1) :- not is(Professor,self_worth,_), occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

update(Student,likes,Professor,Y) :- is(Student,likes,Professor,X), X - 1 = Y, occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X - 1 = Y, occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

is(hold_boring_lecture, work).

is(hold_boring_lecture, scholarly).

is(hold_boring_lecture, failure).

is(hold_boring_lecture, role_specific).

visibility(hold_boring_lecture,0).

action(perform_research, Professor, null, null, null, null):-
		person(Professor),person(null),person(null),event(null),location(null),
		at(Professor,RoleLocation),
		at(Professor,Location),
		is(Professor,professor,RoleLocation),
		Professor != null.

hashed(perform_research,2839958603).

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X + 1 = Y, occurred(action(perform_research, Professor, null, null, null, null)).

update(Professor,self_worth,1) :- not is(Professor,self_worth,_), occurred(action(perform_research, Professor, null, null, null, null)).

is(perform_research, work).

is(perform_research, scholarly).

is(perform_research, role_specific).

visibility(perform_research,0).

action(conspire_against, SpyMaster, Target, null, null, null):-
		person(SpyMaster),person(Target),person(null),event(null),location(null),
		is(Target, important),
		is(SpyMaster,spy_master,RoleLocation),
		at(SpyMaster,RoleLocation),
		SpyMaster != Target,
		SpyMaster != null,
		Target != null.

hashed(conspire_against,2256914512).

update(SpyMaster,plotting_against,Target,Y) :- is(SpyMaster,plotting_against,Target,X), 3 = Y, occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

update(SpyMaster,likes,Target,-1) :- not is(SpyMaster,likes,Target,_), occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

update(SpyMaster,plotting_against,Target,3) :- not is(SpyMaster,plotting_against,Target,_), occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

update(SpyMaster,likes,Target,Y) :- is(SpyMaster,likes,Target,X), X - 1 = Y, occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

is(conspire_against, rare).

is(conspire_against, mean).

is(conspire_against, role_specific).

visibility(conspire_against,0).

action(send_underlings, SpyMaster, Spy, Target, null, null):-
		person(SpyMaster),person(Spy),person(Target),event(null),location(null),
		is(SpyMaster,spy_master,RoleLocation),
		at(Spy,RoleLocation),
		at(SpyMaster,RoleLocation),
		is(SpyMaster,plotting_against,Target,V_SpyMaster_plotting_against_Target), V_SpyMaster_plotting_against_Target >= 1,
		is(Spy,spy,RoleLocation),
		SpyMaster != Spy,
		SpyMaster != Target,
		Spy != Target,
		SpyMaster != null,
		Spy != null,
		Target != null.

hashed(send_underlings,3888929745).

update(SpyMaster,plotting_against,Target,Y) :- is(SpyMaster,plotting_against,Target,X), X - 1 = Y, occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

update(Spy,plotting_against,Target,1) :- not is(Spy,plotting_against,Target,_), occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

update(SpyMaster,plotting_against,Target,-1) :- not is(SpyMaster,plotting_against,Target,_), occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

update(Spy,plotting_against,Target,Y) :- is(Spy,plotting_against,Target,X), 1 = Y, occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

is(send_underlings, work).

is(send_underlings, role_specific).

visibility(send_underlings,0).

action(ready_the_ship, Sailor, null, null, null, null):-
		person(Sailor),person(null),person(null),event(null),location(null),
		at(Sailor,Location),
		at(Sailor,RoleLocation),
		is(Sailor,sailor,RoleLocation),
		Sailor != null.

hashed(ready_the_ship,1973593488).

update(Sailor,tiredness,Y) :- is(Sailor,tiredness,X), X + 1 = Y, occurred(action(ready_the_ship, Sailor, null, null, null, null)).

update(Sailor,tiredness,1) :- not is(Sailor,tiredness,_), occurred(action(ready_the_ship, Sailor, null, null, null, null)).

is(ready_the_ship, role_specific).

is(ready_the_ship, work).

visibility(ready_the_ship,0).

action(sing_shanty, Sailor, Other, null, null, null):-
		person(Sailor),person(Other),person(null),event(null),location(null),
		at(Sailor,Location),
		is(Other,sailor,RoleLocation),
		at(Sailor,RoleLocation),
		is(Sailor,sailor,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		Sailor != Other,
		Sailor != null,
		Other != null.

hashed(sing_shanty,129683609).

update(Other,likes,Sailor,2) :- not is(Other,likes,Sailor,_), occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Other,happiness,Y) :- is(Other,happiness,X), X + 1 = Y, occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Sailor,happiness,1) :- not is(Sailor,happiness,_), occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Other,happiness,1) :- not is(Other,happiness,_), occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Sailor,happiness,Y) :- is(Sailor,happiness,X), X + 1 = Y, occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Sailor,likes,Other,2) :- not is(Sailor,likes,Other,_), occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Other,likes,Sailor,Y) :- is(Other,likes,Sailor,X), X + 2 = Y,occurred(action(sing_shanty, Sailor, Other, null, null, null)).

update(Sailor,likes,Other,Y) :- is(Sailor,likes,Other,X), X + 2 = Y,occurred(action(sing_shanty, Sailor, Other, null, null, null)).

is(sing_shanty, role_specific).

is(sing_shanty, talk).

is(sing_shanty, bold).

visibility(sing_shanty,0).

action(prepare_auction, Auctioneer, null, null, null, null):-
		person(Auctioneer),person(null),person(null),event(null),location(null),
		at(Auctioneer,RoleLocation),
		at(Auctioneer,Location),
		is(Auctioneer,auctioneer,RoleLocation),
		Auctioneer != null.

hashed(prepare_auction,3251006718).

update(Auctioneer,readiness,1) :- not is(Auctioneer,readiness,_), occurred(action(prepare_auction, Auctioneer, null, null, null, null)).

update(Auctioneer,readiness,Y) :- is(Auctioneer,readiness,X), X + 1 = Y, occurred(action(prepare_auction, Auctioneer, null, null, null, null)).

is(prepare_auction, role_specific).

is(prepare_auction, work).

visibility(prepare_auction,0).

action(prime_auction_goer, Auctioneer, Attendee, null, null, null):-
		person(Auctioneer),person(Attendee),person(null),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		is(Attendee, rich),
		at(Attendee,Location),
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		Auctioneer != Attendee,
		Auctioneer != null,
		Attendee != null.

hashed(prime_auction_goer,696734938).

update(Attendee,likes,Auctioneer,1) :- not is(Attendee,likes,Auctioneer,_), occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

update(Attendee,auction_readiness,Y) :- is(Attendee,auction_readiness,X), X + 1 = Y, occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

update(Attendee,auction_readiness,1) :- not is(Attendee,auction_readiness,_), occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

update(Attendee,likes,Auctioneer,Y) :- is(Attendee,likes,Auctioneer,X), X + 1 = Y, occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

update(Auctioneer,readiness,1) :- not is(Auctioneer,readiness,_), occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

update(Auctioneer,readiness,Y) :- is(Auctioneer,readiness,X), X + 1 = Y, occurred(action(prime_auction_goer, Auctioneer, Attendee, null, null, null)).

is(prime_auction_goer, role_specific).

is(prime_auction_goer, work).

is(prime_auction_goer, talk).

visibility(prime_auction_goer,0).

action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null):-
		person(Auctioneer),person(Bidder1),person(Bidder2),event(null),location(null),
		at(Bidder1,Location),
		is(Auctioneer,auctioneer,RoleLocation),
		is(Bidder1,auction_readiness,V_Bidder1_auction_readiness), V_Bidder1_auction_readiness >= 1,
		is(Bidder2,auction_readiness,V_Bidder2_auction_readiness), V_Bidder2_auction_readiness >= 1,
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		is(Auctioneer,readiness,V_Auctioneer_readiness), V_Auctioneer_readiness >= 5,
		at(Bidder2,Location),
		Auctioneer != Bidder1,
		Auctioneer != Bidder2,
		Bidder1 != Bidder2,
		Auctioneer != null,
		Bidder1 != null,
		Bidder2 != null.

hashed(hold_auction_with_bidding_war,1502587576).

update(Bidder1,happiness,5) :- not is(Bidder1,happiness,_), occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder2,likes,Bidder1,-5) :- not is(Bidder2,likes,Bidder1,_), occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder2,likes,Bidder1,Y) :- is(Bidder2,likes,Bidder1,X), X - 5 = Y,occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Auctioneer,readiness,0) :- not is(Auctioneer,readiness,_), occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder1,happiness,Y) :- is(Bidder1,happiness,X), X + 5 = Y, occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder2,happiness,-5) :- not is(Bidder2,happiness,_), occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder1,likes,Bidder2,Y) :- is(Bidder1,likes,Bidder2,X), X - 5 = Y,occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Auctioneer,readiness,Y) :- is(Auctioneer,readiness,X), 0 = Y, occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder1,likes,Bidder2,-5) :- not is(Bidder1,likes,Bidder2,_), occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

update(Bidder2,happiness,Y) :- is(Bidder2,happiness,X), X - 5 = Y, occurred(action(hold_auction_with_bidding_war, Auctioneer, Bidder1, Bidder2, null, null)).

is(hold_auction_with_bidding_war, role_specific).

is(hold_auction_with_bidding_war, work).

is(hold_auction_with_bidding_war, talk).

is(hold_auction_with_bidding_war, bold).

visibility(hold_auction_with_bidding_war,0).

action(hold_auction_with_no_results, Auctioneer, Bidder1, Bidder2, null, null):-
		person(Auctioneer),person(Bidder1),person(Bidder2),event(null),location(null),
		at(Bidder1,Location),
		is(Auctioneer,auctioneer,RoleLocation),
		at(Auctioneer,Location),
		at(Auctioneer,RoleLocation),
		is(Auctioneer,readiness,V_Auctioneer_readiness), V_Auctioneer_readiness >= 5,
		at(Bidder2,Location),
		Auctioneer != Bidder1,
		Auctioneer != Bidder2,
		Bidder1 != Bidder2,
		Auctioneer != null,
		Bidder1 != null,
		Bidder2 != null.

hashed(hold_auction_with_no_results,465650974).

update(Auctioneer,happiness,-5) :- not is(Auctioneer,happiness,_), occurred(action(hold_auction_with_no_results, Auctioneer, Bidder1, Bidder2, null, null)).

update(Auctioneer,readiness,Y) :- is(Auctioneer,readiness,X), 0 = Y, occurred(action(hold_auction_with_no_results, Auctioneer, Bidder1, Bidder2, null, null)).

update(Auctioneer,readiness,0) :- not is(Auctioneer,readiness,_), occurred(action(hold_auction_with_no_results, Auctioneer, Bidder1, Bidder2, null, null)).

update(Auctioneer,happiness,Y) :- is(Auctioneer,happiness,X), X - 5 = Y, occurred(action(hold_auction_with_no_results, Auctioneer, Bidder1, Bidder2, null, null)).

is(hold_auction_with_no_results, role_specific).

is(hold_auction_with_no_results, work).

is(hold_auction_with_no_results, talk).

is(hold_auction_with_no_results, bold).

is(hold_auction_with_no_results, failure).

visibility(hold_auction_with_no_results,0).

action(search_for_artistic_inspiration_at_location, Self, null, null, null, Location):-
		person(Self),person(null),person(null),event(null),location(Location),
		is(Self, artist),
		at(Self,Location),
		Self != null.

hashed(search_for_artistic_inspiration_at_location,1942511817).

add(Self,inspired,Location) :-occurred(action(search_for_artistic_inspiration_at_location, Self, null, null, null, Location)).

is(search_for_artistic_inspiration_at_location, role_specific).

is(search_for_artistic_inspiration_at_location, work).

visibility(search_for_artistic_inspiration_at_location,0).

action(find_muse, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self, artist),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(find_muse,3247740033).

add(Self,inspired,Other) :-occurred(action(find_muse, Self, Other, null, null, null)).

is(find_muse, role_specific).

is(find_muse, work).

visibility(find_muse,0).

action(produce_work_about_muse, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		is(Self,inspired,Other),
		Self != Other,
		Self != null,
		Other != null.

hashed(produce_work_about_muse,2634881053).

add(Self, has_art) :- occurred(action(produce_work_about_muse, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(produce_work_about_muse, Self, Other, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(produce_work_about_muse, Self, Other, null, null, null)).

is(produce_work_about_muse, role_specific).

is(produce_work_about_muse, work).

visibility(produce_work_about_muse,0).

action(produce_work_about_inspiration, Self, null, null, null, Other):-
		person(Self),person(null),person(null),event(null),location(Other),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		is(Self,inspired,Other),
		Self != null.

hashed(produce_work_about_inspiration,169502430).

add(Self, has_art) :- occurred(action(produce_work_about_inspiration, Self, null, null, null, Other)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(produce_work_about_inspiration, Self, null, null, null, Other)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(produce_work_about_inspiration, Self, null, null, null, Other)).

is(produce_work_about_inspiration, role_specific).

is(produce_work_about_inspiration, work).

visibility(produce_work_about_inspiration,0).

action(lose_muse, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		is(Self,inspired,Other),
		Self != Other,
		Self != null,
		Other != null.

hashed(lose_muse,37513374).

del(Self,inspired,Other) :-occurred(action(lose_muse, Self, Other, null, null, null)).

update(Self,self_worth,-3) :- not is(Self,self_worth,_), occurred(action(lose_muse, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 3 = Y, occurred(action(lose_muse, Self, Other, null, null, null)).

is(lose_muse, role_specific).

is(lose_muse, work).

is(lose_muse, failure).

visibility(lose_muse,0).

action(lose_inspiration, Self, null, null, null, Other):-
		person(Self),person(null),person(null),event(null),location(Other),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		is(Self,inspired,Other),
		Self != null.

hashed(lose_inspiration,1743589467).

del(Self,inspired,Other) :-occurred(action(lose_inspiration, Self, null, null, null, Other)).

update(Self,self_worth,-3) :- not is(Self,self_worth,_), occurred(action(lose_inspiration, Self, null, null, null, Other)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 3 = Y, occurred(action(lose_inspiration, Self, null, null, null, Other)).

is(lose_inspiration, role_specific).

is(lose_inspiration, work).

is(lose_inspiration, failure).

visibility(lose_inspiration,0).

action(discuss_art, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		is(Self, has_art),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(discuss_art,3052751863).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(discuss_art, Self, Other, null, null, null)).

update(Other,likes,Self,2) :- not is(Other,likes,Self,_), occurred(action(discuss_art, Self, Other, null, null, null)).

update(Self,likes,Other,2) :- not is(Self,likes,Other,_), occurred(action(discuss_art, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 2 = Y,occurred(action(discuss_art, Self, Other, null, null, null)).

is(discuss_art, role_specific).

is(discuss_art, talk).

visibility(discuss_art,0).

action(give_art_to_benefactor, Self, Baron, null, null, null):-
		person(Self),person(Baron),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,artist,RoleLocation),
		at(Baron,Location),
		is(Self, has_art),
		is(Self,servant,Baron),
		at(Self,Location),
		Self != Baron,
		Self != null,
		Baron != null.

hashed(give_art_to_benefactor,118290933).

update(Baron,likes,Self,2) :- not is(Baron,likes,Self,_), occurred(action(give_art_to_benefactor, Self, Baron, null, null, null)).

update(Baron,likes,Self,Y) :- is(Baron,likes,Self,X), X + 2 = Y, occurred(action(give_art_to_benefactor, Self, Baron, null, null, null)).

is(give_art_to_benefactor, role_specific).

is(give_art_to_benefactor, talk).

visibility(give_art_to_benefactor,0).

action(investigate_target, Spy, null, Target, null, null):-
		person(Spy),person(null),person(Target),event(null),location(null),
		at(Target,Location),
		at(Spy,Location),
		is(Spy,plotting_against,Target,V_Spy_plotting_against_Target), V_Spy_plotting_against_Target >= 1,
		is(Spy, spy),
		Spy != Target,
		Spy != null,
		Target != null.

hashed(investigate_target,1283779134).

add(Spy,knows_personal_info_about,Target) :-occurred(action(investigate_target, Spy, null, Target, null, null)).

is(investigate_target, role_specific).

is(investigate_target, work).

visibility(investigate_target,0).

action(get_too_close_to_target, Spy, null, Target, null, null):-
		person(Spy),person(null),person(Target),event(null),location(null),
		at(Target,Location),
		at(Spy,Location),
		is(Spy,plotting_against,Target,V_Spy_plotting_against_Target), V_Spy_plotting_against_Target >= 1,
		is(Spy, spy),
		Spy != Target,
		Spy != null,
		Target != null.

hashed(get_too_close_to_target,3177632656).

update(Target,likes,Spy,2) :- not is(Target,likes,Spy,_), occurred(action(get_too_close_to_target, Spy, null, Target, null, null)).

update(Target,likes,Spy,Y) :- is(Target,likes,Spy,X), X + 2 = Y,occurred(action(get_too_close_to_target, Spy, null, Target, null, null)).

update(Spy,likes,Target,Y) :- is(Spy,likes,Target,X), X + 2 = Y,occurred(action(get_too_close_to_target, Spy, null, Target, null, null)).

update(Spy,likes,Target,2) :- not is(Spy,likes,Target,_), occurred(action(get_too_close_to_target, Spy, null, Target, null, null)).

is(get_too_close_to_target, role_specific).

is(get_too_close_to_target, talk).

is(get_too_close_to_target, kind).

visibility(get_too_close_to_target,0).

action(report_back, Spy, Spymaster, Target, null, null):-
		person(Spy),person(Spymaster),person(Target),event(null),location(null),
		is(Spy,knows_personal_info_about,Target),
		at(Spy,RoleLocation),
		at(Spymaster,Location_0),
		at(Spy,Location_0),
		Location_0 != Target,
		is(Spy,spy,RoleLocation),
		is(Spymaster,spy_master,RoleLocation),
		is(Spy,plotting_against,Target,V_Spy_plotting_against_Target), V_Spy_plotting_against_Target >= 1,
		at(Spymaster,RoleLocation),
		Spy != Spymaster,
		Spy != Target,
		Spymaster != Target,
		Spy != null,
		Spymaster != null,
		Target != null.

hashed(report_back,1459633414).

update(Spymaster,likes,Spy,Y) :- is(Spymaster,likes,Spy,X), X + 1 = Y, occurred(action(report_back, Spy, Spymaster, Target, null, null)).

update(Spymaster,likes,Spy,1) :- not is(Spymaster,likes,Spy,_), occurred(action(report_back, Spy, Spymaster, Target, null, null)).

add(Spymaster,knows_personal_info_about,Target) :-occurred(action(report_back, Spy, Spymaster, Target, null, null)).

is(report_back, role_specific).

is(report_back, talk).

is(report_back, kind).

visibility(report_back,0).

action(turn_against_spymaster, Spy, Target, Spymaster, null, null):-
		person(Spy),person(Target),person(Spymaster),event(null),location(null),
		at(Spy,Location_0),
		is(Spy, spy),
		Location_0 != Spymaster,
		is(Spymaster, spy_master),
		is(Spy,likes,Target,V_Spy_likes_Target), V_Spy_likes_Target >= 5,
		is(Spy,plotting_against,Target,V_Spy_plotting_against_Target), V_Spy_plotting_against_Target >= 1,
		at(Target,Location_0),
		Spy != Target,
		Spy != Spymaster,
		Target != Spymaster,
		Spy != null,
		Target != null,
		Spymaster != null.

hashed(turn_against_spymaster,2630683583).

update(Spy,plotting_against,Target,-10) :- not is(Spy,plotting_against,Target,_), occurred(action(turn_against_spymaster, Spy, Target, Spymaster, null, null)).

update(Spy,plotting_against,Target,Y) :- is(Spy,plotting_against,Target,X), X - 10 = Y, occurred(action(turn_against_spymaster, Spy, Target, Spymaster, null, null)).

update(Spy,likes,Spymaster,Y) :- is(Spy,likes,Spymaster,X), X - 10 = Y, occurred(action(turn_against_spymaster, Spy, Target, Spymaster, null, null)).

update(Spy,likes,Spymaster,-10) :- not is(Spy,likes,Spymaster,_), occurred(action(turn_against_spymaster, Spy, Target, Spymaster, null, null)).

is(turn_against_spymaster, role_specific).

is(turn_against_spymaster, talk).

is(turn_against_spymaster, kind).

visibility(turn_against_spymaster,0).

action(teach_student, Tutor, Student, null, null, null):-
		person(Tutor),person(Student),person(null),event(null),location(null),
		at(Tutor,Location),
		is(Tutor,tutor,Student),
		at(Tutor,RoleLocation),
		at(Student,Location),
		is(Tutor,tutor,RoleLocation),
		Tutor != Student,
		Tutor != null,
		Student != null.

hashed(teach_student,2532763102).

update(Tutor,self_worth,Y) :- is(Tutor,self_worth,X), X + 1 = Y, occurred(action(teach_student, Tutor, Student, null, null, null)).

update(Student,likes,Tutor,Y) :- is(Student,likes,Tutor,X), X + 1 = Y, occurred(action(teach_student, Tutor, Student, null, null, null)).

update(Student,likes,Tutor,1) :- not is(Student,likes,Tutor,_), occurred(action(teach_student, Tutor, Student, null, null, null)).

update(Tutor,self_worth,1) :- not is(Tutor,self_worth,_), occurred(action(teach_student, Tutor, Student, null, null, null)).

is(teach_student, work).

is(teach_student, scholarly).

is(teach_student, role_specific).

visibility(teach_student,0).

action(bore_student, Tutor, Student, null, null, null):-
		person(Tutor),person(Student),person(null),event(null),location(null),
		at(Tutor,Location),
		is(Tutor,tutor,Student),
		at(Tutor,RoleLocation),
		at(Student,Location),
		is(Tutor,tutor,RoleLocation),
		Tutor != Student,
		Tutor != null,
		Student != null.

hashed(bore_student,855638595).

update(Tutor,self_worth,-1) :- not is(Tutor,self_worth,_), occurred(action(bore_student, Tutor, Student, null, null, null)).

update(Student,likes,Tutor,Y) :- is(Student,likes,Tutor,X), X - 1 = Y, occurred(action(bore_student, Tutor, Student, null, null, null)).

update(Tutor,self_worth,Y) :- is(Tutor,self_worth,X), X - 1 = Y, occurred(action(bore_student, Tutor, Student, null, null, null)).

update(Student,likes,Tutor,-1) :- not is(Student,likes,Tutor,_), occurred(action(bore_student, Tutor, Student, null, null, null)).

is(bore_student, work).

is(bore_student, scholarly).

is(bore_student, failure).

is(bore_student, role_specific).

visibility(bore_student,0).

action(build_ship, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,ship_builder,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(build_ship,533640414).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(build_ship, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(build_ship, Self, null, null, null, null)).

is(build_ship, role_specific).

is(build_ship, work).

visibility(build_ship,0).

action(help_with_ship_building, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Other,ship_builder,RoleLocation),
		is(Self,ship_builder,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(help_with_ship_building,2337586774).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(help_with_ship_building, Self, Other, null, null, null)).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(help_with_ship_building, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(help_with_ship_building, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(help_with_ship_building, Self, Other, null, null, null)).

is(help_with_ship_building, role_specific).

is(help_with_ship_building, work).

is(help_with_ship_building, kind).

visibility(help_with_ship_building,0).

action(argue_with_engineer, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Other,engineer,RoleLocation),
		is(Self,ship_builder,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(argue_with_engineer,98750660).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(argue_with_engineer, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y,occurred(action(argue_with_engineer, Self, Other, null, null, null)).

update(Self,likes,Other,-1) :- not is(Self,likes,Other,_), occurred(action(argue_with_engineer, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 1 = Y,occurred(action(argue_with_engineer, Self, Other, null, null, null)).

is(argue_with_engineer, role_specific).

is(argue_with_engineer, work).

is(argue_with_engineer, critical).

visibility(argue_with_engineer,0).

action(entice_customer, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,prostitute,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(entice_customer,3268113213).

update(Other,likes,Self,1) :- not is(Other,likes,Self,_), occurred(action(entice_customer, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y, occurred(action(entice_customer, Self, Other, null, null, null)).

is(entice_customer, role_specific).

is(entice_customer, work).

visibility(entice_customer,0).

action(attend_class, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,student,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(attend_class,4134826413).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(attend_class, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(attend_class, Self, null, null, null, null)).

is(attend_class, role_specific).

is(attend_class, scholarly).

visibility(attend_class,0).

action(become_inspired_by_lecture, Self, Professor, null, null, null):-
		person(Self),person(Professor),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Professor,Location),
		is(Professor,professor,RoleLocation),
		is(Self,student,RoleLocation),
		at(Professor,RoleLocation),
		at(Self,Location),
		Self != Professor,
		Self != null,
		Professor != null.

hashed(become_inspired_by_lecture,1712046604).

update(Self,likes,Professor,1) :- not is(Self,likes,Professor,_), occurred(action(become_inspired_by_lecture, Self, Professor, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(become_inspired_by_lecture, Self, Professor, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(become_inspired_by_lecture, Self, Professor, null, null, null)).

update(Self,likes,Professor,Y) :- is(Self,likes,Professor,X), X + 1 = Y, occurred(action(become_inspired_by_lecture, Self, Professor, null, null, null)).

is(become_inspired_by_lecture, role_specific).

is(become_inspired_by_lecture, scholarly).

visibility(become_inspired_by_lecture,0).

action(bond_over_study, Student1, Student2, null, null, null):-
		person(Student1),person(Student2),person(null),event(null),location(null),
		is(Student2, student),
		at(Student2,Location),
		is(Student1, student),
		at(Student1,Location),
		Student1 != Student2,
		Student1 != null,
		Student2 != null.

hashed(bond_over_study,2030104006).

update(Student2,likes,Student1,Y) :- is(Student2,likes,Student1,X), X + 2 = Y,occurred(action(bond_over_study, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,2) :- not is(Student1,likes,Student2,_), occurred(action(bond_over_study, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,Y) :- is(Student1,likes,Student2,X), X + 2 = Y,occurred(action(bond_over_study, Student1, Student2, null, null, null)).

update(Student2,likes,Student1,2) :- not is(Student2,likes,Student1,_), occurred(action(bond_over_study, Student1, Student2, null, null, null)).

is(bond_over_study, role_specific).

is(bond_over_study, scholarly).

visibility(bond_over_study,0).

action(pull_all_nighter, Student, null, null, null, null):-
		person(Student),person(null),person(null),event(null),location(null),
		is(Student1, student),
		at(Student,Location),
		Student != null.

hashed(pull_all_nighter,1932234740).

update(Student,tiredness,Y) :- is(Student,tiredness,X), X + 3 = Y, occurred(action(pull_all_nighter, Student, null, null, null, null)).

update(Student,tiredness,3) :- not is(Student,tiredness,_), occurred(action(pull_all_nighter, Student, null, null, null, null)).

is(pull_all_nighter, role_specific).

is(pull_all_nighter, scholarly).

visibility(pull_all_nighter,0).

action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null):-
		person(Student1),person(Student2),person(null),event(null),location(null),
		is(Student1, student),
		is(Location_0,tavern),
		is(Student2, student),
		at(Student1,Location_0),
		at(Student2,Location_0),
		Student1 != Student2,
		Student1 != null,
		Student2 != null.

hashed(hang_out_with_classmates_at_tavern,222120148).

update(Student2,likes,Student1,Y) :- is(Student2,likes,Student1,X), X + 2 = Y,occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,2) :- not is(Student1,likes,Student2,_), occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,Y) :- is(Student1,likes,Student2,X), X + 2 = Y,occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

add(Student2, drunk) :- occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

add(Student1, drunk) :- occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

update(Student2,likes,Student1,2) :- not is(Student2,likes,Student1,_), occurred(action(hang_out_with_classmates_at_tavern, Student1, Student2, null, null, null)).

is(hang_out_with_classmates_at_tavern, role_specific).

is(hang_out_with_classmates_at_tavern, free).

visibility(hang_out_with_classmates_at_tavern,0).

action(have_fun_in_quad, Student1, Student2, null, null, null):-
		person(Student1),person(Student2),person(null),event(null),location(null),
		is(Student1, student),
		is(Student2, student),
		at(Student1,Location_0),
		is(Location_0,quad),
		at(Student2,Location_0),
		Student1 != Student2,
		Student1 != null,
		Student2 != null.

hashed(have_fun_in_quad,1790648199).

update(Student1,tiredness,0) :- not is(Student1,tiredness,_), occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student1,tiredness,Y) :- is(Student1,tiredness,X), 0 = Y, occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student2,likes,Student1,Y) :- is(Student2,likes,Student1,X), X + 2 = Y,occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,2) :- not is(Student1,likes,Student2,_), occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student2,tiredness,Y) :- is(Student2,tiredness,X), 0 = Y, occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,Y) :- is(Student1,likes,Student2,X), X + 2 = Y,occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student2,likes,Student1,2) :- not is(Student2,likes,Student1,_), occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

update(Student2,tiredness,0) :- not is(Student2,tiredness,_), occurred(action(have_fun_in_quad, Student1, Student2, null, null, null)).

is(have_fun_in_quad, role_specific).

is(have_fun_in_quad, silly).

visibility(have_fun_in_quad,0).

action(have_late_night_philosophical_argument, Student1, Student2, null, null, null):-
		person(Student1),person(Student2),person(null),event(null),location(null),
		is(Student2, student),
		at(Student2,Location),
		is(Student1, student),
		at(Student1,Location),
		Student1 != Student2,
		Student1 != null,
		Student2 != null.

hashed(have_late_night_philosophical_argument,4248287275).

update(Student2,likes,Student1,-4) :- not is(Student2,likes,Student1,_), occurred(action(have_late_night_philosophical_argument, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,-4) :- not is(Student1,likes,Student2,_), occurred(action(have_late_night_philosophical_argument, Student1, Student2, null, null, null)).

update(Student1,likes,Student2,Y) :- is(Student1,likes,Student2,X), X - 4 = Y,occurred(action(have_late_night_philosophical_argument, Student1, Student2, null, null, null)).

update(Student2,likes,Student1,Y) :- is(Student2,likes,Student1,X), X - 4 = Y,occurred(action(have_late_night_philosophical_argument, Student1, Student2, null, null, null)).

is(have_late_night_philosophical_argument, role_specific).

is(have_late_night_philosophical_argument, talk).

is(have_late_night_philosophical_argument, critical).

visibility(have_late_night_philosophical_argument,0).

action(tend_the_forge, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,smith_apprentice,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(tend_the_forge,632917663).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(tend_the_forge, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(tend_the_forge, Self, null, null, null, null)).

is(tend_the_forge, role_specific).

is(tend_the_forge, work).

visibility(tend_the_forge,0).

action(guard_prison, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,guard,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(guard_prison,3732382506).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(guard_prison, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(guard_prison, Self, null, null, null, null)).

is(guard_prison, role_specific).

is(guard_prison, work).

visibility(guard_prison,0).

action(sneak_treat_to_prisoner, Self, Prisoner, null, null, null):-
		person(Self),person(Prisoner),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Prisoner,prisoner,RoleLocation),
		is(Self,guard,RoleLocation),
		at(Prisoner,RoleLocation),
		at(Prisoner,Location),
		at(Self,Location),
		Self != Prisoner,
		Self != null,
		Prisoner != null.

hashed(sneak_treat_to_prisoner,1329461041).

update(Prisoner,likes,Self,Y) :- is(Prisoner,likes,Self,X), X + 2 = Y, occurred(action(sneak_treat_to_prisoner, Self, Prisoner, null, null, null)).

update(Prisoner,likes,Self,2) :- not is(Prisoner,likes,Self,_), occurred(action(sneak_treat_to_prisoner, Self, Prisoner, null, null, null)).

is(sneak_treat_to_prisoner, role_specific).

is(sneak_treat_to_prisoner, work).

is(sneak_treat_to_prisoner, kind).

visibility(sneak_treat_to_prisoner,0).

action(mistreat_prisoner, Self, Prisoner, null, null, null):-
		person(Self),person(Prisoner),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Prisoner,prisoner,RoleLocation),
		is(Self,guard,RoleLocation),
		at(Prisoner,RoleLocation),
		at(Prisoner,Location),
		at(Self,Location),
		Self != Prisoner,
		Self != null,
		Prisoner != null.

hashed(mistreat_prisoner,4072807402).

update(Prisoner,likes,Self,Y) :- is(Prisoner,likes,Self,X), X - 2 = Y, occurred(action(mistreat_prisoner, Self, Prisoner, null, null, null)).

update(Prisoner,likes,Self,-2) :- not is(Prisoner,likes,Self,_), occurred(action(mistreat_prisoner, Self, Prisoner, null, null, null)).

is(mistreat_prisoner, role_specific).

is(mistreat_prisoner, work).

is(mistreat_prisoner, mean).

visibility(mistreat_prisoner,0).

action(manage_docks, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,shipping_foreman,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(manage_docks,3176509390).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(manage_docks, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(manage_docks, Self, null, null, null, null)).

is(manage_docks, role_specific).

is(manage_docks, work).

visibility(manage_docks,0).

action(steal_from_mark, Self, Mark, null, null, null):-
		person(Self),person(Mark),person(null),event(null),location(null),
		at(Self,RoleLocation),
		not is(Mark, criminal),
		is(Self,thief,RoleLocation),
		at(Mark,Location),
		at(Self,Location),
		Self != Mark,
		Self != null,
		Mark != null.

hashed(steal_from_mark,4113457750).

update(Mark,suspicion,Self,Y) :- is(Mark,suspicion,Self,X), X + 1 = Y, occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Mark,suspicion,Self,1) :- not is(Mark,suspicion,Self,_), occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(steal_from_mark, Self, Mark, null, null, null)).

is(steal_from_mark, role_specific).

is(steal_from_mark, work).

is(steal_from_mark, criminal).

is(steal_from_mark, bold).

visibility(steal_from_mark,0).

action(get_caught_stealing, Self, Mark, null, null, null):-
		person(Self),person(Mark),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,thief,RoleLocation),
		is(Mark,suspicion,Self,V_Mark_suspicion_Self), V_Mark_suspicion_Self >= 2,
		at(Mark,Location),
		at(Self,Location),
		Self != Mark,
		Self != null,
		Mark != null.

hashed(get_caught_stealing,828928666).

add(Self, on_the_run) :- occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Self,self_worth,-1) :- not is(Self,self_worth,_), occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Mark,likes,Self,-5) :- not is(Mark,likes,Self,_), occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Mark,likes,Self,Y) :- is(Mark,likes,Self,X), X - 5 = Y, occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 1 = Y, occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

is(get_caught_stealing, role_specific).

is(get_caught_stealing, work).

is(get_caught_stealing, criminal).

is(get_caught_stealing, bold).

is(get_caught_stealing, failure).

visibility(get_caught_stealing,0).

action(run_from_authorities, Self, Authority, null, null, null):-
		person(Self),person(Authority),person(null),event(null),location(null),
		is(Authority, authority),
		is(Self, on_the_run),
		at(Authority,Location),
		at(Self,Location),
		Self != Authority,
		Self != null,
		Authority != null.

hashed(run_from_authorities,382194284).

update(Authority,likes,Self,Y) :- is(Authority,likes,Self,X), X - 2 = Y,occurred(action(run_from_authorities, Self, Authority, null, null, null)).

update(Self,likes,Authority,-2) :- not is(Self,likes,Authority,_), occurred(action(run_from_authorities, Self, Authority, null, null, null)).

update(Authority,likes,Self,-2) :- not is(Authority,likes,Self,_), occurred(action(run_from_authorities, Self, Authority, null, null, null)).

update(Self,likes,Authority,Y) :- is(Self,likes,Authority,X), X - 2 = Y,occurred(action(run_from_authorities, Self, Authority, null, null, null)).

is(run_from_authorities, role_specific).

is(run_from_authorities, criminal).

visibility(run_from_authorities,0).

action(evade_authorities, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		is(Self, on_the_run),
		at(Self,Location),
		Self != null.

hashed(evade_authorities,3047848051).

del(Self, on_the_run) :- occurred(action(evade_authorities, Self, null, null, null, null)).

is(evade_authorities, role_specific).

is(evade_authorities, criminal).

visibility(evade_authorities,0).

action(get_caught, Self, null, null, null, Dungeon):-
		person(Self),person(null),person(null),event(null),location(Dungeon),
		is(Self, on_the_run),
		is(Dungeon, dungeon),
		at(Self,Location),
		Self != null.

hashed(get_caught,3499852260).

add(Self,confined,Dungeon) :-occurred(action(get_caught, Self, null, null, null, Dungeon)).

add(Self,prisoner,Dungeon) :-occurred(action(get_caught, Self, null, null, null, Dungeon)).

del(Self, on_the_run) :- occurred(action(get_caught, Self, null, null, null, Dungeon)).

is(get_caught, role_specific).

is(get_caught, criminal).

is(get_caught, failure).

is(get_caught, rare).

visibility(get_caught,0).

action(assuage_benefactor, Self, Patron, null, null, null):-
		person(Self),person(Patron),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,impresario,RoleLocation),
		at(Patron,Location),
		is(Patron,patron,RoleLocation),
		at(Patron,RoleLocation),
		at(Self,Location),
		Self != Patron,
		Self != null,
		Patron != null.

hashed(assuage_benefactor,3971836120).

update(Patron,likes,Self,Y) :- is(Patron,likes,Self,X), X + 1 = Y, occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

update(Patron,self_worth,1) :- not is(Patron,self_worth,_), occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

update(Self,likes,Patron,-1) :- not is(Self,likes,Patron,_), occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

update(Patron,likes,Self,1) :- not is(Patron,likes,Self,_), occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

update(Patron,self_worth,Y) :- is(Patron,self_worth,X), X + 1 = Y, occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

update(Self,likes,Patron,Y) :- is(Self,likes,Patron,X), X - 1 = Y, occurred(action(assuage_benefactor, Self, Patron, null, null, null)).

is(assuage_benefactor, role_specific).

is(assuage_benefactor, work).

is(assuage_benefactor, talk).

visibility(assuage_benefactor,0).

action(assuage_diva, Self, Diva, null, null, null):-
		person(Self),person(Diva),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,impresario,RoleLocation),
		at(Diva,RoleLocation),
		is(Diva,diva,RoleLocation),
		at(Diva,Location),
		at(Self,Location),
		Self != Diva,
		Self != null,
		Diva != null.

hashed(assuage_diva,3283493928).

update(Self,likes,Diva,-1) :- not is(Self,likes,Diva,_), occurred(action(assuage_diva, Self, Diva, null, null, null)).

update(Diva,self_worth,Y) :- is(Diva,self_worth,X), X + 1 = Y, occurred(action(assuage_diva, Self, Diva, null, null, null)).

update(Diva,likes,Self,1) :- not is(Diva,likes,Self,_), occurred(action(assuage_diva, Self, Diva, null, null, null)).

update(Diva,self_worth,1) :- not is(Diva,self_worth,_), occurred(action(assuage_diva, Self, Diva, null, null, null)).

update(Self,likes,Diva,Y) :- is(Self,likes,Diva,X), X - 1 = Y, occurred(action(assuage_diva, Self, Diva, null, null, null)).

update(Diva,likes,Self,Y) :- is(Diva,likes,Self,X), X + 1 = Y, occurred(action(assuage_diva, Self, Diva, null, null, null)).

is(assuage_diva, role_specific).

is(assuage_diva, work).

is(assuage_diva, talk).

visibility(assuage_diva,0).

action(guide_cast_and_crew, Self, Bard, null, null, null):-
		person(Self),person(Bard),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,impresario,RoleLocation),
		at(Bard,Location),
		is(Bard,bad,RoleLocation),
		at(Bard,RoleLocation),
		at(Self,Location),
		Self != Bard,
		Self != null,
		Bard != null.

hashed(guide_cast_and_crew,2956767960).

update(Self,likes,Bard,1) :- not is(Self,likes,Bard,_), occurred(action(guide_cast_and_crew, Self, Bard, null, null, null)).

update(Bard,likes,Self,1) :- not is(Bard,likes,Self,_), occurred(action(guide_cast_and_crew, Self, Bard, null, null, null)).

update(Self,likes,Bard,Y) :- is(Self,likes,Bard,X), X + 1 = Y,occurred(action(guide_cast_and_crew, Self, Bard, null, null, null)).

update(Bard,likes,Self,Y) :- is(Bard,likes,Self,X), X + 1 = Y,occurred(action(guide_cast_and_crew, Self, Bard, null, null, null)).

is(guide_cast_and_crew, role_specific).

is(guide_cast_and_crew, work).

is(guide_cast_and_crew, talk).

is(guide_cast_and_crew, kind).

visibility(guide_cast_and_crew,0).

action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null):-
		person(Self),person(Diva),person(Pursuer),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,impresario,RoleLocation),
		at(Diva,RoleLocation),
		is(Pursuer,crushing_on,Diva),
		is(Diva,diva,RoleLocation),
		at(Pursuer,Location),
		at(Diva,Location),
		at(Self,Location),
		Self != Diva,
		Self != Pursuer,
		Diva != Pursuer,
		Self != null,
		Diva != null,
		Pursuer != null.

hashed(fend_off_diva_pursuer,3703572708).

update(Self,likes,Diva,3) :- not is(Self,likes,Diva,_), occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Diva,likes,Self,Y) :- is(Diva,likes,Self,X), X + 3 = Y,occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Pursuer,likes,Self,Y) :- is(Pursuer,likes,Self,X), X - 5 = Y,occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

del(Pursuer,crushing_on,Diva) :-occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Pursuer,likes,Self,-5) :- not is(Pursuer,likes,Self,_), occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Diva,likes,Self,3) :- not is(Diva,likes,Self,_), occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Self,likes,Pursuer,-5) :- not is(Self,likes,Pursuer,_), occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Self,likes,Pursuer,Y) :- is(Self,likes,Pursuer,X), X - 5 = Y,occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

update(Self,likes,Diva,Y) :- is(Self,likes,Diva,X), X + 3 = Y,occurred(action(fend_off_diva_pursuer, Self, Diva, Pursuer, null, null)).

is(fend_off_diva_pursuer, role_specific).

is(fend_off_diva_pursuer, kind).

visibility(fend_off_diva_pursuer,0).

action(pray_with_follower, Priest, Follower, null, null, null):-
		person(Priest),person(Follower),person(null),event(null),location(null),
		is(Priest,priest,RoleLocation),
		at(Priest,RoleLocation),
		at(Follower,RoleLocation),
		at(Follower,Location),
		is(Follower,follower,RoleLocation),
		at(Priest,Location),
		Priest != Follower,
		Priest != null,
		Follower != null.

hashed(pray_with_follower,2796360415).

update(Priest,devotion,1) :- not is(Priest,devotion,_), occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Priest,devotion,Y) :- is(Priest,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Follower,devotion,1) :- not is(Follower,devotion,_), occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Follower,devotion,Y) :- is(Follower,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

is(pray_with_follower, religious).

is(pray_with_follower, role_specific).

visibility(pray_with_follower,0).

action(lead_ritual, Priest, Other, null, null, null):-
		person(Priest),person(Other),person(null),event(null),location(null),
		is(Priest,priest,RoleLocation),
		at(Priest,RoleLocation),
		is(Other,monk,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Priest,Location),
		Priest != Other,
		Priest != null,
		Other != null.

hashed(lead_ritual,213789253).

update(Other,devotion,Y) :- is(Other,devotion,X), X + 2 = Y, occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Other,devotion,2) :- not is(Other,devotion,_), occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Priest,devotion,Y) :- is(Priest,devotion,X), X + 2 = Y, occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Priest,devotion,2) :- not is(Priest,devotion,_), occurred(action(lead_ritual, Priest, Other, null, null, null)).

is(lead_ritual, religious).

is(lead_ritual, role_specific).

visibility(lead_ritual,0).

action(rationalize_abuse_of_power, Priest, null, null, null, null):-
		person(Priest),person(null),person(null),event(null),location(null),
		at(Priest,RoleLocation),
		is(Priest,devotion,V_Priest_devotion), V_Priest_devotion >= 8,
		is(Priest,priest,RoleLocation),
		at(Priest,Location),
		Priest != null.

hashed(rationalize_abuse_of_power,3344141019).

update(Priest,abusiveness,Y) :- is(Priest,abusiveness,X), X + 1 = Y, occurred(action(rationalize_abuse_of_power, Priest, null, null, null, null)).

update(Priest,abusiveness,1) :- not is(Priest,abusiveness,_), occurred(action(rationalize_abuse_of_power, Priest, null, null, null, null)).

is(rationalize_abuse_of_power, religious).

is(rationalize_abuse_of_power, role_specific).

is(rationalize_abuse_of_power, mean).

visibility(rationalize_abuse_of_power,0).

action(pray_with_follower, Priest, Follower, null, null, null):-
		person(Priest),person(Follower),person(null),event(null),location(null),
		at(Priest,RoleLocation),
		at(Follower,RoleLocation),
		at(Follower,Location),
		is(Priest,high_priest,RoleLocation),
		is(Follower,follower,RoleLocation),
		at(Priest,Location),
		Priest != Follower,
		Priest != null,
		Follower != null.

hashed(pray_with_follower,2796360415).

update(Priest,devotion,1) :- not is(Priest,devotion,_), occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Priest,devotion,Y) :- is(Priest,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Follower,devotion,1) :- not is(Follower,devotion,_), occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

update(Follower,devotion,Y) :- is(Follower,devotion,X), X + 1 = Y, occurred(action(pray_with_follower, Priest, Follower, null, null, null)).

is(pray_with_follower, religious).

is(pray_with_follower, role_specific).

visibility(pray_with_follower,0).

action(lead_ritual, Priest, Other, null, null, null):-
		person(Priest),person(Other),person(null),event(null),location(null),
		at(Priest,RoleLocation),
		is(Other,monk,RoleLocation),
		is(Priest,high_priest,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Priest,Location),
		Priest != Other,
		Priest != null,
		Other != null.

hashed(lead_ritual,213789253).

update(Other,devotion,Y) :- is(Other,devotion,X), X + 2 = Y, occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Other,devotion,2) :- not is(Other,devotion,_), occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Priest,devotion,Y) :- is(Priest,devotion,X), X + 2 = Y, occurred(action(lead_ritual, Priest, Other, null, null, null)).

update(Priest,devotion,2) :- not is(Priest,devotion,_), occurred(action(lead_ritual, Priest, Other, null, null, null)).

is(lead_ritual, religious).

is(lead_ritual, role_specific).

visibility(lead_ritual,0).

action(rationalize_abuse_of_power, Priest, null, null, null, null):-
		person(Priest),person(null),person(null),event(null),location(null),
		at(Priest,RoleLocation),
		is(Priest,high_priest,RoleLocation),
		is(Priest,devotion,V_Priest_devotion), V_Priest_devotion >= 8,
		at(Priest,Location),
		Priest != null.

hashed(rationalize_abuse_of_power,3344141019).

update(Priest,abusiveness,Y) :- is(Priest,abusiveness,X), X + 1 = Y, occurred(action(rationalize_abuse_of_power, Priest, null, null, null, null)).

update(Priest,abusiveness,1) :- not is(Priest,abusiveness,_), occurred(action(rationalize_abuse_of_power, Priest, null, null, null, null)).

is(rationalize_abuse_of_power, religious).

is(rationalize_abuse_of_power, role_specific).

is(rationalize_abuse_of_power, mean).

visibility(rationalize_abuse_of_power,0).

action(steal_from_mark, Self, Mark, null, null, null):-
		person(Self),person(Mark),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Mark,Location),
		is(Self,pickpocket,RoleLocation),
		at(Self,Location),
		Self != Mark,
		Self != null,
		Mark != null.

hashed(steal_from_mark,4113457750).

update(Mark,suspicion,Self,Y) :- is(Mark,suspicion,Self,X), X + 1 = Y, occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Mark,suspicion,Self,1) :- not is(Mark,suspicion,Self,_), occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(steal_from_mark, Self, Mark, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(steal_from_mark, Self, Mark, null, null, null)).

is(steal_from_mark, role_specific).

is(steal_from_mark, work).

is(steal_from_mark, criminal).

is(steal_from_mark, bold).

visibility(steal_from_mark,0).

action(get_caught_stealing, Self, Mark, null, null, null):-
		person(Self),person(Mark),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Mark,suspicion,Self,V_Mark_suspicion_Self), V_Mark_suspicion_Self >= 2,
		is(Self,pickpocket,RoleLocation),
		at(Mark,Location),
		at(Self,Location),
		Self != Mark,
		Self != null,
		Mark != null.

hashed(get_caught_stealing,828928666).

add(Self, on_the_run) :- occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Self,self_worth,-1) :- not is(Self,self_worth,_), occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Mark,likes,Self,-5) :- not is(Mark,likes,Self,_), occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Mark,likes,Self,Y) :- is(Mark,likes,Self,X), X - 5 = Y, occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 1 = Y, occurred(action(get_caught_stealing, Self, Mark, null, null, null)).

is(get_caught_stealing, role_specific).

is(get_caught_stealing, work).

is(get_caught_stealing, criminal).

is(get_caught_stealing, bold).

is(get_caught_stealing, failure).

visibility(get_caught_stealing,0).

action(design_ship, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,engineer,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(design_ship,1059712548).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(design_ship, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(design_ship, Self, null, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(design_ship, Self, null, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(design_ship, Self, null, null, null, null)).

is(design_ship, role_specific).

is(design_ship, work).

visibility(design_ship,0).

action(guide_shipwrights, Self, ShipBuilder, null, null, null):-
		person(Self),person(ShipBuilder),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,engineer,RoleLocation),
		at(ShipBuilder,RoleLocation),
		is(ShipBuilder,ship_builder,RoleLocation),
		at(ShipBuilder,Location),
		at(Self,Location),
		Self != ShipBuilder,
		Self != null,
		ShipBuilder != null.

hashed(guide_shipwrights,1247244298).

update(ShipBuilder,likes,Self,Y) :- is(ShipBuilder,likes,Self,X), X + 1 = Y,occurred(action(guide_shipwrights, Self, ShipBuilder, null, null, null)).

update(Self,likes,ShipBuilder,Y) :- is(Self,likes,ShipBuilder,X), X + 1 = Y,occurred(action(guide_shipwrights, Self, ShipBuilder, null, null, null)).

update(Self,likes,ShipBuilder,1) :- not is(Self,likes,ShipBuilder,_), occurred(action(guide_shipwrights, Self, ShipBuilder, null, null, null)).

update(ShipBuilder,likes,Self,1) :- not is(ShipBuilder,likes,Self,_), occurred(action(guide_shipwrights, Self, ShipBuilder, null, null, null)).

is(guide_shipwrights, role_specific).

is(guide_shipwrights, work).

is(guide_shipwrights, kind).

visibility(guide_shipwrights,0).

action(inspire_crew, Self, Sailor, null, null, null):-
		person(Self),person(Sailor),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,captain,RoleLocation),
		at(Sailor,Location),
		at(Sailor,RoleLocation),
		is(Sailor,sailor,RoleLocation),
		at(Self,Location),
		Self != Sailor,
		Self != null,
		Sailor != null.

hashed(inspire_crew,497389636).

update(Self,likes,Sailor,Y) :- is(Self,likes,Sailor,X), X + 2 = Y,occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Sailor,self_worth,Y) :- is(Sailor,self_worth,X), X + 1 = Y, occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Sailor,self_worth,1) :- not is(Sailor,self_worth,_), occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Self,likes,Sailor,2) :- not is(Self,likes,Sailor,_), occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Sailor,likes,Self,2) :- not is(Sailor,likes,Self,_), occurred(action(inspire_crew, Self, Sailor, null, null, null)).

update(Sailor,likes,Self,Y) :- is(Sailor,likes,Self,X), X + 2 = Y,occurred(action(inspire_crew, Self, Sailor, null, null, null)).

is(inspire_crew, role_specific).

is(inspire_crew, work).

visibility(inspire_crew,0).

action(provide_guidance, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,elder,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(provide_guidance,4190147472).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(provide_guidance, Self, Other, null, null, null)).

update(Other,likes,Self,2) :- not is(Other,likes,Self,_), occurred(action(provide_guidance, Self, Other, null, null, null)).

update(Self,likes,Other,2) :- not is(Self,likes,Other,_), occurred(action(provide_guidance, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 2 = Y,occurred(action(provide_guidance, Self, Other, null, null, null)).

is(provide_guidance, role_specific).

is(provide_guidance, thoughtful).

visibility(provide_guidance,0).

action(fish, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,fisher,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(fish,430093552).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(fish, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(fish, Self, null, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(fish, Self, null, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(fish, Self, null, null, null, null)).

is(fish, role_specific).

is(fish, work).

visibility(fish,0).

action(fight_seagull, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,fisher,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(fight_seagull,1993617866).

update(Self,anger,1) :- not is(Self,anger,_), occurred(action(fight_seagull, Self, null, null, null, null)).

update(Self,anger,Y) :- is(Self,anger,X), X + 1 = Y, occurred(action(fight_seagull, Self, null, null, null, null)).

is(fight_seagull, angry).

is(fight_seagull, rare).

is(fight_seagull, role_specific).

visibility(fight_seagull,0).

action(command_underlings, Self, Thief, null, null, null):-
		person(Self),person(Thief),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Thief,RoleLocation),
		is(Self,master_thief,RoleLocation),
		is(Thief,thief,RoleLocation),
		at(Thief,Location),
		at(Self,Location),
		Self != Thief,
		Self != null,
		Thief != null.

hashed(command_underlings,2383948234).

update(Self,likes,Thief,1) :- not is(Self,likes,Thief,_), occurred(action(command_underlings, Self, Thief, null, null, null)).

update(Self,likes,Thief,Y) :- is(Self,likes,Thief,X), X + 1 = Y,occurred(action(command_underlings, Self, Thief, null, null, null)).

update(Thief,likes,Self,Y) :- is(Thief,likes,Self,X), X + 1 = Y,occurred(action(command_underlings, Self, Thief, null, null, null)).

update(Thief,likes,Self,1) :- not is(Thief,likes,Self,_), occurred(action(command_underlings, Self, Thief, null, null, null)).

is(command_underlings, role_specific).

is(command_underlings, criminal).

visibility(command_underlings,0).

action(consult_spymaster, Self, SpyMaster, null, null, null):-
		person(Self),person(SpyMaster),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(SpyMaster,spy_master,RoleLocation),
		at(SpyMaster,RoleLocation),
		is(Self,master_thief,RoleLocation),
		at(SpyMaster,Location),
		at(Self,Location),
		Self != SpyMaster,
		Self != null,
		SpyMaster != null.

hashed(consult_spymaster,394756120).

update(Self,likes,SpyMaster,Y) :- is(Self,likes,SpyMaster,X), X + 1 = Y,occurred(action(consult_spymaster, Self, SpyMaster, null, null, null)).

update(SpyMaster,likes,Self,Y) :- is(SpyMaster,likes,Self,X), X + 1 = Y,occurred(action(consult_spymaster, Self, SpyMaster, null, null, null)).

update(SpyMaster,likes,Self,1) :- not is(SpyMaster,likes,Self,_), occurred(action(consult_spymaster, Self, SpyMaster, null, null, null)).

update(Self,likes,SpyMaster,1) :- not is(Self,likes,SpyMaster,_), occurred(action(consult_spymaster, Self, SpyMaster, null, null, null)).

is(consult_spymaster, role_specific).

is(consult_spymaster, criminal).

is(consult_spymaster, thoughtful).

visibility(consult_spymaster,0).

action(patronize, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Self,Location),
		is(Self,patron,RoleLocation),
		Self != null.

hashed(patronize,798877656).

update(Self,happiness,Y) :- is(Self,happiness,X), X + 1 = Y, occurred(action(patronize, Self, null, null, null, null)).

update(Self,happiness,1) :- not is(Self,happiness,_), occurred(action(patronize, Self, null, null, null, null)).

is(patronize, role_specific).

visibility(patronize,0).

action(patronize_employee, Self, Employee, null, null, null):-
		person(Self),person(Employee),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Employee,Location),
		is(Self,patron,RoleLocation),
		at(Employee,RoleLocation),
		is(Employee,employee,RoleLocation),
		at(Self,Location),
		Self != Employee,
		Self != null,
		Employee != null.

hashed(patronize_employee,2651588072).

update(Employee,likes,Self,Y) :- is(Employee,likes,Self,X), X - 2 = Y, occurred(action(patronize_employee, Self, Employee, null, null, null)).

update(Employee,likes,Self,-2) :- not is(Employee,likes,Self,_), occurred(action(patronize_employee, Self, Employee, null, null, null)).

update(Self,happiness,Y) :- is(Self,happiness,X), X + 1 = Y, occurred(action(patronize_employee, Self, Employee, null, null, null)).

update(Self,happiness,1) :- not is(Self,happiness,_), occurred(action(patronize_employee, Self, Employee, null, null, null)).

is(patronize_employee, role_specific).

is(patronize_employee, mean).

visibility(patronize_employee,0).

action(work_the_forge, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,smithy,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(work_the_forge,304084257).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(work_the_forge, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(work_the_forge, Self, null, null, null, null)).

is(work_the_forge, role_specific).

is(work_the_forge, work).

visibility(work_the_forge,0).

action(craft_the_sacred_weapon, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		not is(Self, sacred_weapon),
		is(Self,smithy,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(craft_the_sacred_weapon,825912287).

update(Self,self_worth,5) :- not is(Self,self_worth,_), occurred(action(craft_the_sacred_weapon, Self, null, null, null, null)).

del(Self, eworthy) :- occurred(action(craft_the_sacred_weapon, Self, null, null, null, null)).

add(Self, knows_sacred_weapon) :- occurred(action(craft_the_sacred_weapon, Self, null, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 5 = Y, occurred(action(craft_the_sacred_weapon, Self, null, null, null, null)).

add(Self, sacred_weapon) :- occurred(action(craft_the_sacred_weapon, Self, null, null, null, null)).

is(craft_the_sacred_weapon, role_specific).

is(craft_the_sacred_weapon, work).

is(craft_the_sacred_weapon, extremely_rare).

visibility(craft_the_sacred_weapon,0).

action(talk_about_sacred_weapon, Talker, Listener, null, null, null):-
		person(Talker),person(Listener),person(null),event(null),location(null),
		is(Talker, knows_sacred_weapon),
		at(Listener,Location),
		at(Talker,Location),
		Talker != Listener,
		Talker != null,
		Listener != null.

hashed(talk_about_sacred_weapon,2779798444).

add(Listener, knows_sacred_weapon) :- occurred(action(talk_about_sacred_weapon, Talker, Listener, null, null, null)).

is(talk_about_sacred_weapon, rare).

is(talk_about_sacred_weapon, talk).

is(talk_about_sacred_weapon, open).

visibility(talk_about_sacred_weapon,0).

action(perform_research, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,researcher,RoleLocation),
		at(Self,Location),
		Self != null.

hashed(perform_research,2839958603).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(perform_research, Self, null, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(perform_research, Self, null, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(perform_research, Self, null, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(perform_research, Self, null, null, null, null)).

is(perform_research, role_specific).

is(perform_research, work).

is(perform_research, scholarly).

visibility(perform_research,0).

action(uncover_information_about_noteworthy_person, Self, null, Noteworthy, null, null):-
		person(Self),person(null),person(Noteworthy),event(null),location(null),
		at(Self,RoleLocation),
		Noteworthy != Self,
		not is(Noteworthy, eworthy),
		is(Self,researcher,RoleLocation),
		Self != Noteworthy,
		Self != null,
		Noteworthy != null.

hashed(uncover_information_about_noteworthy_person,828142402).

add(Self,knows_personal_info_about,Noteworthy) :-occurred(action(uncover_information_about_noteworthy_person, Self, null, Noteworthy, null, null)).

is(uncover_information_about_noteworthy_person, role_specific).

is(uncover_information_about_noteworthy_person, work).

is(uncover_information_about_noteworthy_person, scholarly).

is(uncover_information_about_noteworthy_person, rare).

visibility(uncover_information_about_noteworthy_person,0).

action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null):-
		person(Self),person(Listener),person(Noteworthy),event(null),location(null),
		is(Self,knows_personal_info_about,Noteworthy),
		not is(Noteworthy, eworthy),
		Noteworthy != Location_0,
		at(Self,Location_0),
		at(Listener,Location_0),
		Self != Listener,
		Self != Noteworthy,
		Listener != Noteworthy,
		Self != null,
		Listener != null,
		Noteworthy != null.

hashed(share_knowledge_about_noteworthy,1816210533).

update(Self,likes,Listener,Y) :- is(Self,likes,Listener,X), X + 1 = Y,occurred(action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null)).

update(Listener,likes,Self,1) :- not is(Listener,likes,Self,_), occurred(action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null)).

update(Self,likes,Listener,1) :- not is(Self,likes,Listener,_), occurred(action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null)).

update(Listener,likes,Self,Y) :- is(Listener,likes,Self,X), X + 1 = Y,occurred(action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null)).

add(Listener,knows_personal_info_about,Noteworthy) :-occurred(action(share_knowledge_about_noteworthy, Self, Listener, Noteworthy, null, null)).

is(share_knowledge_about_noteworthy, specific).

is(share_knowledge_about_noteworthy, talk).

is(share_knowledge_about_noteworthy, free).

visibility(share_knowledge_about_noteworthy,0).

action(perform_for_tourist, Self, Watcher, null, null, null):-
		person(Self),person(Watcher),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Watcher,RoleLocation),
		at(Watcher,Location),
		is(Self,diva,RoleLocation),
		is(Watcher,tourist,RoleLocation),
		at(Self,Location),
		Self != Watcher,
		Self != null,
		Watcher != null.

hashed(perform_for_tourist,2270236229).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,2) :- not is(Watcher,likes,Self,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,Y) :- is(Watcher,likes,Self,X), X + 2 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

is(perform_for_tourist, role_specific).

is(perform_for_tourist, talk).

visibility(perform_for_tourist,0).

action(perform_for_tourist, Self, Watcher, null, null, null):-
		person(Self),person(Watcher),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Watcher,RoleLocation),
		at(Watcher,Location),
		is(Self,diva,RoleLocation),
		is(Watcher,tourist,RoleLocation),
		at(Self,Location),
		Self != Watcher,
		Self != null,
		Watcher != null.

hashed(perform_for_tourist,2270236229).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,self_worth,1) :- not is(Self,self_worth,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,2) :- not is(Watcher,likes,Self,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,Y) :- is(Watcher,likes,Self,X), X + 2 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,tiredness,Y) :- is(Self,tiredness,X), X + 1 = Y, occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

update(Self,tiredness,1) :- not is(Self,tiredness,_), occurred(action(perform_for_tourist, Self, Watcher, null, null, null)).

is(perform_for_tourist, role_specific).

is(perform_for_tourist, talk).

visibility(perform_for_tourist,0).

action(turn_fan_into_superfan, Self, Watcher, null, null, null):-
		person(Self),person(Watcher),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Watcher,RoleLocation),
		at(Watcher,Location),
		is(Self,diva,RoleLocation),
		is(Watcher,tourist,RoleLocation),
		at(Self,Location),
		Self != Watcher,
		Self != null,
		Watcher != null.

hashed(turn_fan_into_superfan,3860215446).

add(Watcher,crushing_on,Self) :-occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,Y) :- is(Watcher,likes,Self,X), X + 2 = Y, occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,2) :- not is(Watcher,likes,Self,_), occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

is(turn_fan_into_superfan, role_specific).

is(turn_fan_into_superfan, talk).

visibility(turn_fan_into_superfan,0).

action(turn_fan_into_superfan, Self, Watcher, null, null, null):-
		person(Self),person(Watcher),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Watcher,RoleLocation),
		at(Watcher,Location),
		is(Self,diva,RoleLocation),
		is(Watcher,patron,RoleLocation),
		at(Self,Location),
		Self != Watcher,
		Self != null,
		Watcher != null.

hashed(turn_fan_into_superfan,3860215446).

add(Watcher,crushing_on,Self) :-occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,Y) :- is(Watcher,likes,Self,X), X + 2 = Y, occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

update(Watcher,likes,Self,2) :- not is(Watcher,likes,Self,_), occurred(action(turn_fan_into_superfan, Self, Watcher, null, null, null)).

is(turn_fan_into_superfan, role_specific).

is(turn_fan_into_superfan, talk).

visibility(turn_fan_into_superfan,0).

action(belittle_other_performers, Self, Performer, null, null, null):-
		person(Self),person(Performer),person(null),event(null),location(null),
		at(Self,RoleLocation),
		at(Performer,Location),
		at(Performer,RoleLocation),
		is(Self,diva,RoleLocation),
		is(Performer,bard,RoleLocation),
		at(Self,Location),
		Self != Performer,
		Self != null,
		Performer != null.

hashed(belittle_other_performers,2901497485).

update(Performer,likes,Self,Y) :- is(Performer,likes,Self,X), X - 2 = Y,occurred(action(belittle_other_performers, Self, Performer, null, null, null)).

update(Performer,likes,Self,-2) :- not is(Performer,likes,Self,_), occurred(action(belittle_other_performers, Self, Performer, null, null, null)).

update(Self,likes,Performer,-2) :- not is(Self,likes,Performer,_), occurred(action(belittle_other_performers, Self, Performer, null, null, null)).

update(Self,likes,Performer,Y) :- is(Self,likes,Performer,X), X - 2 = Y,occurred(action(belittle_other_performers, Self, Performer, null, null, null)).

is(belittle_other_performers, role_specific).

is(belittle_other_performers, mean).

visibility(belittle_other_performers,0).

action(feud_with_diva, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Self,diva,RoleLocation),
		is(Other,diva,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(feud_with_diva,320267351).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 3 = Y,occurred(action(feud_with_diva, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 3 = Y,occurred(action(feud_with_diva, Self, Other, null, null, null)).

update(Other,likes,Self,-3) :- not is(Other,likes,Self,_), occurred(action(feud_with_diva, Self, Other, null, null, null)).

update(Self,likes,Other,-3) :- not is(Self,likes,Other,_), occurred(action(feud_with_diva, Self, Other, null, null, null)).

is(feud_with_diva, role_specific).

is(feud_with_diva, mean).

visibility(feud_with_diva,0).

action(demand_more_of_impresario, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Self,RoleLocation),
		is(Other,impresario,RoleLocation),
		is(Self,diva,RoleLocation),
		at(Other,RoleLocation),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

hashed(demand_more_of_impresario,3722596430).

update(Self,likes,Other,1) :- not is(Self,likes,Other,_), occurred(action(demand_more_of_impresario, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(demand_more_of_impresario, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y, occurred(action(demand_more_of_impresario, Self, Other, null, null, null)).

update(Other,likes,Self,-1) :- not is(Other,likes,Self,_), occurred(action(demand_more_of_impresario, Self, Other, null, null, null)).

is(demand_more_of_impresario, role_specific).

is(demand_more_of_impresario, mean).

visibility(demand_more_of_impresario,0).

action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null):-
		person(Self),person(Patron),person(Impresario),event(null),location(null),
		at(Self,RoleLocation),
		is(Impresario,impresario,RoleLocation),
		at(Patron,Location),
		is(Self,diva,RoleLocation),
		at(Impresario,RoleLocation),
		at(Impresario,Location),
		is(Patron,patron,RoleLocation),
		at(Patron,RoleLocation),
		at(Self,Location),
		Self != Patron,
		Self != Impresario,
		Patron != Impresario,
		Self != null,
		Patron != null,
		Impresario != null.

hashed(deliver_stunning_perfomance,1582989271).

update(Self,self_worth,5) :- not is(Self,self_worth,_), occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Impresario,likes,Self,Y) :- is(Impresario,likes,Self,X), X + 5 = Y, occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Patron,likes,Self,5) :- not is(Patron,likes,Self,_), occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 5 = Y, occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Impresario,likes,Self,5) :- not is(Impresario,likes,Self,_), occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Patron,likes,Impresario,5) :- not is(Patron,likes,Impresario,_), occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Patron,likes,Self,Y) :- is(Patron,likes,Self,X), X + 5 = Y, occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

update(Patron,likes,Impresario,Y) :- is(Patron,likes,Impresario,X), X + 5 = Y, occurred(action(deliver_stunning_perfomance, Self, Patron, Impresario, null, null)).

is(deliver_stunning_perfomance, role_specific).

is(deliver_stunning_perfomance, talk).

is(deliver_stunning_perfomance, rare).

visibility(deliver_stunning_perfomance,0).

action(serve_patron, Barkeep, Patron, null, null, null):-
		person(Barkeep),person(Patron),person(null),event(null),location(null),
		at(Barkeep,RoleLocation),
		at(Patron,Location),
		at(Barkeep,Location),
		is(Barkeep,barkeep,RoleLocation),
		is(Patron,patron,RoleLocation),
		at(Patron,RoleLocation),
		Barkeep != Patron,
		Barkeep != null,
		Patron != null.

hashed(serve_patron,15464427).

update(Patron,tiredness,0) :- not is(Patron,tiredness,_), occurred(action(serve_patron, Barkeep, Patron, null, null, null)).

update(Patron,tiredness,Y) :- is(Patron,tiredness,X), 0 = Y, occurred(action(serve_patron, Barkeep, Patron, null, null, null)).

add(Patron, drunk) :- occurred(action(serve_patron, Barkeep, Patron, null, null, null)).

is(serve_patron, work).

is(serve_patron, role_specific).

visibility(serve_patron,0).

action(chat_with_regular, Barkeep, Regular, null, null, null):-
		person(Barkeep),person(Regular),person(null),event(null),location(null),
		at(Barkeep,RoleLocation),
		at(Barkeep,Location),
		is(Regular,regular,RoleLocation),
		is(Barkeep,barkeep,RoleLocation),
		at(Regular,RoleLocation),
		at(Regular,Location),
		Barkeep != Regular,
		Barkeep != null,
		Regular != null.

hashed(chat_with_regular,2400446285).

update(Regular,likes,Barkeep,Y) :- is(Regular,likes,Barkeep,X), X + 1 = Y,occurred(action(chat_with_regular, Barkeep, Regular, null, null, null)).

update(Regular,likes,Barkeep,1) :- not is(Regular,likes,Barkeep,_), occurred(action(chat_with_regular, Barkeep, Regular, null, null, null)).

add(Regular, drunk) :- occurred(action(chat_with_regular, Barkeep, Regular, null, null, null)).

update(Barkeep,likes,Regular,Y) :- is(Barkeep,likes,Regular,X), X + 1 = Y,occurred(action(chat_with_regular, Barkeep, Regular, null, null, null)).

update(Barkeep,likes,Regular,1) :- not is(Barkeep,likes,Regular,_), occurred(action(chat_with_regular, Barkeep, Regular, null, null, null)).

is(chat_with_regular, role_specific).

is(chat_with_regular, talk).

visibility(chat_with_regular,0).

action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null):-
		person(Barkeep),person(Fighter1),person(Fighter2),event(null),location(null),
		is(Fighter2,likes,Fighter1,V_Fighter2_likes_Fighter1), V_Fighter2_likes_Fighter1 <= -3,
		at(Barkeep,RoleLocation),
		at(Fighter2,Location),
		at(Fighter1,Location),
		at(Barkeep,Location),
		is(Fighter2, drunk),
		is(Barkeep,barkeep,RoleLocation),
		is(Fighter1, drunk),
		is(Fighter1,likes,Fighter2,V_Fighter1_likes_Fighter2), V_Fighter1_likes_Fighter2 <= -3,
		Barkeep != Fighter1,
		Barkeep != Fighter2,
		Fighter1 != Fighter2,
		Barkeep != null,
		Fighter1 != null,
		Fighter2 != null.

hashed(breakup_barfight,256841022).

update(Barkeep,likes,Fighter1,Y) :- is(Barkeep,likes,Fighter1,X), X - 3 = Y, occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter2,-3) :- not is(Barkeep,likes,Fighter2,_), occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Fighter1,Y) :- is(Fighter2,likes,Fighter1,X), X - 3 = Y,occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Fighter1,-3) :- not is(Fighter2,likes,Fighter1,_), occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter1,-3) :- not is(Barkeep,likes,Fighter1,_), occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter1,likes,Fighter2,-3) :- not is(Fighter1,likes,Fighter2,_), occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter1,likes,Fighter2,Y) :- is(Fighter1,likes,Fighter2,X), X - 3 = Y,occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter2,Y) :- is(Barkeep,likes,Fighter2,X), X - 3 = Y, occurred(action(breakup_barfight, Barkeep, Fighter1, Fighter2, null, null)).

is(breakup_barfight, role_specific).

is(breakup_barfight, thoughtful).

visibility(breakup_barfight,0).

action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null):-
		person(Barkeep),person(Fighter1),person(Fighter2),event(null),location(null),
		is(Fighter2,likes,Fighter1,V_Fighter2_likes_Fighter1), V_Fighter2_likes_Fighter1 <= -3,
		at(Barkeep,RoleLocation),
		at(Fighter2,Location),
		at(Fighter1,Location),
		at(Barkeep,Location),
		is(Fighter2, drunk),
		is(Barkeep,barkeep,RoleLocation),
		is(Fighter1, drunk),
		is(Fighter1,likes,Fighter2,V_Fighter1_likes_Fighter2), V_Fighter1_likes_Fighter2 <= -3,
		Barkeep != Fighter1,
		Barkeep != Fighter2,
		Fighter1 != Fighter2,
		Barkeep != null,
		Fighter1 != null,
		Fighter2 != null.

hashed(breakup_cathartic_barfight,3481780173).

update(Fighter1,likes,Barkeep,Y) :- is(Fighter1,likes,Barkeep,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Fighter1,Y) :- is(Fighter2,likes,Fighter1,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter1,likes,Barkeep,3) :- not is(Fighter1,likes,Barkeep,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter1,likes,Fighter2,Y) :- is(Fighter1,likes,Fighter2,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter1,likes,Fighter2,3) :- not is(Fighter1,likes,Fighter2,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter2,3) :- not is(Barkeep,likes,Fighter2,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter2,Y) :- is(Barkeep,likes,Fighter2,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Barkeep,Y) :- is(Fighter2,likes,Barkeep,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Barkeep,3) :- not is(Fighter2,likes,Barkeep,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter1,3) :- not is(Barkeep,likes,Fighter1,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Barkeep,likes,Fighter1,Y) :- is(Barkeep,likes,Fighter1,X), X + 3 = Y,occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

update(Fighter2,likes,Fighter1,3) :- not is(Fighter2,likes,Fighter1,_), occurred(action(breakup_cathartic_barfight, Barkeep, Fighter1, Fighter2, null, null)).

is(breakup_cathartic_barfight, role_specific).

is(breakup_cathartic_barfight, thoughtful).

visibility(breakup_cathartic_barfight,0).

action(sober_up, Drunk, null, null, null, null):-
		person(Drunk),person(null),person(null),event(null),location(null),
		is(Drunk, drunk),
		at(Drunk,Location),
		Drunk != null.

hashed(sober_up,3120992131).

del(Drunk, drunk) :- occurred(action(sober_up, Drunk, null, null, null, null)).

is(sober_up, specific).

visibility(sober_up,0).

action(cast_ur_job, TheWorker, null, null, null, null):-
		person(TheWorker),person(null),person(null),event(null),location(null),
		castable(ur_job,Location),
		at(TheWorker,Location),
		mode(casting),
		not is(TheWorker, ur_job),
		TheWorker != null.

hashed(cast_ur_job,681582689).

add(TheWorker,ur_job,Location) :- at(TheWorker, Location), occurred(action(cast_ur_job, TheWorker, null, null, null, null)).

is(cast_ur_job, work).

visibility(cast_ur_job,0).

action(cast_monk, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(monk,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_monk,37490167).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_monk, Worker, null, null, null, null)).

add(Worker,monk,Location) :- at(Worker, Location), occurred(action(cast_monk, Worker, null, null, null, null)).

is(cast_monk, work).

is(cast_monk, religious).

visibility(cast_monk,0).

action(cast_foreman, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(foreman,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_foreman,457220032).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_foreman, Worker, null, null, null, null)).

add(Worker,foreman,Location) :- at(Worker, Location), occurred(action(cast_foreman, Worker, null, null, null, null)).

is(cast_foreman, talk).

is(cast_foreman, work).

is(cast_foreman, critical).

visibility(cast_foreman,0).

action(cast_miner, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(miner,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_miner,1881544711).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_miner, Worker, null, null, null, null)).

add(Worker,miner,Location) :- at(Worker, Location), occurred(action(cast_miner, Worker, null, null, null, null)).

is(cast_miner, work).

is(cast_miner, bold).

visibility(cast_miner,0).

action(cast_curator, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(curator,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_curator,235036349).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_curator, Worker, null, null, null, null)).

add(Worker,curator,Location) :- at(Worker, Location), occurred(action(cast_curator, Worker, null, null, null, null)).

is(cast_curator, work).

is(cast_curator, scholarly).

visibility(cast_curator,0).

action(cast_vendor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(vendor,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_vendor,2149809113).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_vendor, Worker, null, null, null, null)).

add(Worker,vendor,Location) :- at(Worker, Location), occurred(action(cast_vendor, Worker, null, null, null, null)).

is(cast_vendor, talk).

is(cast_vendor, work).

visibility(cast_vendor,0).

action(cast_enforcer, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(enforcer,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_enforcer,1887912917).

add(Worker,enforcer,Location) :- at(Worker, Location), occurred(action(cast_enforcer, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_enforcer, Worker, null, null, null, null)).

is(cast_enforcer, criminal).

is(cast_enforcer, work).

is(cast_enforcer, mean).

is(cast_enforcer, risky).

visibility(cast_enforcer,0).

action(cast_dockworker, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(dockworker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_dockworker,3105840004).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_dockworker, Worker, null, null, null, null)).

add(Worker,dockworker,Location) :- at(Worker, Location), occurred(action(cast_dockworker, Worker, null, null, null, null)).

is(cast_dockworker, work).

is(cast_dockworker, mariner).

visibility(cast_dockworker,0).

action(cast_librarian, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(librarian,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_librarian,2350257585).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_librarian, Worker, null, null, null, null)).

add(Worker,librarian,Location) :- at(Worker, Location), occurred(action(cast_librarian, Worker, null, null, null, null)).

is(cast_librarian, work).

is(cast_librarian, scholarly).

visibility(cast_librarian,0).

action(cast_chef, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(chef,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_chef,1085042918).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_chef, Worker, null, null, null, null)).

add(Worker,chef,Location) :- at(Worker, Location), occurred(action(cast_chef, Worker, null, null, null, null)).

is(cast_chef, talk).

is(cast_chef, work).

visibility(cast_chef,0).

action(cast_treasure_hunter, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(treasure_hunter,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_treasure_hunter,3115069461).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_treasure_hunter, Worker, null, null, null, null)).

add(Worker,treasure_hunter,Location) :- at(Worker, Location), occurred(action(cast_treasure_hunter, Worker, null, null, null, null)).

is(cast_treasure_hunter, criminal).

is(cast_treasure_hunter, risky).

is(cast_treasure_hunter, work).

is(cast_treasure_hunter, bold).

visibility(cast_treasure_hunter,0).

action(cast_archaelogist, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(archaelogist,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_archaelogist,3096517470).

add(Worker,archaelogist,Location) :- at(Worker, Location), occurred(action(cast_archaelogist, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_archaelogist, Worker, null, null, null, null)).

is(cast_archaelogist, work).

is(cast_archaelogist, scholarly).

is(cast_archaelogist, thoughtful).

visibility(cast_archaelogist,0).

action(cast_bard, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(bard,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_bard,2068234373).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_bard, Worker, null, null, null, null)).

add(Worker,bard,Location) :- at(Worker, Location), occurred(action(cast_bard, Worker, null, null, null, null)).

is(cast_bard, talk).

is(cast_bard, silly).

is(cast_bard, work).

visibility(cast_bard,0).

action(cast_monarch, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(monarch,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_monarch,3001504743).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_monarch, Worker, null, null, null, null)).

add(Worker,monarch,Location) :- at(Worker, Location), occurred(action(cast_monarch, Worker, null, null, null, null)).

is(cast_monarch, work).

is(cast_monarch, critical).

is(cast_monarch, bold).

visibility(cast_monarch,0).

action(cast_chancellor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(chancellor,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_chancellor,3456264334).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_chancellor, Worker, null, null, null, null)).

add(Worker,chancellor,Location) :- at(Worker, Location), occurred(action(cast_chancellor, Worker, null, null, null, null)).

is(cast_chancellor, talk).

is(cast_chancellor, work).

is(cast_chancellor, critical).

visibility(cast_chancellor,0).

action(cast_professor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(professor,Location),
		Worker != null.

hashed(cast_professor,3619081011).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_professor, Worker, null, null, null, null)).

add(Worker,professor,Location) :- at(Worker, Location), occurred(action(cast_professor, Worker, null, null, null, null)).

is(cast_professor, talk).

is(cast_professor, scholarly).

is(cast_professor, work).

is(cast_professor, critical).

visibility(cast_professor,0).

action(cast_spy_master, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(spy_master,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_spy_master,3947548369).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_spy_master, Worker, null, null, null, null)).

add(Worker,spy_master,Location) :- at(Worker, Location), occurred(action(cast_spy_master, Worker, null, null, null, null)).

is(cast_spy_master, work).

is(cast_spy_master, critical).

is(cast_spy_master, risky).

visibility(cast_spy_master,0).

action(cast_sailor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(sailor,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_sailor,47669604).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_sailor, Worker, null, null, null, null)).

add(Worker,sailor,Location) :- at(Worker, Location), occurred(action(cast_sailor, Worker, null, null, null, null)).

is(cast_sailor, work).

is(cast_sailor, physical).

visibility(cast_sailor,0).

action(cast_auctioneer, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(auctioneer,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_auctioneer,2398942100).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_auctioneer, Worker, null, null, null, null)).

add(Worker,auctioneer,Location) :- at(Worker, Location), occurred(action(cast_auctioneer, Worker, null, null, null, null)).

is(cast_auctioneer, talk).

is(cast_auctioneer, work).

is(cast_auctioneer, bold).

visibility(cast_auctioneer,0).

action(cast_artist, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(artist,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_artist,2979370592).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_artist, Worker, null, null, null, null)).

add(Worker,artist,Location) :- at(Worker, Location), occurred(action(cast_artist, Worker, null, null, null, null)).

is(cast_artist, work).

is(cast_artist, creative).

visibility(cast_artist,0).

action(cast_spy, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		not is(Worker, ur_job),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(spy,Location),
		Worker != null.

hashed(cast_spy,1456768721).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_spy, Worker, null, null, null, null)).

add(Worker,spy,Location) :- at(Worker, Location), occurred(action(cast_spy, Worker, null, null, null, null)).

is(cast_spy, work).

is(cast_spy, criminal).

visibility(cast_spy,0).

action(cast_tutor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(tutor,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_tutor,1888535063).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_tutor, Worker, null, null, null, null)).

add(Worker,tutor,Location) :- at(Worker, Location), occurred(action(cast_tutor, Worker, null, null, null, null)).

is(cast_tutor, work).

is(cast_tutor, scholarly).

visibility(cast_tutor,0).

action(cast_ship_builder, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(ship_builder,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_ship_builder,3651305260).

add(Worker,ship_builder,Location) :- at(Worker, Location), occurred(action(cast_ship_builder, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_ship_builder, Worker, null, null, null, null)).

is(cast_ship_builder, work).

visibility(cast_ship_builder,0).

action(cast_prostitute, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(prostitute,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_prostitute,1960064863).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_prostitute, Worker, null, null, null, null)).

add(Worker,prostitute,Location) :- at(Worker, Location), occurred(action(cast_prostitute, Worker, null, null, null, null)).

is(cast_prostitute, work).

visibility(cast_prostitute,0).

action(cast_student, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(student,Location),
		Worker != null.

hashed(cast_student,121481192).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_student, Worker, null, null, null, null)).

add(Worker,student,Location) :- at(Worker, Location), occurred(action(cast_student, Worker, null, null, null, null)).

is(cast_student, work).

is(cast_student, scholarly).

visibility(cast_student,0).

action(cast_smith_apprentice, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(smith_apprentice,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_smith_apprentice,3865805135).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_smith_apprentice, Worker, null, null, null, null)).

add(Worker,smith_apprentice,Location) :- at(Worker, Location), occurred(action(cast_smith_apprentice, Worker, null, null, null, null)).

is(cast_smith_apprentice, work).

visibility(cast_smith_apprentice,0).

action(cast_guard, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(guard,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_guard,2801145091).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_guard, Worker, null, null, null, null)).

add(Worker,guard,Location) :- at(Worker, Location), occurred(action(cast_guard, Worker, null, null, null, null)).

is(cast_guard, work).

visibility(cast_guard,0).

action(cast_shipping_foreman, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(shipping_foreman,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_shipping_foreman,1395473801).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_shipping_foreman, Worker, null, null, null, null)).

add(Worker,shipping_foreman,Location) :- at(Worker, Location), occurred(action(cast_shipping_foreman, Worker, null, null, null, null)).

is(cast_shipping_foreman, work).

visibility(cast_shipping_foreman,0).

action(cast_thief, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(thief,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_thief,1370252555).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_thief, Worker, null, null, null, null)).

add(Worker,thief,Location) :- at(Worker, Location), occurred(action(cast_thief, Worker, null, null, null, null)).

is(cast_thief, work).

visibility(cast_thief,0).

action(cast_impresario, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(impresario,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_impresario,2634565640).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_impresario, Worker, null, null, null, null)).

add(Worker,impresario,Location) :- at(Worker, Location), occurred(action(cast_impresario, Worker, null, null, null, null)).

is(cast_impresario, work).

visibility(cast_impresario,0).

action(cast_priest, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(priest,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_priest,332587877).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_priest, Worker, null, null, null, null)).

add(Worker,priest,Location) :- at(Worker, Location), occurred(action(cast_priest, Worker, null, null, null, null)).

is(cast_priest, work).

visibility(cast_priest,0).

action(cast_high_priest, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(high_priest,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_high_priest,1638976192).

add(Worker,high_priest,Location) :- at(Worker, Location), occurred(action(cast_high_priest, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_high_priest, Worker, null, null, null, null)).

is(cast_high_priest, work).

visibility(cast_high_priest,0).

action(cast_pickpocket, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(pickpocket,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_pickpocket,367139853).

add(Worker,pickpocket,Location) :- at(Worker, Location), occurred(action(cast_pickpocket, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_pickpocket, Worker, null, null, null, null)).

is(cast_pickpocket, work).

visibility(cast_pickpocket,0).

action(cast_engineer, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(engineer,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_engineer,2536316630).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_engineer, Worker, null, null, null, null)).

add(Worker,engineer,Location) :- at(Worker, Location), occurred(action(cast_engineer, Worker, null, null, null, null)).

is(cast_engineer, work).

visibility(cast_engineer,0).

action(cast_captain, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(captain,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_captain,3239883416).

add(Worker,captain,Location) :- at(Worker, Location), occurred(action(cast_captain, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_captain, Worker, null, null, null, null)).

is(cast_captain, work).

visibility(cast_captain,0).

action(cast_elder, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(elder,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_elder,2497673982).

add(Worker,elder,Location) :- at(Worker, Location), occurred(action(cast_elder, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_elder, Worker, null, null, null, null)).

is(cast_elder, work).

visibility(cast_elder,0).

action(cast_fisher, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(fisher,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_fisher,1647130145).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_fisher, Worker, null, null, null, null)).

add(Worker,fisher,Location) :- at(Worker, Location), occurred(action(cast_fisher, Worker, null, null, null, null)).

is(cast_fisher, work).

visibility(cast_fisher,0).

action(cast_master_thief, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		not is(Worker, ur_job),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(master_thief,Location),
		Worker != null.

hashed(cast_master_thief,2791087122).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_master_thief, Worker, null, null, null, null)).

add(Worker,master_thief,Location) :- at(Worker, Location), occurred(action(cast_master_thief, Worker, null, null, null, null)).

is(cast_master_thief, criminal).

is(cast_master_thief, work).

visibility(cast_master_thief,0).

action(cast_patron, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(patron,Location),
		Worker != null.

hashed(cast_patron,1007065881).

add(Worker,patron,Location) :- at(Worker, Location), occurred(action(cast_patron, Worker, null, null, null, null)).

is(cast_patron, free).

visibility(cast_patron,0).

action(cast_smithy, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		not is(Worker, ur_job),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(smithy,Location),
		Worker != null.

hashed(cast_smithy,3616776956).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_smithy, Worker, null, null, null, null)).

add(Worker,smithy,Location) :- at(Worker, Location), occurred(action(cast_smithy, Worker, null, null, null, null)).

is(cast_smithy, work).

visibility(cast_smithy,0).

action(cast_researcher, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(researcher,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_researcher,3161432146).

add(Worker,researcher,Location) :- at(Worker, Location), occurred(action(cast_researcher, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_researcher, Worker, null, null, null, null)).

is(cast_researcher, work).

is(cast_researcher, scholarly).

visibility(cast_researcher,0).

action(cast_diva, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(diva,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_diva,2158051114).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_diva, Worker, null, null, null, null)).

add(Worker,diva,Location) :- at(Worker, Location), occurred(action(cast_diva, Worker, null, null, null, null)).

is(cast_diva, work).

is(cast_diva, talk).

visibility(cast_diva,0).

action(cast_barkeep, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(barkeep,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

hashed(cast_barkeep,2967007036).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_barkeep, Worker, null, null, null, null)).

add(Worker,barkeep,Location) :- at(Worker, Location), occurred(action(cast_barkeep, Worker, null, null, null, null)).

is(cast_barkeep, work).

is(cast_barkeep, talk).

visibility(cast_barkeep,0).

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

trait(stay_in_confinement).

trait(visiting_places_you_like).

trait(visiting_as_regular).

propensity(romance, 3, romantic_towards_crush,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, romantic_towards_crush),
		is(Self,crushing_on,Other),
		is(ACTION_NAME,romance).

trait(romantic_towards_crush).

trait(stay_at_hometown).

propensity(role_specific, 4, do_role_specific_actions,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, do_role_specific_actions),
		is(ACTION_NAME,role_specific).

trait(do_role_specific_actions).

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