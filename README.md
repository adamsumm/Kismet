# Kismet

Kismet is a light weight social simulation language/engine.

To use Kismet you will need:

* python 3
* clingo
* The python ANTLR library, and tracery library
* Jupyter notebook


```
  pip3 install antlr4-python3-runtime tracery graphviz
```

The jupyter notebook contains a showcase of how to use Kismet and sample schemas can be found in the schema folder.

A kismet schema is some number of:

* Traits
* Locations
* Actions
* Patterns

## Syntax
In general, the main syntax of Kismet is in an arrow notation denoting a relationship

* `->(likes)` Means `Initiator likes Recipient`
* `<-(likes)` Means `Recipient likes Initiator`
* `<->(likes)` Means `Recipient and Initiator like eachother` (shorthand for `->(likes) <-(likes)`)

There is also the `?` arrow notation which means `There exists`

* `?>(likes)` Means `Initiator likes someone`
* `<?(likes)` Means `Recipient likes someone`
* `<->(likes)` Means `Recipient and Initiator like someone but they don't have to like the same person`

The other major notation is the `+` and `-` notation for action likelihood

* `++(talk)` means a person is more likely to do something that is tagged as `talk`
* '--(talk)` means a person is less likely to do something that is tagged as `talk`

Any number of +'s and -'s can be strung together (although they can't be interwoven) So 

* `++++++++++++++++++++++++++(talk)`
* `-(talk)`

are both valid.

## Trait

All characters in kismet have traits that affect the likelihood of the character taking a given action

A trait looks like:

```
trait drunkard:
  ++(drink);
```

Which can be read as "A person with the trait 'drunkard' is more likely to take an action tagged as 'drink'"

Traits can also be affected by the relationships between people:

```
trait horny:
   +++(romance if ->(likes));
```

Which can be read as "A person with the trait 'horny' is MUCH more likely to take an action tagged as 'romance' if they like the recipient of the action.


## Locations

Locations are where actions take place, and locations are of the form:

```
location bar 10;
```

Which means there is a location of type 'bar' and it can support 10 people at it.

## Actions

Actions are where the meat of the simulation lie.  Actions are defined as a name, a set of tags, a condition as to whether the action can occur, and the effects of the action.

A simple action looks something like:

```
action chit_chat:
  is talk
  add <-(likes).
```

Which can be read as "There is an action called 'chit_chat'.  It is tagged as a 'talk' action and the result of it is that the recipient likes the initiator."

A more advanced actions looks like:

```
action divorce_for_cheating:
  is breakup
  if <->(married) <?(cheating) ->(spied_on)
  add <->(dislikes)
  del <->(married) <?(cheating) ->(spied_on);
```

Which can be read as:
* There is an action called 'divorce_for_cheating'
* It can only occur if the initiator and recipient are married, if the recipient is cheating on the initiator with someone (anyone), and the initiator has spied on the recipient
* After the divorce, both members dislike each other
* also, they are no longer married, the recipient is no longer cheating (since you it isn't cheating anymore), and the initiator has no longer spied on their partner cheating on them
  

