module Interface.Interface where

import Tipos.Base

-- Converte cada construtor no seu respectivo Emoji
makeCell :: Celula -> String
makeCell Agua     = "🌊"
makeCell Navio    = "🚢"
makeCell Acertou  = "💥"
makeCell Errou    = "💨"

-- Converte uma linha inteira de células em uma única String de emojis
converteLinha :: [Celula] -> String
converteLinha linha = concatMap makeCell linha

-- Imprime o tabuleiro na tela com os números das linhas (0 a 9)
-- Como no Batalha Naval você costuma ver o seu tabuleiro E o do inimigo, 
-- essa função recebe dois tabuleiros e mostra um ao lado do outro.
printTabuleiro :: Tabuleiro -> Tabuleiro -> Int -> IO ()
printTabuleiro t1 t2 0 = do
    -- Imprime a linha de números (colunas) antes de começar a desenhar as matrizes
    -- O espaço inicial compensa o número da linha e o espaço lateral
    putStrLn "   0  1  2  3  4  5  6  7  8  9           0  1  2  3  4  5  6  7  8  9"
    desenharLinhas t1 t2 0
printTabuleiro t1 t2 n = desenharLinhas t1 t2 n

-- Funções de manipulação que você já tinha:
coordenadaValida :: Coordenada -> Tabuleiro -> Bool
coordenadaValida (x, y) tab =
    not (null tab) && not (null (head tab)) &&
    x >= 0 && y >= 0 && x < length tab && y < length (head tab)

obter :: Coordenada -> Tabuleiro -> Maybe Celula
obter (x, y) tab
    | coordenadaValida (x, y) tab = Just ((tab !! x) !! y)
    | otherwise                  = Nothing

marca :: Coordenada -> Celula -> Tabuleiro -> Tabuleiro
marca (x, y) novo tab
    | coordenadaValida (x, y) tab =
        let linha     = tab !! x
            novaLinha = atualizaIndice y novo linha
        in  atualizaIndice x novaLinha tab
    | otherwise = tab

-- Função auxiliar necessária para a função 'marca' funcionar
atualizaIndice :: Int -> a -> [a] -> [a]
atualizaIndice _ _ [] = []
atualizaIndice 0 elemento (_:xs) = elemento : xs
atualizaIndice n elemento (x:xs) = x : atualizaIndice (n - 1) elemento xs

desenharLinhas :: Tabuleiro -> Tabuleiro -> Int -> IO ()
desenharLinhas [] [] _ = return ()
desenharLinhas (h1:t1) (h2:t2) n = do
    -- Se o número da linha for menor que 10, colocamos um espaço extra para não desalinhar
    let prefixo = if n < 10 then show n ++ " " else show n
    putStrLn (prefixo ++ " " ++ converteLinha h1 ++ "       " ++ converteLinha h2)
    desenharLinhas t1 t2 (n + 1)