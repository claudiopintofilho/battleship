-- Aqui vai conter a função main, que é o ponto de entrada do programa

module Main (main) where
import Controle.Menu (menu)

main :: IO ()
main = do
  menu
