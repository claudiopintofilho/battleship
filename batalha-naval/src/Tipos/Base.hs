-- Aqui vai conter os tipos de dados e funções básicas para o jogo

module Tipos.Base where
import System.IO
--Determinando um tipo de "Coordenada"
type Coordenada = (Int, Int)

-- criando as células para serem usadas no tabuleiro
data Cell = Agua | Navio | Acertou | Errou deriving (Show, Eq)

type Board = [[Cell]]

-- Função para definir como vamos montar a célula do tabuleiro
makeCell :: Cell -> String
makeCell Agua = "🌊"
makeCell Navio = "🚢"
makeCell Acertou = "💥"
makeCell Errou = "💨"

-- Função para criar as linhas vazias
linhaVazia :: [Cell]
linhaVazia = [Agua,Agua,Agua,Agua,Agua,Agua,Agua,Agua,Agua,Agua]

-- Função para juntar as linhas e formar o tabuleiro vazio, só com água
tabuleiro :: Board
tabuleiro = [linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia, linhaVazia]

-- Função para converter a linha em uma string
converte :: [Cell] -> String
converte [] = ""
converte (h:t) = makeCell h ++ converte t

-- Função para mostrar o tabuleiro com o número da linha
printTabuleiro :: Board -> Board -> Int -> IO()
printTabuleiro [] [] n = return ()
printTabuleiro (h:t) (h2:t2) n = do
    putStrLn (show n ++ "  " ++ converte h ++ "      " ++ converte h2)
    printTabuleiro t t2 (n+1)


data Navios = Navios {
    tipo :: String,
    tamanho :: Int,
    posicoes :: [Coordenada],
    partesAtingidas :: [Coordenada]
} deriving (Show, Eq)

naviosPadrao :: [Navios]
naviosPadrao = [
    Navios "Grande" 3 [] [],
    Navios "Medio" 2 [] [],
    Navios "Pequeno" 1 [] []
]

-- Definindo a orientacao do navio 
data Orientacao  = H | V deriving (Show, Eq)


