game_loop(Size,NextPlayer) :-
	repeat,
	clear_screen,
	gameboard(Board),
	display_board(Board),
	turn(Player),
	read_inputs(Size, Column, Row),
	check_move(Column, Row, Board),
	change_element(Row, Column,2, Player, Board, NewBoard),
	retract(gameboard(_)),
	asserta(gameboard(NewBoard)),
	change_turn(),
	game_over, !.



play(Board,NextPlayer) :-
	is_human(NextPlayer) ->
		human_turn(Board);
		computer_turn(Board).

change_turn():-
	turn(Player),
	retract(turn(_)),
	NextPlayer is - Player,
	asserta(turn(NextPlayer)).

human_turn(Board) :-
	read_inputs(Board).

