% =============================================================
% Menu : Onde aparecerá o menu_do_jogo
% =============================================================

:- module(menu, [menu/0]).

:- use_module('jogo', [iniciar_jogo/0]).

% tela_regras/0
% Equivalente a "telaRegras"
tela_regras :-
    format("============================================================================~n"),
    format("#                        R E G R A S                                       #~n"),
    format("============================================================================~n"),
    nl,
    format("1. Cada jogador posiciona seus navios no tabuleiro~n"),
    format("2. Os jogadores se alternam atirando coordenadas~n"),
    format("3. Acertar um navio marca como Acertou, errar como Errou~n"),
    format("4. Vence quem afundar todos os navios do oponente~n"),
    nl,
    format("Aperte 1 para voltar ao menu~n"),
    read_line_to_string(user_input, Opcao),
    ( Opcao == "1" -> menu
    ; tela_regras
    ).

% tela_jogo/0
% Equivalente a "telaJogo"
tela_jogo :- iniciar_jogo.

% tela_saida/0
% Equivalente a "telaSaida"
tela_saida :-
    format("~nObrigado por jogar! Ate logo! :)~n").

% menu/0
% Equivalente a "menu"
menu :-
    nl,
    format("============================================================================~n"),
    format("#                        B A T A L H A   N A V A L                        #~n"),
    format("============================================================================~n"),
    nl,
    format("1 - Jogar~n"),
    format("2 - Regras~n"),
    format("3 - Sair~n"),
    format("Escolha uma opcao: "),
    read_line_to_string(user_input, Opcao),
    ( Opcao == "1" -> tela_jogo
    ; Opcao == "2" -> tela_regras
    ; Opcao == "3" -> tela_saida
    ;
        format("Opcao invalida! Tente novamente.~n"),
        menu
    ).
