% =============================================================
% Modulo: tipos/base.pl
% Equivalente a: Tipos/Base.hs
%
% Define os "tipos" (por convencao, ja que Prolog nao tem tipos
% estaticos) e os dados basicos usados no jogo: celulas do
% tabuleiro, o tabuleiro vazio e a lista de navios padrao.
%
% Representacoes usadas:
%   - Coordenada:  coord(Linha, Coluna)          -> dois inteiros de 0 a 9
%   - Celula:      agua | navio | acertou | errou
%   - Tabuleiro:   lista de 10 listas de 10 celulas
%   - Navio:       navio(Tipo, Tamanho, Posicoes, PartesAtingidas)
%   - Orientacao:  h | v
% =============================================================

:- module(base, [
    celula/1,
    orientacao/1,
    linha_vazia/1,
    tabuleiro_vazio/1,
    navios_padrao/1
]).

% celula(?Celula)
% Equivalente ao "data Celula = Agua | Navio | Acertou | Errou"
celula(agua).
celula(navio).
celula(acertou).
celula(errou).

% orientacao(?Orientacao)
% Equivalente ao "data Orientacao = H | V"
orientacao(h).
orientacao(v).

% linha_vazia(-Linha)
% Equivalente a "linhaVazia = replicate 10 Agua"
linha_vazia(Linha) :-
    cria_linha(10, Linha).

cria_linha(0, []) :- !.
cria_linha(N, [agua | Resto]) :-
    N > 0,
    N1 is N - 1,
    cria_linha(N1, Resto).

% tabuleiro_vazio(-Tabuleiro)
% Equivalente a "tabuleiroVazio = replicate 10 linhaVazia"
tabuleiro_vazio(Tabuleiro) :-
    cria_tabuleiro(10, Tabuleiro).

cria_tabuleiro(0, []) :- !.
cria_tabuleiro(N, [Linha | Resto]) :-
    N > 0,
    linha_vazia(Linha),
    N1 is N - 1,
    cria_tabuleiro(N1, Resto).

% navios_padrao(-Navios)
% Equivalente a:
%   naviosPadrao = [Navios "Grande" 3 [] [], Navios "Medio" 2 [] [], Navios "Pequeno" 1 [] []]
navios_padrao([
    navio(grande,  3, [], []),
    navio(medio,   2, [], []),
    navio(pequeno, 1, [], [])
]).
