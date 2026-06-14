# 🚢 Batalha Naval em Haskell 🌊

![Haskell](https://img.shields.io/badge/Haskell-5e5086?style=for-the-badge&logo=haskell&logoColor=white)
![Stack](https://img.shields.io/badge/Stack-Build-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-success?style=for-the-badge)

Um jogo clássico de Batalha Naval desenvolvido inteiramente em **Haskell** para execução no terminal. Este projeto foi construído do zero em 15 dias como parte do estudo de programação funcional, aplicando conceitos como imutabilidade, funções puras, funções de alta ordem e separação estrita de efeitos colaterais (Mundo Limpo vs. Mundo Sujo / IO).

---

## 🎮 Funcionalidades

* **Interface Clássica no Terminal:** Menu interativo com arte ASCII e tabuleiros formatados lado a lado.
* **Sistema de Turnos (PvP):** Jogo local para 2 jogadores com alternância automática de turnos.
* **Sistema de Posicionamento Seguro:** Posicionamento de navios com validação matemática que impede navios fora do tabuleiro ou sobreposição de peças.
* **"Névoa de Guerra" (Fog of War):** Uso de High-Order Functions (`map`) para ocultar os navios intactos do inimigo durante o turno do atirador.
* **Blindagem de Input (Anti-Crash):** Sistema robusto de leitura de entradas usando `reads`, garantindo que o programa não quebre caso o usuário digite letras ou caracteres especiais em vez de coordenadas numéricas.
* **Condição de Vitória Dinâmica:** Varredura rápida da matriz utilizando as funções nativas `any` e `elem` para detectar o fim da partida.

---

## 🏗️ Arquitetura do Projeto

O projeto foi rigorosamente modularizado para separar a lógica matemática e os tipos puros do "Mundo Sujo" das operações de Input/Output (`IO`), facilitando o desenvolvimento em equipe e a manutenção.

```text
batalha-naval/
├── app/
│   └── Main.hs                 # Ponto de entrada do programa
├── src/
│   ├── Tipos/
│   │   └── Base.hs             # Definição das matrizes, tipos puros (Cell, Board) e dados
│   ├── Logica/
│   │   ├── Atirar.hs           # Regras puras de substituição e acertos
│   │   └── Posicionamento.hs   # Regras puras de coordenadas e ocupação
│   ├── Interface/
│   │   └── Interface.hs        # Renderização visual dos emojis/caracteres e matrizes
│   └── Controle/
│       ├── Jogo.hs             # Loop principal recursivo de turnos e Inputs
│       └── Menu.hs             # Telas estáticas, navegação e arte ASCII
└── batalha-naval.cabal         # Configuração de dependências e módulos do Stack

# 🚀 Como Executar

## 📋 Pré-requisitos

Para rodar este projeto, você precisará ter os seguintes softwares instalados em sua máquina:

- **GHC (Glasgow Haskell Compiler)**
- **Stack**

A forma recomendada de instalar ambos é utilizando o **GHCup**.

## 🔧 Instalação e Execução

### 1. Clone este repositório

```bash
git clone https://github.com/SeuUsuario/NomeDoRepositorio.git
```

### 2. Acesse a pasta do projeto

```bash
cd NomeDoRepositorio
```

### 3. Compile o projeto utilizando o Stack

```bash
stack build
```

### 4. Execute o jogo

```bash
stack run
```

## ✅ Pronto!

Após executar o comando acima, o jogo será iniciado e estará pronto para uso.
