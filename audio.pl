:- module(audio, [
    tocar_intro/0, 
    tocar_lets_play/1, 
    tocar_suspense/1, 
    tocar_vitoria/1, 
    tocar_fundo/1, 
    tocar_perdeu/0, 
    parar_sons/0,
    tocar_win_heart/0,
    tocar_lose_heart/0
]).

:- use_module(library(process)).
:- use_module(library(filesex)).
:- use_module(library(thread)).

:- dynamic pid_musica/1.
:- at_halt(parar_sons).

% Motor de Áudio Prolog-Windows usando PowerShell
localizar_pasta_audios(PathAbsoluto) :-
    absolute_file_name('audio', PathAbsoluto, [
        access(read), file_type(directory), file_errors(fail)
    ]), !.

encontrar_som(Input, PathFinal) :-
    % Converte numeros para atomos para evitar erros de tipo
    (number(Input) -> term_to_atom(Input, ParteNome) ; ParteNome = Input),
    
    localizar_pasta_audios(Pasta),
    directory_files(Pasta, TodosFicheiros),
    
    % Tratamento de espacos e underscores
    (atomic_list_concat(ListaPalavras, ' ', ParteNome) -> true ; ListaPalavras = [ParteNome]),
    atomic_list_concat(ListaPalavras, '_', NomeComUnderscores),
    
    % Procura o ficheiro na pasta
    member(Ficheiro, TodosFicheiros),
    sub_atom(Ficheiro, _, _, _, NomeComUnderscores),
    atomic_list_concat([Pasta, '/', Ficheiro], PathFinal),
    !.

parar_sons :-
    % 1. Mata processo registado de loop (se houver)
    (pid_musica(Pid) -> 
        (catch(process_kill(Pid), _, true), retractall(pid_musica(_))) 
    ; 
        true
    ),
    % 2. Mata forcadamente qualquer powershell de audio solto (para parar SFX instantaneamente)
    catch(shell('taskkill /F /IM powershell.exe >nul 2>&1', _), _, true).

tocar_sfx(Nome) :-
    % Executa numa thread separada para nao bloquear o jogo
    thread_create(
        (encontrar_som(Nome, Path) ->
            % O PlaySync e usado, mas como estamos numa thread, o jogo continua.
            % Se chamarmos parar_sons, este processo morre imediatamente.
            process_create(path(powershell), 
                ['-c', '(New-Object Media.SoundPlayer ''', Path, ''').PlaySync()'], 
                [])
        ;
            format('~n[AUDIO] Som nao encontrado: ~w~n', [Nome])
        ),
        _, 
        [detached(true)] 
    ).

tocar_loop(Nome) :-
    parar_sons,
    (encontrar_som(Nome, Path) ->
        % Inicia processo persistente e guarda o PID
        process_create(path(powershell), 
            ['-c', '$p=New-Object Media.SoundPlayer ''', Path, '''; $p.PlayLooping(); Start-Sleep -s 3600'], 
            [detached(true), process(Pid)]),
        assertz(pid_musica(Pid))
    ;
        format('~n[AUDIO] Loop nao encontrado: ~w~n', [Nome])
    ).

% Mapeamento de Áudios para Eventos

tocar_intro :- tocar_loop('intro'). 
tocar_perdeu :- parar_sons, tocar_sfx('Lose').
tocar_lose_heart :- parar_sons, tocar_sfx('loseheart').
tocar_win_heart :- parar_sons, tocar_sfx('winheart').
tocar_chamada :- parar_sons, tocar_sfx('chamada').

tocar_lets_play(Valor) :-
    parar_sons,
    (Valor =< 1000 -> tocar_sfx('2,000 Lets Play');
     Valor = 2000 -> tocar_sfx('2,000 Lets Play');
     Valor = 4000 -> tocar_sfx('4,000 Lets Play');
     Valor = 8000 -> tocar_sfx('8,000 Lets Play');
     Valor = 16000 -> tocar_sfx('16,000 Lets Play');
     Valor = 32000 -> tocar_sfx('32,000 Lets Play');
     Valor = 64000 -> tocar_sfx('64,000 Lets Play');
     Valor = 125000 -> tocar_sfx('125,000 Lets Play');
     Valor = 250000 -> tocar_sfx('250,000 Lets Play');
     Valor = 500000 -> tocar_sfx('500,000 Lets Play');
     Valor >= 1000000 -> tocar_sfx('1,000,000 Lets Play');
     true
    ).

tocar_fundo(Valor) :-
    (Valor < 2000 -> tocar_loop('100-1000 Questions');
     Valor < 4000 -> tocar_loop('2,000 Question');
     Valor < 8000 -> tocar_loop('4,000 Question');
     Valor < 16000 -> tocar_loop('8,000 Question');
     Valor < 32000 -> tocar_loop('16,000 Question');
     Valor < 64000 -> tocar_loop('32,000 Question'); 
     Valor < 125000 -> tocar_loop('64,000 Question');
     Valor < 250000 -> tocar_loop('125,000 Question');
     Valor < 500000 -> tocar_loop('250,000 Question');
     Valor < 1000000 -> tocar_loop('500,000 Question');
     tocar_loop('1,000,000 Question')
    ).

tocar_suspense(Valor) :-
    parar_sons,
    (Valor < 2000 -> tocar_sfx('2,000 Final Answer');
     Valor < 4000 -> tocar_sfx('2,000 Final Answer');
     Valor < 8000 -> tocar_sfx('4,000 Final Answer');
     Valor < 16000 -> tocar_sfx('8,000 Final Answer');
     Valor < 32000 -> tocar_sfx('16,000 Final Answer');
     Valor < 64000 -> tocar_sfx('32,000 Final Answer');
     Valor < 125000 -> tocar_sfx('64,000 Final Answer');
     Valor < 250000 -> tocar_sfx('125,000 Final Answer');
     Valor < 500000 -> tocar_sfx('250,000 Final Answer');
     Valor < 1000000 -> tocar_sfx('500,000 Final Answer');
     tocar_sfx('1,000,000 Final Answer')
    ).

tocar_vitoria(Valor) :-
    parar_sons, 
    (Valor = 100 -> tocar_sfx('2,000 Win');
     Valor = 200 -> tocar_sfx('4,000 Win');
     Valor = 300 -> tocar_sfx('8,000 Win');
     Valor = 500 -> tocar_sfx('16,000 Win');
     Valor = 1000 -> tocar_sfx('1,000 Win');
     Valor = 2000 -> tocar_sfx('2,000 Win');
     Valor = 4000 -> tocar_sfx('4,000 Win');
     Valor = 8000 -> tocar_sfx('8,000 Win');
     Valor = 16000 -> tocar_sfx('16,000 Win');
     Valor = 32000 -> tocar_sfx('32,000 Win');
     Valor = 64000 -> tocar_sfx('64,000 Win');
     Valor = 125000 -> tocar_sfx('125,000 Win');
     Valor = 250000 -> tocar_sfx('250,000 Win');
     Valor = 500000 -> tocar_sfx('500,000 Win');
     Valor >= 1000000 -> tocar_sfx('1,000,000 Win');
     tocar_sfx('1,000 Win')
    ).