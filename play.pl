game_loop(Board,NextPlayer) :-
	repeat,
	clear_screen,
	display_board(Board),
	play(Board,NextPlayer),
	game_over, !.



play(Board,NextPlayer) :-
	is_human(NextPlayer) ->
		human_turn(Board);
		computer_turn(Board).



human_turn(Board) :-
	read_inputs(Board).

