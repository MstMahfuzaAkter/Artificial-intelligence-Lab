
:- dynamic product/3.

% ---------- Initial Database ----------
product(101, 'Mouse', 500).
product(102, 'Keyboard', 1000).

% ---------- Input Helper ----------
get_input(Value) :-
    read_line_to_string(user_input, Input),
    normalize_space(string(CleanInput), Input),
    atom_string(Value, CleanInput).

% ---------- Entry Point ----------
start :-
    menu.

% ---------- Menu ----------
menu :-
    nl,
    write('===== PRODUCT MANAGEMENT SYSTEM ====='), nl,
    write('1. Add New Product'), nl,
    write('2. Update Product Price'), nl,
    write('3. Delete Product'), nl,
    write('4. Show All Products'), nl,
    write('5. Search Product'), nl,
    write('6. Exit'), nl,
    write('Enter your choice (1-6): '),

    read_line_to_string(user_input, Input),

    (   catch(number_string(Choice, Input), _, fail)
    ->  handle_choice(Choice)
    ;   write('Invalid choice. Please enter a number.'), nl,
        menu
    ).

% ---------- Handle Menu Choices ----------
handle_choice(1) :-
    add_product,
    menu.

handle_choice(2) :-
    update_price,
    menu.

handle_choice(3) :-
    delete_product,
    menu.

handle_choice(4) :-
    show_products,
    menu.

handle_choice(5) :-
    search_product,
    menu.

handle_choice(6) :-
    write('Thank you for using Product Management System!'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 6.'), nl,
    menu.

% ---------- Helper: Validate Price ----------
valid_price(Price) :-
    number(Price),
    Price >= 0.

% ---------- 1. Add New Product (assertz) ----------
add_product :-
    write('Enter Product ID: '),
    read(ID),

    (   product(ID, _, _)
    ->  write('Product ID already exists.'), nl

    ;   write('Enter Product Name: '),
        get_input(Name),
        write('Enter Price: '),
        read(Price),

        (   valid_price(Price)
        ->  assertz(product(ID, Name, Price)),
            write('Product added successfully.'), nl

        ;   write('Invalid price. Price must be greater than or equal to 0.'), nl
        )
    ).

% ---------- 2. Update Product Price (retract + assertz) ----------
update_price :-
    write('Enter Product ID: '),
    read(ID),

    (   product(ID, Name, _)
    ->  write('Enter New Price: '),
        read(NewPrice),

        (   valid_price(NewPrice)
        ->  retractall(product(ID, _, _)),
            assertz(product(ID, Name, NewPrice)),
            write('Product price updated successfully.'), nl

        ;   write('Invalid price. Price must be greater than or equal to 0.'), nl
        )

    ;   write('Product not found.'), nl
    ).

% ---------- 3. Delete Product (retractall) ----------
delete_product :-
    write('Enter Product ID: '),
    read(ID),

    (   retractall(product(ID, _, _))
    ->  write('Product deleted successfully.'), nl

    ;   write('Product not found.'), nl
    ).

% ---------- 4. Show All Products ----------
show_products :-
    (   product(_, _, _)
    ->  write('Product Records:'), nl,

        forall(
            product(ID, Name, Price),
            format('ID: ~w   Name: ~w   Price: ~w~n',
                   [ID, Name, Price])
        )

    ;   write('No product records found.'), nl
    ).

% ---------- 5. Search Product ----------
search_product :-
    write('Enter Product ID: '),
    read(ID),

    (   product(ID, Name, Price)
    ->  write('Product Found!'), nl,
        format('ID: ~w~nName: ~w~nPrice: ~w~n',
               [ID, Name, Price])

    ;   write('Product not found.'), nl
    ).
