:- dynamic book/3.

% ---------- Initial Database ----------
book('Data Mining: Concepts and Techniques', 'Vikram Pudi', 'available').
book('Introduction to Algorithms', 'Thomas H. Cormen', 'borrowed').
book('Programming in ANSI C', 'E. Balagurusamy', 'available').
book('Database System Concepts', 'Abraham Silberschatz', 'available').

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
    write('===== LIBRARY BOOK MANAGEMENT SYSTEM ====='), nl,
    write('1. Add New Book'), nl,
    write('2. Update Book Status'), nl,
    write('3. Remove Book'), nl,
    write('4. Show All Books'), nl,
    write('5. Search Book'), nl,
    write('6. Exit'), nl,
    write('Enter your choice (1-6): '),
    read_line_to_string(user_input, Input),
    (   catch(number_string(Choice, Input), _, fail)
    ->  handle_choice(Choice)
    ;   write('Invalid choice. Please enter a number from 1 to 6.'), nl,
        menu
    ).

% ---------- Handle Menu Choices ----------
handle_choice(1) :-
    add_book,
    menu.

handle_choice(2) :-
    update_book,
    menu.

handle_choice(3) :-
    remove_book,
    menu.

handle_choice(4) :-
    show_books,
    menu.

handle_choice(5) :-
    search_book,
    menu.

handle_choice(6) :-
    write('Thank you for using the Library Management System!'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 6.'), nl,
    menu.

% ---------- Helper: Validate Status ----------
valid_status(available).
valid_status(borrowed).

% ---------- 1. Add New Book (assertz) ----------
add_book :-
    write('Enter book title: '),
    get_input(Title),
    (   book(Title, _, _)
    ->  write('A book with this title already exists.'), nl
    ;   write('Enter author name: '),
        get_input(Author),
        write('Enter book status (available/borrowed): '),
        get_input(Status),
        (   valid_status(Status)
        ->  assertz(book(Title, Author, Status)),
            write('Book added successfully.'), nl
        ;   write('Invalid status. Use available or borrowed.'), nl
        )
    ).

% ---------- 2. Update Book Status (retract + assertz) ----------
update_book :-
    write('Enter book title: '),
    get_input(Title),
    (   book(Title, Author, _)
    ->  write('Enter new status (available/borrowed): '),
        get_input(NewStatus),
        (   valid_status(NewStatus)
        ->  retract(book(Title, Author, _)),
            assertz(book(Title, Author, NewStatus)),
            write('Book status updated successfully.'), nl
        ;   write('Invalid status. Use available or borrowed.'), nl
        )
    ;   write('Book not found.'), nl
    ).

% ---------- 3. Remove Book (retract) ----------
remove_book :-
    write('Enter book title: '),
    get_input(Title),
    (   retract(book(Title, _, _))
    ->  write('Book removed successfully.'), nl
    ;   write('Book not found.'), nl
    ).

% ---------- 4. Show All Books ----------
show_books :-
    (   book(_, _, _)
    ->  write('Library Book Records:'), nl,
        forall(
            book(Title, Author, Status),
            format('Title: ~w  Author: ~w  Status: ~w~n',
                   [Title, Author, Status])
        )
    ;   write('The library has no books.'), nl
    ).

% ---------- 5. Search Book ----------
search_book :-
    write('Enter book title: '),
    get_input(Title),
    (   book(Title, Author, Status)
    ->  write('Book Found!'), nl,
        format('Title: ~w~nAuthor: ~w~nStatus: ~w~n',
               [Title, Author, Status])
    ;   write('Book not found.'), nl
    ).
