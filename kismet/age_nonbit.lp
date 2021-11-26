#const families = 20.
#const characters = 100.
#const factories = 1.

1 {family_count(M)  : M =families..families} 1.
family(I) :- I = 1..M, family_count(M).

1 {character_count(M)} 1 :- M =characters..characters.
character(I) :- I = 1..M, character_count(M).


%%%%Trait Stuff
traits(extrovert;introvert;manic_depressive;happy_go_lucky;generous;selfish;gregarious;cantankerous).

2 {is(character(Character),Trait) : traits(Trait)} 5 :- character(Character).

:- is(Character,extrovert), is(Character,introvert).
:- is(Character,generous), is(Character,selfish).
:- is(Character,gregarious), is(Character,cantankerous).

%For each trait, it should be the case, that it shows up some amount of time
:- {is(Character, Trait)} Characters/(2*Traits) ,traits(Trait), Traits = {traits(_)}, character_count(Characters).




%%%%Other Stuff
1 {age(character(Character), Age): Age=1..70} 1 :- character(Character).

%mutually exclusive wealth: rich/poor/middleclass.
exclusive_trait(wealth, (rich;poor;middleclass)).

%default character:
%    has [1] wealth.
1  {is(character(Character),Trait) : exclusive_trait(TraitType,Trait)} 1 :- character(Character),exclusive_trait(TraitType,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Family %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

2 {assigned(family(FamilyID), parent, character(CharacterID)): 
    character(CharacterID),
    (CharacterID+FamilyID) \ (2*characters/families) = 0} 2 :- family(FamilyID).

:- assigned(Family, parent, Character), age(Character, Age), Age < 20.
:- assigned(Family, parent, Character),  age(Character, Age), Age > 50.
:- 2 {assigned(Family, parent, Character)}, character(Character).

is(Character,parent,Other)  :- assigned(Family, parent, Character), assigned(Family, child, Other).

is(Character,married,Other)  :- assigned(Family, parent, Character), assigned(Family, parent, Other), Character != Other.


%Child Stuff
%1 {assigned(family(FamilyID), child, character(CharacterID)): CharacterID=(FamilyID*characters/families)..(FamilyID+1)*characters/families} 5 :- family(FamilyID).

1 {assigned(family(FamilyID), child, character(CharacterID)):  
    character(CharacterID),
    (CharacterID+FamilyID) \ (5*characters/families) = 0} 5 :- family(FamilyID).

:- 2 {assigned(Family, child, Character)}, character(Character).

:- assigned(Family, child, Character),  age(Character, Age), Age <1.
:- assigned(Family, child, Character),  age(Character, Age), Age> 30.
is(Character,child,Other)  :- assigned(Family, child, Character), assigned(Family, parent, Other).
is(Character,sibling,Other)  :- assigned(Family, child, Character), assigned(Family, child, Other).


:- assigned(Family, child, Character),assigned(Family, parent, Other),
            #sum {Age:age(Other,Age); -Age2:age(Character, Age2)} < 20.
        


%%% SPECIFY CONSTRAINTS ABOUT THE GENERATION
grand_parent :- is(GC, child, P), is(P, child, GP).
:- not grand_parent.

fall_from_wealth(GC,GP) :- is(GC, child, P), is(P, child, GP), is(GC,poor), is(GP,rich).
:- not fall_from_wealth(_,_).

rags_to_riches(GC,P) :- is(GC, child, P), is(GC,rich), is(P,poor).
:- not rags_to_riches(_,_).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RICH-POOR JOB HOUSE STUFF %%%%%%%%%%%%%%%%%%%%%%%%%%



% select [1] character as parentA:
%     shares wealth with parentB.
:-  assigned(Family, parentA, Character), assigned(Family, parentB, Other), is(Character,Trait), exclusive_trait(wealth,Trait), not is(Other,Trait).

% select [1] character as child:
%     shares wealth with parentA if age < 25.
:-  assigned(Family, parentA, Character), assigned(Family, child, Other), is(Character,Trait), exclusive_trait(wealth,Trait), not is(Other,Trait),
     age(Other,Age), Age < 25.
     

%This means go through the possible things of type residence
%1 {mansion_count(M)  : M =0..10} 1.
%mansion(I) :- I = 1..M, mansion_count(M).
%is(mansion(I), mansion) :- mansion(I).
%1 {house_count(M)  : M =0..10} 1.
%house(I) :- I = 1..M, house_count(M).
%is(house(I), house) :- house(I).
%1 {tenement_count(M)  : M =0..10} 1.
%tenement(I) :- I = 1..M, tenement_count(M).

1 {residenceCount(I) : I=families..characters} 1. 
residence(I) :- I = 0..M-1, residenceCount(M).
residence_type(mansion;tenement;house).
1 {is(residence(I),Type) : residence_type(Type)} 1 :- residence(I).

%abstract residence extends location.

is(Residence, location) :- is(Residence,residence).


%default character:
% has lives_at of [1] residence.

1  {is(character(Character),lives_at, Other): is(Other, residence)} 1 :- character(Character).

%define mansion extends residence:
%	require all who lives_at mansion are rich.
is(Mansion, residence) :- is(Mansion,mansion).
:- is(Mansion,mansion), is(Other, lives_at, Mansion), not is(Other, rich).

%define house extends residence:
%	require all who lives_at house are middleclass.
is(House, residence) :- is(House,house).
:- is(House,house), is(Other, lives_at, House), not is(Other, middleclass).

%define tenement extends residence:
%	require all who lives_at tenement are poor.
is(Tenement, residence) :- is(Tenement,tenement).
:- is(Tenement,tenement), is(Other, lives_at, Tenement), not is(Other, poor).



1 {factory_count(M):   M =factories..factories} 1.
factory(I) :- I = 1..M, factory_count(M).


%initialization factory:
%    select [2:3] character as worker:
%        is employee of factory
%        :where         
%        age = [18:50],
%        is poor;

2 {assigned(factory(FactoryID), worker, character(CharacterID)): character(CharacterID)} 3 :- factory(FactoryID).
is(Character,employee,factory(FactoryID)) :- assigned(factory(FactoryID), worker,Character).
:- assigned(factory(FactoryID), worker,Character), not is(Character,poor).
:- assigned(factory(FactoryID), worker,Character), 
    age(Character,Age), Age  < 18.
:- assigned(factory(FactoryID), worker,Character), 
    age(Character,Age), Age > 50.
    
%    select [1] character as manager:
%        age = [30:50],
%        is middleclass,
%        is manager of factory;

1 {assigned(factory(FactoryID), manager, character(CharacterID)): character(CharacterID)} 1 :- factory(FactoryID).
is(Character,manager,factory(FactoryID)) :- assigned(factory(FactoryID), manager,Character).
:- assigned(factory(FactoryID), manager,Character), not is(Character,middleclass).
:- assigned(factory(FactoryID), manager,Character), 
    age(Character,Age), Age  < 30.
:- assigned(factory(FactoryID), manager,Character), 
    age(Character,Age), Age > 50.        
    
%    select [1] character as owner:
%        age = [40:65],
%        is rich,
%        is owner of factory.

1 {assigned(factory(FactoryID), owner, character(CharacterID)): character(CharacterID)} 1 :- factory(FactoryID).
is(Character,owner,factory(FactoryID)) :- assigned(factory(FactoryID), owner,Character).
:- assigned(factory(FactoryID), owner,Character), not is(Character,rich).
:- assigned(factory(FactoryID), owner,Character), 
    age(Character,Age), Age  < 40.
:- assigned(factory(FactoryID), owner,Character), 
    age(Character,Age), Age  > 65.            




%prevent  0 character lives_at residence.
%:- is(Residence,residence), 0 {is(_, lives_at, Residence)} 0.

%PersonA can_live_with PersonB if PersonA and PersonB are married to each other.
is(PersonA, can_live_with, PersonB) :- 
                            is(PersonA, married, PersonB), 
                            is(PersonB, married, PersonA) .

is(PersonB, can_live_with, PersonA) :- 
                            is(PersonA, married, PersonB), 
                            is(PersonB, married, PersonA) .
                            
%Parent and Child can_live_with each other if Parent  is parent to Child, Child’s age < 1.

is(Parent, can_live_with, Child) :- 
    is(Parent, parent, Child), 
   age(Character,Age), Age  < 18.

is(Child, can_live_with, Parent) :- 
    is(Parent, parent, Child), 
   age(Character,Age), Age  < 18.
   
%PersonA and PersonB can_live_with each other if PersonA and PersonB are roommates with each other.

is(PersonA, can_live_with, PersonB) :- 
                            is(PersonA, roommates, PersonB), 
                            is(PersonB, roommates, PersonA) .

%require PersonA and PersonB can_live_with each other for PersonA and PersonB lives_at same.
%:- is(PersonA, lives_at, Other),  is(PersonB, lives_at, Other),
%    2 {is(PersonA, lives_at, Other);  is(PersonB, lives_at, Other)},
%    not is(PersonA, can_live_with, PersonB).
    
%require PersonA and PersonB lives_at same if PersonA and PersonB can_live_with each other
:- is(PersonA, can_live_with,PersonB), is(PersonB, can_live_with,PersonA), is(PersonA, lives_at,Other), not is(PersonB,lives_at,Other).

lives_at(Location,Person) :-is(Person, lives_at,Location). 