
:- dynamic product/3.

% Initial Products
product(laptop, 50000, 10).
product(mobile, 20000, 15).
product(keyboard, 1500, 20).

start :-
    nl,
    write('==== PRODUCT INVENTORY SYSTEM ===='),
    nl,
    menu.

menu :-
    write('1. Add Product'), nl,
    write('2. Update Quantity'), nl,
    write('3. Delete Product'), nl,
    write('4. Show All Products'), nl,
    write('5. Search Product'), nl,
    write('6. Exit'), nl,
    write('Enter choice: '),
    read(Choice),
    handle_choice(Choice).

% Add Product
handle_choice(1) :-
    write('Enter Product Name: '), read(Name),
    write('Enter Price: '), read(Price),
    write('Enter Quantity: '), read(Qty),
    (
        product(Name, _, _) ->
        write('Product already exists!'), nl
    ;
        assertz(product(Name, Price, Qty)),
        write('Product added successfully!'), nl
    ),
    menu.

% Update Quantity
handle_choice(2) :-
    write('Enter Product Name: '), read(Name),
    (
        product(Name, Price, OldQty) ->
        write('Enter New Quantity: '), read(NewQty),
        retract(product(Name, Price, OldQty)),
        assertz(product(Name, Price, NewQty)),
        write('Quantity updated successfully!'), nl
    ;
        write('Product not found!'), nl
    ),
    menu.

% Delete Product
handle_choice(3) :-
    write('Enter Product Name: '), read(Name),
    (
        retract(product(Name, _, _)) ->
        write('Product deleted successfully!'), nl
    ;
        write('Product not found!'), nl
    ),
    menu.

% Show All Products
handle_choice(4) :-
    nl,
    write('All Products:'), nl,
    (
        product(_, _, _) ->
        forall(
            product(Name, Price, Qty),
            (
                write('Name: '), write(Name),
                write(' Price: '), write(Price),
                write(' Quantity: '), write(Qty), nl
            )
        )
    ;
        write('No products available!'), nl
    ),
    menu.

% Search Product
handle_choice(5) :-
    write('Enter Product Name: '), read(Name),
    (
        product(Name, Price, Qty) ->
        write('Product Found!'), nl,
        write('Price: '), write(Price), nl,
        write('Quantity: '), write(Qty), nl
    ;
        write('Product not found!'), nl
    ),
    menu.

% Exit
handle_choice(6) :-
    write('Thank you!'), nl.

% Invalid Choice
handle_choice(_) :-
    write('Invalid choice!'), nl,
    menu.
