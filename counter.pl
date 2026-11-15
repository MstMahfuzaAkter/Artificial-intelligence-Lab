:- dynamic counter/1.
counter(0).

increment :-
    counter(X),
    NewX is X + 1,
    retract(counter(X)),
    assertz(counter(NewX)).
