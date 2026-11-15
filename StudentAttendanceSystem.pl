:- dynamic attendance/2.

% Initial Database
attendance('Rahim', present).
attendance('Karim', absent).

% Add Attendance
add_attendance :-
    write('Enter Student Name: '),
    read(Name),
    write('Enter Status (present/absent): '),
    read(Status),
    assertz(attendance(Name, Status)),
    write('Attendance Added!'), nl.

% Update Attendance
update_attendance :-
    write('Enter Student Name: '),
    read(Name),
    ( attendance(Name, _) ->
        write('Enter New Status: '),
        read(NewStatus),
        retract(attendance(Name, _)),
        assertz(attendance(Name, NewStatus)),
        write('Attendance Updated!'), nl
    ;
        write('Student Not Found!'), nl
    ).

% Remove Attendance
remove_attendance :-
    write('Enter Student Name: '),
    read(Name),
    retractall(attendance(Name, _)),
    write('Attendance Removed!'), nl.

% Show Attendance
show_attendance :-
    forall(
        attendance(Name, Status),
        format('Name: ~w Status: ~w~n',
               [Name, Status])
    ).
