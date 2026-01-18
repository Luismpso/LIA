:- module(animacao, [apresentar/2]).
:- use_module(audio).
:- use_module(library(filesex)).

% 0. Tabela de Configurações de Animação

% Sintaxe: config_anim(Nome/Valor, Passo, Sleep).
% Passo: Incremento de frames (saltar frames para ir mais rápido).
% Sleep: Segundos entre frames (tempo de espera).

% Configurações Específicas 
config_anim('intro', 2, 0.036).   
config_anim(1000000, 2, 0.020).
config_anim('over', 2, 0.02).
config_anim('winheart', 2, 0.01).
config_anim('loseheart', 2, 0.01).

% Configuração Padrão (Fallback)
config_anim(_, 1, 0.015). 

% 1. Pontos de Entrada de Animação

apresentar(intro, _) :-
    audio:tocar_intro,       
    reproduzir_inteligente('intro').

apresentar(pergunta, Valor) :-
    audio:tocar_lets_play(Valor),
    reproduzir_inteligente(Valor),
    audio:tocar_fundo(Valor).

apresentar(vitoria, Valor) :-
    audio:tocar_vitoria(Valor),
    reproduzir_inteligente(Valor).

apresentar(suspense, Valor) :-
    audio:tocar_suspense(Valor).

apresentar(perdeu, _) :-
    audio:tocar_perdeu,
    reproduzir_inteligente('over').

apresentar(ganhou_coracao, _) :-
    audio:tocar_win_heart,
    reproduzir_inteligente('winheart').

apresentar(perdeu_coracao, _) :-
    audio:tocar_lose_heart,
    reproduzir_inteligente('loseheart').

% 2. Reprodutor de Animações

localizar_raiz(Path) :-
    absolute_file_name('animation', Path, [
        access(read), file_type(directory), file_errors(fail)
    ]), !.

reproduzir_inteligente(Valor) :-
    write('\e[2J'), 
    
    % 1. Carregar configuração de velocidade para este Valor
    % Se não existir config específica, usa a padrão (_)
    (config_anim(Valor, Passo, Tempo) -> true ; config_anim(_, Passo, Tempo)),

    (localizar_raiz(Root) ->
        % Formatação de nomes (lidar com numeros e strings)
        (number(Valor) -> format(string(StrVal), "~w", [Valor]) ; StrVal = Valor),
        
        % Tratamento de milhares (1,000 vs 1.000)
        (number(Valor) -> format(string(ComVirgula), "~t~d~3+", [Valor]) ; ComVirgula = Valor),
        
        % Tenta converter virgula em ponto (caso o sistema use pontos)
        (atomic_list_concat(L, ',', ComVirgula) -> atomic_list_concat(L, '.', ComPonto) ; ComPonto = ComVirgula),

        % Tenta encontrar a pasta com as várias formatações possíveis
        (   tenta_caminho(Root, StrVal, Passo, Tempo)     -> true
        ;   tenta_caminho(Root, ComVirgula, Passo, Tempo) -> true
        ;   tenta_caminho(Root, ComPonto, Passo, Tempo)   -> true
        ;   
            format('~n[ERRO] Animacao nao encontrada para: ~w~n', [Valor]),
            sleep(0.5)
        )
    ;
        writeln('ERRO CRITICO: Pasta "animation" nao encontrada!'),
        sleep(2)
    ).

tenta_caminho(Root, NomePasta, Passo, Tempo) :-
    atomic_list_concat([Root, '/', NomePasta, '/ansi/'], CaminhoBase),
    % Verifica se o primeiro frame existe (00001.ansi)
    format(string(PrimeiroFrame), "~w00001.ansi", [CaminhoBase]),
    exists_file(PrimeiroFrame), 
    !, 
    play_loop(CaminhoBase, 1, Passo, Tempo).

% 3. Loop de Reprodução de Animação

play_loop(CaminhoBase, N, Passo, Tempo) :-
    % Formata o nome do ficheiro (ex: 00001.ansi, 00002.ansi)
    format(string(File), "~w~|~`0t~d~5+.ansi", [CaminhoBase, N]),
    
    (exists_file(File) ->
        write('\e[H'), % Move cursor para Home (evita flicker vs limpar tudo)
        open(File, read, Stream, [type(binary)]), 
        copy_stream_data(Stream, current_output),  
        close(Stream), 
        flush_output, 
        
        % Utiliza o tempo customizado
        sleep(Tempo),
        
        % Incrementa N usando o Passo customizado
        Next is N + Passo,
        play_loop(CaminhoBase, Next, Passo, Tempo)
    ;
        % Fim da animação -> Para o som se necessário
        audio:parar_sons,
        true
    ).