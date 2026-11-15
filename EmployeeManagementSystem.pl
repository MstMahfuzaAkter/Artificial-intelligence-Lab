
:- dynamic employee/3.

% ---------- Initial Database ----------
employee(101, 'Rahim', 25000).
employee(102, 'Karim', 30000).

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
    write('===== EMPLOYEE MANAGEMENT SYSTEM ====='), nl,
    write('1. Add New Employee'), nl,
    write('2. Update Employee Salary'), nl,
    write('3. Delete Employee'), nl,
    write('4. Show All Employees'), nl,
    write('5. Search Employee'), nl,
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
    add_employee,
    menu.

handle_choice(2) :-
    update_salary,
    menu.

handle_choice(3) :-
    delete_employee,
    menu.

handle_choice(4) :-
    show_employees,
    menu.

handle_choice(5) :-
    search_employee,
    menu.

handle_choice(6) :-
    write('Thank you for using Employee Management System!'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 6.'), nl,
    menu.

% ---------- Helper: Validate Salary ----------
valid_salary(Salary) :-
    number(Salary),
    Salary >= 0.

% ---------- 1. Add New Employee (assertz) ----------
add_employee :-
    write('Enter Employee ID: '),
    read(ID),

    (   employee(ID, _, _)
    ->  write('Employee ID already exists.'), nl

    ;   write('Enter Employee Name: '),
        get_input(Name),
        write('Enter Salary: '),
        read(Salary),

        (   valid_salary(Salary)
        ->  assertz(employee(ID, Name, Salary)),
            write('Employee added successfully.'), nl

        ;   write('Invalid salary. Salary must be greater than or equal to 0.'), nl
        )
    ).

% ---------- 2. Update Employee Salary (retract + assertz) ----------
update_salary :-
    write('Enter Employee ID: '),
    read(ID),

    (   employee(ID, Name, _)
    ->  write('Enter New Salary: '),
        read(NewSalary),

        (   valid_salary(NewSalary)
        ->  retractall(employee(ID, _, _)),
            assertz(employee(ID, Name, NewSalary)),
            write('Employee salary updated successfully.'), nl

        ;   write('Invalid salary. Salary must be greater than or equal to 0.'), nl
        )

    ;   write('Employee not found.'), nl
    ).

% ---------- 3. Delete Employee (retractall) ----------
delete_employee :-
    write('Enter Employee ID: '),
    read(ID),

    (   retractall(employee(ID, _, _))
    ->  write('Employee deleted successfully.'), nl

    ;   write('Employee not found.'), nl
    ).

% ---------- 4. Show All Employees ----------
show_employees :-
    (   employee(_, _, _)
    ->  write('Employee Records:'), nl,

        forall(
            employee(ID, Name, Salary),
            format('ID: ~w   Name: ~w   Salary: ~w~n',
                   [ID, Name, Salary])
        )

    ;   write('No employee records found.'), nl
    ).

% ---------- 5. Search Employee ----------
search_employee :-
    write('Enter Employee ID: '),
    read(ID),

    (   employee(ID, Name, Salary)
    ->  write('Employee Found!'), nl,
        format('ID: ~w~nName: ~w~nSalary: ~w~n',
               [ID, Name, Salary])

    ;   write('Employee not found.'), nl
    ).
