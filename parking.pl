:- dynamic parking/2.

% Initial Parking
parking(1001, 5000).
parking(1002, 10000).
parking(1003, 15000).

start :-
    nl,
    write('==== Parking MANAGEMENT SYSTEM ===='),
    nl,
    menu.

menu :-
    write('1.Park a Vehicle'), nl,
    write('2.Remove a Vehicle'), nl,
    write('3.Change Parking Slot'), nl,
    write('4. Display Parked Vehicles'), nl,
    write('5. Exit'), nl,
    write('Enter choice: '),
    read(Choice),
    handle_choice(Choice).

% Add Parking
handle_choice(1) :-
    write('Enter Vehicle Number: '), read(Vehicle),
    write('Enter Parking Slot: '), read(Slot),
    (
        parking(Vehicle,_) ->
        write('Vehicle already exists!'), nl
    ;
        assertz(parking(Vehicle,Slot)),
        write('Vehicle added successfully!'), nl
    ),
    menu.


% Show All Parking
handle_choice(4) :-
    nl,
    write('All Parking Vehicle:'), nl,
    (
        parking(_, _) ->
        forall(
            parking(Vehicle,Slot),
            (
                write('Vehicle Number: '), write(Vehicle),
                write(' Slot '), write(Slot),
nl
                           )
        )
    ;
        write('No vehicle available!'), nl
    ),
    menu.


% Update Parking
handle_choice(3) :-
    write('Enter Vehicle Number: '), read(Vehicle),
    (
        parking(Vehicle,OldSlot) ->
        write('Enter New Slot: '), read(NewSlot),
        retract(parking(Vehicle,OldSlot)),
        assertz(parking(Vehicle,NewSlot)),
        write('Slot updated successfully!'), nl
    ;
        write('Slot not found!'), nl
    ),
    menu.

% Delete Parking
handle_choice(2) :-
    write('Enter Vehicle Number: '), read(Vehicle),
    (
        retract(parking(Vehicle, _)) ->
        write('Remove Vehicle successfully!'), nl
    ;
        write('Vehicle not found!'), nl
    ),
    menu.

% Exit
handle_choice(5) :-
    write('Thank you for using the parking system!'), nl.

% Invalid Choice
handle_choice(_) :-
    write('Invalid choice!'), nl,
    menu.