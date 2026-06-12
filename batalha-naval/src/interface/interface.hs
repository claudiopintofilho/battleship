{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module Interface.Interface where

import Tipos.Base

makeCell :: Celula -> String
makeCell Agua    = "🌊"
makeCell Navio   = "🚢"
makeCell Acertou = "💥"
makeCell Errou   = "💨"

converteLinha :: [Celula] -> String
converteLinha linha = concatMap makeCell linha

printTabuleiro :: Tabuleiro -> Tabuleiro -> Int -> IO ()
printTabuleiro t1 t2 0 = do
    putStrLn "   0 1 2 3 4 5 6 7 8 9        0 1 2 3 4 5 6 7 8 9"
    desenharLinhas t1 t2 0
printTabuleiro t1 t2 n = desenharLinhas t1 t2 n

coordenadaDentroTab :: Coordenada -> Tabuleiro -> Bool
coordenadaDentroTab (x, y) tab =
    not (null tab) && not (null (head tab)) &&
    x >= 0 && y >= 0 && x < length tab && y < length (head tab)

obter :: Coordenada -> Tabuleiro -> Maybe Celula
obter (x, y) tab
    | coordenadaDentroTab (x, y) tab = Just ((tab !! x) !! y)
    | otherwise                      = Nothing

marca :: Coordenada -> Celula -> Tabuleiro -> Tabuleiro
marca (x, y) novo tab
    | coordenadaDentroTab (x, y) tab =
        let linha     = tab !! x
            novaLinha = atualizaIndice y novo linha    :: [Celula]
            novoTab   = atualizaIndice x novaLinha tab :: Tabuleiro
        in  novoTab
    | otherwise = tab

atualizaIndice :: Int -> a -> [a] -> [a]
atualizaIndice _ _ []     = []
atualizaIndice 0 elemento (_:xs) = elemento : xs
atualizaIndice n elemento (x:xs) = x : atualizaIndice (n - 1) elemento xs

desenharLinhas :: Tabuleiro -> Tabuleiro -> Int -> IO ()
desenharLinhas [] [] _ = return ()
desenharLinhas (h1:t1) (h2:t2) n = do
    let prefixo = if n < 10 then show n ++ " " else show n
    putStrLn (prefixo ++ " " ++ converteLinha h1 ++ "       " ++ converteLinha h2)
    desenharLinhas t1 t2 (n + 1)
desenharLinhas _ _ _ = return ()
