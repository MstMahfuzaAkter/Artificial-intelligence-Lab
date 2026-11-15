
:- dynamic attendance/2.

% ---------- Initial Database ----------
attendance('Rahim', present).
attendance('Karim', absent).

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
    write('===== STUDENT ATTENDANCE MANAGEMENT SYSTEM ====='), nl,
    write('1. Add New Attendance'), nl,
    write('2. Update Attendance'), nl,
    write('3. Remove Attendance'), nl,
    write('4. Show All Attendance'), nl,
    write('5. Exit'), nl,
    write('Enter your choice (1-5): '),
    read_line_to_string(user_input, Input),
    (   catch(number_string(Choice, Input), _, fail)
    ->  handle_choice(Choice)
    ;   write('Invalid choice. Please enter a number from 1 to 5.'), nl,
        menu
    ).

% ---------- Handle Menu Choices ----------
handle_choice(1) :-
    add_attendance,
    menu.

handle_choice(2) :-
    update_attendance,
    menu.

handle_choice(3) :-
    remove_attendance,
    menu.

handle_choice(4) :-
    show_attendance,
    menu.

handle_choice(5) :-
    write('Thank you for using the Attendance Management System!'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 5.'), nl,
    menu.

% ---------- Helper: Validate Status ----------
valid_status(present).
valid_status(absent).

% ---------- 1. Add New Attendance (assertz) ----------
add_attendance :-
    write('Enter student name: '),
    get_input(Name),
    (   attendance(Name, _)
    ->  write('Attendance record already exists.'), nl
    ;   write('Enter status (present/absent): '),
        get_input(Status),
        (   valid_status(Status)
        ->  assertz(attendance(Name, Status)),
            write('Attendance added successfully.'), nl
        ;   write('Invalid status. Use present or absent.'), nl
        )
    ).

% ---------- 2. Update Attendance (retract + assertz) ----------
update_attendance :-
    write('Enter student name: '),
    get_input(Name),
    (   attendance(Name, _)
    ->  write('Enter new status (present/absent): '),
        get_input(NewStatus),
        (   valid_status(NewStatus)
        ->  retractall(attendance(Name, _)),
            assertz(attendance(Name, NewStatus)),
            write('Attendance updated successfully.'), nl
        ;   write('Invalid status. Use present or absent.'), nl
        )
    ;   write('Student not found.'), nl
    ).

% ---------- 3. Remove Attendance (retract) ----------
remove_attendance :-
    write('Enter student name: '),
    get_input(Name),
    (   retractall(attendance(Name, _))
    ->  write('Attendance removed successfully.'), nl
    ;   write('Student not found.'), nl
    ).

% ---------- 4. Show All Attendance ----------
show_attendance :-
    (   attendance(_, _)
    ->  write('Student Attendance Records:'), nl,
        forall(
            attendance(Name, Status),
            format('Name: ~w  Status: ~w~n', [Name, Status])
        )
    ;   write('No attendance records found.'), nl
    ).
