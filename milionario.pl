:- module(milionario, [jogar/0]).
:- encoding(utf8).

% ==============================================================================
% 1. Importação de Bibliotecas e Módulos
% ==============================================================================

:- use_module(library(readutil)).   % Para ler ficheiros
:- use_module(library(lists)).      % Operações com listas
:- use_module(library(random)).     % Geração de números aleatórios
:- use_module(library(date)).       % Manipulação de datas e horas

% Módulos do utilizador (certifica-te que estes ficheiros existem na pasta)
:- use_module(audio).              % Biblioteca de áudio
:- use_module(animacao).           % Biblioteca de animações
:- use_module(regras).             % Biblioteca de regras do jogo    
:- use_module(ranking).            % Biblioteca de ranking
:- use_module(menu).               % Biblioteca de menu
:- use_module(estudio).            % Biblioteca de estúdio (HUD/Perguntas)
:- consult('perguntas.pl').        % Base de dados das perguntas
:- consult('chamada/telefonar.pl'). % Módulo de chamada à IA (Ollama)

:- dynamic(intro_played/0).        % Flag para controlar se a intro já foi reproduzida

% ==============================================================================
% 2. Estrutura de Dados do Jogo e Utilitários
% ==============================================================================

% patamar(Nivel, ValorPremio, IsCheckpoint (1=Sim), Dificuldade)
patamar(1, 100, 0, 1).    patamar(2, 200, 0, 1).    patamar(3, 300, 0, 1).
patamar(4, 500, 0, 2).    patamar(5, 1000, 1, 2).   patamar(6, 2000, 0, 2).
patamar(7, 4000, 0, 3).   patamar(8, 8000, 0, 3).   patamar(9, 16000, 0, 3).
patamar(10, 32000, 1, 4). patamar(11, 64000, 0, 4). patamar(12, 125000, 0, 4).
patamar(13, 250000, 0, 5). patamar(14, 500000, 0, 5). patamar(15, 1000000, 0, 5).

% Utilitários de Ecrã
limpar_ecra :- write('\e[2J\e[H').                    % Limpa o ecrã
style_hud   :- write('\x1b[1;33;40m').                % Amarelo sobre preto
style_reset :- write('\x1b[0m').                      % Reset
style_azul  :- write('\x1b[1;37;44m').                % Branco sobre azul
cursor_at(X, Y) :- format('~c[~d;~dH', [27, Y, X]).   % Posiciona cursor

% ==============================================================================
% 3. Motor de Inferência Lógica (Requisito 3.4 do Enunciado)
% ==============================================================================

% Base de Conhecimento: Regra universal do jogo
implica(resposta_certa, progresso_nivel).

% 3.1 Modus Ponens (Raciocínio Válido Positivo)
% "Se a resposta é a certa, então progride."
raciocinio_logico(ponens, Input, RespC) :-
    Input == RespC,                     
    implica(resposta_certa, progresso_nivel). 

% 3.2 Modus Tollens (Raciocínio Válido Negativo)
% "Se não progrediu (input errado), então a resposta não era a certa."
raciocinio_logico(tollens, Input, RespC) :-
    Input \== RespC,                    
    implica(resposta_certa, progresso_nivel).

% 3.3 Modus Mistaken (Falácia)
% Opcional: verificação de "má sorte" mesmo acertando (para modos hardcore ou similar)
verificar_falacia_sorte(hardcore) :- !. 
verificar_falacia_sorte(_) :-
    random_between(1, 100, R),
    (R =< 10 -> 
        throw('Falacia da Sorte Ativada! Resposta Errada!')
     ; true).

% ==============================================================================
% 4. Menu e Fluxo Inicial
% ==============================================================================

% Ponto de entrada interno (Menu)
menu :-
    limpar_ecra,
    (intro_played -> true ; catch(animacao:apresentar(intro, 0), _, true), assertz(intro_played)),
    audio:tocar_fundo(0),
    menu:exibir_menu_principal(Op), 
    processar_menu(Op).

processar_menu(1) :- iniciar_fluxo_jogo.
processar_menu(2) :- ranking:exibir_ranking, menu.
processar_menu(3) :- regras:exibir_regras, menu.
processar_menu(4) :- audio:parar_sons, halt.
processar_menu(_) :- menu.

% Configuração inicial do jogo
iniciar_fluxo_jogo :-
    menu:menu_obter_nome(Nome),
    menu:menu_obter_modo(Modo),
    menu:menu_obter_tema(Categoria),
    audio:parar_sons,
    preparar_jogo(Nome, Categoria, Modo).

preparar_jogo(Nome, Categoria, Modo) :-
    findall(N, patamar(N,_,_,_), Niveis),
    gerar_lista_perguntas(Niveis, Categoria, [], Lista),
    (Lista == [] -> 
        style_hud, writeln('Erro: Perguntas insuficientes!'), style_reset,
        pressionar_continuar, menu 
    ; 
        configurar_modo(Modo, _, Aju),
        (Modo == hardcore -> Vid = 1 ; Vid = 3),
        animacao:apresentar(pergunta, 100),
        ciclo_jogo(Nome, Lista, 1, 0, 0, Aju, Categoria, Vid, Lista, Modo)
    ).

configurar_modo(normal, 3, [c, p, t]).
configurar_modo(hardcore, 0, []). 

gerar_lista_perguntas([], _, _, []).
gerar_lista_perguntas([N|RestoN], Cat, Usados, [IdEsc|RestoP]) :-
    patamar(N, _, _, Dif),
    (Cat == geral -> findall(Id, pergunta(Id,_,_,_,Dif,_), Ids) ; findall(Id, pergunta(Id,_,_,_,Dif,Cat), Ids)),
    subtract(Ids, Usados, Disp),
    (Disp \== [] -> random_member(IdEsc, Disp), gerar_lista_perguntas(RestoN, Cat, [IdEsc|Usados], RestoP) ; fail).

% ==============================================================================
% 5. Ciclo Principal do Jogo (Recursivo)
% ==============================================================================

% Condição de Paragem: Vitória (Lista vazia)
ciclo_jogo(Nome, [], _, _, _, _, Cat, _, _, Modo) :- 
    animacao:apresentar(vitoria, 1000000), 
    ranking:gravar_ranking(Nome, 15, 1000000, Cat, Modo), 
    pausa_obrigatoria, audio:parar_sons, menu.

% Passo Recursivo: Pergunta
ciclo_jogo(Nome, [Id|Resto], Nivel, Va, Up, Ajudas, Cat, Vidas, Usadas, Modo) :-
    pergunta(Id, Texto, [A,B,C,D], RespC, _, _), 
    patamar(Nivel, Vp, Seg, _),
    
    estudio:mostrar_pergunta(Texto, A, B, C, D), 
    desenhar_hud(Nome, Vidas, Nivel, Vp, Up),

    cursor_at(5, 1), style_hud, write('Resposta (A/B/C/D) ou Ajuda (H) ou Sair (S): '), style_reset,
    
    ler_opcao(Input), 
    verificar_resposta(Input, Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, [A,B,C,D], Vp, Seg, Cat, Vidas, Usadas, Modo).

desenhar_hud(Nome, Vidas, Nivel, Vp, Up) :-
    style_reset, cursor_at(1, 1), style_hud,
    writeln(' -----------------------------------------------------------'),
    format(' | JOGADOR: ~w | VIDAS: ~d | NIVEL: ~d/15                  |~n', [Nome, Vidas, Nivel]),
    format(' | PREMIO: ~d EUR | CHECKPOINT: ~d EUR                     |~n', [Vp, Up]),
    writeln(' -----------------------------------------------------------'),
    style_reset.

% ==============================================================================
% 6. Validação e Lógica de Resposta
% ==============================================================================

% Opção: Ajuda (H)
verificar_resposta(h, Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, Op, Vp, Seg, Cat, Vid, Usd, Modo) :-
    processar_input_ajuda(Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, Op, Vp, Seg, Cat, Vid, Usd, Modo).

% Opção: Sair (S)
verificar_resposta(s, Nome, Id, _, Nivel, Va, _, _, _, _, _, _, Cat, _, _, Modo) :-
    audio:parar_sons, 
    pergunta(Id, _, _, _, _, _), 
    Acertadas is Nivel - 1,
    format(string(StrValor), "~d EUR", [Va]),
    estudio:mostrar_background,
    cursor_at(1, 1), style_hud,
    writeln(' -----------------------------------------------------------'),
    format(' | ACERTADAS: ~d | VALOR GANHO: ~w                           |~n', [Acertadas, StrValor]),
    writeln(' -----------------------------------------------------------'),
    style_reset,
    ranking:gravar_ranking(Nome, Acertadas, Va, Cat, Modo),
    pausa_obrigatoria, 
    menu.

% Opção: Resposta Lógica (A, B, C, D)
verificar_resposta(Input, Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, _, Vp, Seg, Cat, Vidas, Usadas, Modo) :-
    
    % Modus Ponens: Se acertou, avança
    (raciocinio_logico(ponens, Input, RespC) ->
        % verificar_falacia_sorte(Modo), % (Descomentar se quiser ativar falácia da sorte)
        (Seg == 1 -> NovoUp = Vp ; NovoUp = Up),
        (Seg == 1, Modo \== hardcore -> pergunta_extra(Cat, Usadas, Vidas, NovasVidas, NovasUsadas) ; NovasVidas=Vidas, NovasUsadas=Usadas),
        
        Next is Nivel + 1,

        (Resto \== [] -> 
            patamar(Next, ProxVal, _, _),
            animacao:apresentar(pergunta, ProxVal)
        ; true),

        ciclo_jogo(Nome, Resto, Next, Vp, NovoUp, Ajudas, Cat, NovasVidas, NovasUsadas, Modo)
    ;
        % Modus Tollens: Se Input != RespC, então errou
        (raciocinio_logico(tollens, Input, RespC),
         tratar_erro(Nome, Id, Resto, Nivel, Va, Up, Ajudas, Cat, Vidas, Usadas, Modo, RespC))
    ).

% Tratamento de Erro
tratar_erro(Nome, Id, _Resto, NivelAtual, _VaAtual, Up, Ajudas, Cat, Vidas, Usadas, Modo, _) :-
    % Caso 1: Vidas Extra Disponíveis
    (Vidas > 1, Modo \== hardcore -> 
        VR is Vidas - 1, 
        animacao:apresentar(perdeu_coracao, 0),
        
        % Checkpoint Logic
        (Up == 0 -> 
            NovoNivel = 1, 
            NovoVa = 0
        ; 
            patamar(NCheck, Up, _, _), 
            NovoNivel is NCheck + 1,
            NovoVa = Up
        ),

        % Regenerar lista de perguntas futuras
        findall(N, (patamar(N,_,_,_), N >= NovoNivel), NiveisRestantes),
        gerar_lista_perguntas(NiveisRestantes, Cat, [Id|Usadas], NovaLista),
        
        ciclo_jogo(Nome, NovaLista, NovoNivel, NovoVa, Up, Ajudas, Cat, VR, [Id|Usadas], Modo)

    ; 
        % Caso 2: Game Over
        animacao:apresentar(perdeu, 0), 
        limpar_ecra,
        patamar(NivelAtual, _, _, _),
        ranking:gravar_ranking(Nome, NivelAtual, Up, Cat, Modo), 
        menu
    ).

% Pergunta Extra (Bónus de Vida)
pergunta_extra(Cat, Usadas, Vidas, NovasVidas, NovasUsadas) :-
    Vidas < 3, !, 
    (Cat == geral -> 
        findall(Id, pergunta(Id,_,_,_,_,_), T) 
    ; 
        findall(Id, pergunta(Id,_,_,_,_,Cat), T)
    ), 
    subtract(T, Usadas, Disponiveis),
    (Disponiveis \== [] -> 
        random_member(IdEsc, Disponiveis), 
        pergunta(IdEsc, Txt, [OA, OB, OC, OD], RespC, _, _),
        estudio:mostrar_pergunta(Txt, OA, OB, OC, OD),
        cursor_at(1, 1), style_hud,
        writeln(' -----------------------------------------------------------'),
        writeln(' |               *** PERGUNTA DE BONUS *** |'),
        writeln(' |          Acerte para recuperar 1 VIDA EXTRA!            |'),
        writeln(' -----------------------------------------------------------'),
        style_reset,
        
        cursor_at(5, 1), style_hud, write('Sua Resposta Bonus (A/B/C/D): '), style_reset,
        
        ler_opcao(Resp), 
        
        (Resp == RespC ->  
            NovasVidas is Vidas + 1,        
            limpar_ecra,
            animacao:apresentar(ganhou_coracao, 0)
        ; 
            NovasVidas = Vidas,            
            audio:tocar_perdeu,           
            style_hud, cursor_at(7, 1),
            write('Resposta Errada! Nao ganhou vida extra.'), style_reset,
            sleep(2) 
        ),
        NovasUsadas = [IdEsc|Usadas]
    ; 
        writeln('Sem perguntas bonus suficientes.'), 
        NovasVidas = Vidas, 
        NovasUsadas = Usadas, 
        pressionar_continuar
    ).

pergunta_extra(_, Usadas, Vidas, Vidas, Usadas) :- 
    style_hud,
    writeln('[Maximo de Vidas]...'), 
    style_reset,
    sleep(1).

% ==============================================================================
% 7. Ajudas
% ==============================================================================

processar_input_ajuda(Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, Op, Vp, Seg, Cat, Vid, Usd, Modo) :-
    (Ajudas == [] ->
        cursor_at(6, 1), style_hud, write('Sem ajudas disponiveis!'), style_reset,
        pressionar_continuar,
        ciclo_jogo(Nome, [Id|Resto], Nivel, Va, Up, Ajudas, Cat, Vid, Usd, Modo)
    ;
        cursor_at(6, 1), style_hud,
        write('AJUDAS: (C) 50/50  (P) Publico  (T) Telefone'), 
        cursor_at(7, 1), write('Escolha a opcao: '), style_reset,
        ler_opcao(Tipo),
        
        (member(Tipo, Ajudas) ->
            (Tipo == c -> aplicar_ajuda_5050(Op, RespC, NOp); NOp = Op), 
            
            delete(Ajudas, Tipo, NAjudas),
            
            (Tipo \== c -> 
                pergunta(Id, Txt, _, _, _, _),
                aplicar_ajuda_texto(Tipo, Txt, Op, RespC)
            ; true),
            
            ciclo_jogo_ajudado(Nome, Id, Resto, Nivel, Va, Up, NAjudas, NOp, RespC, Vp, Seg, Cat, Vid, Usd, Modo)
        ;
            cursor_at(8, 1), style_hud, write('Invalido!'), style_reset,
            pressionar_continuar,
            ciclo_jogo(Nome, [Id|Resto], Nivel, Va, Up, Ajudas, Cat, Vid, Usd, Modo)
        )
    ).

ciclo_jogo_ajudado(Nome, Id, Resto, Nivel, Va, Up, Ajudas, NOp, RespC, Vp, Seg, Cat, Vidas, Usd, Modo) :-
    pergunta(Id, Texto, _, _, _, _), 
    NOp = [OA, OB, OC, OD],
    
    estudio:mostrar_pergunta(Texto, OA, OB, OC, OD), 
    desenhar_hud(Nome, Vidas, Nivel, Vp, Up),

    cursor_at(5, 1), style_hud, write('Resposta c/ AJUDA (A/B/C/D): '), style_reset,
    ler_opcao(In),
    verificar_resposta(In, Nome, Id, Resto, Nivel, Va, Up, Ajudas, RespC, NOp, Vp, Seg, Cat, Vidas, Usd, Modo).

% ==============================================================================
% 8. Helpers e Auxiliares
% ==============================================================================

ler_opcao(Opcao) :-
    flush_output,
    get_single_char(Code),
    (Code = 13 -> ler_opcao(Opcao); true), 
    (Code >= 65, Code =< 90 -> CharCode is Code + 32 ; CharCode = Code),
    char_code(Char, CharCode),
    (member(Char, [a, b, c, d, h, s, p, t]) -> 
        atom_string(Opcao, Char), write(Char), sleep(0.5)
    ; 
        ler_opcao(Opcao)
    ).

pausa_obrigatoria :- cursor_at(43, 42),style_hud, write('[Tecla para continuar]'), style_reset,get_single_char(_).
pressionar_continuar :- cursor_at(43, 42), style_hud, write('Tecla para continuar...'), style_reset,get_single_char(_).

% 50/50
aplicar_ajuda_5050(Op, RespC, NOp) :- 
    obter_idx_correto(RespC, Idx),
    nth0(Idx, Op, TextoCorreto), 
    select(TextoCorreto, Op, ListaErradas), 
    random_member(TextoManter, ListaErradas), 
    mascarar(Op, TextoCorreto, TextoManter, NOp).

obter_idx_correto(a, 0). obter_idx_correto(b, 1). obter_idx_correto(c, 2). obter_idx_correto(d, 3).
mascarar([], _, _, []).
mascarar([H|T], C, K, [H|R]) :- (H == C ; H == K), !, mascarar(T, C, K, R).
mascarar([_|T], C, K, ['---|---|'|R]) :- mascarar(T, C, K, R).

% Público
aplicar_ajuda_texto(p, _, _, RespC) :- 
    gerar_votos(RespC, Pa, Pb, Pc, Pd),
    cursor_at(7, 1), style_hud,
    format('PUBLICO: A:~d% B:~d% C:~d% D:~d%', [Pa, Pb, Pc, Pd]), style_reset,
    pressionar_continuar.

% Telefone
aplicar_ajuda_texto(t, Txt, [A, B, C, D], _) :- 
    audio:tocar_chamada, 
    catch(
        consultar_ia(Txt, A, B, C, D, _), 
        Erro,
        (cursor_at(1,1),style_azul,write('Erro ao chamar a Llama: '),style_reset, write(Erro), nl)
    ),
    cursor_at(3, 1), 
    style_azul, write('[Tecla para continuar]'), style_reset,
    get_single_char(_).

gerar_votos(RespC, Pa, Pb, Pc, Pd) :- 
    random_between(45,85, C), R is 100-C, 
    random_between(0,R, R1), R2A is R-R1, random_between(0,R2A, R2), R3 is R2A-R2, 
    distribuir_votos(RespC, C, R1, R2, R3, Pa, Pb, Pc, Pd).

distribuir_votos(a,C,X,Y,Z, C,X,Y,Z). distribuir_votos(b,C,X,Y,Z, X,C,Y,Z).
distribuir_votos(c,C,X,Y,Z, X,Y,C,Z). distribuir_votos(d,C,X,Y,Z, X,Y,Z,C).

% ==============================================================================
% 9. Predicado inicial
% ==============================================================================

jogar :- menu.
