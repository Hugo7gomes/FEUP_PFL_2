player(0,32).
player(1,164). % player1
player(-1,181). % player2

row(0,'A').
row(1,'B').
row(2,'C').
row(3,'D').
row(4,'E').
row(5,'F').
row(6,'G').
row(7,'H').
row(8,'I').
row(9,'J').

row_lower(0,'a').
row_lower(1,'b').
row_lower(2,'c').
row_lower(3,'d').
row_lower(4,'e').
row_lower(5,'f').
row_lower(6,'g').
row_lower(7,'h').
row_lower(8,'i').



clear_screen :- write('\33\[2J').


board_size(Board, Size):-
	nth0(0, Board, Row),
	length(Row, Size),
	length(Board, Y),
	Size == Y.



print_separator_mid(X) :-
	X > 2,
	write('- + '),
	X1 is X - 1, 
	print_separator_mid(X1).

print_separator_mid(2) :-
	write('- |\n').


print_board([], _, _).
print_board([L|T],N,X) :-
	X > N,
	row(N,Letter),
	write(' '), write(Letter), write(' | '),
	print_line(L), nl,
	write('---| - + '), print_separator_mid(X),
	N1 is N + 1,
	print_board(T, N1, X).


print_line([]):- !.
print_line([C|L]):-
	player(C, Char),
	put_code(Char),
	write(' | '),
	print_line(L).


print_header(X) :-
	write('   |'),
  	print_columns_numbers(0, X),
  	write('---'),
  	print_separator_board(X).


print_separator_board(0) :-
	write('|'), nl.
print_separator_board(X) :-
	X >0,
	write('+---'), 
	X1 is X-1, 
	print_separator_board(X1).


print_columns_numbers(Initial, Initial) :-
	nl.
print_columns_numbers(Initial, Final) :-
	write(' '), write(Initial), write(' |'),
	Initial1 is Initial + 1,
	print_columns_numbers(Initial1, Final). 


display_board(Board) :-
	nl, board_size(Board, Size),
	print_header(Size),
	print_board(Board,0,Size). 


