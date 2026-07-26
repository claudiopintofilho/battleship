% =============================================================
% Main : Executável_Do_Jogo
% =============================================================

:- use_module('controle/menu', [menu/0]).

:- initialization(main).

main :-
    menu,
    halt.
