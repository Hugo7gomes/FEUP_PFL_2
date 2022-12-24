option_size(1, 5).
option_size(2, 7).
option_size(3, 9).

player_turn(-1,2).
player_turn(1,1).

hadron_logo :-
write('##    ##    ###    #####   #########  ######## ##     ##\n'),
write('##    ##   ## ##   #    #  ##      ## #      # ###    ##\n'),
write('##    ##  ##   ##  #     # ##      ## #      # ## #   ##\n'),
write('######## ##     ## #     # #########  #      # ##  #  ##\n'),
write('##    ## ######### #     # ####       #      # ##   # ##\n'),
write('##    ## ##     ## #    #  ##  ####   #      # ##    ###\n'),
write('##    ## ##     ## #####   ##     ### ######## ##     ##\n').

menu_header_format(Header):-
  format( ' ~n~`*t ~p ~`*t~57|~n', [Header]).

menu_empty_format :-
  format( '*~t*~57|~n', []).

menu_option_format(Option, Details):-
  format( '*~t~d~t~15|~t~a~t~40+~t*~57|~n', [Option, Details]).

menu_second_header_format(Label1, Label2):-
      format( '*~t~a~t~15+~t~a~t~40+~t*~57|~n', [Label1, Label2]).

menu_end_format :-
  format( '~`*t~57|~n', []).




menu :-
    menu_header_format('MAIN MENU'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_empty_format,
    menu_option_format(1, 'Player vs Player'),
    menu_option_format(2, 'Player vs Computer'),
    menu_option_format(3, 'Computer vs Computer'),
    menu_option_format(4, 'Game Rules'),
    menu_empty_format,
    menu_option_format(0, 'EXIT'),
    menu_empty_format,
    menu_end_format,

    read_number(4, Number),
    menu_option(Number).

menu_choose_size(Size):-
    menu_header_format('Choose a size to the board'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_option_format(1, '5x5'),
    menu_option_format(2, '7x7'),
    menu_option_format(3, '9x9'),
    menu_empty_format,
    menu_option_format(0,'EXIT'),
    menu_end_format,
    read_number(3,Size).

banner(String) :-
    format( '~n~`*t~57|~n', []),
    format( '*~t~a~t*~57|~n', [String]),
    format( '~`*t~57|~n', []).


win_message(Player):-
    player_turn(Player, PlayerNumber),
    format( '~n~`*t~57|~n', []),
    format( '*~t Player ~d Won!~t*~57|~n', [PlayerNumber]),
    format( '~`*t~57|~n', []),
    sleep(2).


computer_move(Row, Col, Player):-
    player_turn(Player, PlayerNumber),
    row(Row, Letter),
    format( '*~t Computer ~d Put a Piece in Tale ~dx~a!~t*~57|~n', [PlayerNumber, Col, Letter]).


menu_option(0):-
    banner('Thank You For Playing'),
    hadron_logo.

menu_option(1):-
    asserta(player(1, 'Human')),
    asserta(player(-1, 'Human')),
    menu_choose_size(Size),
    clear_screen,
    pp_start(Size), clear_screen.

menu_option(2):-
    banner('Player vs Computer'),
    menu_choose_size(Size),
    pc_menu_1(Size),
    clear_screen, menu.


menu_option(3):-
    banner('Computer vs Computer'),
    menu_choose_size(Size),
    cc_menu_1(Size),
    clear_screen, menu.


pp_start(0):-
    menu.

pp_start(Option):-
    option_size(Option, Size),
    create_board(Size,0),
    asserta(turn(-1)),
    game_loop(Size),
    menu.


pc_menu_1(0).

pc_menu_1(Size):-
    banner('Player vs Computer'),
    menu_header_format('Choose a Difficulty'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_empty_format,
    menu_option_format(1, 'Easy (Random)'),
    menu_option_format(2, 'Normal (Greedy)'),
    menu_empty_format,
    menu_option_format(0, 'EXIT'),
    menu_empty_format,
    menu_end_format,

    read_number(2,Difficulty),
    pc_menu_2(Size, Difficulty).

pc_menu_2(_,0).

pc_menu_2(Size, Difficulty):-
    banner('Player vs Computer'),
    menu_header_format('Choose a Player'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_empty_format,
    menu_option_format(1, 'Player 1 (Plays First)'),
    menu_option_format(2, 'Player 2'),
    menu_empty_format,
    menu_option_format(0, 'EXIT'),
    menu_empty_format,
    menu_end_format,
    read_number(2, PlayerTurn),
    pc_start(Size, Difficulty, PlayerTurn).



pc_start(Option, Difficulty, 1):-
    option_size(Option, Size),
    create_board(Size,0),
    asserta(player(1, 'Human')),
    asserta(player(-1, 'Bot')),
    asserta(turn(-1)),
    asserta(difficulty(-1,Difficulty)),
    game_loop(Size).

pc_start(Option, Difficulty, 2):-
    option_size(Option, Size),
    create_board(Size,0),
    asserta(player(1, 'Bot')),
    asserta(player(-1, 'Human')),
    asserta(turn(-1)),
    asserta(difficulty(1, Difficulty)),
    game_loop(Size).

cc_menu_1(0).

cc_menu_1(Size):-
    banner('Computer vs Computer'),
    menu_header_format('Choose a Difficulty For Computer 1'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_empty_format,
    menu_option_format(1, 'Easy (Random)'),
    menu_option_format(2, 'Normal (Greedy)'),
    menu_empty_format,
    menu_option_format(0, 'EXIT'),
    menu_empty_format,
    menu_end_format,

    read_number(2,Difficulty),
    cc_menu_2(Size, Difficulty).

cc_menu_2(_,0).

cc_menu_2(Size, Difficulty1):-
    banner('Computer vs Computer'),
    menu_header_format('Choose a Difficulty For Computer 2'),
    menu_empty_format,
    menu_second_header_format('Option', 'Details'),
    menu_empty_format,
    menu_option_format(1, 'Easy (Random)'),
    menu_option_format(2, 'Normal (Greedy)'),
    menu_empty_format,
    menu_option_format(0, 'EXIT'),
    menu_empty_format,
    menu_end_format,

    read_number(2,Difficulty),
    cc_start(Size, Difficulty1, Difficulty).

cc_start(_,_,0).

cc_start(Option, Difficulty1, Difficulty2):-
    option_size(Option, Size),
    create_board(Size, 0),
    asserta(difficulty(1, Difficulty1)),
    asserta(difficulty(-1, Difficulty2)),
    asserta(turn(-1)),
    asserta(player(1, 'Bot')),
    asserta(player(-1, 'Bot')),
    game_loop(Size).






    


