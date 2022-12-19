:-consult('board.pl').
:-consult('play.pl').
:-consult('logic.pl').
:-consult('bot.pl').
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(samsort)).

:- dynamic gameboard/1. 

hadron :-
	create_board(5,0),
	gameboard(Board),
	display_board(Board),
	change_element(1,2, 1, Board, NewBoard),
	retract(gameboard(_)),
	asserta(gameboard(NewBoard)),
	gameboard(Board1),
	display_board(Board1).
