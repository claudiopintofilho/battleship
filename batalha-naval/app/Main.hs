-- Aqui vai conter a função main, que é o ponto de entrada do programa

module Main (main) where
import Controle.Menu (menu)
import System.IO (hSetEncoding, stdout, utf8)

main :: IO ()
main = do
  hSetEncoding stdout utf8
  menu
