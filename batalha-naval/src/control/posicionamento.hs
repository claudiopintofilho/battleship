module Posicionamento where

import Types

-- Verifica se a coordenada é válida
coordenadaValida :: Coordenada -> Bool
coordenadaValida (linha, coluna) =
    linha >= 0 &&
    linha <= 9 &&
    coluna >= 0 &&
    coluna <= 9

-- Gera as posições do Navio
geraCorpo :: Coordenada -> Int -> Orientacao -> [Coordenada]
geraCorpo (linha, coluna) tamanho H =    -- Navio Horizontal
    [ (linha + deslocamento, coluna) | deslocamento <- [0 .. tamanho - 1] ]

geraCorpo (linha, coluna) tamanho V =    -- Navio Vertical
    [ (linha, coluna + deslocamento) | deslocamento <- [0 .. tamanho - 1] ]

-- Verifica se uma posição está livre
posicaoLivre :: Board -> Coordenada -> Bool
posicaoLivre tabuleiro (linha, coluna) =
    tabuleiro !! linha !! coluna == Agua

-- Verifica se a posição é válida para colocar o návio
posicaoValida :: Board -> [Coordenada] -> Bool
posicaoValida tabuleiro coordenadas =
    coordenadasValidas && posicoesLivres
    where
        -- todas dentro do tabuleiro
        coordenadasValidas =
            all coordenadaValida coordenadas

        -- todas livres
        posicoesLivres =
            all (posicaoLivre tabuleiro) coordenadas

--Atualiza a célula no tabuleiro
atualizaCelula :: Board -> Coordenada -> Cell -> Board
atualizaCelula tabuleiro (linha,coluna) novoValor = 
    substituiNoTabuleiro tabuleiro linha linhaAtualizada
    where 
        linhaAtual = tabuleiro !! linha
        linhaAtualizada = substituiNaLinha linhaAtual coluna novoValor

--Função para substituir a célula na linha e coluna correta
substituiNaLinha :: [Cell] -> Int -> Cell -> [Cell]
substituiNaLinha [] _ _  = []
substituiNaLinha (h:t) 0 novo = novo : t
substituiNaLinha (h:t) col novo = h : substituiNaLinha t (col-1) novo 

--Função para modificar a linha no tabuleiro
substituiNoTabuleiro :: Board -> Int -> [Cell] -> Board
substituiNoTabuleiro [] _ _ = []
substituiNoTabuleiro (h:t) 0 nova = nova : t
substituiNoTabuleiro (h:t) linha nova = h : substituiNoTabuleiro t (linha - 1) nova

-- Colocar navio no tabuleiro
colocarNavio :: Board -> [Coordenada] -> Board
colocarNavio tabuleiro [] = tabuleiro
colocarNavio tabuleiro (coord : resto) =
    colocarNavio
        tabuleiroAtualizado
        resto
    where
        tabuleiroAtualizado =
            atualizaCelula
                tabuleiro
                coord
                Navio