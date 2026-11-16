
:- dynamic account/3.

% Initial Accounts
account(1001, rahim, 5000).
account(1002, karim, 10000).
account(1003, sumaiya, 15000).

start :-
    nl,
    write('==== BANK ACCOUNT MANAGEMENT SYSTEM ===='),
    nl,
    menu.

menu :-
    write('1. Add Account'), nl,
    write('2. Update Balance'), nl,
    write('3. Delete Account'), nl,
    write('4. Show All Accounts'), nl,
    write('5. Search Account'), nl,
    write('6. Exit'), nl,
    write('Enter choice: '),
    read(Choice),
    handle_choice(Choice).

% Add Account
handle_choice(1) :-
    write('Enter Account Number: '), read(ID),
    write('Enter Account Holder Name: '), read(Name),
    write('Enter Balance: '), read(Balance),
    (
        account(ID, _, _) ->
        write('Account already exists!'), nl
    ;
        assertz(account(ID, Name, Balance)),
        write('Account added successfully!'), nl
    ),
    menu.

% Update Balance
handle_choice(2) :-
    write('Enter Account Number: '), read(ID),
    (
        account(ID, Name, OldBalance) ->
        write('Enter New Balance: '), read(NewBalance),
        retract(account(ID, Name, OldBalance)),
        assertz(account(ID, Name, NewBalance)),
        write('Balance updated successfully!'), nl
    ;
        write('Account not found!'), nl
    ),
    menu.

% Delete Account
handle_choice(3) :-
    write('Enter Account Number: '), read(ID),
    (
        retract(account(ID, _, _)) ->
        write('Account deleted successfully!'), nl
    ;
        write('Account not found!'), nl
    ),
    menu.

% Show All Accounts
handle_choice(4) :-
    nl,
    write('All Bank Accounts:'), nl,
    (
        account(_, _, _) ->
        forall(
            account(ID, Name, Balance),
            (
                write('Account Number: '), write(ID),
                write(' Name: '), write(Name),
                write(' Balance: '), write(Balance), nl
            )
        )
    ;
        write('No accounts available!'), nl
    ),
    menu.

% Search Account
handle_choice(5) :-
    write('Enter Account Number: '), read(ID),
    (
        account(ID, Name, Balance) ->
        write('Account Found!'), nl,
        write('Name: '), write(Name), nl,
        write('Balance: '), write(Balance), nl
    ;
        write('Account not found!'), nl
    ),
    menu.

% Exit
handle_choice(6) :-
    write('Thank you for using the bank system!'), nl.

% Invalid Choice
handle_choice(_) :-
    write('Invalid choice!'), nl,
    menu.
