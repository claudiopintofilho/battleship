# Batalha Naval em Haskell

Projeto desenvolvido em Haskell que implementa o jogo clássico de Batalha Naval para execução no terminal. O objetivo do projeto foi praticar conceitos de programação funcional, como funções puras, recursão, tipos algébricos, imutabilidade de dados e separação entre lógica de negócio e operações de entrada e saída.

## Funcionalidades

- Jogo para dois jogadores no terminal.
- Posicionamento de navios com validação de coordenadas.
- Impedimento de sobreposição de navios.
- Sistema de ataques e atualização dos tabuleiros.
- Ocultação dos navios do adversário durante a partida.
- Tratamento de entradas inválidas para evitar encerramentos inesperados do programa.
- Verificação automática da condição de vitória.

## Organização do Projeto

```text
batalha-naval/
├── app/
│   └── Main.hs
├── src/
│   ├── Tipos/
│   │   └── Base.hs
│   ├── Logica/
│   │   ├── Atirar.hs
│   │   └── Posicionamento.hs
│   ├── Interface/
│   │   └── Interface.hs
│   └── Controle/
│       ├── Jogo.hs
│       └── Menu.hs
└── batalha-naval.cabal
```

### Descrição dos módulos

| Módulo | Responsabilidade |
|---------|------------------|
| Base.hs | Definição dos tipos utilizados no jogo |
| Posicionamento.hs | Regras de posicionamento dos navios |
| Atirar.hs | Processamento dos disparos e atualização do tabuleiro |
| Interface.hs | Exibição dos tabuleiros e elementos visuais |
| Jogo.hs | Controle do fluxo principal da partida |
| Menu.hs | Navegação pelos menus do sistema |
| Main.hs | Ponto de entrada da aplicação |

## Requisitos

Para executar o projeto é necessário ter instalado:

- GHC (Glasgow Haskell Compiler)
- Stack

A instalação através do GHCup é recomendada.

## Como executar

Clone o repositório:

```bash
git clone https://github.com/usuario/batalha-naval.git
```

Entre na pasta do projeto:

```bash
cd batalha-naval
```

Compile o projeto:

```bash
stack build
```

Execute a aplicação:

```bash
stack run
```

## Observações

Este projeto foi desenvolvido com foco no aprendizado de programação funcional utilizando Haskell e na aplicação prática dos conceitos estudados durante a disciplina.