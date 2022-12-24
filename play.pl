game_loop(Size) :-
	clear_screen,
	repeat,
		change_turn,
		display_board,
		next_move(Size),
		game_over, !,
	turn(Winner),
	win_message(Winner),
	retract(gameboard(_)),
	retract(turn(_)),
	retract(player(_,_)),
	retract(difficulty(_,_)).



next_move(Size) :-
	turn(NextPlayer),
	gameboard(Board),
	player(NextPlayer, Type),
	(Type == 'Human' -> human_turn(Board, NewBoard, NextPlayer, Size);
	 Type == 'Bot' -> computer_turn(Board, NewBoard, NextPlayer)), !,
	retract(gameboard(_)), 
	asserta(gameboard(NewBoard)).


human_turn(Board, NewBoard, NextPlayer, Size) :-
	read_input(Size, Column, Row),
	check_move(Column, Row, Board), 
	change_element(Row, Column, NextPlayer, Board, NewBoard).


computer_turn(Board, NewBoard, NextPlayer) :-
	difficulty(NextPlayer, Difficulty),
	(Difficulty == 1 -> easy_mode(Board, Col, Row);
	 Difficulty == 2 -> intelligent_mode(Col, Row, NextPlayer, Board)), 
	change_element(Row, Col, NextPlayer, Board, NewBoard),
	computer_move(Row, Col, NextPlayer),
	sleep(2).

change_turn :-
	turn(Player),
	retract(turn(_)), !,
	NextPlayer is - Player,
	asserta(turn(NextPlayer)), !.

