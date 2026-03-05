# 💰 Quem Quer Ser Milionário - Prolog Edition

![Prolog](https://img.shields.io/badge/SWI--Prolog-9.2.9-red)
![Python](https://img.shields.io/badge/Python-3.13+-blue)
![AI](https://img.shields.io/badge/AI-Ollama%20%7C%20Gemma-purple)
![Grade](https://img.shields.io/badge/Grade-17%2F20-brightgreen)
![Platform](https://img.shields.io/badge/Platform-Windows%20Only-blueviolet)
![License](https://img.shields.io/badge/License-Academic-lightgrey)

> **Lógica e Inteligência Artificial (LIA)** | Universidade do Minho

Implementação completa do jogo televisivo "Quem Quer Ser Milionário" utilizando **Lógica Declarativa (SWI-Prolog)**. O projeto destaca-se pela integração híbrida de sistemas, utilizando Python para **Inteligência Artificial (LLM)** nas ajudas e PowerShell para o motor de áudio.

---

## 🌟 Funcionalidades Principais
* **Motor de Jogo em Prolog:** Gestão de estados, validação de regras e base de conhecimento.
* **🤖 Ajuda com IA (GenAI):** A "Ajuda Telefónica" conecta-se ao modelo **Gemma (via Ollama)** para gerar respostas dinâmicas e justificadas em tempo real.
* **🔊 Ambiente Sonoro:** Integração com o sistema de áudio do Windows para reproduzir a banda sonora icónica e efeitos sonoros.
* **🖥️ Interface Consola (HUD):** Renderização gráfica baseada em caracteres com animações simples.

---

## ⚠️ Requisitos do Sistema
Devido à utilização de componentes nativos de áudio via PowerShell, este projeto é estritamente para **Windows**.

| Componente | Requisito |
| :--- | :--- |
| **SO** | Windows 10 ou 11 |
| **Prolog** | SWI-Prolog (v9.2.9) |
| **Python** | Versão 3.13 |
| **AI Engine** | [Ollama](https://ollama.com/) instalado |

---

## 🛠️ Instalação e Configuração

### 1. Clonar o Repositório
```bash
git clone [https://github.com/Luismpso/LIA.git](https://github.com/Luismpso/LIA.git)
cd LIA
```

### 2. Configurar a Inteligência Artificial
O jogo utiliza o modelo gemma para simular o "amigo inteligente" na ajuda telefónica. No terminal, execute:
```bash

ollama pull gemma

```
### 3. Verificar Python no Windows (Importante!) 🚨

Se a ajuda telefónica falhar, é provável que o Windows esteja a tentar abrir a Loja em vez do Python.

Pesquise no Windows por "Manage App Execution Aliases" (Gerir aliases de execução de aplicações).

DESATIVE os interruptores para python.exe e python3.exe (App Installer).

---

## 🚀 Como Jogar

+ Abra o ficheiro milionario.pl com o SWI-Prolog.

+ Maximize a janela da consola (Crucial para a renderização correta do HUD).

+ Execute o predicado de entrada:

```Prolog

?- jogar.

```
---

## 📂 Estrutura do Código

- `milionario.pl`: Ponto de entrada e loop principal do jogo.

- `perguntas.pl`: Base de conhecimento (Factos) com as perguntas e níveis de dificuldade.

- `regras.pl`: Lógica de validação de respostas e progressão.

- `audio.pl` & `animacao.pl`: Módulos de interface e chamadas de sistema para multimédia.

- `chamada/`: Scripts Python que fazem a ponte entre o Prolog e o Ollama.

- `report.pdf`: Documentação técnica e análise do desenvolvimento.

## 👥 Autores

* **[Pedro Reis]** - [PG59908@alunos.uminho.pt]
* **[Luís Silva]** - [PG60390@alunos.uminho.pt]
* **[Guilherme Pinto]** - [PG60225@alunos.uminho.pt]
* **[João Azevedo]** - [PG61693@alunos.uminho.pt]
* **[Diogo Azevedo]** - [PG61217@alunos.uminho.pt]

## 📜 Licença

Este trabalho é de cariz estritamente académico. Universidade do Minho, Escola de Engenharia, Departamento de Informática.
