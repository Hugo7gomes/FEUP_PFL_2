:-consult('board.pl').
:-consult('play.pl').
:-consult('logic.pl').
:-consult('bot.pl').
:-consult('menus.pl').
:-consult('inputs.pl').
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(samsort)).
:- use_module(library(system)).

:- dynamic gameboard/1. 

play :-
	clear_screen,
	hadron_logo,
	menu.
