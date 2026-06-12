module Main (main) where

import Controle.Menu (menu)
import System.IO (hSetEncoding, stdout, stdin, stderr, utf8)
import GHC.IO.Encoding (setLocaleEncoding, utf8)

main :: IO ()
main = do
  setLocaleEncoding utf8
  hSetEncoding stdout utf8
  hSetEncoding stdin  utf8
  hSetEncoding stderr utf8
  menu