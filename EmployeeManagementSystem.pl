:- dynamic employee/3.

% Initial Database
employee(101, 'Rahim', 25000).
employee(102, 'Karim', 30000).

% Add Employee
add_employee :-
    write('Enter ID: '), read(ID),
    write('Enter Name: '), read(Name),
    write('Enter Salary: '), read(Salary),
    assertz(employee(ID, Name, Salary)),
    write('Employee Added!'), nl.

% Update Salary
update_salary :-
    write('Enter ID: '), read(ID),
    ( employee(ID, Name, _) ->
        write('Enter New Salary: '),
        read(NewSalary),
        retract(employee(ID, Name, _)),
        assertz(employee(ID, Name, NewSalary)),
        write('Salary Updated!'), nl
    ;
        write('Employee Not Found!'), nl
    ).

% Delete Employee
delete_employee :-
    write('Enter ID: '), read(ID),
    ( retract(employee(ID, _, _)) ->
        write('Employee Deleted!'), nl
    ;
        write('Employee Not Found!'), nl
    ).

% Show Employees
show_employees :-
    forall(
        employee(ID, Name, Salary),
        format('ID: ~w Name: ~w Salary: ~w~n',
               [ID, Name, Salary])
    ).
