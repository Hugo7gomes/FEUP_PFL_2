is_human(NextPlayer) :-
	player(NextPlayer, 'Human').


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
