import sys
import os
import math
from PIL import Image

# --- CONFIGURAÇÕES GERAIS ---
OUTPUT_WIDTH = 80

# As 8 Cores básicas do terminal (RGB) -> ANSI 40-47
BASIC_COLORS = {
    (0, 0, 0):       "40", # Preto
    (205, 0, 0):     "41", # Vermelho
    (0, 205, 0):     "42", # Verde
    (205, 205, 0):   "43", # Amarelo
    (0, 0, 238):     "44", # Azul
    (205, 0, 205):   "45", # Magenta
    (0, 205, 205):   "46", # Ciano
    (229, 229, 229): "47", # Branco
}

def get_distance(c1, c2):
    """Calcula a diferença entre duas cores"""
    (r1, g1, b1) = c1
    (r2, g2, b2) = c2
    return math.sqrt((r1 - r2)**2 + (g1 - g2)**2 + (b1 - b2)**2)

def get_closest_ansi_code(rgb):
    """Encontra a cor básica mais parecida"""
    shortest_distance = 1000000
    best_code = "40" # Default preto
    
    for color_rgb, code in BASIC_COLORS.items():
        dist = get_distance(rgb, color_rgb)
        if dist < shortest_distance:
            shortest_distance = dist
            best_code = code
            
    return best_code

def resize_image(image, new_width):
    (old_width, old_height) = image.size
    
    aspect_ratio = old_height / float(old_width)
    new_height = int((new_width * aspect_ratio))
    
    return image.resize((new_width, new_height))

def convert_to_simple_ansi(image_path, width):
    try:
        im = Image.open(image_path).convert('RGB')
        im = resize_image(im, width)
        x_width = im.size[0]
        im_data = list(im.getdata())
        
        s = []
        for i, p in enumerate(im_data):
            # Encontra a cor mais proxima
            code = get_closest_ansi_code(p)
            s.append(f"\033[{code}m  ") # Dois espaços para ficar mais quadrado

            if (i + 1) % x_width == 0:
                s.append("\033[0m\n")
        
        # Adiciona reset no final do ficheiro para não estragar o terminal
        s.append("\033[0m") 
        return "".join(s)
    except Exception as e:
        print(f"Erro no ficheiro {image_path}: {e}")
        return None

def processar_nivel(nivel_nome, base_dir):
    # Constrói os caminhos baseados na localização do script
    pasta_nivel = os.path.join(base_dir, nivel_nome)
    input_folder = os.path.join(pasta_nivel, 'frames')
    output_folder = os.path.join(pasta_nivel, 'ansi')

    # Verifica se a pasta frames existe
    if not os.path.exists(input_folder):
        print(f"⚠️  AVISO: Pasta de frames não encontrada em: {input_folder}")
        print(f"   (Executaste o video-to-frames.py para o '{nivel_nome}'?)")
        return

    # Cria pasta ansi se não existir
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    files = sorted([f for f in os.listdir(input_folder) if f.endswith('.png')])
    
    if not files:
        print(f"⚠️  AVISO: Nenhum ficheiro .png encontrado em {input_folder}")
        return

    print(f"\n📂 A processar nível: {nivel_nome} ({len(files)} frames)...")

    count = 0
    for filename in files:
        input_path = os.path.join(input_folder, filename)
        output_filename = filename.replace('.png', '.ansi')
        output_path = os.path.join(output_folder, output_filename)
        
        # Print de progresso na mesma linha
        print(f"   -> A converter: {filename}", end='\r')
        
        ansi_content = convert_to_simple_ansi(input_path, OUTPUT_WIDTH)
        
        if ansi_content:
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(ansi_content)
        count += 1
    
    print(f"\n✅ {nivel_nome} concluído! {count} ficheiros ANSI criados.")

if __name__ == '__main__':
    # --- LISTA DE PASTAS A PROCESSAR ---
    # Adicionei todas as pastas importantes aqui
    LISTA_NIVEIS = [
        "winheart",
        "over",
        "loseheart", 
    ]

    # Diretoria base (onde está este script)
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    
    print(f"🚀 INICIANDO CONVERSÃO PARA ANSI...")
    print(f"📍 Diretoria base: {BASE_DIR}\n")

    for nivel in LISTA_NIVEIS:
        # Só tenta processar se a pasta do nível existir
        if os.path.exists(os.path.join(BASE_DIR, nivel)):
            processar_nivel(nivel, BASE_DIR)
        
    print("\n🏁 TUDO TERMINADO! Agora podes correr o Prolog.")