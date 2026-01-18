import cv2
import os

def extrair_frames(nivel_pasta):
    # --- CONFIGURAÇÃO INTELIGENTE DE CAMINHOS ---
    # Isto garante que o script procura as pastas no sítio onde o script está guardado
    # e não onde o terminal está aberto.
    diretoria_base = os.path.dirname(os.path.abspath(__file__))
    
    # Define o caminho para a pasta do nível (ex: .../animation/over)
    caminho_pasta_nivel = os.path.join(diretoria_base, nivel_pasta)
    
    # Tenta encontrar o vídeo com .mp4 (minúsculo) ou .MP4 (maiúsculo)
    caminho_video = os.path.join(caminho_pasta_nivel, f"{nivel_pasta}.mp4")
    if not os.path.exists(caminho_video):
        caminho_video = os.path.join(caminho_pasta_nivel, f"{nivel_pasta}.MP4")

    # Pasta onde vão ficar as imagens
    pasta_saida = os.path.join(caminho_pasta_nivel, "frames")

    # --- VERIFICAÇÕES ---
    if not os.path.exists(caminho_video):
        print(f"❌ ERRO: O vídeo não foi encontrado: {nivel_pasta}.mp4")
        print(f"   (Procurado em: {caminho_video})")
        return

    # Cria a pasta 'frames' se ela não existir
    if not os.path.exists(pasta_saida):
        os.makedirs(pasta_saida)
    
    # --- PROCESSAMENTO ---
    print(f"\n🎬 A processar: {nivel_pasta} ...")
    vidcap = cv2.VideoCapture(caminho_video)
    
    total_frames = int(vidcap.get(cv2.CAP_PROP_FRAME_COUNT))
    
    count = 1
    success = True

    while success:
        success, image = vidcap.read()
        
        if success:
            # Formato 00001.png
            nome_ficheiro = f"{count:05d}.png"
            caminho_completo = os.path.join(pasta_saida, nome_ficheiro)
            
            # Salvar imagem
            cv2.imwrite(caminho_completo, image)

            # Barra de progresso simples
            if count % 50 == 0:
                print(f"   -> Frame {count}/{total_frames}", end='\r')
            
            count += 1

    vidcap.release()
    print(f"✅ CONCLUÍDO: {nivel_pasta} ({count-1} frames gerados)")

# --- EXECUÇÃO EM LOTE ---
if __name__ == "__main__":
    # Adiciona aqui todas as pastas que queres processar
    # Com base na tua imagem, adicionei as que vi:
    LISTA_NIVEIS = [
        "winheart", 
    ]

    print(f"🚀 A iniciar extração para {len(LISTA_NIVEIS)} vídeos...\n")

    for nivel in LISTA_NIVEIS:
        # Verifica se a pasta existe antes de tentar
        diretoria_atual = os.path.dirname(os.path.abspath(__file__))
        if os.path.exists(os.path.join(diretoria_atual, nivel)):
            extrair_frames(nivel)
        else:
            print(f"⚠️ Aviso: A pasta '{nivel}' não existe, a saltar...")
    
    print("\n🏁 Processo terminado!")