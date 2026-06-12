module Tipos.Base where

type Coordenada = (Int, Int)

data Celula = Agua | Navio | Acertou | Errou deriving (Show, Eq)

type Tabuleiro = [[Celula]]

type Board = Tabuleiro
type Cell = Celula

linhaVazia :: [Celula]
linhaVazia = replicate 10 Agua

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