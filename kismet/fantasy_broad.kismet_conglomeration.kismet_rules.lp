castable(monarch,throne_room).

castable(chancellor,throne_room).

castable(royalty,throne_room).

castable(citizen,throne_room).

castable(foreman,docks).

castable(dockworker,docks).

castable(prostitute,docks).

castable(fisher,docks).

castable(visitor,docks).

castable(curator,auction_house).

castable(auctioneer,auction_house).

castable(patron,auction_house).

castable(guest,ballroom).

castable(owner,ballroom).

castable(artist,ballroom).

castable(visitor,quad).

castable(miner,mine).

castable(foreman,mine).

castable(elder,elders_house).

castable(visitor,elders_house).

castable(guard,dungeon).

castable(prisoner,dungeon).

castable(impresario,opera_house).

castable(diva,opera_house).

castable(tourist,opera_house).

castable(bard,opera_house).

castable(patron,opera_house).

castable(smith_apprentice,smith).

castable(smithy,smith).

castable(patron,smith).

castable(sailor,boat).

castable(captain,boat).

castable(passenger,boat).

castable(spy,thieves_den).

castable(thief,thieves_den).

castable(spy_master,thieves_den).

castable(master_thief,thieves_den).

castable(librarian,library).

castable(tutor,library).

castable(student,library).

castable(researcher,library).

castable(visitor,library).

castable(guest,kitchen).

castable(chef,kitchen).

castable(worker,kitchen).

castable(owner,kitchen).

castable(tourist,amphitheatre).

castable(bard,amphitheatre).

castable(owner,shipyard).

castable(engineer,shipyard).

castable(ship_builder,shipyard).

castable(visitor,shipyard).

castable(archaelogist,ruins).

castable(treasure_hunter,ruins).

castable(visitor,ruins).

castable(priest,temple).

castable(follower,temple).

castable(monk,temple).

castable(high_priest,temple).

castable(parishioner,temple).

castable(vendor,marketplace).

castable(enforcer,marketplace).

castable(pickpocket,marketplace).

castable(racketeer,marketplace).

castable(patron,marketplace).

castable(regular,tavern).

castable(owner,tavern).

castable(barkeep,tavern).

castable(patron,tavern).

castable(student,classroom).

castable(professor,classroom).

castable(dean,classroom).

castable(guest,garden).

castable(gardener,garden).

castable(owner,garden).

castable(visitor,garden).

action(chit_chat, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(chit_chat, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(chit_chat, Self, Other, null, null, null)).

is(chit_chat, talk).

visibility(chit_chat,0).

action(complain_to_and_make_annoyed, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		not is(Other, compassionate),
		Self != Other,
		Self != null,
		Other != null.

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y, occurred(action(complain_to_and_make_annoyed, Self, Other, null, null, null)).

is(complain_to_and_make_annoyed, talk).

is(complain_to_and_make_annoyed, critical).

is(complain_to_and_make_annoyed, failure).

visibility(complain_to_and_make_annoyed,0).

action(complain_to_compassionate, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		not is(Other, compassionate),
		Self != Other,
		Self != null,
		Other != null.

update(Other,self_worth,Y) :- is(Other,self_worth,X), X + 1 = Y, occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(complain_to_compassionate, Self, Other, null, null, null)).

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

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y, occurred(action(flirt_at, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(flirt_at, Self, Other, null, null, null)).

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

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(flirt_with, Self, Other, null, null, null)).

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

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(use_humor_to_spark_love, Self, Other, null, null, null)).

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

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 2 = Y,occurred(action(be_open_about_crush, Self, Other, null, null, null)).

is(be_open_about_crush, romance).

is(be_open_about_crush, bold).

is(be_open_about_crush, specific).

visibility(be_open_about_crush,0).

action(be_open_about_crush_and_burn, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self,crushing_on,Other),
		at(Other,Location),
		at(Self,Location),
		is(Other,loves,Self,V_Other_loves_Self), V_Other_loves_Self <= 0,
		Self != Other,
		Self != null,
		Other != null.

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

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y, occurred(action(pine_over, Self, Other, null, null, null)).

is(pine_over, romance).

visibility(pine_over,0).

action(make_out_with, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		at(Other,Location),
		at(Self,Location),
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		Self != Other,
		Self != null,
		Other != null.

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X + 1 = Y,occurred(action(make_out_with, Self, Other, null, null, null)).

is(make_out_with, romance).

visibility(make_out_with,0).

action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null):-
		person(Self),person(Other),person(ThirdWheel),event(null),location(null),
		at(Other,Location),
		is(Other,loves,ThirdWheel,V_Other_love_ThirdWheel), V_Other_love_ThirdWheel >= 3,
		at(ThirdWheel,Location),
		at(Self,Location),
		is(ThirdWheel,loves,Other,V_ThirdWheel_love_Other), V_ThirdWheel_love_Other >= 3,
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		Self != Other,
		Self != ThirdWheel,
		Other != ThirdWheel,
		Self != null,
		Other != null,
		ThirdWheel != null.

update(ThirdWheel,loves,Self,Y) :- is(ThirdWheel,loves,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,loves,ThirdWheel,Y) :- is(Self,loves,ThirdWheel,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,likes,ThirdWheel,Y) :- is(Self,likes,ThirdWheel,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(ThirdWheel,likes,Self,Y) :- is(ThirdWheel,likes,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

update(Self,loves,Other,Y) :- is(Self,loves,Other,X), X - 5 = Y,occurred(action(blow_up_love_triangle, Self, Other, ThirdWheel, null, null)).

is(blow_up_love_triangle, talk).

is(blow_up_love_triangle, romance).

is(blow_up_love_triangle, angry).

visibility(blow_up_love_triangle,0).

action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null):-
		person(Self),person(Other),person(ThirdWheel),event(null),location(null),
		at(Other,Location),
		is(Other,loves,ThirdWheel,V_Other_love_ThirdWheel), V_Other_love_ThirdWheel >= 3,
		at(ThirdWheel,Location),
		at(Self,Location),
		is(ThirdWheel,loves,Other,V_ThirdWheel_love_Other), V_ThirdWheel_love_Other >= 3,
		is(Self,loves,Other,V_Self_love_Other), V_Self_love_Other >= 3,
		is(Other,loves,Self,V_Other_love_Self), V_Other_love_Self >= 3,
		Self != Other,
		Self != ThirdWheel,
		Other != ThirdWheel,
		Self != null,
		Other != null,
		ThirdWheel != null.

update(Self,likes,ThirdWheel,Y) :- is(Self,likes,ThirdWheel,X), X - 2 = Y, occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

update(Self,loves,ThirdWheel,Y) :- is(Self,loves,ThirdWheel,X), X - 2 = Y, occurred(action(plot_about_sabotaging_romantic_rival, Self, Other, ThirdWheel, null, null)).

is(plot_about_sabotaging_romantic_rival, talk).

is(plot_about_sabotaging_romantic_rival, romance).

is(plot_about_sabotaging_romantic_rival, angry).

visibility(plot_about_sabotaging_romantic_rival,0).

action(reject_romance, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,loves,Self,V_Other_loves_Self), V_Other_loves_Self >= 5,
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other <= 0,
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

update(Other,loves,Self,Y) :- is(Other,loves,Self,X), X - 5 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,self_worth,Y) :- is(Other,self_worth,X), X - 1 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 5 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

update(Other,shame,Y) :- is(Other,shame,X), X + 1 = Y, occurred(action(reject_romance, Self, Other, null, null, null)).

is(reject_romance, talk).

visibility(reject_romance,0).

action(insult_as_bully, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Self, bully),
		at(Other,Location),
		at(Self,Location),
		Self != Other,
		Self != null,
		Other != null.

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 3 = Y, occurred(action(insult_as_bully, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(insult_as_bully, Self, Other, null, null, null)).

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

update(Self,self_worth,Y) :- is(Self,self_worth,X), X - 1 = Y, occurred(action(insult, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 3 = Y, occurred(action(insult, Self, Other, null, null, null)).

is(insult, talk).

is(insult, mean).

visibility(insult,0).

action(sulk, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		is(Self,self_worth,V_Self_self_worth), V_Self_self_worth <= -3,
		at(Self,Location),
		Self != null.

is(sulk, worry).

visibility(sulk,0).

action(have_catharsis, Self, null, null, null, null):-
		person(Self),person(null),person(null),event(null),location(null),
		is(Self,self_worth,V_Self_self_worth), V_Self_self_worth <= -3,
		at(Self,Location),
		Self != null.

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(have_catharsis, Self, null, null, null, null)).

is(have_catharsis, thoughtful).

visibility(have_catharsis,0).

action(try_to_help_struggling_friend, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -3,
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other >= 3,
		at(Other,Location),
		at(Self,Location),
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self >= 3,
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(try_to_help_struggling_friend, Self, Other, null, null, null)).

is(try_to_help_struggling_friend, thoughtful).

visibility(try_to_help_struggling_friend,0).

action(help_struggling_friend, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -3,
		at(Other,Location),
		is(Other,likes,Self,V_Other_like_Self), V_Other_like_Self >= 3,
		at(Self,Location),
		is(Self,likes,Other,V_Self_like_Other), V_Self_like_Other >= 3,
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(help_struggling_friend, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(help_struggling_friend, Self, Other, null, null, null)).

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

add(Other,knows_personal_info_about,Self) :-occurred(action(share_personal_info, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(share_personal_info, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(share_personal_info, Self, Other, null, null, null)).

is(share_personal_info, talk).

is(share_personal_info, bold).

is(share_personal_info, thoughtful).

visibility(share_personal_info,0).

action(help_really_struggling_person, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		is(Other,self_worth,V_Other_self_worth), V_Other_self_worth <= -5,
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(help_really_struggling_person, Self, Other, null, null, null)).

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

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 2 = Y,occurred(action(joke_around_with, Self, Other, null, null, null)).

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

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y, occurred(action(criticize, Self, Other, null, null, null)).

is(criticize, talk).

is(criticize, critical).

visibility(criticize,0).

action(provide_critical_feedback, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Self,Location),
		is(Other, agreeable),
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(provide_critical_feedback, Self, Other, null, null, null)).

is(provide_critical_feedback, talk).

is(provide_critical_feedback, critical).

is(provide_critical_feedback, specific).

visibility(provide_critical_feedback,0).

action(get_into_argument, Self, Other, null, null, null):-
		person(Self),person(Other),person(null),event(null),location(null),
		is(Other,likes,Self,V_Other_likes_Self), V_Other_likes_Self <= -1,
		at(Other,Location),
		at(Self,Location),
		is(Self,likes,Other,V_Self_likes_Other), V_Self_likes_Other <= -1,
		Self != Other,
		Self != null,
		Other != null.

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 1 = Y,occurred(action(get_into_argument, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y,occurred(action(get_into_argument, Self, Other, null, null, null)).

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

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X + 1 = Y,occurred(action(impress, Self, Other, null, null, null)).

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X + 1 = Y,occurred(action(impress, Self, Other, null, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(impress, Self, Other, null, null, null)).

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

update(Self,likes,Other,Y) :- is(Self,likes,Other,X), X - 1 = Y,occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

update(Other,likes,Self,Y) :- is(Other,likes,Self,X), X - 1 = Y,occurred(action(try_to_impress_and_fail, Self, Other, null, null, null)).

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

update(Disliker,likes,Friend,Y) :- is(Disliker,likes,Friend,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Disliker,likes,Self,Y) :- is(Disliker,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Friend,likes,Self,Y) :- is(Friend,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_persuade, Self, Other, Friend, null, null)).

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

update(Disliker,likes,Friend,Y) :- is(Disliker,likes,Friend,X), X - 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Disliker,likes,Self,Y) :- is(Disliker,likes,Self,X), X - 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Friend,likes,Self,Y) :- is(Friend,likes,Self,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

update(Self,self_worth,Y) :- is(Self,self_worth,X), X + 1 = Y, occurred(action(stand_up_for_friend_and_fail, Self, Other, Friend, null, null)).

is(stand_up_for_friend_and_fail, talk).

is(stand_up_for_friend_and_fail, bold).

is(stand_up_for_friend_and_fail, failure).

visibility(stand_up_for_friend_and_fail,0).

action(pray, Monk, null, null, null, null):-
		person(Monk),person(null),person(null),event(null),location(null),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		at(Monk,Location),
		Monk != null.

update(Monk,devotion,Y) :- is(Monk,devotion,X), X + 1 = Y, occurred(action(pray, Monk, null, null, null, null)).

is(pray, religious).

visibility(pray,0).

action(perform_ritual, Monk, Other, null, null, null):-
		person(Monk),person(Other),person(null),event(null),location(null),
		at(Other,RoleLocation),
		at(Other,Location),
		is(Other,monk,RoleLocation),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		at(Monk,Location),
		Monk != Other,
		Monk != null,
		Other != null.

update(Monk,devotion,Y) :- is(Monk,devotion,X), X + 2 = Y, occurred(action(perform_ritual, Monk, Other, null, null, null)).

update(Other,devotion,Y) :- is(Other,devotion,X), X + 2 = Y, occurred(action(perform_ritual, Monk, Other, null, null, null)).

is(perform_ritual, religious).

visibility(perform_ritual,0).

action(screw_up_ritual, Monk, Other, null, null, null):-
		person(Monk),person(Other),person(null),event(null),location(null),
		at(Other,RoleLocation),
		at(Other,Location),
		is(Other,monk,RoleLocation),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		at(Monk,Location),
		Monk != Other,
		Monk != null,
		Other != null.

update(Monk,devotion,Y) :- is(Monk,devotion,X), X - 1 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Other,devotion,Y) :- is(Other,devotion,X), X - 1 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

update(Other,likes,Monk,Y) :- is(Other,likes,Monk,X), X - 2 = Y, occurred(action(screw_up_ritual, Monk, Other, null, null, null)).

is(screw_up_ritual, religious).

is(screw_up_ritual, failure).

visibility(screw_up_ritual,0).

action(have_crisis_of_faith, Monk, null, null, null, null):-
		person(Monk),person(null),person(null),event(null),location(null),
		at(Monk,RoleLocation),
		is(Monk,monk,RoleLocation),
		at(Monk,Location),
		Monk != null.

update(Monk,devotion,Y) :- is(Monk,devotion,X), X - 2 = Y, occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

update(Monk,self_worth,Y) :- is(Monk,self_worth,X), X - 1 = Y, occurred(action(have_crisis_of_faith, Monk, null, null, null, null)).

is(have_crisis_of_faith, religious).

is(have_crisis_of_faith, worry).

visibility(have_crisis_of_faith,0).

action(manage_mine, Foreman, null, null, null, null):-
		person(Foreman),person(null),person(null),event(null),location(null),
		at(Foreman,Location),
		is(Foreman,foreman,RoleLocation),
		at(Foreman,RoleLocation),
		Foreman != null.

is(manage_mine, work).

visibility(manage_mine,0).

action(boss_miner_around, Foreman, Miner, null, null, null):-
		person(Foreman),person(Miner),person(null),event(null),location(null),
		at(Miner,RoleLocation),
		at(Foreman,Location),
		is(Foreman,foreman,RoleLocation),
		at(Foreman,RoleLocation),
		at(Miner,Location),
		is(Miner,miner,RoleLocation),
		Foreman != Miner,
		Foreman != null,
		Miner != null.

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X - 1 = Y, occurred(action(boss_miner_around, Foreman, Miner, null, null, null)).

is(boss_miner_around, work).

is(boss_miner_around, critical).

visibility(boss_miner_around,0).

action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Foreman,Location),
		at(Miner,Location),
		is(Miner2,likes,Miner,V_Miner2_likes_Miner), V_Miner2_likes_Miner <= -1,
		is(Miner,likes,Miner2,V_Miner_likes_Miner2), V_Miner_likes_Miner2 <= -1,
		is(Foreman,foreman,RoleLocation),
		at(Foreman,RoleLocation),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner2,Location),
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

update(Miner2,likes,Miner,Y) :- is(Miner2,likes,Miner,X), X + 1 = Y,occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X + 1 = Y, occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X + 1 = Y, occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Miner2,Y) :- is(Miner,likes,Miner2,X), X + 1 = Y,occurred(action(manage_dispute_between_miners, Foreman, Miner, Miner2, null, null)).

is(manage_dispute_between_miners, work).

is(manage_dispute_between_miners, thoughtful).

is(manage_dispute_between_miners, kind).

visibility(manage_dispute_between_miners,0).

action(endanger_miners, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Foreman,Location),
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		at(Foreman,RoleLocation),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner2,Location),
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,Y) :- is(Miner2,likes,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X - 2 = Y, occurred(action(endanger_miners, Foreman, Miner, Miner2, null, null)).

is(endanger_miners, work).

is(endanger_miners, risky).

visibility(endanger_miners,0).

action(strike_motherlode, Foreman, Miner, Miner2, null, null):-
		person(Foreman),person(Miner),person(Miner2),event(null),location(null),
		at(Miner,RoleLocation),
		at(Foreman,Location),
		at(Miner,Location),
		is(Foreman,foreman,RoleLocation),
		at(Foreman,RoleLocation),
		is(Miner2,miner,RoleLocation),
		at(Miner2,RoleLocation),
		is(Miner,miner,RoleLocation),
		at(Miner2,Location),
		Foreman != Miner,
		Foreman != Miner2,
		Miner != Miner2,
		Foreman != null,
		Miner != null,
		Miner2 != null.

update(Miner,likes,Foreman,Y) :- is(Miner,likes,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner2,respects,Foreman,Y) :- is(Miner2,respects,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner,respects,Foreman,Y) :- is(Miner,respects,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Miner2,likes,Foreman,Y) :- is(Miner2,likes,Foreman,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

update(Foreman,self_worth,Y) :- is(Foreman,self_worth,X), X + 2 = Y, occurred(action(strike_motherlode, Foreman, Miner, Miner2, null, null)).

is(strike_motherlode, work).

is(strike_motherlode, risky).

is(strike_motherlode, rare).

visibility(strike_motherlode,0).

action(mine, Miner, null, null, null, null):-
		person(Miner),person(null),person(null),event(null),location(null),
		is(Miner,miner,RoleLocation),
		at(Miner,RoleLocation),
		at(Miner,Location),
		Miner != null.

update(Miner,tiredness,Y) :- is(Miner,tiredness,X), X + 1 = Y, occurred(action(mine, Miner, null, null, null, null)).

is(mine, work).

visibility(mine,0).

action(hold_auction, Auctioneer, P1, P2, null, null):-
		person(Auctioneer),person(P1),person(P2),event(null),location(null),
		at(P1,RoleLocation),
		is(Auctioneer,auctioneer,RoleLocation),
		at(P1,Location),
		at(Auctioneer,Location),
		at(P2,RoleLocation),
		is(P1,patron,RoleLocation),
		is(P2,patron,RoleLocation),
		at(Auctioneer,RoleLocation),
		at(P2,Location),
		Auctioneer != P1,
		Auctioneer != P2,
		P1 != P2,
		Auctioneer != null,
		P1 != null,
		P2 != null.

update(Auctioneer,self_worth,Y) :- is(Auctioneer,self_worth,X), X + 1 = Y, occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

update(P1,self_worth,Y) :- is(P1,self_worth,X), X + 1 = Y, occurred(action(hold_auction, Auctioneer, P1, P2, null, null)).

is(hold_auction, work).

is(hold_auction, bold).

is(hold_auction, talk).

visibility(hold_auction,0).

action(discuss_collection, Auctioneer, Curator, null, null, null):-
		person(Auctioneer),person(Curator),person(null),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		at(Auctioneer,Location),
		at(Curator,RoleLocation),
		at(Auctioneer,RoleLocation),
		Auctioneer != Curator,
		Auctioneer != null,
		Curator != null.

update(Auctioneer,likes,Curator,Y) :- is(Auctioneer,likes,Curator,X), X + 1 = Y,occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

update(Curator,likes,Auctioneer,Y) :- is(Curator,likes,Auctioneer,X), X + 1 = Y,occurred(action(discuss_collection, Auctioneer, Curator, null, null, null)).

is(discuss_collection, work).

is(discuss_collection, talk).

is(discuss_collection, thoughtful).

visibility(discuss_collection,0).

action(demand_a_new_piece, Auctioneer, Curator, null, null, null):-
		person(Auctioneer),person(Curator),person(null),event(null),location(null),
		is(Auctioneer,auctioneer,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		at(Auctioneer,Location),
		at(Curator,RoleLocation),
		at(Auctioneer,RoleLocation),
		Auctioneer != Curator,
		Auctioneer != null,
		Curator != null.

update(Curator,likes,Auctioneer,Y) :- is(Curator,likes,Auctioneer,X), X - 2 = Y,occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

update(Auctioneer,likes,Curator,Y) :- is(Auctioneer,likes,Curator,X), X - 2 = Y,occurred(action(demand_a_new_piece, Auctioneer, Curator, null, null, null)).

is(demand_a_new_piece, work).

is(demand_a_new_piece, talk).

is(demand_a_new_piece, mean).

visibility(demand_a_new_piece,0).

action(curate_collection, Curator, null, null, null, null):-
		person(Curator),person(null),person(null),event(null),location(null),
		at(Curator,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		Curator != null.

is(curate_collection, work).

visibility(curate_collection,0).

action(acquire_artifacts, Curator, null, null, null, null):-
		person(Curator),person(null),person(null),event(null),location(null),
		at(Curator,RoleLocation),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		Curator != null.

update(Curator,self_worth,Y) :- is(Curator,self_worth,X), X + 1 = Y, occurred(action(acquire_artifacts, Curator, null, null, null, null)).

is(acquire_artifacts, work).

is(acquire_artifacts, bold).

visibility(acquire_artifacts,0).

action(discuss_collection, Curator, Other, null, null, null):-
		person(Curator),person(Other),person(null),event(null),location(null),
		at(Curator,RoleLocation),
		at(Other,Location),
		is(Curator,curator,RoleLocation),
		at(Curator,Location),
		Curator != Other,
		Curator != null,
		Other != null.

update(Other,respects,Curator,Y) :- is(Other,respects,Curator,X), X + 1 = Y, occurred(action(discuss_collection, Curator, Other, null, null, null)).

is(discuss_collection, work).

is(discuss_collection, talk).

visibility(discuss_collection,0).

action(sell_wares, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		at(Other,Location),
		at(Vendor,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		Vendor != Other,
		Vendor != null,
		Other != null.

update(Vendor,likes,Other,Y) :- is(Vendor,likes,Other,X), X + 1 = Y, occurred(action(sell_wares, Vendor, Other, null, null, null)).

is(sell_wares, work).

visibility(sell_wares,0).

action(give_deal_to, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		is(Vendor,likes,Other,V_Vendor_likes_Other), V_Vendor_likes_Other >= 3,
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		at(Other,Location),
		at(Vendor,RoleLocation),
		Vendor != Other,
		Vendor != null,
		Other != null.

update(Other,likes,Vendor,Y) :- is(Other,likes,Vendor,X), X + 2 = Y, occurred(action(give_deal_to, Vendor, Other, null, null, null)).

is(give_deal_to, work).

is(give_deal_to, kind).

is(give_deal_to, talk).

visibility(give_deal_to,0).

action(hustle, Vendor, Other, null, null, null):-
		person(Vendor),person(Other),person(null),event(null),location(null),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		is(Vendor,likes,Other,V_Vendor_likes_Other), V_Vendor_likes_Other <= 0,
		at(Other,Location),
		at(Vendor,RoleLocation),
		Vendor != Other,
		Vendor != null,
		Other != null.

update(Vendor,self_worth,Y) :- is(Vendor,self_worth,X), X + 1 = Y, occurred(action(hustle, Vendor, Other, null, null, null)).

update(Other,likes,Vendor,Y) :- is(Other,likes,Vendor,X), X - 1 = Y, occurred(action(hustle, Vendor, Other, null, null, null)).

is(hustle, work).

is(hustle, bold).

is(hustle, mean).

is(hustle, risky).

visibility(hustle,0).

action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null):-
		person(Vendor),person(OtherVendor),person(null),event(null),location(null),
		at(OtherVendor,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		at(Vendor,RoleLocation),
		at(OtherVendor,Location),
		is(OtherVendor,vendor,RoleLocation),
		Vendor != OtherVendor,
		Vendor != null,
		OtherVendor != null.

update(Vendor,likes,OtherVendor,Y) :- is(Vendor,likes,OtherVendor,X), X + 1 = Y,occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

update(OtherVendor,likes,Vendor,Y) :- is(OtherVendor,likes,Vendor,X), X + 1 = Y,occurred(action(commiserate_with_fellow_vendor, Vendor, OtherVendor, null, null, null)).

is(commiserate_with_fellow_vendor, work).

is(commiserate_with_fellow_vendor, talk).

is(commiserate_with_fellow_vendor, thoughtful).

is(commiserate_with_fellow_vendor, kind).

visibility(commiserate_with_fellow_vendor,0).

action(undercut, Vendor, OtherVendor, null, null, null):-
		person(Vendor),person(OtherVendor),person(null),event(null),location(null),
		at(OtherVendor,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		is(Vendor,likes,OtherVendor,V_Vendor_likes_OtherVendor), V_Vendor_likes_OtherVendor <= 0,
		at(Vendor,RoleLocation),
		at(OtherVendor,Location),
		is(OtherVendor,vendor,RoleLocation),
		Vendor != OtherVendor,
		Vendor != null,
		OtherVendor != null.

update(Vendor,self_worth,Y) :- is(Vendor,self_worth,X), X + 1 = Y, occurred(action(undercut, Vendor, OtherVendor, null, null, null)).

update(OtherVendor,likes,Vendor,Y) :- is(OtherVendor,likes,Vendor,X), X - 1 = Y, occurred(action(undercut, Vendor, OtherVendor, null, null, null)).

is(undercut, work).

is(undercut, bold).

is(undercut, mean).

visibility(undercut,0).

action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null):-
		person(Vendor),person(OtherVendor),person(Enforcer),event(null),location(null),
		at(OtherVendor,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Vendor,Location),
		at(Enforcer,Location),
		is(Vendor,fears,Enforcer,V_Vendor_fears_Enforcer), V_Vendor_fears_Enforcer >= 6,
		at(Vendor,RoleLocation),
		is(OtherVendor,fears,Enforcer,V_OtherVendor_fears_Enforcer), V_OtherVendor_fears_Enforcer >= 6,
		at(OtherVendor,Location),
		is(OtherVendor,vendor,RoleLocation),
		Vendor != OtherVendor,
		Vendor != Enforcer,
		OtherVendor != Enforcer,
		Vendor != null,
		OtherVendor != null,
		Enforcer != null.

update(Vendor,likes,OtherVendor,Y) :- is(Vendor,likes,OtherVendor,X), X + 5 = Y,occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Enforcer,likes,OtherVendor,Y) :- is(Enforcer,likes,OtherVendor,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Vendor,fears,Enforcer,Y) :- is(Vendor,fears,Enforcer,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(Enforcer,likes,Vendor,Y) :- is(Enforcer,likes,Vendor,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,likes,Vendor,Y) :- is(OtherVendor,likes,Vendor,X), X + 5 = Y,occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

update(OtherVendor,fears,Enforcer,Y) :- is(OtherVendor,fears,Enforcer,X), X - 3 = Y, occurred(action(standup_to_enforcer_together, Vendor, OtherVendor, Enforcer, null, null)).

is(standup_to_enforcer_together, work).

is(standup_to_enforcer_together, bold).

visibility(standup_to_enforcer_together,0).

action(collect_protection_fees, Enforcer, Vendor, null, null, null):-
		person(Enforcer),person(Vendor),person(null),event(null),location(null),
		is(Enforcer,enforcer,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Enforcer,RoleLocation),
		at(Vendor,Location),
		at(Enforcer,Location),
		at(Vendor,RoleLocation),
		Enforcer != Vendor,
		Enforcer != null,
		Vendor != null.

update(Vendor,likes,Enforcer,Y) :- is(Vendor,likes,Enforcer,X), X - 1 = Y, occurred(action(collect_protection_fees, Enforcer, Vendor, null, null, null)).

is(collect_protection_fees, work).

is(collect_protection_fees, mean).

is(collect_protection_fees, risky).

is(collect_protection_fees, criminal).

visibility(collect_protection_fees,0).

action(rough_up, Enforcer, Vendor, null, null, null):-
		person(Enforcer),person(Vendor),person(null),event(null),location(null),
		is(Enforcer,enforcer,RoleLocation),
		is(Vendor,vendor,RoleLocation),
		at(Enforcer,RoleLocation),
		at(Vendor,Location),
		at(Enforcer,Location),
		at(Vendor,RoleLocation),
		Enforcer != Vendor,
		Enforcer != null,
		Vendor != null.

update(Vendor,fears,Enforcer,Y) :- is(Vendor,fears,Enforcer,X), X + 2 = Y, occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

update(Vendor,likes,Enforcer,Y) :- is(Vendor,likes,Enforcer,X), X - 2 = Y, occurred(action(rough_up, Enforcer, Vendor, null, null, null)).

is(rough_up, work).

is(rough_up, mean).

is(rough_up, risky).

is(rough_up, criminal).

visibility(rough_up,0).

action(load_cargo, Dockworker, null, null, null, null):-
		person(Dockworker),person(null),person(null),event(null),location(null),
		at(Dockworker,Location),
		at(Dockworker,RoleLocation),
		is(Dockworker,dockworker,RoleLocation),
		Dockworker != null.

update(Dockworker,tiredness,Y) :- is(Dockworker,tiredness,X), X + 1 = Y, occurred(action(load_cargo, Dockworker, null, null, null, null)).

is(load_cargo, work).

visibility(load_cargo,0).

action(fight_seagull, Dockworker, null, null, null, null):-
		person(Dockworker),person(null),person(null),event(null),location(null),
		at(Dockworker,Location),
		at(Dockworker,RoleLocation),
		is(Dockworker,dockworker,RoleLocation),
		Dockworker != null.

update(Dockworker,anger,Y) :- is(Dockworker,anger,X), X + 1 = Y, occurred(action(fight_seagull, Dockworker, null, null, null, null)).

is(fight_seagull, angry).

is(fight_seagull, rare).

visibility(fight_seagull,0).

action(stock_books, Librarian, null, null, null, null):-
		person(Librarian),person(null),person(null),event(null),location(null),
		at(Librarian,Location),
		at(Librarian,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		Librarian != null.

update(Librarian,tiredness,Y) :- is(Librarian,tiredness,X), X + 1 = Y, occurred(action(stock_books, Librarian, null, null, null, null)).

is(stock_books, work).

is(stock_books, scholarly).

visibility(stock_books,0).

action(shush_patron, Librarian, Patron, null, null, null):-
		person(Librarian),person(Patron),person(null),event(null),location(null),
		is(Patron,guest,RoleLocation),
		at(Librarian,RoleLocation),
		at(Patron,Location),
		at(Librarian,Location),
		at(Patron,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		Librarian != Patron,
		Librarian != null,
		Patron != null.

update(Patron,shame,Y) :- is(Patron,shame,X), X + 1 = Y, occurred(action(shush_patron, Librarian, Patron, null, null, null)).

update(Patron,likes,Librarian,Y) :- is(Patron,likes,Librarian,X), X - 1 = Y, occurred(action(shush_patron, Librarian, Patron, null, null, null)).

is(shush_patron, work).

is(shush_patron, mean).

is(shush_patron, bold).

visibility(shush_patron,0).

action(assist_research, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Researcher,Location),
		at(Researcher,RoleLocation),
		is(Researcher,researcher,RoleLocation),
		at(Librarian,RoleLocation),
		at(Librarian,Location),
		is(Librarian,librarian,RoleLocation),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

is(assist_research, work).

is(assist_research, scholarly).

visibility(assist_research,0).

action(assist_research, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Researcher,Location),
		at(Researcher,RoleLocation),
		at(Librarian,RoleLocation),
		is(Researcher, scholar),
		at(Librarian,Location),
		is(Researcher,guest,RoleLocation),
		is(Librarian,librarian,RoleLocation),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_research, Librarian, Researcher, null, null, null)).

is(assist_research, work).

is(assist_research, scholarly).

visibility(assist_research,0).

action(assist_student, Librarian, Researcher, null, null, null):-
		person(Librarian),person(Researcher),person(null),event(null),location(null),
		at(Researcher,Location),
		at(Researcher,RoleLocation),
		at(Librarian,RoleLocation),
		is(Researcher,student,RoleLocation),
		at(Librarian,Location),
		is(Librarian,librarian,RoleLocation),
		Librarian != Researcher,
		Librarian != null,
		Researcher != null.

update(Librarian,self_worth,Y) :- is(Librarian,self_worth,X), X + 1 = Y, occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Librarian,likes,Researcher,Y) :- is(Librarian,likes,Researcher,X), X + 1 = Y,occurred(action(assist_student, Librarian, Researcher, null, null, null)).

update(Researcher,likes,Librarian,Y) :- is(Researcher,likes,Librarian,X), X + 1 = Y,occurred(action(assist_student, Librarian, Researcher, null, null, null)).

is(assist_student, work).

is(assist_student, scholarly).

visibility(assist_student,0).

action(acquire_ingredients, Chef, ShopOwner, null, null, null):-
		person(Chef),person(ShopOwner),person(null),event(null),location(null),
		at(ShopOwner,RoleLocation),
		at(Chef,Location),
		is(ShopOwner,vendor,RoleLocation),
		at(ShopOwner,Location),
		is(Chef, chef),
		Chef != ShopOwner,
		Chef != null,
		ShopOwner != null.

update(Chef,likes,ShopOwner,Y) :- is(Chef,likes,ShopOwner,X), X + 1 = Y,occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

update(ShopOwner,likes,Chef,Y) :- is(ShopOwner,likes,Chef,X), X + 1 = Y,occurred(action(acquire_ingredients, Chef, ShopOwner, null, null, null)).

is(acquire_ingredients, work).

visibility(acquire_ingredients,0).

action(develop_recipe, Chef, null, null, null, null):-
		person(Chef),person(null),person(null),event(null),location(null),
		at(Chef,Location),
		is(Chef,chef,RoleLocation),
		at(Chef,RoleLocation),
		Chef != null.

update(Chef,self_worth,Y) :- is(Chef,self_worth,X), X + 1 = Y, occurred(action(develop_recipe, Chef, null, null, null, null)).

is(develop_recipe, work).

visibility(develop_recipe,0).

action(boss_cooks_around, Chef, Cook, null, null, null):-
		person(Chef),person(Cook),person(null),event(null),location(null),
		is(Chef,chef,RoleLocation),
		at(Chef,RoleLocation),
		at(Cook,Location),
		at(Chef,Location),
		at(Cook,RoleLocation),
		is(Cook,worker,RoleLocation),
		Chef != Cook,
		Chef != null,
		Cook != null.

update(Cook,likes,Chef,Y) :- is(Cook,likes,Chef,X), X - 1 = Y, occurred(action(boss_cooks_around, Chef, Cook, null, null, null)).

is(boss_cooks_around, work).

is(boss_cooks_around, mean).

visibility(boss_cooks_around,0).

action(mentor_cook, Chef, Cook, null, null, null):-
		person(Chef),person(Cook),person(null),event(null),location(null),
		is(Chef,chef,RoleLocation),
		at(Chef,RoleLocation),
		at(Cook,Location),
		at(Chef,Location),
		at(Cook,RoleLocation),
		is(Cook,worker,RoleLocation),
		Chef != Cook,
		Chef != null,
		Cook != null.

update(Cook,likes,Chef,Y) :- is(Cook,likes,Chef,X), X + 1 = Y, occurred(action(mentor_cook, Chef, Cook, null, null, null)).

is(mentor_cook, work).

is(mentor_cook, kind).

visibility(mentor_cook,0).

action(create_culinary_masterpiece, Chef, Guest, null, null, null):-
		person(Chef),person(Guest),person(null),event(null),location(null),
		is(Chef,chef,RoleLocation),
		at(Chef,RoleLocation),
		at(Chef,Location),
		at(Guest,RoleLocation),
		at(Guest,Location),
		is(Guest,guest,RoleLocation),
		Chef != Guest,
		Chef != null,
		Guest != null.

update(Chef,self_worth,Y) :- is(Chef,self_worth,X), X + 2 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Guest,respects,Chef,Y) :- is(Guest,respects,Chef,X), X + 3 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

update(Guest,happiness,Y) :- is(Guest,happiness,X), X + 2 = Y, occurred(action(create_culinary_masterpiece, Chef, Guest, null, null, null)).

is(create_culinary_masterpiece, work).

is(create_culinary_masterpiece, rare).

visibility(create_culinary_masterpiece,0).

action(bitch_about_boss, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		at(Worker,Location_0),
		is(Worker,employee,Boss),
		at(Coworker,Location_0),
		is(Worker,coworker,Coworker),
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X + 1 = Y,occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X + 1 = Y,occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,Y) :- is(Coworker,likes,Boss,X), X - 1 = Y, occurred(action(bitch_about_boss, Worker, Coworker, Boss, null, null)).

is(bitch_about_boss, work).

is(bitch_about_boss, mean).

visibility(bitch_about_boss,0).

action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Coworker,likes,Boss,V_Coworker_likes_Boss), V_Coworker_likes_Boss >= 3,
		is(Worker,employee,Boss),
		is(Worker,coworker,Coworker),
		at(Worker,Location_0),
		at(Coworker,Location_0),
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X - 1 = Y,occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X - 1 = Y,occurred(action(bitch_about_boss_to_resistance, Worker, Coworker, Boss, null, null)).

is(bitch_about_boss_to_resistance, work).

is(bitch_about_boss_to_resistance, mean).

is(bitch_about_boss_to_resistance, failure).

visibility(bitch_about_boss_to_resistance,0).

action(praise_boss, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,employee,Boss),
		is(Worker,likes,Boss,V_Worker_likes_Boss), V_Worker_likes_Boss >= 3,
		is(Worker,coworker,Coworker),
		at(Worker,Location_0),
		at(Coworker,Location_0),
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X + 1 = Y,occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X + 1 = Y,occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Boss,Y) :- is(Coworker,likes,Boss,X), X + 1 = Y, occurred(action(praise_boss, Worker, Coworker, Boss, null, null)).

is(praise_boss, work).

is(praise_boss, kind).

visibility(praise_boss,0).

action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null):-
		person(Worker),person(Coworker),person(Boss),event(null),location(null),
		is(Worker,employee,Boss),
		is(Coworker,likes,Boss,V_Coworker_likes_Boss), V_Coworker_likes_Boss <= -1,
		is(Worker,likes,Boss,V_Worker_likes_Boss), V_Worker_likes_Boss >= 3,
		is(Worker,coworker,Coworker),
		at(Worker,Location_0),
		at(Coworker,Location_0),
		Worker != Coworker,
		Worker != Boss,
		Coworker != Boss,
		Worker != null,
		Coworker != null,
		Boss != null.

update(Worker,likes,Coworker,Y) :- is(Worker,likes,Coworker,X), X - 1 = Y,occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

update(Coworker,likes,Worker,Y) :- is(Coworker,likes,Worker,X), X - 1 = Y,occurred(action(praise_boss_to_resistance, Worker, Coworker, Boss, null, null)).

is(praise_boss_to_resistance, work).

is(praise_boss_to_resistance, kind).

visibility(praise_boss_to_resistance,0).

action(search_for_treasure, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		TreasureHunter != null.

update(TreasureHunter,tiredness,Y) :- is(TreasureHunter,tiredness,X), X + 1 = Y, occurred(action(search_for_treasure, TreasureHunter, null, null, null, null)).

is(search_for_treasure, work).

is(search_for_treasure, bold).

is(search_for_treasure, criminal).

visibility(search_for_treasure,0).

action(find_treasure, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		TreasureHunter != null.

add(TreasureHunter, rich) :- occurred(action(find_treasure, TreasureHunter, null, null, null, null)).

update(TreasureHunter,self_worth,Y) :- is(TreasureHunter,self_worth,X), X + 5 = Y, occurred(action(find_treasure, TreasureHunter, null, null, null, null)).

is(find_treasure, work).

is(find_treasure, bold).

is(find_treasure, criminal).

is(find_treasure, rare).

visibility(find_treasure,0).

action(investigate_ruins, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		TreasureHunter != null.

is(investigate_ruins, work).

is(investigate_ruins, scholarly).

is(investigate_ruins, thoughtful).

visibility(investigate_ruins,0).

action(trigger_trap, TreasureHunter, null, null, null, null):-
		person(TreasureHunter),person(null),person(null),event(null),location(null),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		TreasureHunter != null.

update(TreasureHunter,self_worth,Y) :- is(TreasureHunter,self_worth,X), X - 1 = Y, occurred(action(trigger_trap, TreasureHunter, null, null, null, null)).

is(trigger_trap, work).

is(trigger_trap, careless).

visibility(trigger_trap,0).

action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null):-
		person(TreasureHunter),person(OtherTH),person(null),event(null),location(null),
		at(OtherTH,Location),
		is(TreasureHunter,rival,OtherTH),
		at(OtherTH,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		is(OtherTH,treasure_hunter,RoleLocation),
		TreasureHunter != OtherTH,
		TreasureHunter != null,
		OtherTH != null.

update(OtherTH,respects,TreasureHunter,Y) :- is(OtherTH,respects,TreasureHunter,X), X + 1 = Y, occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

update(OtherTH,likes,TreasureHunter,Y) :- is(OtherTH,likes,TreasureHunter,X), X - 1 = Y, occurred(action(sabotage_rival_treasure_hunter, TreasureHunter, OtherTH, null, null, null)).

is(sabotage_rival_treasure_hunter, work).

is(sabotage_rival_treasure_hunter, mean).

is(sabotage_rival_treasure_hunter, bold).

visibility(sabotage_rival_treasure_hunter,0).

action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null):-
		person(TreasureHunter),person(OtherTH),person(null),event(null),location(null),
		at(OtherTH,Location),
		is(TreasureHunter,rival,OtherTH),
		at(OtherTH,RoleLocation),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		is(OtherTH,treasure_hunter,RoleLocation),
		TreasureHunter != OtherTH,
		TreasureHunter != null,
		OtherTH != null.

update(OtherTH,likes,TreasureHunter,Y) :- is(OtherTH,likes,TreasureHunter,X), X + 1 = Y,occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

update(TreasureHunter,likes,OtherTH,Y) :- is(TreasureHunter,likes,OtherTH,X), X + 1 = Y,occurred(action(overcome_rivalry_to_work_together, TreasureHunter, OtherTH, null, null, null)).

is(overcome_rivalry_to_work_together, work).

is(overcome_rivalry_to_work_together, kind).

is(overcome_rivalry_to_work_together, bold).

visibility(overcome_rivalry_to_work_together,0).

action(investigate_ruins, Archaelogist, null, null, null, null):-
		person(Archaelogist),person(null),person(null),event(null),location(null),
		at(Archaelogist,Location),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		Archaelogist != null.

is(investigate_ruins, work).

is(investigate_ruins, scholarly).

is(investigate_ruins, thoughtful).

visibility(investigate_ruins,0).

action(catalog_findings, Archaelogist, null, null, null, null):-
		person(Archaelogist),person(null),person(null),event(null),location(null),
		at(Archaelogist,Location),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		Archaelogist != null.

is(catalog_findings, work).

is(catalog_findings, scholarly).

is(catalog_findings, thoughtful).

visibility(catalog_findings,0).

action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null):-
		person(Archaelogist),person(TreasureHunter),person(null),event(null),location(null),
		is(Archaelogist,rival,TreasureHunter),
		at(Archaelogist,Location),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		Archaelogist != TreasureHunter,
		Archaelogist != null,
		TreasureHunter != null.

update(TreasureHunter,likes,Archaelogist,Y) :- is(TreasureHunter,likes,Archaelogist,X), X - 1 = Y,occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

update(Archaelogist,likes,TreasureHunter,Y) :- is(Archaelogist,likes,TreasureHunter,X), X - 1 = Y,occurred(action(argue_with_treasure_hunter, Archaelogist, TreasureHunter, null, null, null)).

is(argue_with_treasure_hunter, talk).

is(argue_with_treasure_hunter, critical).

visibility(argue_with_treasure_hunter,0).

action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null):-
		person(Archaelogist),person(TreasureHunter),person(null),event(null),location(null),
		is(Archaelogist,rival,TreasureHunter),
		at(Archaelogist,Location),
		is(TreasureHunter,treasure_hunter,RoleLocation),
		at(TreasureHunter,RoleLocation),
		at(TreasureHunter,Location),
		at(Archaelogist,RoleLocation),
		is(Archaelogist,archaelogist,RoleLocation),
		Archaelogist != TreasureHunter,
		Archaelogist != null,
		TreasureHunter != null.

update(TreasureHunter,likes,Archaelogist,Y) :- is(TreasureHunter,likes,Archaelogist,X), X + 1 = Y,occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

update(Archaelogist,likes,TreasureHunter,Y) :- is(Archaelogist,likes,TreasureHunter,X), X + 1 = Y,occurred(action(develop_begrudging_respect_towards, Archaelogist, TreasureHunter, null, null, null)).

is(develop_begrudging_respect_towards, talk).

is(develop_begrudging_respect_towards, kind).

visibility(develop_begrudging_respect_towards,0).

action(perform_to_no_effect, Bard, null, null, null, null):-
		person(Bard),person(null),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		at(Bard,Location),
		Bard != null.

update(Bard,tiredness,Y) :- is(Bard,tiredness,X), X + 1 = Y, occurred(action(perform_to_no_effect, Bard, null, null, null, null)).

is(perform_to_no_effect, work).

is(perform_to_no_effect, talk).

visibility(perform_to_no_effect,0).

action(amuse_with_performance, Bard, Tourist, null, null, null):-
		person(Bard),person(Tourist),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Bard,Location),
		at(Tourist,RoleLocation),
		Bard != Tourist,
		Bard != null,
		Tourist != null.

update(Bard,self_worth,Y) :- is(Bard,self_worth,X), X + 1 = Y, occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X + 1 = Y, occurred(action(amuse_with_performance, Bard, Tourist, null, null, null)).

is(amuse_with_performance, work).

is(amuse_with_performance, talk).

visibility(amuse_with_performance,0).

action(grouse_backstage, Bard, Other, null, null, null):-
		person(Bard),person(Other),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Other,RoleLocation),
		at(Bard,RoleLocation),
		is(Other,bard,RoleLocation),
		at(Other,Location),
		at(Bard,Location),
		Bard != Other,
		Bard != null,
		Other != null.

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X - 1 = Y,occurred(action(grouse_backstage, Bard, Other, null, null, null)).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X - 1 = Y,occurred(action(grouse_backstage, Bard, Other, null, null, null)).

is(grouse_backstage, work).

is(grouse_backstage, criticial).

visibility(grouse_backstage,0).

action(encourage_fellow_performer, Bard, Other, null, null, null):-
		person(Bard),person(Other),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Other,RoleLocation),
		at(Bard,RoleLocation),
		is(Other,bard,RoleLocation),
		at(Other,Location),
		at(Bard,Location),
		Bard != Other,
		Bard != null,
		Other != null.

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X + 1 = Y,occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X + 1 = Y,occurred(action(encourage_fellow_performer, Bard, Other, null, null, null)).

is(encourage_fellow_performer, work).

is(encourage_fellow_performer, kind).

visibility(encourage_fellow_performer,0).

action(annoy_diva_for_laughs, Bard, Diva, Other, null, null):-
		person(Bard),person(Diva),person(Other),event(null),location(null),
		at(Diva,RoleLocation),
		is(Bard,bard,RoleLocation),
		at(Other,RoleLocation),
		at(Bard,RoleLocation),
		is(Other,bard,RoleLocation),
		at(Diva,Location),
		is(Other,likes,Diva,V_Other_likes_Diva), V_Other_likes_Diva <= -1,
		is(Diva,diva,RoleLocation),
		at(Other,Location),
		at(Bard,Location),
		Bard != Diva,
		Bard != Other,
		Diva != Other,
		Bard != null,
		Diva != null,
		Other != null.

update(Diva,likes,Bard,Y) :- is(Diva,likes,Bard,X), X - 1 = Y, occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Bard,likes,Other,Y) :- is(Bard,likes,Other,X), X + 1 = Y,occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Other,likes,Bard,Y) :- is(Other,likes,Bard,X), X + 1 = Y,occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

update(Bard,self_worth,Y) :- is(Bard,self_worth,X), X + 1 = Y, occurred(action(annoy_diva_for_laughs, Bard, Diva, Other, null, null)).

is(annoy_diva_for_laughs, work).

is(annoy_diva_for_laughs, mean).

is(annoy_diva_for_laughs, silly).

visibility(annoy_diva_for_laughs,0).

action(become_annoyed_with_bard, Tourist, Bard, null, null, null):-
		person(Tourist),person(Bard),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Bard,Location),
		at(Tourist,RoleLocation),
		Tourist != Bard,
		Tourist != null,
		Bard != null.

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X - 1 = Y, occurred(action(become_annoyed_with_bard, Tourist, Bard, null, null, null)).

is(become_annoyed_with_bard, critical).

visibility(become_annoyed_with_bard,0).

action(be_amused_by_bard, Tourist, Bard, null, null, null):-
		person(Tourist),person(Bard),person(null),event(null),location(null),
		is(Bard,bard,RoleLocation),
		at(Bard,RoleLocation),
		is(Tourist,tourist,RoleLocation),
		at(Tourist,Location),
		at(Bard,Location),
		at(Tourist,RoleLocation),
		Tourist != Bard,
		Tourist != null,
		Bard != null.

update(Tourist,likes,Bard,Y) :- is(Tourist,likes,Bard,X), X + 1 = Y, occurred(action(be_amused_by_bard, Tourist, Bard, null, null, null)).

is(be_amused_by_bard, silly).

visibility(be_amused_by_bard,0).

action(make_judicious_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(Monarch, monarch),
		is(Monarch,monarch,RoleLocation),
		at(O2,Location),
		at(Monarch,RoleLocation),
		is(O2,fealty,Monarch),
		at(O1,Location),
		is(O1,fealty,Monarch),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X + 1 = Y, occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X + 1 = Y, occurred(action(make_judicious_decree, Monarch, O1, O2, null, null)).

is(make_judicious_decree, work).

is(make_judicious_decree, thoughtful).

visibility(make_judicious_decree,0).

action(make_imprudent_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(Monarch, monarch),
		is(Monarch,monarch,RoleLocation),
		at(O2,Location),
		at(Monarch,RoleLocation),
		is(O2,fealty,Monarch),
		at(O1,Location),
		is(O1,fealty,Monarch),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X - 1 = Y, occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X - 1 = Y, occurred(action(make_imprudent_decree, Monarch, O1, O2, null, null)).

is(make_imprudent_decree, work).

is(make_imprudent_decree, careless).

visibility(make_imprudent_decree,0).

action(make_callous_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(Monarch, monarch),
		is(Monarch,monarch,RoleLocation),
		at(O2,Location),
		at(Monarch,RoleLocation),
		is(O2,fealty,Monarch),
		at(O1,Location),
		is(O1,fealty,Monarch),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X - 1 = Y, occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X - 1 = Y, occurred(action(make_callous_decree, Monarch, O1, O2, null, null)).

is(make_callous_decree, work).

is(make_callous_decree, mean).

visibility(make_callous_decree,0).

action(make_benevolent_decree, Monarch, O1, O2, null, null):-
		person(Monarch),person(O1),person(O2),event(null),location(null),
		at(Monarch,Location),
		is(Monarch, monarch),
		is(Monarch,monarch,RoleLocation),
		at(O2,Location),
		at(Monarch,RoleLocation),
		is(O2,fealty,Monarch),
		at(O1,Location),
		is(O1,fealty,Monarch),
		Monarch != O1,
		Monarch != O2,
		O1 != O2,
		Monarch != null,
		O1 != null,
		O2 != null.

update(O1,likes,Monarch,Y) :- is(O1,likes,Monarch,X), X + 1 = Y, occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

update(O2,likes,Monarch,Y) :- is(O2,likes,Monarch,X), X + 1 = Y, occurred(action(make_benevolent_decree, Monarch, O1, O2, null, null)).

is(make_benevolent_decree, work).

is(make_benevolent_decree, kind).

visibility(make_benevolent_decree,0).

action(banish_monarchling, Monarch, Child, null, null, null):-
		person(Monarch),person(Child),person(null),event(null),location(null),
		at(Monarch,Location),
		is(Child,child,Monarch),
		is(Monarch, monarch),
		at(Child,Location),
		is(Monarch,likes,Child,V_Monarch_likes_Child), V_Monarch_likes_Child <= -5,
		is(Monarch,monarch,RoleLocation),
		at(Monarch,RoleLocation),
		is(Child, royalty),
		is(Child,age,V_Child_age), V_Child_age >= 16,
		Monarch != Child,
		Monarch != null,
		Child != null.

update(Child,likes,Monarch,Y) :- is(Child,likes,Monarch,X), X - 10 = Y, occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

del(Child, royalty) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

del(Child, hometown) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

add(Child, ex_royalty) :- occurred(action(banish_monarchling, Monarch, Child, null, null, null)).

is(banish_monarchling, mean).

is(banish_monarchling, rare).

visibility(banish_monarchling,0).

action(consult_with_chancellor, Monarch, Chancellor, null, null, null):-
		person(Monarch),person(Chancellor),person(null),event(null),location(null),
		at(Monarch,Location),
		is(Chancellor,chancellor,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		at(Chancellor,RoleLocation),
		at(Monarch,RoleLocation),
		at(Chancellor,Location),
		Monarch != Chancellor,
		Monarch != null,
		Chancellor != null.

update(Monarch,likes,Chancellor,Y) :- is(Monarch,likes,Chancellor,X), X + 1 = Y,occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

update(Chancellor,likes,Monarch,Y) :- is(Chancellor,likes,Monarch,X), X + 1 = Y,occurred(action(consult_with_chancellor, Monarch, Chancellor, null, null, null)).

is(consult_with_chancellor, work).

is(consult_with_chancellor, thoughtful).

visibility(consult_with_chancellor,0).

action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null):-
		person(Chancellor),person(Monarch),person(null),event(null),location(null),
		at(Monarch,Location),
		is(Chancellor,chancellor,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		at(Chancellor,RoleLocation),
		at(Monarch,RoleLocation),
		at(Chancellor,Location),
		Chancellor != Monarch,
		Chancellor != null,
		Monarch != null.

add(Monarch, compassionate) :- occurred(action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null)).

del(Monarch, indifferent) :- occurred(action(sway_monarch_to_kindness, Chancellor, Monarch, null, null, null)).

is(sway_monarch_to_kindness, kind).

is(sway_monarch_to_kindness, talk).

is(sway_monarch_to_kindness, bold).

is(sway_monarch_to_kindness, rare).

visibility(sway_monarch_to_kindness,0).

action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null):-
		person(Chancellor),person(Monarch),person(null),event(null),location(null),
		at(Monarch,Location),
		is(Chancellor,chancellor,RoleLocation),
		is(Monarch,monarch,RoleLocation),
		at(Chancellor,RoleLocation),
		at(Monarch,RoleLocation),
		at(Chancellor,Location),
		Chancellor != Monarch,
		Chancellor != null,
		Monarch != null.

del(Monarch, compassionate) :- occurred(action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null)).

add(Monarch, indifferent) :- occurred(action(sway_monarch_to_indifference, Chancellor, Monarch, null, null, null)).

is(sway_monarch_to_indifference, mean).

is(sway_monarch_to_indifference, talk).

is(sway_monarch_to_indifference, bold).

is(sway_monarch_to_indifference, rare).

visibility(sway_monarch_to_indifference,0).

action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null):-
		person(Monarchling),person(ExMonarchling),person(null),event(null),location(null),
		is(Monarchling, royalty),
		at(ExMonarchling,Location),
		is(Monarchling,sibling,ExMonarchling),
		at(Monarchling,Location),
		is(ExMonarchling, ex_royalty),
		Monarchling != ExMonarchling,
		Monarchling != null,
		ExMonarchling != null.

update(Monarchling,likes,ExMonarchling,Y) :- is(Monarchling,likes,ExMonarchling,X), X + 1 = Y,occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(ExMonarchling,likes,Monarchling,Y) :- is(ExMonarchling,likes,Monarchling,X), X + 1 = Y,occurred(action(support_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

is(support_banished_sibling, kind).

is(support_banished_sibling, free).

visibility(support_banished_sibling,0).

action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null):-
		person(Monarchling),person(ExMonarchling),person(null),event(null),location(null),
		is(Monarchling, royalty),
		at(ExMonarchling,Location),
		is(Monarchling,sibling,ExMonarchling),
		at(Monarchling,Location),
		is(ExMonarchling, ex_royalty),
		Monarchling != ExMonarchling,
		Monarchling != null,
		ExMonarchling != null.

update(ExMonarchling,likes,Monarchling,Y) :- is(ExMonarchling,likes,Monarchling,X), X - 1 = Y,occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

update(Monarchling,likes,ExMonarchling,Y) :- is(Monarchling,likes,ExMonarchling,X), X - 1 = Y,occurred(action(shun_banished_sibling, Monarchling, ExMonarchling, null, null, null)).

is(shun_banished_sibling, mean).

is(shun_banished_sibling, duty).

visibility(shun_banished_sibling,0).

action(play, Child, null, null, null, null):-
		person(Child),person(null),person(null),event(null),location(null),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		at(Child,Location),
		Child != null.

update(Child,happiness,Y) :- is(Child,happiness,X), X + 1 = Y, occurred(action(play, Child, null, null, null, null)).

is(play, silly).

visibility(play,0).

action(play_together, Child, OtherChild, null, null, null):-
		person(Child),person(OtherChild),person(null),event(null),location(null),
		at(OtherChild,Location),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		is(OtherChild,age,V_OtherChild_age), V_OtherChild_age <= 15,
		at(Child,Location),
		Child != OtherChild,
		Child != null,
		OtherChild != null.

update(Child,likes,OtherChild,Y) :- is(Child,likes,OtherChild,X), X + 1 = Y,occurred(action(play_together, Child, OtherChild, null, null, null)).

update(Child,happiness,Y) :- is(Child,happiness,X), X + 1 = Y, occurred(action(play_together, Child, OtherChild, null, null, null)).

update(OtherChild,happiness,Y) :- is(OtherChild,happiness,X), X + 1 = Y, occurred(action(play_together, Child, OtherChild, null, null, null)).

update(OtherChild,likes,Child,Y) :- is(OtherChild,likes,Child,X), X + 1 = Y,occurred(action(play_together, Child, OtherChild, null, null, null)).

is(play_together, silly).

is(play_together, kind).

is(play_together, talk).

visibility(play_together,0).

action(argue_with_playmate, Child, OtherChild, null, null, null):-
		person(Child),person(OtherChild),person(null),event(null),location(null),
		at(OtherChild,Location),
		is(Child,age,V_Child_age), V_Child_age <= 15,
		is(OtherChild,age,V_OtherChild_age), V_OtherChild_age <= 15,
		at(Child,Location),
		Child != OtherChild,
		Child != null,
		OtherChild != null.

update(Child,happiness,Y) :- is(Child,happiness,X), X - 1 = Y, occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(Child,likes,OtherChild,Y) :- is(Child,likes,OtherChild,X), X - 1 = Y,occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(OtherChild,happiness,Y) :- is(OtherChild,happiness,X), X - 1 = Y, occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

update(OtherChild,likes,Child,Y) :- is(OtherChild,likes,Child,X), X - 1 = Y,occurred(action(argue_with_playmate, Child, OtherChild, null, null, null)).

is(argue_with_playmate, critical).

is(argue_with_playmate, mean).

visibility(argue_with_playmate,0).

action(worry_about_future, Adult, null, null, null, null):-
		person(Adult),person(null),person(null),event(null),location(null),
		at(Adult,Location),
		is(Adult,age,V_Adult_age), V_Adult_age >= 35,
		Adult != null.

update(Adult,tiredness,Y) :- is(Adult,tiredness,X), X + 1 = Y, occurred(action(worry_about_future, Adult, null, null, null, null)).

is(worry_about_future, critical).

is(worry_about_future, worry).

visibility(worry_about_future,0).

action(worry_about_mortality, Adult, null, null, null, null):-
		person(Adult),person(null),person(null),event(null),location(null),
		at(Adult,Location),
		is(Adult,age,V_Adult_age), V_Adult_age >= 55,
		Adult != null.

update(Adult,happiness,Y) :- is(Adult,happiness,X), X - 1 = Y, occurred(action(worry_about_mortality, Adult, null, null, null, null)).

update(Adult,tiredness,Y) :- is(Adult,tiredness,X), X + 1 = Y, occurred(action(worry_about_mortality, Adult, null, null, null, null)).

is(worry_about_mortality, critical).

is(worry_about_mortality, worry).

visibility(worry_about_mortality,0).

action(argue_about_duty, Dutybound, Free, null, null, null):-
		person(Dutybound),person(Free),person(null),event(null),location(null),
		is(Free, free_sprited),
		at(Free,Location),
		is(Dutybound, duty_bound),
		at(Dutybound,Location),
		Dutybound != Free,
		Dutybound != null,
		Free != null.

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X - 1 = Y,occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X - 1 = Y,occurred(action(argue_about_duty, Dutybound, Free, null, null, null)).

is(argue_about_duty, critical).

visibility(argue_about_duty,0).

action(convince_importance_of_duty, Dutybound, Free, null, null, null):-
		person(Dutybound),person(Free),person(null),event(null),location(null),
		is(Free, free_sprited),
		at(Free,Location),
		is(Dutybound, duty_bound),
		at(Dutybound,Location),
		Dutybound != Free,
		Dutybound != null,
		Free != null.

update(Free,likes,Dutybound,Y) :- is(Free,likes,Dutybound,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

update(Dutybound,likes,Free,Y) :- is(Dutybound,likes,Free,X), X + 1 = Y,occurred(action(convince_importance_of_duty, Dutybound, Free, null, null, null)).

is(convince_importance_of_duty, thoughtful).

visibility(convince_importance_of_duty,0).

action(hold_lecture, Professor, Student, null, null, null):-
		person(Professor),person(Student),person(null),event(null),location(null),
		is(Student,student,RoleLocation),
		is(Professor,professor,RoleLocation),
		at(Student,Location),
		at(Student,RoleLocation),
		at(Professor,Location),
		at(Professor,RoleLocation),
		Professor != Student,
		Professor != null,
		Student != null.

update(Student,likes,Professor,Y) :- is(Student,likes,Professor,X), X + 1 = Y, occurred(action(hold_lecture, Professor, Student, null, null, null)).

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X + 1 = Y, occurred(action(hold_lecture, Professor, Student, null, null, null)).

is(hold_lecture, work).

is(hold_lecture, scholarly).

visibility(hold_lecture,0).

action(hold_boring_lecture, Professor, Student, null, null, null):-
		person(Professor),person(Student),person(null),event(null),location(null),
		is(Student,student,RoleLocation),
		is(Professor,professor,RoleLocation),
		at(Student,Location),
		at(Student,RoleLocation),
		at(Professor,Location),
		at(Professor,RoleLocation),
		Professor != Student,
		Professor != null,
		Student != null.

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X - 1 = Y, occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

update(Student,likes,Professor,Y) :- is(Student,likes,Professor,X), X - 1 = Y, occurred(action(hold_boring_lecture, Professor, Student, null, null, null)).

is(hold_boring_lecture, work).

is(hold_boring_lecture, scholarly).

is(hold_boring_lecture, failure).

visibility(hold_boring_lecture,0).

action(perform_research, Professor, null, null, null, null):-
		person(Professor),person(null),person(null),event(null),location(null),
		at(Professor,Location),
		is(Professor,professor,RoleLocation),
		at(Professor,RoleLocation),
		Professor != null.

update(Professor,self_worth,Y) :- is(Professor,self_worth,X), X + 1 = Y, occurred(action(perform_research, Professor, null, null, null, null)).

is(perform_research, work).

is(perform_research, scholarly).

visibility(perform_research,0).

action(conspire_against, SpyMaster, Target, null, null, null):-
		person(SpyMaster),person(Target),person(null),event(null),location(null),
		is(Target, important),
		at(SpyMaster,RoleLocation),
		is(SpyMaster,spy_master,RoleLocation),
		SpyMaster != Target,
		SpyMaster != null,
		Target != null.

update(SpyMaster,likes,Target,Y) :- is(SpyMaster,likes,Target,X), X - 1 = Y, occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

update(SpyMaster,plotting_against,Target,Y) :- is(SpyMaster,plotting_against,Target,X), 3 = Y, occurred(action(conspire_against, SpyMaster, Target, null, null, null)).

is(conspire_against, rare).

is(conspire_against, mean).

visibility(conspire_against,0).

action(send_underlings, SpyMaster, Spy, Target, null, null):-
		person(SpyMaster),person(Spy),person(Target),event(null),location(null),
		is(SpyMaster,plotting_against,Target,V_SpyMaster_plotting_against_Target), V_SpyMaster_plotting_against_Target >= 1,
		at(Spy,RoleLocation),
		at(SpyMaster,RoleLocation),
		is(Spy,spy,RoleLocation),
		is(SpyMaster,spy_master,RoleLocation),
		SpyMaster != Spy,
		SpyMaster != Target,
		Spy != Target,
		SpyMaster != null,
		Spy != null,
		Target != null.

update(SpyMaster,plotting_against,Target,Y) :- is(SpyMaster,plotting_against,Target,X), X - 1 = Y, occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

update(Spy,plotting_against,Target,Y) :- is(Spy,plotting_against,Target,X), 1 = Y, occurred(action(send_underlings, SpyMaster, Spy, Target, null, null)).

is(send_underlings, work).

visibility(send_underlings,0).

action(cast_ur_job, TheWorker, null, null, null, null):-
		person(TheWorker),person(null),person(null),event(null),location(null),
		at(TheWorker,Location),
		mode(casting),
		not is(TheWorker, ur_job),
		castable(ur_job,Location),
		TheWorker != null.

add(TheWorker,ur_job,Location) :- at(TheWorker, Location), occurred(action(cast_ur_job, TheWorker, null, null, null, null)).

is(cast_ur_job, work).

visibility(cast_ur_job,0).

action(cast_monk, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(monk,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,monk,Location) :- at(Worker, Location), occurred(action(cast_monk, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_monk, Worker, null, null, null, null)).

is(cast_monk, religious).

is(cast_monk, work).

visibility(cast_monk,0).

action(cast_foreman, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(foreman,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_foreman, Worker, null, null, null, null)).

add(Worker,foreman,Location) :- at(Worker, Location), occurred(action(cast_foreman, Worker, null, null, null, null)).

is(cast_foreman, talk).

is(cast_foreman, critical).

is(cast_foreman, work).

visibility(cast_foreman,0).

action(cast_miner, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(miner,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_miner, Worker, null, null, null, null)).

add(Worker,miner,Location) :- at(Worker, Location), occurred(action(cast_miner, Worker, null, null, null, null)).

is(cast_miner, work).

is(cast_miner, bold).

visibility(cast_miner,0).

action(cast_curator, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		castable(curator,Location),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,curator,Location) :- at(Worker, Location), occurred(action(cast_curator, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_curator, Worker, null, null, null, null)).

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

add(Worker,vendor,Location) :- at(Worker, Location), occurred(action(cast_vendor, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_vendor, Worker, null, null, null, null)).

is(cast_vendor, talk).

is(cast_vendor, work).

visibility(cast_vendor,0).

action(cast_enforcer, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(enforcer,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,enforcer,Location) :- at(Worker, Location), occurred(action(cast_enforcer, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_enforcer, Worker, null, null, null, null)).

is(cast_enforcer, risky).

is(cast_enforcer, criminal).

is(cast_enforcer, work).

is(cast_enforcer, mean).

visibility(cast_enforcer,0).

action(cast_dockworker, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(dockworker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,dockworker,Location) :- at(Worker, Location), occurred(action(cast_dockworker, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_dockworker, Worker, null, null, null, null)).

is(cast_dockworker, mariner).

is(cast_dockworker, work).

visibility(cast_dockworker,0).

action(cast_librarian, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		castable(librarian,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_librarian, Worker, null, null, null, null)).

add(Worker,librarian,Location) :- at(Worker, Location), occurred(action(cast_librarian, Worker, null, null, null, null)).

is(cast_librarian, work).

is(cast_librarian, scholarly).

visibility(cast_librarian,0).

action(cast_chef, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(chef,Location),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_chef, Worker, null, null, null, null)).

add(Worker,chef,Location) :- at(Worker, Location), occurred(action(cast_chef, Worker, null, null, null, null)).

is(cast_chef, talk).

is(cast_chef, work).

visibility(cast_chef,0).

action(cast_treasure_hunter, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(treasure_hunter,Location),
		Worker != null.

add(Worker,treasure_hunter,Location) :- at(Worker, Location), occurred(action(cast_treasure_hunter, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_treasure_hunter, Worker, null, null, null, null)).

is(cast_treasure_hunter, risky).

is(cast_treasure_hunter, criminal).

is(cast_treasure_hunter, bold).

is(cast_treasure_hunter, work).

visibility(cast_treasure_hunter,0).

action(cast_archaelogist, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(archaelogist,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,archaelogist,Location) :- at(Worker, Location), occurred(action(cast_archaelogist, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_archaelogist, Worker, null, null, null, null)).

is(cast_archaelogist, work).

is(cast_archaelogist, scholarly).

is(cast_archaelogist, thoughtful).

visibility(cast_archaelogist,0).

action(cast_bard, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(bard,Location),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_bard, Worker, null, null, null, null)).

add(Worker,bard,Location) :- at(Worker, Location), occurred(action(cast_bard, Worker, null, null, null, null)).

is(cast_bard, talk).

is(cast_bard, work).

is(cast_bard, silly).

visibility(cast_bard,0).

action(cast_monarch, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(monarch,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_monarch, Worker, null, null, null, null)).

add(Worker,monarch,Location) :- at(Worker, Location), occurred(action(cast_monarch, Worker, null, null, null, null)).

is(cast_monarch, critical).

is(cast_monarch, bold).

is(cast_monarch, work).

visibility(cast_monarch,0).

action(cast_chancellor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		castable(chancellor,Location),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		Worker != null.

add(Worker,chancellor,Location) :- at(Worker, Location), occurred(action(cast_chancellor, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_chancellor, Worker, null, null, null, null)).

is(cast_chancellor, talk).

is(cast_chancellor, critical).

is(cast_chancellor, work).

visibility(cast_chancellor,0).

action(cast_professor, Worker, null, null, null, null):-
		person(Worker),person(null),person(null),event(null),location(null),
		mode(casting),
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(professor,Location),
		Worker != null.

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
		at(Worker,Location),
		castable(ur_job,Location),
		not is(Worker, ur_job),
		castable(spy_master,Location),
		Worker != null.

add(Worker,spy_master,Location) :- at(Worker, Location), occurred(action(cast_spy_master, Worker, null, null, null, null)).

add(Worker,ur_job,Location) :- at(Worker, Location), occurred(action(cast_spy_master, Worker, null, null, null, null)).

is(cast_spy_master, risky).

is(cast_spy_master, critical).

is(cast_spy_master, work).

visibility(cast_spy_master,0).

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

propensity(rare, -2, rare_things_rare,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, rare_things_rare),
		is(ACTION_NAME,rare).

trait(rare_things_rare).

propensity(specific, 3, do_more_specific_things,Self, DEFAULT_TARGET, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,DEFAULT_TARGET,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, do_more_specific_things),
		is(ACTION_NAME,specific).

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

propensity(romance, 3, romantic_towards_crush,Self, Other, DEFAULT_OBJECT, DEFAULT_ACTION, DEFAULT_LOCATION )  :- 
		action(ACTION_NAME,Self,Other,DEFAULT_OBJECT,DEFAULT_ACTION,DEFAULT_LOCATION),
		is(Self, romantic_towards_crush),
		is(Self,crushing_on,Other),
		is(ACTION_NAME,romance).

trait(romantic_towards_crush).

go_to_propensity(go_to_location, 3, stay_at_hometown,Self, null, null, null, Location )  :- 
		is(Self, stay_at_hometown),
		is(Self,hometown,V_Self_hometown), is(Location,hometown,V_Location_hometown), V_Self_hometown == V_Location_hometown.

trait(stay_at_hometown).

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

status(loves).

status(respects).

status(rivalry).

status(dissapointed_in).

status(proud_of).

status(embarrassed_by).

status(protective_of).

status(friends_with).

status(happiness).

status(anger).

status(tiredness).

status(sadness).

status(guilt).

status(shame).

status(self_worth).

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