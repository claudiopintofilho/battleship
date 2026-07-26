% =============================================================
% Responsável pelo controle da partida do jogo.
% =============================================================

:- module(jogo, [iniciar_jogo/0]).

:- use_module('../tipos/base',            [tabuleiro_vazio/1, navios_padrao/1]).
:- use_module('../interface/interface',   [print_tabuleiro/2]).
:- use_module('../logica/atirar',         [atirar/3]).
:- use_module('../logica/posicionamento', [posicionar_navio/5, gera_corpo/4, coordenada_valida/1]).

% Lê a orientação escolhida pelo usuário
ler_orientacao(Orientacao) :-
    format("Orientacao (H ou V): "),
    read_line_to_string(user_input, Linha),
    string_upper(Linha, LinhaMaiuscula),
    ( LinhaMaiuscula == "H" -> Orientacao = h
    ; LinhaMaiuscula == "V" -> Orientacao = v
    ; format("Orientacao invalida! Digite H (horizontal) ou V (vertical).~n"),
      ler_orientacao(Orientacao)
    ).

% Lê um número inteiro válido entre 0 e 9
ler_int(Prompt, Valor) :-
    format("~w", [Prompt]),
    read_line_to_string(user_input, Linha),
    ( number_string(N, Linha), integer(N), N >= 0, N =< 9 ->
        Valor = N
    ; format("Valor invalido! Digite um numero entre 0 e 9.~n"),
      ler_int(Prompt, Valor)
    ).

% Inicia a partida completa
iniciar_jogo :-
    format("~n=== JOGADOR 1: Posicione seus navios ===~n"),
    fase_posicionamento(TabP1),
    format("~n=== JOGADOR 2: Posicione seus navios ===~n"),
    fase_posicionamento(TabP2),
    loop_jogo(TabP1, TabP2, true).

% Fase de posicionamento dos navios
fase_posicionamento(Tabuleiro) :-
    tabuleiro_vazio(TabuleiroVazio),
    navios_padrao(Navios),
    posicionar_navios(TabuleiroVazio, Navios, Tabuleiro).

% Posiciona todos os navios do jogador
posicionar_navios(Tabuleiro, [], Tabuleiro).
posicionar_navios(Tabuleiro, [navio(Tipo, Tamanho, _, _) | Resto], TabuleiroFinal) :-
    format("~nSeu tabuleiro atual:~n"),
    tabuleiro_vazio(TabuleiroOculto),
    print_tabuleiro(Tabuleiro, TabuleiroOculto),
    format("~nPosicione o navio ~w (tamanho ~w)~n", [Tipo, Tamanho]),
    ler_int("Linha inicial (0-9): ", Linha),
    ler_int("Coluna inicial (0-9): ", Coluna),
    ler_orientacao(Orientacao),
    Coord = coord(Linha, Coluna),
    ( posicionar_navio(Tabuleiro, Coord, Tamanho, Orientacao, NovoTabuleiro) ->
        posicionar_navios(NovoTabuleiro, Resto, TabuleiroFinal)
    ;
        gera_corpo(Coord, Tamanho, Orientacao, Corpo),
        ( forall(member(C, Corpo), coordenada_valida(C)) ->
            format("Posicao invalida: ja existe um navio nessa posicao!~n")
        ;
            format("Posicao invalida: o navio ficaria fora do tabuleiro!~n")
        ),
        posicionar_navios(Tabuleiro, [navio(Tipo, Tamanho, _, _) | Resto], TabuleiroFinal)
    ).

% Versão do tabuleiro sem exibir os navios
esconder_navios([], []).
esconder_navios([Linha | Resto], [LinhaOculta | RestoOculto]) :-
    esconder_linha(Linha, LinhaOculta),
    esconder_navios(Resto, RestoOculto).

esconder_linha([], []).
esconder_linha([navio | Resto], [agua | RestoOculto]) :- !,
    esconder_linha(Resto, RestoOculto).
esconder_linha([Celula | Resto], [Celula | RestoOculto]) :-
    esconder_linha(Resto, RestoOculto).

% Ciclo principal dos turnos da partida
loop_jogo(TabP1, TabP2, TurnoP1) :-
    format("~n========================================~n"),
    ( TurnoP1 -> format(">>> VEZ DO JOGADOR 1 <<<~n")
    ;            format(">>> VEZ DO JOGADOR 2 <<<~n")
    ),
    format("   SEU TABULEIRO                         TABULEIRO INIMIGO~n"),
    ( TurnoP1 ->
        esconder_navios(TabP2, TabP2Oculto),
        print_tabuleiro(TabP1, TabP2Oculto)
    ;
        esconder_navios(TabP1, TabP1Oculto),
        print_tabuleiro(TabP2, TabP1Oculto)
    ),
    format("~nSua vez de atirar!~n"),
    ler_int("Digite a LINHA (0-9): ", Linha),
    ler_int("Digite a COLUNA (0-9): ", Coluna),
    Coord = coord(Linha, Coluna),
    ( TurnoP1 ->
        atirar(Coord, TabP2, NovoTabP2),
        ( jogo_acabou(NovoTabP2) ->
            format("~nJOGADOR 1 VENCEU! Todos os navios inimigos foram afundados!~n")
        ;
            loop_jogo(TabP1, NovoTabP2, false)
        )
    ;
        atirar(Coord, TabP1, NovoTabP1),
        ( jogo_acabou(NovoTabP1) ->
            format("~nJOGADOR 2 VENCEU! Todos os navios inimigos foram afundados!~n")
        ;
            loop_jogo(NovoTabP1, TabP2, true)
        )
    ).

% Verifica se todos os navios foram destruídos para definir fim
jogo_acabou(Tabuleiro) :-
    \+ (member(Linha, Tabuleiro), member(navio, Linha)).
