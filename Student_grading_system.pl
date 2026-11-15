
:- dynamic student/2.

% ---------- Initial Database ----------
student('Mahfuza', 3.92).
student('Suborna', 3.85).
student('Rahim', 3.50).
student('Karim', 3.75).

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
    write('===== STUDENT GRADEBOOK MANAGEMENT SYSTEM ====='), nl,
    write('1. Add New Student'), nl,
    write('2. Update Student Grade'), nl,
    write('3. Remove Student'), nl,
    write('4. Show All Students'), nl,
    write('5. Exit'), nl,
    write('Enter your choice (1-5): '),

    read_line_to_string(user_input, Input),

    (   catch(number_string(Choice, Input), _, fail)
    ->  handle_choice(Choice)
    ;   write('Invalid choice. Please enter a number.'), nl,
        menu
    ).

% ---------- Handle Menu Choices ----------

handle_choice(1) :-
    add_student,
    menu.

handle_choice(2) :-
    update_grade,
    menu.

handle_choice(3) :-
    remove_student,
    menu.

handle_choice(4) :-
    show_students,
    menu.

handle_choice(5) :-
    write('Thank you for using Student Gradebook Management System!'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 5.'), nl,
    menu.

% ---------- Grade Validation ----------
valid_grade(Grade) :-
    number(Grade),
    Grade >= 0,
    Grade =< 4.00.

% ---------- 1. Add New Student (assertz) ----------
add_student :-
    write('Enter student name: '),
    get_input(Name),

    (   student(Name, _)
    ->  write('Student already exists.'), nl

    ;   write('Enter student grade: '),
        read(Grade),

        (   valid_grade(Grade)
        ->  assertz(student(Name, Grade)),
            write('Student added successfully.'), nl

        ;   write('Invalid grade. Grade must be between 0 and 4.'), nl
        )
    ).

% ---------- 2. Update Student Grade (retract + assertz) ----------
update_grade :-
    write('Enter student name: '),
    get_input(Name),

    (   student(Name, _)
    ->  write('Enter new grade: '),
        read(NewGrade),

        (   valid_grade(NewGrade)
        ->  retract(student(Name, _)),
            assertz(student(Name, NewGrade)),
            write('Student grade updated successfully.'), nl

        ;   write('Invalid grade. Grade must be between 0 and 4.'), nl
        )

    ;   write('Student not found.'), nl
    ).

% ---------- 3. Remove Student (retract) ----------
remove_student :-
    write('Enter student name: '),
    get_input(Name),

    (   retract(student(Name, _))
    ->  write('Student removed successfully.'), nl

    ;   write('Student not found.'), nl
    ).

% ---------- 4. Show All Students ----------
show_students :-
    (   student(_, _)
    ->  write('Student Grade Records:'), nl,

        forall(
            student(Name, Grade),
            format('Name: ~w   Grade: ~w~n', [Name, Grade])
        )

    ;   write('No student records found.'), nl
    ).
