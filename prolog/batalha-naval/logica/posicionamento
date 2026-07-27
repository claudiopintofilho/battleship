% =============================================================
% Modulo: logica/posicionamento.pl
% Equivalente a: Logica/Posicionamento.hs
%
% Regras de posicionamento dos navios no tabuleiro: validar
% coordenadas, gerar o "corpo" do navio, checar sobreposicao e
% efetivamente colocar o navio no tabuleiro.
% =============================================================

:- module(posicionamento, [
    coordenada_valida/1,
    gera_corpo/4,
    posicao_livre/2,
    posicao_valida/2,
    colocar_navio/3,
    posicionar_navio/5
]).

:- use_module('../interface/interface', [obter/3, marca/4]).

% coordenada_valida(+Coordenada)
% Equivalente a "coordenadaValida"
coordenada_valida(coord(Linha, Coluna)) :-
    Linha  >= 0, Linha  =< 9,
    Coluna >= 0, Coluna =< 9.

% gera_corpo(+CoordenadaInicial, +Tamanho, +Orientacao, -Corpo)
% Equivalente a "geraCorpo"
gera_corpo(coord(Linha, Coluna), Tamanho, h, Corpo) :-
    gera_corpo_h(Linha, Coluna, Tamanho, Corpo).
gera_corpo(coord(Linha, Coluna), Tamanho, v, Corpo) :-
    gera_corpo_v(Linha, Coluna, Tamanho, Corpo).

gera_corpo_h(_, _, 0, []) :- !.
gera_corpo_h(Linha, Coluna, Tamanho, [coord(Linha, Coluna) | Resto]) :-
    Tamanho > 0,
    Coluna1 is Coluna + 1,
    Tamanho1 is Tamanho - 1,
    gera_corpo_h(Linha, Coluna1, Tamanho1, Resto).

gera_corpo_v(_, _, 0, []) :- !.
gera_corpo_v(Linha, Coluna, Tamanho, [coord(Linha, Coluna) | Resto]) :-
    Tamanho > 0,
    Linha1 is Linha + 1,
    Tamanho1 is Tamanho - 1,
    gera_corpo_v(Linha1, Coluna, Tamanho1, Resto).

% posicao_livre(+Tabuleiro, +Coordenada)
% Equivalente a "posicaoLivre"
posicao_livre(Tabuleiro, Coordenada) :-
    obter(Coordenada, Tabuleiro, agua).

% posicao_valida(+Tabuleiro, +Coordenadas)
% Equivalente a "posicaoValida"
posicao_valida(_, []).
posicao_valida(Tabuleiro, [Coordenada | Resto]) :-
    coordenada_valida(Coordenada),
    posicao_livre(Tabuleiro, Coordenada),
    posicao_valida(Tabuleiro, Resto).

% colocar_navio(+Tabuleiro, +Coordenadas, -NovoTabuleiro)
% Equivalente a "colocarNavio"
colocar_navio(Tabuleiro, [], Tabuleiro).
colocar_navio(Tabuleiro, [Coordenada | Resto], NovoTabuleiro) :-
    marca(Coordenada, navio, Tabuleiro, TabuleiroTemp),
    colocar_navio(TabuleiroTemp, Resto, NovoTabuleiro).

% posicionar_navio(+Tabuleiro, +Inicio, +Tamanho, +Orientacao, -NovoTabuleiro)
% Equivalente a "posicionarNavio :: Tabuleiro -> Coordenada -> Int -> Orientacao -> Maybe Tabuleiro"
% Aqui, o "Nothing" do Haskell corresponde a este predicado falhar.
posicionar_navio(Tabuleiro, Inicio, Tamanho, Orientacao, NovoTabuleiro) :-
    gera_corpo(Inicio, Tamanho, Orientacao, CorpoNavio),
    posicao_valida(Tabuleiro, CorpoNavio),
    colocar_navio(Tabuleiro, CorpoNavio, NovoTabuleiro).
