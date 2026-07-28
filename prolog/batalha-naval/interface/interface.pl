% =============================================================
% Modulo: interface/interface.pl
% Equivalente a: Interface/Interface.hs
%
% Responsavel por exibir os tabuleiros no terminal e por
% oferecer as operacoes basicas de acesso/atualizacao de uma
% celula do tabuleiro (obter/marca), assim como no arquivo
% Haskell original.
% =============================================================

:- module(interface, [
    make_cell/2,
    converte_linha/2,
    print_tabuleiro/2,
    coordenada_dentro_tab/2,
    obter/3,
    marca/4
]).

% make_cell(+Celula, -Simbolo)
% Equivalente a "makeCell"
make_cell(agua,    '~ ').
make_cell(navio,   'B ').
make_cell(acertou, 'X ').
make_cell(errou,   'o ').

% converte_linha(+Linha, -Texto)
% Equivalente a "converteLinha linha = concatMap makeCell linha"
converte_linha([], '').
converte_linha([Celula | Resto], Texto) :-
    make_cell(Celula, Simbolo),
    converte_linha(Resto, TextoResto),
    atom_concat(Simbolo, TextoResto, Texto).

% print_tabuleiro(+TabuleiroProprio, +TabuleiroInimigo)
% Equivalente a "printTabuleiro t1 t2 n"; aqui o contador de
% linha comeca sempre em 0, entao nao precisamos do 3o parametro.
print_tabuleiro(T1, T2) :-
    write('   0 1 2 3 4 5 6 7 8 9         0 1 2 3 4 5 6 7 8 9'), nl,
    desenha_linhas(T1, T2, 0).

desenha_linhas([], [], _) :- !.
desenha_linhas([H1 | T1], [H2 | T2], N) :-
    ( N < 10 -> format(atom(Prefixo), '~w ', [N])
    ; format(atom(Prefixo), '~w', [N])
    ),
    converte_linha(H1, Texto1),
    converte_linha(H2, Texto2),
    format('~w ~w      ~w~n', [Prefixo, Texto1, Texto2]),
    N1 is N + 1,
    desenha_linhas(T1, T2, N1).

% coordenada_dentro_tab(+Coordenada, +Tabuleiro)
% Equivalente a "coordenadaDentroTab"
coordenada_dentro_tab(coord(L, C), Tab) :-
    Tab \= [],
    L >= 0, C >= 0,
    length(Tab, NumLinhas),
    L < NumLinhas,
    obter_elemento(L, Tab, Linha),
    length(Linha, NumColunas),
    C < NumColunas.

% obter_elemento(+Indice, +Lista, -Elemento) - percorre por recursao
% (usado tanto para pegar uma linha do tabuleiro quanto uma
% celula dentro de uma linha, ja que a ideia e a mesma)
obter_elemento(0, [Elemento | _], Elemento) :- !.
obter_elemento(N, [_ | Resto], Elemento) :-
    N > 0,
    N1 is N - 1,
    obter_elemento(N1, Resto, Elemento).

% obter(+Coordenada, +Tabuleiro, -Celula)
% Equivalente a "obter :: Coordenada -> Tabuleiro -> Maybe Celula"
% Aqui, se a coordenada esta fora do tabuleiro, obter/3 simplesmente
% falha (o Maybe Nothing do Haskell vira falha na unificacao).
obter(coord(L, C), Tab, Celula) :-
    coordenada_dentro_tab(coord(L, C), Tab),
    obter_elemento(L, Tab, Linha),
    obter_elemento(C, Linha, Celula).

% marca(+Coordenada, +NovaCelula, +Tabuleiro, -NovoTabuleiro)
% Equivalente a "marca :: Coordenada -> Celula -> Tabuleiro -> Tabuleiro"
marca(coord(L, C), Novo, Tab, NovoTab) :-
    ( coordenada_dentro_tab(coord(L, C), Tab) ->
        obter_elemento(L, Tab, Linha),
        atualiza_indice(C, Novo, Linha, NovaLinha),
        atualiza_indice(L, NovaLinha, Tab, NovoTab)
    ; NovoTab = Tab
    ).

% atualiza_indice(+Indice, +NovoElemento, +Lista, -NovaLista)
% Equivalente a "atualizaIndice"
atualiza_indice(_, _, [], []) :- !.
atualiza_indice(0, Novo, [_ | Resto], [Novo | Resto]) :- !.
atualiza_indice(N, Novo, [X | Resto], [X | NovoResto]) :-
    N > 0,
    N1 is N - 1,
    atualiza_indice(N1, Novo, Resto, NovoResto).
