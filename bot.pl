easy_mode(Board, Col, Row):-
	findall([Columns, Rows], check_move(Columns, Rows, Board), AvailableMoves),
	length(AvailableMoves, X),
	Size is X -1,
	random(0,Size, MoveIndex),
	nth0(MoveIndex, AvailableMoves, ChosenMove),
	nth0(0, ChosenMove, Col),
	nth0(1, ChosenMove, Row).



number_moves_opponent([], _, _, []).
number_moves_opponent([H | T], Board, PlayerTurn, Solution):-
	nth0(0,H, Col),
	nth0(1, H, Row),
	change_element(Row, Col, PlayerTurn, Board, NewBoard),
	findall([Columns, Rows], check_move(Columns, Rows, NewBoard), AvailableMoves),
	length(AvailableMoves, Size),
	number_moves_opponent(T, Board, PlayerTurn, SolutionSize),
	append(SolutionSize, [[Size,Col, Row]], Solution).

compare_first_element(Order, [H1 | _], [H2 | _]) :-
    compare(Order, H1, H2).


intelligent_mode(Col, Row, PlayerTurn, Board):-
	findall([Columns, Rows], check_move(Columns, Rows, Board), AvailableMoves),
	number_moves_opponent(AvailableMoves, Board, PlayerTurn, Solution),
	samsort(Solution, OrderedSolution),
	nth0(0, OrderedSolution, Result),
	nth0(1, Result, Col),
	nth0(2, Result, Row).


