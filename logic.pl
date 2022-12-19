is_human(NextPlayer) :-
	player(NextPlayer, 'Human').

create_board(N, Count):-
	N > Count,
	length(List, N),
	maplist(=(0), List),
	Count1 is Count + 1,
	assertz(gameboard(List)),
	create_board(N, Count1).

create_board(N, N):-
	findall(Row, gameboard(Row), Board), 
	retractall(gameboard(_)),
	asserta(gameboard(Board)). 


take(0, _, []). 
take(N, [H|T], [H|Rest]) :-
    N > 0, 
    N1 is N - 1, 
    take(N1, T, Rest).  


drop(0, List, List). 
drop(N, [_|T], Rest) :-
    N > 0,  
    N1 is N - 1, 
    drop(N1, T, Rest). 



change_row(OldRow, Col, Value, NewRow):-
	take(Col, OldRow, Previous),
	Col1 is Col + 1,
	drop(Col1, OldRow, After),
	append(Previous, [Value], FirstResult),
	append(FirstResult, After, NewRow).

change_element(Row, Col, Value, Board, NewBoard) :-
    take(Row, Board, Previous),
    Row1 is Row +1,
    drop(Row1, Board, After),
    nth0(Row, Board, OldRow),
    change_row(OldRow, Col, Value, NewRow),
    append(Previous, [NewRow], FirstResult),
    append(FirstResult, After, NewBoard).

check_place(Row, Col, Player1Count, Player2Count, Board):-
	nth0(Row, Board, X),
	nth0(Col, X, Position),
	(Position == 1 -> Player1Count is 1, Player2Count is 0;
	Position == -1 -> Player2Count is 1, Player1Count is 0;
	Position == 0 -> Player1Count is 0, Player2Count is 0).


check_all_places(Col, Row, Player1Count, Player2Count, Board):-
	RowUp is Row +1,
	RowDown is Row -1,
	ColUp is Col + 1,
	ColDown is Col -1,
	check_place(RowUp, Col, Player1Count1, Player2Count1, Board),
	check_place(RowDown, Col, Player1Count2, Player2Count2, Board),
	check_place(Row, ColUp, Player1Count3, Player2Count3, Board),
	check_place(Row, ColDown, Player1Count4, Player2Count4, Board),
	Player1Count is Player1Count1 + Player1Count2 + Player1Count3 + Player1Count4,
	Player2Count is Player2Count1 + Player2Count2 + Player2Count3 + Player2Count4.



check_move(Col, Row, Board):-
	nth0(Row, Board, X),
	nth0(Col, X, Position),
	Position == 0,
	check_all_places(Col, Row, Player1Count, Player2Count, Board),
	Player1Count == Player2Count.



