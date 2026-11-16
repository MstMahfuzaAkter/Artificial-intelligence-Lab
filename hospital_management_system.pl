
:- dynamic patient/3.

% Initial Patients
patient(101, rahim, admitted).
patient(102, karim, discharged).
patient(103, sumaiya, admitted).

start :-
    nl,
    write('==== HOSPITAL MANAGEMENT SYSTEM ===='),
    nl,
    menu.

menu :-
    write('1. Add Patient'), nl,
    write('2. Update Patient Status'), nl,
    write('3. Remove Patient'), nl,
    write('4. Show All Patients'), nl,
    write('5. Search Patient'), nl,
    write('6. Exit'), nl,
    write('Enter choice: '),
    read(Choice),
    handle_choice(Choice).

% Add Patient
handle_choice(1) :-
    write('Enter Patient ID: '), read(ID),
    write('Enter Patient Name: '), read(Name),
    write('Enter Status (admitted/discharged): '),
    read(Status),
    (
        patient(ID, _, _) ->
        write('Patient already exists!'), nl
    ;
        (
            (Status = admitted ; Status = discharged) ->
            assertz(patient(ID, Name, Status)),
            write('Patient added successfully!'), nl
        ;
            write('Invalid status!'), nl
        )
    ),
    menu.

% Update Patient Status
handle_choice(2) :-
    write('Enter Patient ID: '), read(ID),
    (
        patient(ID, Name, OldStatus) ->
        write('Enter New Status: '), read(NewStatus),
        (
            (NewStatus = admitted ; NewStatus = discharged) ->
            retract(patient(ID, Name, OldStatus)),
            assertz(patient(ID, Name, NewStatus)),
            write('Status updated successfully!'), nl
        ;
            write('Invalid status!'), nl
        )
    ;
        write('Patient not found!'), nl
    ),
    menu.

% Remove Patient
handle_choice(3) :-
    write('Enter Patient ID: '), read(ID),
    (
        retract(patient(ID, _, _)) ->
        write('Patient removed successfully!'), nl
    ;
        write('Patient not found!'), nl
    ),
    menu.

% Show All Patients
handle_choice(4) :-
    nl,
    write('All Patient Records:'), nl,
    (
        patient(_, _, _) ->
        forall(
            patient(ID, Name, Status),
            (
                write('ID: '), write(ID),
                write(' Name: '), write(Name),
                write(' Status: '), write(Status), nl
            )
        )
    ;
        write('No patients available!'), nl
    ),
    menu.

% Search Patient
handle_choice(5) :-
    write('Enter Patient ID: '), read(ID),
    (
        patient(ID, Name, Status) ->
        write('Patient Found!'), nl,
        write('Name: '), write(Name), nl,
        write('Status: '), write(Status), nl
    ;
        write('Patient not found!'), nl
    ),
    menu.

% Exit
handle_choice(6) :-
    write('Thank you!'), nl.

% Invalid Choice
handle_choice(_) :-
    write('Invalid choice!'), nl,
    menu.
