:- module(telefonar, [consultar_ia/6]).
:- use_module(library(process)).
:- use_module(library(readutil)).

% 1. Configurações

python_script('chamada/ask_ollama.py').
background_file('image/llama.ans'). 

% 2. Funções de Interface

cls :- write('\x1b[2J'), write('\x1b[H'), flush_output.
cursor_at(X, Y) :- format('~c[~d;~dH', [27, Y, X]).

style_hud   :- write('\x1b[1;33;40m'). 
style_reset :- write('\x1b[0m').
style_azul  :- write('\x1b[1;37;44m'). 

escrever_centrado_azul(Linha, Texto) :-
    string_length(Texto, Comp),
    LarguraEcra = 80,
    X is (LarguraEcra - Comp) // 2,
    XFinal is max(1, X),
    cursor_at(XFinal, Linha),
    style_azul, write(Texto), style_reset, flush_output.

mostrar_background_llama :-
    background_file(File),
    catch(
        (open(File, read, Stream, [encoding(octet)]),
         read_stream_to_codes(Stream, Codes),
         close(Stream),
         string_codes(Str, Codes),
         cursor_at(1,1),
         write(Str),
         flush_output),
        _,
        (cls, cursor_at(1,1), writeln('ERRO: Falta imagem image/llama.ans'))
    ).

% 3. Lógica com Python

consultar_ia(Pergunta, OpA, OpB, OpC, OpD, RespostaIA) :-
    cls,
    mostrar_background_llama,
    
    cursor_at(1, 1), 
    style_azul, write('A contactar o Sabio...'), style_reset,
    flush_output,

    python_script(Script),

    % 'python.exe' vai direto ao Python instalado (necessário ajustar, infelizmente).
    process_create('C:\\Users\\Luimp\\anaconda3\\envs\\LIA\\python.exe', 
                   [Script, Pergunta, OpA, OpB, OpC, OpD], 
                   [stdout(pipe(OutStream)), stderr(pipe(ErrStream))]),
    
    set_stream(OutStream, encoding(utf8)),
    read_string(OutStream, _, StringRaw),
    read_string(ErrStream, _, ErrorRaw), 
    close(OutStream),
    close(ErrStream),
    
    (ErrorRaw \= "" -> 
        RespostaIA = 'Erro tecnico no Python.',
        TextoParaMostrar = ErrorRaw
    ;
        normalize_space(atom(RespostaIA), StringRaw),
        TextoParaMostrar = RespostaIA
    ),

    cls,
    mostrar_background_llama, 
    format(string(TextoFinal), "O Sabio diz: ~w", [TextoParaMostrar]),
    escrever_centrado_azul(1, TextoFinal).