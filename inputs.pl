ascii_code(48, 0).
ascii_code(49, 1).
ascii_code(50, 2).
ascii_code(51, 3).
ascii_code(52, 4).
ascii_code(53, 5).
ascii_code(54, 6).
ascii_code(55, 7).
ascii_code(56, 8).
ascii_code(57, 9).


letter_to_number('a',0).
letter_to_number('b',1).
letter_to_number('c',2).
letter_to_number('d',3).
letter_to_number('e',4).
letter_to_number('f',5).
letter_to_number('g',6).
letter_to_number('h',7).
letter_to_number('i',8).


between(S,Upper) :- S >= 0, S< Upper.

read_input(Size, Column, Row) :-
	check_column(Size,Column),
	check_row(Size, Row).



check_column(Size, Column) :-
	repeat,
		format( ' | Column 0-~d\n', Size - 1),
		get_code(X),
		peek_char(Enter),
		Enter == '\n',
		ascii_code(X, Column),
		skip_line,
		(between(Column,Size) -> format( ': Column read : ~d\n', Column);
		write('~ Invalid column | Enter a column again:\n')),
		between(Column,Size), !.


check_row(Size, Row) :-
	repeat,
		S1 is Size -1,
		letter_to_number(Letter, S1),
		format( ' | Row a-~a\n', Letter),
		get_char(Y),
		peek_char(Enter),
		Enter == '\n',
		letter_to_number(Y, Row),
		skip_line,
		(between(Row,Size) -> format( ': Row read : ~a\n', Y);
		write('~ Invalid column | Enter a column again:\n')),
		between(Row,Size), !.




read_number(UpperBound, Result) :-
	repeat,
		format( '| Choose an Option (~d-~d) - ', [0, UpperBound]),
		get_code(ASCIICode),
		peek_char(Enter),
		Enter == '\n',
		ascii_code(ASCIICode, Result),
		skip_line,
		UP is UpperBound +1,
		(between(Result,UP) -> true;
		write('Not a valid number, try again\n')),
		between(Result,UP), !.



