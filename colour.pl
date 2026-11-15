:- dynamic colour/2.
colour(apple, red).

add_colour(Fruit, Shade) :-
    assertz(colour(Fruit, Shade)).

remove_colour(Fruit) :-
    retract(colour(Fruit, _)).
