:-consult('board.pl').
:-consult('play.pl').
:-consult('logic.pl').
:- use_module(library(lists)).
:- dynamic gameboard/1. 

hadron :-
	create_board(5,0,Board),
	change_element(1,2, 1, Board, NewBoard),
	display_board(NewBoard).
