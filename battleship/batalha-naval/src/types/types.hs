module Types where
--Determinando um tipo de "Coordenada"
type Coordenada = (Int, Int)

--Estados de cada celula
data Celula = Agua
            | Navio
            | Atingido
            | Erro
            deriving(Eq, Show)

