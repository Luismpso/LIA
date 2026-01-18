:- module(estudio, [mostrar_pergunta/5]).
:- use_module(library(readutil)).
:- encoding(utf8).

% 1. Configurações

base_directory('image').
background_file('estudio.ans').

% 2. Visual (ajustado para X, Y)

cls :- 
    write('\x1b[2J'), 
    write('\x1b[H'), 
    flush_output.

% Move o cursor 
cursor_at(X, Y) :- 
    % O terminal precisa de [Linha, Coluna], por isso trocamos aqui dentro
    format('~c[~d;~dH', [27, Y, X]).

% Atalho para escrever em coordenadas X, Y
write_at(X, Y, Text) :- 
    cursor_at(X, Y), 
    write(Text), 
    flush_output.

% Escreve texto centrado na largura fixa da imagem
write_centered(Y, Text) :-
    string_length(Text, TextLen),
    
    % Configuração
    ImageWidth = 121,        % A largura fixa da tua imagem
    ImageStartX = 0,       % Onde a imagem começa (ex: se centrada no ecrã 80)

    % Calcula o offset dentro da imagem
    Offset is (ImageWidth - TextLen) // 2,
    
    % O X final é a posição da imagem + o offset
    FinalX is ImageStartX + Offset,
    
    cursor_at(Y, FinalX),
    write(Text),
    flush_output.
% Estilos de texto
style_pergunta :- write('\x1b[1;37;44m'). % Branco em fundo Azul
style_opcao    :- write('\x1b[0;30;47m'). % Preto em fundo Branco
style_reset    :- write('\x1b[0m').

% 3. Carregar e Mostrar Background

mostrar_background :-
    base_directory(Dir),
    background_file(File),
    atomic_list_concat([Dir, '/', File], FullPath),
    catch(
        (open(FullPath, read, Stream, [encoding(octet)]),
         read_stream_to_codes(Stream, Codes),
         close(Stream),
         string_codes(Str, Codes),
         cursor_at(1,1),
         write(Str),
         flush_output),
        Error,
        (print_message(error, Error), write('ERRO IMAGEM'))
    ).

% 4. Desenhar texto (coordenadas X, Y)

desenhar_texto(Pergunta, OpA, OpB, OpC, OpD) :-
    
    % 1. A Pergunta 

    style_pergunta, 
    write_centered(31, Pergunta), 
    style_reset,

    % 2. As Opções 
    style_pergunta,
    
    write_at(34, 35,  'A: '), write(OpA),              
    write_at(34, 67, 'B: '), write(OpB),    
    
    write_at(38,35,  'C: '), write(OpC),    
    write_at(38, 67, 'D: '), write(OpD),    
    
    style_reset.


% Perdicado principal para mostrar a pergunta e opções
mostrar_pergunta(Pergunta, OpA, OpB, OpC, OpD) :-
    cls,
    mostrar_background,
    desenhar_texto(Pergunta, OpA, OpB, OpC, OpD),
    style_reset,
    flush_output. 
