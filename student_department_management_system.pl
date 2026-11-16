
:- dynamic student/3.

% Initial Students
student(101, rahim, cse).
student(102, karim, eee).
student(103, sumaiya, cse).

start :-
    nl,
    write('==== STUDENT MANAGEMENT SYSTEM ===='),
    nl,
    menu.

menu :-
    write('1. Add Student'), nl,
    write('2. Update Department'), nl,
    write('3. Delete Student'), nl,
    write('4. Show All Students'), nl,
    write('5. Search Student'), nl,
    write('6. Exit'), nl,
    write('Enter choice: '),
    read(Choice),
    handle_choice(Choice).

% Add Student
handle_choice(1) :-
    write('Enter ID: '), read(ID),
    write('Enter Name: '), read(Name),
    write('Enter Department: '), read(Dept),
    (
        student(ID, _, _) ->
        write('Student already exists!'), nl
    ;
        assertz(student(ID, Name, Dept)),
        write('Student added successfully!'), nl
    ),
    menu.

% Update Department
handle_choice(2) :-
    write('Enter Student ID: '), read(ID),
    (
        student(ID, Name, OldDept) ->
        write('Enter New Department: '), read(NewDept),
        retract(student(ID, Name, OldDept)),
        assertz(student(ID, Name, NewDept)),
        write('Department updated!'), nl
    ;
        write('Student not found!'), nl
    ),
    menu.

% Delete Student
handle_choice(3) :-
    write('Enter Student ID: '), read(ID),
    (
        retract(student(ID, _, _)) ->
        write('Student deleted!'), nl
    ;
        write('Student not found!'), nl
    ),
    menu.

% Show All Students
handle_choice(4) :-
    nl,
    write('All Students:'), nl,
    (
        student(_, _, _) ->
        forall(
            student(ID, Name, Dept),
            (
                write('ID: '), write(ID),
                write(' Name: '), write(Name),
                write(' Department: '), write(Dept), nl
            )
        )
    ;
        write('No students available!'), nl
    ),
    menu.

% Search Student
handle_choice(5) :-
    write('Enter Student ID: '), read(ID),
    (
        student(ID, Name, Dept) ->
        write('Student Found!'), nl,
        write('Name: '), write(Name), nl,
        write('Department: '), write(Dept), nl
    ;
        write('Student not found!'), nl
    ),
    menu.

% Exit
handle_choice(6) :-
    write('Thank you!'), nl.

% Invalid Choice
handle_choice(_) :-
    write('Invalid choice!'), nl,
    menu.
