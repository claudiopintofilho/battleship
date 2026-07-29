# Batalha Naval

Projeto que implementa o jogo clássico de Batalha Naval para execução no
terminal, com **duas implementações equivalentes**: uma em **Haskell**
(programação funcional) e outra em **Prolog** (programação lógica). As duas
versões compartilham as mesmas regras e funcionalidades, mudando apenas o
paradigma e a forma de organizar o código.

## Funcionalidades

- Jogo para dois jogadores no terminal.
- Posicionamento de navios com validação de coordenadas.
- Impedimento de sobreposição de navios.
- Sistema de ataques e atualização dos tabuleiros.
- Ocultação dos navios do adversário durante a partida.
- Tratamento de entradas inválidas para evitar encerramentos inesperados do programa.
- Verificação automática da condição de vitória.

---

## Versão em Haskell

Implementação feita em Haskell com foco em praticar conceitos de programação
funcional, como funções puras, recursão, tipos algébricos, imutabilidade de
dados e separação entre lógica de negócio e operações de entrada e saída.

### Organização do Projeto

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

#### Descrição dos módulos

| Módulo            | Responsabilidade                                      |
| ----------------- | ------------------------------------------------------ |
| Base.hs           | Definição dos tipos utilizados no jogo                 |
| Posicionamento.hs | Regras de posicionamento dos navios                     |
| Atirar.hs         | Processamento dos disparos e atualização do tabuleiro   |
| Interface.hs      | Exibição dos tabuleiros e elementos visuais             |
| Jogo.hs           | Controle do fluxo principal da partida                  |
| Menu.hs           | Navegação pelos menus do sistema                        |
| Main.hs           | Ponto de entrada da aplicação                           |

### Requisitos

Para executar o projeto é necessário ter instalado:

- GHC (Glasgow Haskell Compiler)
- Stack

A instalação através do GHCup é recomendada.

### Como executar

Entre na pasta do projeto em Haskell:

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

---

## Versão em Prolog

Implementação equivalente feita em **SWI-Prolog**, com foco em praticar
programação lógica: unificação, recursão sobre listas e entrada/saída básica.
As regras do jogo, o tabuleiro 10x10 e os três navios (Grande, Médio,
Pequeno) são os mesmos da versão em Haskell.

### Organização do Projeto

```text
prolog_battleship/
├── main.pl
├── tipos/
│   └── base.pl
├── logica/
│   ├── posicionamento.pl
│   └── atirar.pl
├── interface/
│   └── interface.pl
└── controle/
    ├── jogo.pl
    └── menu.pl
```

#### Descrição dos módulos

| Módulo             | Responsabilidade                                        | Equivalente em Haskell |
| ------------------ | -------------------------------------------------------- | ----------------------- |
| base.pl            | Definição dos dados utilizados no jogo (célula, tabuleiro vazio, navios padrão) | Base.hs |
| posicionamento.pl  | Regras de posicionamento dos navios                       | Posicionamento.hs |
| atirar.pl          | Processamento dos disparos e atualização do tabuleiro     | Atirar.hs |
| interface.pl       | Exibição dos tabuleiros e acesso/atualização de células   | Interface.hs |
| jogo.pl            | Controle do fluxo principal da partida                    | Jogo.hs |
| menu.pl            | Navegação pelos menus do sistema                          | Menu.hs |
| main.pl            | Ponto de entrada da aplicação                              | Main.hs |

### Requisitos

Para executar o projeto é necessário ter instalado:

- SWI-Prolog

Instalação no Ubuntu/Debian:

```bash
sudo apt install swi-prolog
```

Ou baixando diretamente em https://www.swi-prolog.org/.

### Como executar

Entre na pasta do projeto em Prolog:

```bash
cd prolog_battleship
```

Execute a aplicação:

```bash
swipl main.pl
```

O jogo inicia automaticamente no menu principal.

---

## Observações

Este projeto foi desenvolvido com foco no aprendizado prático de dois
paradigmas de programação diferentes: programação funcional (Haskell) e
programação lógica (Prolog), aplicando os conceitos estudados durante a
disciplina de PLP (Paradigmas de Linguagens de Programação) a um mesmo
problema — o jogo Batalha Naval.
