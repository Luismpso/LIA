# Quem Quer Ser Milionário (Prolog)
Implementação do jogo "Quem Quer Ser Milionário" em SWI-Prolog. O projeto integra áudio via PowerShell e suporte de IA (LLM) para as ajudas.

## ⚠️ Requisitos Obrigatórios
- **Sistema Operativo:** Windows 10 ou 11 (Necessário para o motor de áudio).

- **SWI-Prolog:** Versão 9.2.9 ou superior.

- **Python:** Versão 3.13.

- **Ollama:** Instalado com o modelo gemma.

## 🛠️ Configuração Inicial
Antes de iniciar, execute o seguinte comando no terminal para preparar a IA da "Ajuda Telefónica":

```Bash

ollama pull gemma

```
## 🚀 Como Executar
+ Abra o ficheiro milionario.pl com o SWI-Prolog.

+ Maximize a janela da consola (Crucial para a renderização correta do HUD).

+ Execute o predicado de entrada:

```Prolog

?- jogar.

```
## 📝 Notas Importantes
- **Inputs:** Restrinja a interação às opções apresentadas (A, B, C, D, H, S) para evitar erros de fluxo.

- **Python no Windows:** Se a ajuda telefónica falhar, verifique nas definições do Windows ("Manage App Execution Aliases") se os aliases do Python estão DESATIVADOS. O sistema deve usar o executável real do Python e não o atalho da Windows Store.

- **Diretória:** O ficheiro milionario.pl deve ser executado a partir da raiz da pasta do projeto (junto às pastas audio, image, etc.).