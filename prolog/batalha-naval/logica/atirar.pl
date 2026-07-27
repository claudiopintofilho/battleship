% =============================================================
% Modulo: logica/atirar.pl
% Equivalente a: Logica/Atirar.hs
%
% Processa um disparo em uma coordenada do tabuleiro inimigo,
% marcando "acertou" se havia um navio ou "errou" caso contrario.
% =============================================================

:- module(atirar, [atirar/3]).

:- use_module('../interface/interface', [obter/3, marca/4]).

% atirar(+Coordenada, +Tabuleiro, -NovoTabuleiro)
% Equivalente a:
%   atirar coordenada tabuleiro =
%       case obter coordenada tabuleiro of
%           Just Navio -> marca coordenada Acertou tabuleiro
%           Just Agua  -> marca coordenada Errou   tabuleiro
%           _          -> tabuleiro
atirar(Coordenada, Tabuleiro, NovoTabuleiro) :-
    ( obter(Coordenada, Tabuleiro, navio) ->
        marca(Coordenada, acertou, Tabuleiro, NovoTabuleiro)
    ; obter(Coordenada, Tabuleiro, agua) ->
        marca(Coordenada, errou, Tabuleiro, NovoTabuleiro)
    ; NovoTabuleiro = Tabuleiro
    ).
