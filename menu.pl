:- module(menu, [
    exibir_menu_principal/1,
    menu_obter_nome/1,
    menu_obter_modo/1,
    menu_obter_tema/1
]).
:- use_module(library(readutil)).
:- encoding(utf8).

% 1. Configurações de Ecrã

imagem_fundo('image/menu.ans').

cls :- write('\x1b[2J'), write('\x1b[H'), flush_output.
cursor_at(X, Y) :- format('~c[~d;~dH', [27, Y, X]).
style_titulo :- write('\x1b[1;33;44m'). % Amarelo/Azul
style_texto  :- write('\x1b[1;37;44m'). % Branco/Azul
style_reset  :- write('\x1b[0m').

write_at(X, Y, Text) :- cursor_at(X, Y), write(Text), flush_output.

% Desenha o fundo
desenhar_fundo :-
    imagem_fundo(File),
    (exists_file(File) ->
        open(File, read, Stream, [encoding(octet)]),
        read_stream_to_codes(Stream, Codes),
        close(Stream),
        string_codes(Str, Codes),
        cursor_at(1,1),
        write(Str),
        flush_output
    ; true).

% 2. Estrutura Genérica da Caixa

% Desenha a caixa vazia com um Título
desenhar_caixa_base(Titulo) :-
    X = 30,
    style_titulo,
    write_at(12,X, ' ______________________________________________________________'),
    write_at(13,X, '/                                                              \\'),
    write_at(14,X, '|                                                              |'),
    desenhar_titulo(Titulo, X),
    write_at(16,X, '| ============================================================ |'),
    style_texto,
    desenhar_linhas_vazias(17, 36, X),
    style_titulo,
    write_at(37,X, '|    ====================================================      |'),
    write_at(38,X, '|               QUEM QUER SER MILIONARIO?                      |'),
    write_at(39,X, '\\______________________________________________________________/'),
    style_reset.

desenhar_linhas_vazias(Y, MaxY, _) :- Y > MaxY, !.
desenhar_linhas_vazias(Y, MaxY, X) :- 
    write_at(Y, X, '|                                                              |'), 
    Y1 is Y + 1, desenhar_linhas_vazias(Y1, MaxY, X).

desenhar_titulo(Titulo, X) :-
    string_length(Titulo, Len),
    write_at(15, X, '|                                                              |'), 
    Start is X + 31 - (Len // 2),
    write_at(15, Start, Titulo).

% 3. Menu Principal

% Exibe o menu principal e lê a opção escolhida
exibir_menu_principal(Opcao) :-
    cls, desenhar_fundo, desenhar_caixa_base('MENU PRINCIPAL'),
    X = 30, style_texto,
    write_at(21, X, '|                  1. JOGAR                                    |'),
    write_at(23, X, '|                  2. HALL OF FAME                             |'),
    write_at(25, X, '|                  3. REGRAS DO JOGO                           |'),
    write_at(27, X, '|                  4. SAIR                                     |'),
    cursor_at(45, 42), style_titulo, write('Escolha uma opcao (1-4): '), style_reset,
    ler_tecla_simples(Opcao, [1,2,3,4]).

% 4. Menu: Obter Nome

menu_obter_nome(Nome) :-
    cls, desenhar_fundo, desenhar_caixa_base('IDENTIFICACAO'),
    X = 30, style_texto,
    
    write_at(22, X, '|            Por favor, introduza o seu nome:                  |'),
    write_at(24, X, '|            >                                                 |'),
    
    % 1. Define a cor (Azul/Amarelo)
    style_titulo,       
    
    % 2. Mete o cursor no sítio (APENAS UMA VEZ)
    cursor_at(24, X + 15),  
    flush_output,       
    
    % 3. Inicia a leitura natural
    ler_input_natural(Codes),
    
    atom_codes(Nome, Codes),
    style_reset.

% 5. Menu: Seleção de Modo

menu_obter_modo(Modo) :-
    cls, desenhar_fundo, desenhar_caixa_base('SELECAO DE MODO'),
    X = 30, style_texto,
    write_at(19, X, '|                  1. NORMAL                                   |'),
    write_at(22, X, '|                  2. HARDCORE                                 |'),
    cursor_at(45, 42), style_titulo, write('Escolha o modo (1-2): '), style_reset,
    ler_tecla_simples(Op, [1,2]),
    traduzir_modo(Op, Modo).

traduzir_modo(1, normal).
traduzir_modo(2, hardcore).

% 6. Menu: Seleção de Tema

menu_obter_tema(Tema) :-
    cls, desenhar_fundo, desenhar_caixa_base('SELECAO DE TEMA'),
    X = 30, style_texto,
    write_at(18, X, '|        1. GERAL               2. DESPORTO                    |'),
    write_at(20, X, '|        3. HISTORIA            4. GEOGRAFIA                   |'),
    write_at(22, X, '|        5. LITERATURA          6. CIENCIA                     |'),
    cursor_at(45, 42), style_titulo, write('Escolha o tema (1-6): '), style_reset,
    ler_tecla_simples(Op, [1,2,3,4,5,6]),
    traduzir_tema(Op, Tema).

traduzir_tema(1, geral).      traduzir_tema(2, desporto).
traduzir_tema(3, historia).   traduzir_tema(4, geografia).
traduzir_tema(5, literatura). traduzir_tema(6, ciencia).

% 7. Utilitários

% Leitura Simples de Tecla (1-9)
ler_tecla_simples(Opcao, Validos) :-
    get_single_char(Code),
    (member(Code, [49,50,51,52,53,54,55,56,57]) -> % Se for 1-9
        CharNum is Code - 48,
        (member(CharNum, Validos) -> Opcao = CharNum 
        ; ler_tecla_simples(Opcao, Validos)) % Invalido, tenta de novo
    ; ler_tecla_simples(Opcao, Validos)). % Não é numero, tenta de novo

% Leitura Natural de Input (Letras, Backspace, Enter)
ler_input_natural(StringCodes) :-
    ler_loop_natural([], StringCodes).

ler_loop_natural(Acc, Resultado) :-
    get_single_char(Code),
    tratar_tecla_natural(Code, Acc, Resultado).

% Enter (13 ou 10) -> Termina
tratar_tecla_natural(13, Acc, Resultado) :- !, reverse(Acc, Resultado).
tratar_tecla_natural(10, Acc, Resultado) :- !, reverse(Acc, Resultado).

% Backspace (127 ou 8) -> Apaga
tratar_tecla_natural(Code, Acc, Resultado) :-
    member(Code, [127, 8]), 
    Acc \= [], % Só apaga se houver letras
    !,
    write('\b \b'), % Recua, espaço, recua (truque clássico)
    flush_output,
    [_|Resto] = Acc, % Remove a última letra da lista
    ler_loop_natural(Resto, Resultado).

% Ignora Backspace se a lista estiver vazia
tratar_tecla_natural(Code, Acc, Resultado) :-
    member(Code, [127, 8]), !,
    ler_loop_natural(Acc, Resultado).

% Letras Normais
tratar_tecla_natural(Code, Acc, Resultado) :-
    code_type(Code, graph), % Confirma que é letra/número visível
    !,
    put_code(Code),  % Escreve a letra (o cursor avança sozinho)
    flush_output,    % Garante que aparece logo
    ler_loop_natural([Code|Acc], Resultado).

% Ignora o resto (F1, Setas, etc.)
tratar_tecla_natural(_, Acc, Resultado) :- 
    ler_loop_natural(Acc, Resultado).