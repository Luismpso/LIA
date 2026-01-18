:- module(ranking, [exibir_ranking/0, gravar_ranking/5]).
:- use_module(library(readutil)).
:- use_module(library(lists)).
:- use_module(library(date)).
:- encoding(utf8).

% 1. Configurações Básicas

ficheiro_dados('ranking.txt').
imagem_fundo('image/menu.ans').

% 2. Utilitarios visuais

cls :- write('\x1b[2J'), write('\x1b[H'), flush_output.
cursor_at(X, Y) :- format('~c[~d;~dH', [27, Y, X]).
write_at(X, Y, Text) :- cursor_at(X, Y), write(Text), flush_output.

style_titulo :- write('\x1b[1;33;44m'). 
style_texto  :- write('\x1b[1;37;44m'). 
style_reset  :- write('\x1b[0m').

% 2. Desenhar o fundo e a caixa do ranking
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
    ;
        true
    ).

% Desenhar a caixa do ranking
desenhar_caixa_ranking :-
    X = 30,
    style_titulo,
    write_at(12,X, ' ______________________________________________________________'),
    write_at(13,X, '/                                                              \\'),
    write_at(14,X, '|                                                              |'),
    write_at(15,X, '|                        HALL OF FAME                          |'),
    write_at(16,X, '| ============================================================ |'),
    style_texto,
    write_at(17,X, '|  RK   JOGADOR              PREMIO        MODO         DATA   |'),
    write_at(18,X, '| ------------------------------------------------------------ |'),
    % Linhas vazias para encher a caixa
    desenhar_linhas_vazias(19, 36, X),
    style_titulo,
    write_at(37,X, '| ============================================================ |'),
    write_at(38,X, '|                    QUEM QUER SER MILIONARIO?                 |'),
    write_at(39,X, '\\_____________________________________________________________/'),
    style_reset.

% Função auxiliar para desenhar linhas vazias na caixa
desenhar_linhas_vazias(Y, MaxY, _) :- Y > MaxY, !.
desenhar_linhas_vazias(Y, MaxY, X) :-
    write_at(Y, X, '|                                                              |'),
    Y1 is Y + 1, desenhar_linhas_vazias(Y1, MaxY, X).

% Escrever texto formatado com tamanho fixo
escrever_formatado(Texto, Tamanho) :-
    atom_chars(Texto, Chars), length(Chars, L),
    (L > Tamanho -> sub_atom(Texto, 0, Tamanho, _, Cortado), write(Cortado)
    ; write(Texto), Espacos is Tamanho - L, escrever_espacos(Espacos)).

% Escrever N espaços
escrever_espacos(0) :- !.
escrever_espacos(N) :- write(' '), N1 is N - 1, escrever_espacos(N1).


% 3. Sistema de gravação e leitura do ranking

% Grava o jogador no ficheiro de texto
gravar_ranking(NomeBruto, Nivel, Premio, Categoria, Modo) :-
    % Preparar nome
    (atom(NomeBruto) -> atom_chars(NomeBruto, L1); string_chars(NomeBruto, L1)),
    (append(NLimpo, ['.'], L1) -> atom_chars(Nome, NLimpo); atom_chars(Nome, L1)),
    
    % Preparar data
    get_time(Stamp), stamp_date_time(Stamp, DateTime, local), 
    date_time_value(date, DateTime, date(Ano, Mes, Dia)),
    
    % Escrever no ficheiro (Append)
    ficheiro_dados(File),
    open(File, append, Stream, [encoding(utf8)]),
    % Formato: ranking('Nome', Nivel, Premio, 'Cat', 'Modo', 'D/M/A').
    format(Stream, "ranking('~w', ~d, ~d, '~w', '~w', '~d/~d/~d').~n", 
           [Nome, Nivel, Premio, Categoria, Modo, Dia, Mes, Ano]),
    close(Stream).

% Lê o ficheiro e devolve a lista de rankings
ler_todos_rankings(ListaOrdenada) :-
    ficheiro_dados(File),
    (exists_file(File) ->
        setup_call_cleanup(
            open(File, read, Stream, [encoding(utf8)]),
            ler_termos(Stream, ListaBruta),
            close(Stream)
        ),
        % ListaBruta vem como [ranking(Nome...)...]
        % Vamos converter para formato interno r(Premio, Nome, ...) para ordenar
        map_rankings(ListaBruta, ListaProcessada),
        sort(3, @>=, ListaProcessada, ListaOrdenada)
    ;
        ListaOrdenada = [] % Se ficheiro nao existe, lista vazia
    ).

ler_termos(Stream, []) :- at_end_of_stream(Stream), !.
ler_termos(Stream, [Termo|Resto]) :-
    read(Stream, Termo),
    (Termo == end_of_file -> Resto = [] ; ler_termos(Stream, Resto)).

map_rankings([], []).
map_rankings([ranking(N, Niv, Val, Cat, Mod, Dat)|T], [r(Niv, N, Val, Cat, Mod, Dat)|T2]) :-
    map_rankings(T, T2).
map_rankings([_|T], T2) :- map_rankings(T, T2). % Ignora linhas inválidas

% 4. Exibir o ranking na tela

exibir_ranking :-
    cls,
    desenhar_fundo,
    desenhar_caixa_ranking,
    
    ler_todos_rankings(Lista),
    
    X = 30,
    imprimir_linhas(Lista, 1, 19, X),
    
    style_titulo,
    % O texto tem de ter o tamanho exato para manter a borda da direita alinhada
    % A caixa tem largura fixa, ajustei os espaços abaixo:
    write_at(45, X, '               Pressione <Enter> para voltar...                 '),
    style_reset,
    
    % Esconder o cursor no canto superior esquerdo para não ficar a piscar no meio
    cursor_at(45, X + 47),
    
    get_char(_),
    write('\x1b[0m'), flush_output.

    
imprimir_linhas(_, 10, _, _) :- !. 
imprimir_linhas([], _, _, _).
imprimir_linhas([r(_, Nome, Premio, _, Modo, Data)|T], Rank, Y, X) :-
    style_texto,
    cursor_at(X, Y), 
    write_at(Y, X, '| '),
    
    % Rank
    format('0~d', [Rank]), write('   '),
    
    % Nome
    escrever_formatado(Nome, 18), write('   '),
    
    % Prémio
    format(string(PStr), '~w', [Premio]), 
    escrever_formatado(PStr, 10), write('    '),
    
    % Modo
    (sub_atom(Modo, 0, 3, _, MC) -> true; MC = Modo), 
    string_upper(MC, MU),
    write(MU), 
    write('      '), 
    escrever_formatado(Data, 10),
    cursor_at(92, Y), write('|'),
    NR is Rank + 1, 
    NY is Y + 1,
    imprimir_linhas(T, NR, NY, X).