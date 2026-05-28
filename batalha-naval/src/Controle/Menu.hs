module Controle.Menu where

import Tipos.Base (tabuleiroVazio)
import Interface.Interface (printTabuleiro)

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
  putStrLn "   JOGADOR 1                               JOGADOR 2"
  -- Passando o tabuleiro vazio duas vezes para desenhar as duas matrizes de emojis
  printTabuleiro tabuleiroVazio tabuleiroVazio 0
  putStrLn ""
  putStrLn "Aperte 1 para voltar ao menu"
  opcao <- getLine
  case opcao of
    "1" -> menu
    _   -> telaJogo

telaSaida :: IO ()
telaSaida = putStrLn "\nObrigado por jogar! Ate logo!"

menu :: IO ()
menu = do
  putStrLn "\n==== Batalha Naval ===="
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