% =============================================================
% Menu : Versao Retro Terminal (Batalha Naval)
% =============================================================

:- module(menu, [menu/0]).

:- use_module('jogo', [iniciar_jogo/0]).

% Limpa a tela do terminal
limpar_tela :-
    format("~c[2J~c[H", [27, 27]).

% Imprime o conteudo de um arquivo de texto linha por linha
imprimir_arquivo(Caminho) :-
    setup_call_cleanup(
        open(Caminho, read, Stream, [encoding(utf8)]),
        imprimir_linhas(Stream),
        close(Stream)
    ).

imprimir_linhas(Stream) :-
    read_line_to_string(Stream, Linha),
    ( Linha \== end_of_file ->
        writeln(Linha),
        imprimir_linhas(Stream)
    ; true
    ).

% tela_regras/0
tela_regras :-
    limpar_tela,
    format("============================================================================~n"),
    format("                                R E G R A S                                 ~n"),
    format("============================================================================~n"),
    format("1. Posicione seus navios de forma estrategica no tabuleiro.~n"),
    format("2. Os jogadores se alternam informando as coordenadas de disparo.~n"),
    format("3. Disparos na agua sao marcados como Errou; alvos como Fogo.~n"),
    format("4. Vence quem afundar toda a frota inimiga primeiro!~n"),
    format("============================================================================~n"),
    nl,
    format(">>> Digite 1 e pressione ENTER para voltar ao menu: "),
    read_line_to_string(user_input, Opcao),
    ( Opcao == "1" -> menu
    ; tela_regras
    ).

% tela_jogo/0
tela_jogo :- 
    limpar_tela,
    iniciar_jogo.

% tela_saida/0
tela_saida :-
    limpar_tela,
    nl,
    format("Obrigado por jogar Batalha Naval! Ate a proxima!~n"),
    nl.

% menu/0
menu :-
    limpar_tela,
    % Carrega e exibe a arte diretamente do arquivo externalizado
    catch(imprimir_arquivo('menu_art.txt'), _, writeln("=== BATALHA NAVAL ===")),
    nl,
    format("                       [1] JOGAR~n"),
    format("                       [2] REGRAS~n"),
    format("                       [3] SAIR~n"),
    nl,
    format("Escolha uma opcao [1-3]: "),
    read_line_to_string(user_input, Opcao),
    ( Opcao == "1" -> tela_jogo
    ; Opcao == "2" -> tela_regras
    ; Opcao == "3" -> tela_saida
    ;
        format("~nOpcao invalida! Pressione ENTER para tentar novamente..."),
        read_line_to_string(user_input, _),
        menu
    ).