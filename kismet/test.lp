bit(0..8).
role(big;small).
{on(R,B) : bit(B)} :- role(R).
:- #sum {(2**B):on(big,B); -(2**B):on(small,B)} < 10.

#show on/2.
#show age/2.