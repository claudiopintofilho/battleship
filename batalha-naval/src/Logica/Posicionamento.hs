{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module Logica.Posicionamento where

import Tipos.Base

coordenadaValida :: Coordenada -> Bool
coordenadaValida (linha, coluna) =
    linha  >= 0 && linha  <= 9 &&
    coluna >= 0 && coluna <= 9

geraCorpo :: Coordenada -> Int -> Orientacao -> [Coordenada]
geraCorpo (linha, coluna) tam H =
    [ (linha, coluna + d) | d <- [0 .. tam - 1] ]
geraCorpo (linha, coluna) tam V =
    [ (linha + d, coluna) | d <- [0 .. tam - 1] ]

posicaoLivre :: Board -> Coordenada -> Bool
posicaoLivre tabuleiro (linha, coluna) =
    tabuleiro !! linha !! coluna == Agua

posicaoValida :: Board -> [Coordenada] -> Bool
posicaoValida tabuleiro coordenadas =
    all coordenadaValida coordenadas &&
    all (posicaoLivre tabuleiro) coordenadas

atualizaCelula :: Board -> Coordenada -> Cell -> Board
atualizaCelula tabuleiro (linha, coluna) novoValor =
    substituiNoTabuleiro tabuleiro linha linhaAtualizada
    where
        linhaAtual      = tabuleiro !! linha
        linhaAtualizada = substituiNaLinha linhaAtual coluna novoValor

substituiNaLinha :: [Cell] -> Int -> Cell -> [Cell]
substituiNaLinha []    _ _    = []
substituiNaLinha (_:t) 0 novo = novo : t
substituiNaLinha (h:t) col novo = h : substituiNaLinha t (col - 1) novo

substituiNoTabuleiro :: Board -> Int -> [Cell] -> Board
substituiNoTabuleiro []    _ _    = []
substituiNoTabuleiro (_:t) 0 nova = nova : t
substituiNoTabuleiro (h:t) linha nova = h : substituiNoTabuleiro t (linha - 1) nova

colocarNavio :: Board -> [Coordenada] -> Board
colocarNavio tabuleiro [] = tabuleiro
colocarNavio tabuleiro (coord:resto) =
    colocarNavio (atualizaCelula tabuleiro coord Navio) resto

posicionarNavio :: Tabuleiro -> Coordenada -> Int -> Orientacao -> Maybe Tabuleiro
posicionarNavio tabuleiro inicio tam orientacao =
    if posicaoValida tabuleiro corpoNavio
        then Just (colocarNavio tabuleiro corpoNavio)
        else Nothing
    where
        corpoNavio = geraCorpo inicio tam orientacao