:- dynamic product/3.

% Initial Database
product(101, 'Mouse', 500).
product(102, 'Keyboard', 1000).

% Add Product
add_product :-
    write('Enter Product ID: '),
    read(ID),
    write('Enter Product Name: '),
    read(Name),
    write('Enter Price: '),
    read(Price),
    assertz(product(ID, Name, Price)),
    write('Product Added!'), nl.

% Update Price
update_price :-
    write('Enter Product ID: '),
    read(ID),
    ( product(ID, Name, _) ->
        write('Enter New Price: '),
        read(NewPrice),
        retract(product(ID, Name, _)),
        assertz(product(ID, Name, NewPrice)),
        write('Price Updated!'), nl
    ;
        write('Product Not Found!'), nl
    ).

% Delete Product
delete_product :-
    write('Enter Product ID: '),
    read(ID),
    retractall(product(ID, _, _)),
    write('Product Deleted!'), nl.

% Show Products
show_products :-
    forall(
        product(ID, Name, Price),
        format('ID: ~w Name: ~w Price: ~w~n',
               [ID, Name, Price])
    ).
