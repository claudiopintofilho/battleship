module Logica.Atirar where

import Tipos.Base
import Interface.Interface (obter, marca)

atirar :: Coordenada -> Tabuleiro -> Tabuleiro
atirar coordenada tabuleiro =
    case obter coordenada tabuleiro of
        Just Navio -> marca coordenada Acertou tabuleiro
        Just Agua  -> marca coordenada Errou tabuleiro
        _          -> tabuleiro
