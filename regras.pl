:- module(regras, [exibir_regras/0]).
:- use_module(library(readutil)).
:- encoding(utf8).

% 1. Configuração do caminho da imagem de fundo

background_regras('image/menu.ans').

% 2. Predicados auxiliares para manipulação do terminal

cls :- write('\x1b[2J'), write('\x1b[H'), flush_output.

% Move o cursor para X (Coluna), Y (Linha)
cursor_at(X, Y) :- format('~c[~d;~dH', [27, Y, X]).

% Escreve numa posição exata (Essencial para a caixa ficar direita)
write_at(X, Y, Text) :- 
    cursor_at(X, Y), 
    write(Text), 
    flush_output.

% Centra apenas textos soltos (como o prompt final)
write_centered_line(Y, Text) :-
    string_length(Text, Len),
    Width = 121,
    Offset is (Width - Len) // 2,
    FinalX is max(1, 1 + Offset),
    cursor_at(FinalX, Y),
    write(Text),
    flush_output.

% Estilos de texto
style_titulo :- write('\x1b[1;33;44m'). % Amarelo Bold / Azul
style_texto  :- write('\x1b[1;37;44m'). % Branco Bold / Azul
style_reset  :- write('\x1b[0m').

% 3. Desenhar o fundo das regras a partir do ficheiro .ans

% Desenha o fundo das regras
desenhar_fundo_regras :-
    background_regras(File),
    (exists_file(File) ->
        % 'encoding(octet)' é crucial para não partir o desenho .ans
        open(File, read, Stream, [encoding(octet)]),
        read_stream_to_codes(Stream, Codes),
        close(Stream),
        string_codes(Str, Codes),
        cursor_at(1,1),
        write(Str),
        flush_output
    ;
        write('ERRO: image/menu.ans nao encontrado'), nl
    ).

% 4. Escrever o conteúdo das regras do jogo

% Escreve o conteúdo das regras do jogo dentro da caixa
escrever_conteudo :-
    % Calculo do X para centralizar o texto
    % (121 largura - 62 texto) / 2 = ~29/30.
    X = 30,
    % Cabeçalho
    style_titulo,
    write_at(12,X, ' ______________________________________________________________'),
    write_at(13,X, '/                                                              \\'),
    write_at(14,X, '|                                                              |'),
    write_at(15,X, '|                        REGRAS DO JOGO                        |'),
    write_at(16,X, '| ============================================================ |'),
    style_texto,
    write_at(17,X, '|                                                              |'),
    % Secção 1
    style_titulo,
    write_at(18,X, '| 1. O OBJETIVO:                                               |'),
    style_texto,
    write_at(19,X, '|      Responder a 15 perguntas de dificuldade crescente.      |'),
    write_at(20,X, '|      Checkpoints de seguranca: Niveis 5 e 10.                |'),
    write_at(21,X, '|                                                              |'),
    % Secção 2
    style_titulo,
    write_at(22,X, '| 2. MODOS DE JOGO:                                            |'),
    style_texto,
    write_at(23,X, '|      [1] NORMAL: Comecas com 3 Vidas e 3 Ajudas.             |'),
    write_at(24,X, '|          Ganhas vidas nas Perguntas Bonus (Checkpoints).     |'),
    write_at(25,X, '|                                                              |'),
    write_at(26,X, '|      [2] HARDCORE: 1 Vida e 0 Ajudas.                        |'),
    write_at(27,X, '|          Não há perguntas bonus.                            |'),
    write_at(28,X, '|          ERRO = GAME OVER                                    |'),
    write_at(29,X, '|                                                              |'),
    % Secção 3
    style_titulo,
    write_at(30,X, '| 3. COMO JOGAR:                                               |'),
    style_texto,
    write_at(31,X, '|      - Escreve a letra da opcao (a, b, c, d) e Enter.        |'),
    write_at(32,X, '|      - NAO precisas de colocar ponto final.                  |'),
    write_at(33,X, '|      - [h] Ajuda | [s] Sair com dinheiro                     |'),
    write_at(34,X, '|                                                              |'),
    % Rodapé
    style_titulo,
    write_at(35,X, '|    ====================================================      |'),
    write_at(36,X, '|               BOA SORTE, FUTURO MILIONARIO!                  |'),
    write_at(37,X, '\\______________________________________________________________/'),
    
    style_reset.

% 5. Predicado Principal para exibir as regras

% Exibe as regras do jogo
exibir_regras :-
    cls,
    desenhar_fundo_regras,
    escrever_conteudo,
    style_reset,
    style_texto,
    write_at(42,45, 'Pressiona <Enter> para voltar...'),
    style_reset,
    get_char(_),
    cursor_at(70, 1),
    writeln(' '),
    style_reset, 
    flush_output.
