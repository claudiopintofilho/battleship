module Controle.Menu where

import Tipos.Base (printTabuleiro, tabuleiro)

telaRegras :: IO ()
telaRegras = do
  putStrLn "=== REGRAS ==="
  putStrLn "1. Cada jogador posiciona seus navios no tabuleiro"
  putStrLn "2. Os jogadores se alternam atirando coordenadas"
  putStrLn "3. Acertar um navio marca como Acertou, errar como Errou"
  putStrLn "4. Vence quem afundar todos os navios do oponente"
  putStrLn ""
  putStrLn "Aperte 1 para voltar ao menu"
  opcao <- getLine
  case opcao of
    "1" -> menu
    _   -> telaRegras

telaJogo :: IO ()
telaJogo = do
  putStrLn ""
  putStrLn "=== JOGO ==="
  printTabuleiro tabuleiro tabuleiro 0
  putStrLn ""
  putStrLn "Aperte 1 para voltar ao menu"
  opcao <- getLine
  case opcao of
    "1" -> menu
    _   -> telaJogo

telaSaida :: IO ()
telaSaida = do
  putStrLn ""
  putStrLn "Obrigado por jogar! Ate logo!"

menu :: IO ()
menu = do
  putStrLn "==== Batalha Naval ===="
  putStrLn "1 - Jogar"
  putStrLn "2 - Regras"
  putStrLn "3 - Sair"
  putStr "Escolha uma opcao: "
  opcao <- getLine
  case opcao of
    "1" -> telaJogo
    "2" -> telaRegras
    "3" -> telaSaida
    _   -> do
      putStrLn "Opcao invalida! Tente novamente."
      menu