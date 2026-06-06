-- Aqui vai conter o Loop Principal - Turnos
{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module Controle.Jogo where

import Tipos.Base
import Interface.Interface (printTabuleiro)
import Logica.Atirar (atirar)
import System.IO (hFlush, stdout)

iniciarJogo :: IO ()
iniciarJogo = do
    putStrLn "\nPREPARANDO OS TABULEIROS..."
    loopJogo tabuleiroVazio tabuleiroVazio True

-- O Loop Principal do jogo
loopJogo :: Tabuleiro -> Tabuleiro -> Bool -> IO ()
loopJogo tabP1 tabP2 turnoP1 = do
    putStrLn "\n========================================"
    if turnoP1 
        then putStrLn ">>> VEZ DO JOGADOR 1 <<<" 
        else putStrLn ">>> VEZ DO JOGADOR 2 <<<"
    
    putStrLn "   SEU TABULEIRO                         TABULEIRO INIMIGO"
    
    -- Se for o turno do P1, mostramos o tabuleiro dele e o do P2
    -- Se for do P2, invertemos a ordem de visualização!
    if turnoP1
        then printTabuleiro tabP1 tabP2 0
        else printTabuleiro tabP2 tabP1 0
    
    putStrLn "\nSua vez de atirar!"
    putStr "Digite a LINHA (0-9): "
    hFlush stdout 
    linhaStr <- getLine
    putStr "Digite a COLUNA (0-9): "
    hFlush stdout 
    colStr <- getLine
    
    let linha = read linhaStr :: Int
    let coluna = read colStr :: Int
    let coord = (linha, coluna)

    -- Executa o tiro e chama o loop novamente passando o turno (False/True)
    if turnoP1
        then do
            let novoTabP2 = atirar coord tabP2
            loopJogo tabP1 novoTabP2 False
        else do
            let novoTabP1 = atirar coord tabP1
            loopJogo novoTabP1 tabP2 True