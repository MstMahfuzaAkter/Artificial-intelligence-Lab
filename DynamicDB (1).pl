:-dynamic todo/1.
start :- 
    write(" --- TO-DO LIST --- "),
    menu.
menu :-
    nl,
    write(" --- Options (1-4)"), nl,
    write(" 1. Add New Task."), nl,
    write(" 2. Remove Task."), nl,
    write(" 3. Update Task"), nl, 
    write(" 4. Show All Task."), nl,
    write(" 5. Exit"), nl,
    read_line_to_string(user_input, Task),
    format(" You have Chosen Option ~w ", [Task]), nl,
    handle_choice(Task).
    


handle_choice("1"):-
nl, 
write("Please input your task : "), nl,
read_line_to_string(user_input, Task),
assertz(todo(Task)),
format("Added Task: ~w~n", [Task]),
menu.


handle_choice("2"):-
nl, 
write("Please input task to be removed: "), nl,
read_line_to_string(user_input, Task),
(   retract(todo(Task))
    ->  format("Removed  Task: ~w~n", [Task]), nl,
    format("Updated Task List: "), nl,
    forall(todo(T), format("- ~w~n", [T])), nl   
    ;   format("No Task: ~w~n found.", [Task]), nl
  ),                                                                                                     
menu.

handle_choice("3") :-
    nl,
    write("Input old task to update: "),
    read_line_to_string(user_input, OldTask),
    (   retract(todo(OldTask))
    ->  write("Input new task name: "),
        read_line_to_string(user_input, NewTask),
        assertz(todo(NewTask)),
        format("Old Task '~w' updated to New Task '~w'~n", [OldTask, NewTask]),
        write("Updated Task List:"), nl,
        forall(todo(T), format("- ~w~n", [T]))
    ;   write("Task not found."), nl
    ),
    menu.

handle_choice("4"):-
forall(todo(Task), format("- ~w~n", [Task])),
menu.

% 5. Exit (FIX: Added missing Option 5 without calling menu)
handle_choice("5") :-
    nl,
    write("Goodbye!"), nl.
    
handle_choice(_) :-
    write("Invalid option, please try again."), nl,
    menu.

