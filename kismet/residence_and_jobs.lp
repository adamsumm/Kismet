
#const families = 5.
#const characters = 100.
#const factories = 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RICH-POOR JOB HOUSE STUFF %%%%%%%%%%%%%%%%%%%%%%%%%%






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
    #sum {2**Bit:age_bits(Character, Bit)} < 18.
:- assigned(factory(FactoryID), worker,Character), 
    #sum {2**Bit:age_bits(Character, Bit)}> 50.
    
%    select [1] character as manager:
%        age = [30:50],
%        is middleclass,
%        is manager of factory;

1 {assigned(factory(FactoryID), manager, character(CharacterID)): character(CharacterID)} 1 :- factory(FactoryID).
is(Character,manager,factory(FactoryID)) :- assigned(factory(FactoryID), manager,Character).
:- assigned(factory(FactoryID), manager,Character), not is(Character,middleclass).
:- assigned(factory(FactoryID), manager,Character), 
    #sum {2**Bit:age_bits(Character, Bit)} < 30.
:- assigned(factory(FactoryID), manager,Character), 
    #sum {2**Bit:age_bits(Character, Bit)}> 50.        
    
%    select [1] character as owner:
%        age = [40:65],
%        is rich,
%        is owner of factory.

1 {assigned(factory(FactoryID), owner, character(CharacterID)): character(CharacterID)} 1 :- factory(FactoryID).
is(Character,owner,factory(FactoryID)) :- assigned(factory(FactoryID), owner,Character).
:- assigned(factory(FactoryID), owner,Character), not is(Character,rich).
:- assigned(factory(FactoryID), owner,Character), 
    #sum {2**Bit:age_bits(Character, Bit)} < 40.
:- assigned(factory(FactoryID), owner,Character), 
    #sum {2**Bit:age_bits(Character, Bit)}> 65.            




%prevent  0 character lives_at residence.
%:- is(Residence,residence), 0 {is(_, lives_at, Residence)} 0.

%PersonA can_live_with PersonB if PersonA and PersonB are married to each other.
is(PersonA, can_live_with, PersonB) :- 
                            is(PersonA, married, PersonB), 
                            is(PersonB, married, PersonA) .

is(PersonB, can_live_with, PersonA) :- 
                            is(PersonA, married, PersonB), 
                            is(PersonB, married, PersonA) .
                            
%Parent and Child must_live_with each other if Parent  is parent to Child, Child’s age < 18.

is(Parent, must_live_with, Child) :- 
    is(Parent, parent, Child), 
   #sum {2**Bit:age_bits(Child, Bit)} < 18.

is(Child, must_live_with, Parent) :- 
    is(Parent, parent, Child), 
   #sum {2**Bit:age_bits(Child, Bit)} < 18.

is(Parent, can_live_with, Child) :- 
    is(Parent, parent, Child).

is(Child, can_live_with, Parent) :- 
    is(Parent, parent, Child). 

is(Child, can_live_with, Sibling) :- 
    is(Sibling, sibling, Child).  
   
%PersonA and PersonB can_live_with each other if PersonA and PersonB are roommates with each other.

is(PersonA, must_live_with, PersonB) :- 
                            is(PersonA, roommates, PersonB), 
                            is(PersonB, roommates, PersonA) .

is(PersonA, can_live_with, PersonB) :- 
                            is(PersonA, roommates, PersonB), 
                            is(PersonB, roommates, PersonA) .

is(PersonA, roommates, PersonB) :- is(PersonB, roommates, PersonA).
is(PersonA, roommates, PersonC) :- is(PersonB, roommates, PersonA), is(PersonC, roommates, PersonB), PersonA != PersonC, PersonA != PersonB, PersonB != PersonC.

is(character(Character), can_live_with,character(Character)) :- character(Character). 


%require PersonA and PersonB lives_at same if PersonA and PersonB can_live_with each other
%:- is(PersonA, can_live_with,PersonB), is(PersonB, can_live_with,PersonA), is(PersonA, lives_at,Other), is(PersonB,lives_at,Other2), %PersonA != PersonB, Other != Other2.

%:- is(PersonA, lives_at,Residence), is(PersonB, lives_at,Residence), not is(PersonA, can_live_with,PersonB).
%:- is(PersonA, must_live_with, PersonB),is(PersonA, lives_at,ResidenceA), is(PersonB, lives_at,ResidenceB), ResidenceA != ResidenceB.

{lives_with(PersonA, PersonB)} :- is(PersonA, can_live_with,PersonB).
lives_with(PersonA, PersonB) :- is(PersonA,must_live_with,PersonB).
lives_with(PersonA, PersonB) :- lives_with(PersonB, PersonA).

{lives_at(PersonA, residence(PersonA)) :  lives_with(PersonA, PersonB)} 1 :- lives_with(PersonA, PersonB).
lives_at(PersonA, Location) :- lives_with(PersonA, PersonB), lives_at(PersonB, Location), PersonA != PersonB.
:- 2 {lives_at(PersonA, _)}, lives_at(PersonA,_).
:-  {lives_at(character(PersonA), _)} 0, character(PersonA).
:-  lives_at(PersonA,RA) , lives_with(PersonA,PersonB), lives_at(PersonB, RB), RA != RB.
{lives_at(character(PersonA), residence(character(PersonA)))} 1  :- character(PersonA), not lives_with(PersonA,_).

is(Person, lives_at, Residence) :- lives_at(Person, Residence).
%lives_at(character(PersonA), residence(character(PersonA))) :- character(PersonA), not lives_with(PersonA,_).

more_than_one(Person,R1, R2) :- lives_at(Person,R1), lives_at(Person,R2), R1 != R2.
%#show lives_at/2.
%#show lives_with/2.
%#show lives_alone/1.
%#show more_than_one/3.

residence(R) :- lives_at(_,R).


%This means go through the possible things of type residence
%1 {mansion_count(M)  : M =0..10} 1.
%mansion(I) :- I = 1..M, mansion_count(M).
%is(mansion(I), mansion) :- mansion(I).
%1 {house_count(M)  : M =0..10} 1.
%house(I) :- I = 1..M, house_count(M).
%is(house(I), house) :- house(I).
%1 {tenement_count(M)  : M =0..10} 1.
%tenement(I) :- I = 1..M, tenement_count(M).

%1 {residenceCount(I) : I=families*3..characters} 1. 
residence(I) :- lives_at(_,I).
residence_type(mansion;house;tenement).
1 {is(I,Type) : residence_type(Type)} 1 :- residence(I).
%abstract residence extends location.

is(Residence, location) :- is(Residence,residence).

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
