import sys
import re
from ollama import chat

# Modelo Gemma
MODELO = 'gemma:latest'

def ask_ollama(pergunta, ops):
    # Formatar as opções para o prompt
    op_texto = f"A) {ops[0]}\nB) {ops[1]}\nC) {ops[2]}\nD) {ops[3]}"
    prompt_content = f"""
    Analisa esta pergunta de quiz:
    "{pergunta}"
    
    Opções:
    {op_texto}
    
    TAREFA: Qual é a opção correta?
    REGRA: Responde APENAS com uma única letra (A, B, C ou D). Não escrevas frases completas.
    """

    try:
        response = chat(model=MODELO, messages=[
            {
                'role': 'user',
                'content': prompt_content,
            },
        ],keep_alive=0)

        content = response.message.content.strip().upper()

        # Limpeza de Segurança
        # Caso o modelo diga "A resposta é B", queremos apenas "B".
        # Procuramos a primeira letra isolada A, B, C ou D.
        match = re.search(r'\b([A-D])\b', content)
        
        if match:
            print(match.group(1), end="")
        else:
            # Se não encontrar letra óbvia, imprime X (erro de interpretação)
            print("X", end="")

    except Exception as e:
        # Em caso de erro, imprime E
        print("E", end="")

if __name__ == "__main__":
    # Garante que o encoding de saída é UTF-8 (essencial no Windows)
    sys.stdout.reconfigure(encoding='utf-8')

    # Verifica se recebeu os 5 argumentos do Prolog
    if len(sys.argv) >= 6:
        # sys.argv[1] é a Pergunta, [2] a [5] são as opções
        ask_ollama(sys.argv[1], sys.argv[2:])
    else:
        # Se faltar argumento, imprime erro
        print("E", end="")