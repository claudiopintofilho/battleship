{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module Controle.Jogo where

import Tipos.Base
import Interface.Interface (printTabuleiro)
import Logica.Atirar (atirar)
import Logica.Posicionamento (posicionarNavio, geraCorpo, coordenadaValida)
import System.IO (hFlush, stdout)
import Data.Char (toUpper)

lerOrientacao :: IO Orientacao
lerOrientacao = do
    putStr "Orientacao (H ou V): "
    hFlush stdout
    entrada <- getLine
    case map toUpper entrada of
        "H" -> return H
        "V" -> return V
        _   -> do
            putStrLn "Orientacao invalida! Digite H (horizontal) ou V (vertical)."
            lerOrientacao

lerInt :: String -> IO Int
lerInt prompt = do
    putStr prompt
    hFlush stdout
    entrada <- getLine
    case reads entrada of
        [(n, "")] | n >= 0 && n <= 9 -> return n
        _ -> do
            putStrLn "Valor invalido! Digite um numero entre 0 e 9."
            lerInt prompt

iniciarJogo :: IO ()
iniciarJogo = do
    putStrLn "\n=== JOGADOR 1: Posicione seus navios ==="
    tabP1 <- fasePosicionamento
    putStrLn "\n=== JOGADOR 2: Posicione seus navios ==="
    tabP2 <- fasePosicionamento
    loopJogo tabP1 tabP2 True

fasePosicionamento :: IO Tabuleiro
fasePosicionamento = posicionarNavios tabuleiroVazio naviosPadrao

posicionarNavios :: Tabuleiro -> [Navios] -> IO Tabuleiro
posicionarNavios tab [] = return tab
posicionarNavios tab (navio:resto) = do
    putStrLn "\nSeu tabuleiro atual:"
    printTabuleiro tab tabuleiroVazio 0
    putStrLn $ "\nPosicione o navio " ++ tipo navio ++ " (tamanho " ++ show (tamanho navio) ++ ")"
    linha  <- lerInt "Linha inicial (0-9): "
    coluna <- lerInt "Coluna inicial (0-9): "
    orient <- lerOrientacao
    let coord = (linha, coluna)
    case posicionarNavio tab coord (tamanho navio) orient of
        Just novoTab -> posicionarNavios novoTab resto
        Nothing      -> do
            let corpo = geraCorpo coord (tamanho navio) orient
            if not (all coordenadaValida corpo)
                then putStrLn "Posicao invalida: o navio ficaria fora do tabuleiro!"
                else putStrLn "Posicao invalida: ja existe um navio nessa posicao!"
            posicionarNavios tab (navio:resto)

esconderNavios :: Tabuleiro -> Tabuleiro
esconderNavios = map (map esconderCelula)
    where
        esconderCelula Navio = Agua
        esconderCelula c     = c

loopJogo :: Tabuleiro -> Tabuleiro -> Bool -> IO ()
loopJogo tabP1 tabP2 turnoP1 = do
    putStrLn "\n========================================"
    if turnoP1
        then putStrLn ">>> VEZ DO JOGADOR 1 <<<"
        else putStrLn ">>> VEZ DO JOGADOR 2 <<<"
    putStrLn "   SEU TABULEIRO                         TABULEIRO INIMIGO"
    if turnoP1
        then printTabuleiro tabP1 (esconderNavios tabP2) 0
        else printTabuleiro tabP2 (esconderNavios tabP1) 0
    putStrLn "\nSua vez de atirar!"
    linha  <- lerInt "Digite a LINHA (0-9): "
    coluna <- lerInt "Digite a COLUNA (0-9): "
    let coord = (linha, coluna)
    if turnoP1
        then do
            let novoTabP2 = atirar coord tabP2
            if jogoAcabou novoTabP2
                then putStrLn "\nJOGADOR 1 VENCEU! Todos os navios inimigos foram afundados!"
                else loopJogo tabP1 novoTabP2 False
        else do
            let novoTabP1 = atirar coord tabP1
            if jogoAcabou novoTabP1
                then putStrLn "\nJOGADOR 2 VENCEU! Todos os navios inimigos foram afundados!"
                else loopJogo novoTabP1 tabP2 True

jogoAcabou :: Tabuleiro -> Bool
jogoAcabou tab = not (any (elem Navio) tab)