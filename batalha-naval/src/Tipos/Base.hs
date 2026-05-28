module Tipos.Base where

type Coordenada = (Int, Int)

-- Padronizado para Celula
data Celula = Agua | Navio | Acertou | Errou deriving (Show, Eq)

-- Padronizado para Tabuleiro
type Tabuleiro = [[Celula]]

-- Função para criar uma linha de água (usando a função replicate do Haskell que é mais limpa)
linhaVazia :: [Celula]
linhaVazia = replicate 10 Agua

-- Cria a matriz 10x10 preenchida com Agua
tabuleiroVazio :: Tabuleiro
tabuleiroVazio = replicate 10 linhaVazia

data Navios = Navios {
        tipo :: String,
        tamanho :: Int,
        posicoes :: [Coordenada],
        partesAtingidas :: [Coordenada]
    } deriving (Show, Eq)

naviosPadrao :: [Navios]
naviosPadrao = [Navios "Grande" 3 [] [], Navios "Medio" 2 [] [], Navios "Pequeno" 1 [] []]

data Orientacao = H | V deriving (Show, Eq)