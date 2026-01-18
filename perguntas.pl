:- encoding(utf8).

% Perguntas
% pergunta(id, "pergunta", [opcoes], resposta_correta, dificuldade, categoria)

% Desporto (id 1 a 20)

pergunta(1, 'Quantos jogadores tem uma equipa de futebol em campo?',
    ['10','11','12','9'], b, 1, desporto).
pergunta(2, 'Qual é o país de origem do "Jiu-Jitsu" tradicional?',
    ['Japão','China','Brasil','Coreia do Sul'], a, 1, desporto).
pergunta(3, 'Qual é a distância oficial de uma maratona (em km)?',
    ['40.195 km','41.195 km','42.095 km','42.195 km'], d, 1, desporto).
pergunta(4, 'O que significa a sigla "NBA" no basquetebol?',
    ['National Ball Association','North Basketball Alliance','New Basketball Association','National Basketball Association'], d, 1, desporto).

pergunta(5, 'O termo "birdie" é usado em que modalidade?',
    ['Ténis','Hóquei','Golfe','Basebol'], c, 2, desporto).
pergunta(6, 'Qual o clube português com mais títulos de campeão nacional de futebol?',
    ['Sporting CP','SL Benfica','FC Porto','Belenenses'], c, 2, desporto).
pergunta(7, 'Em que ano foi disputada a primeira Taça do Mundo de Futebol?',
    ['1930','1934','1938','1950'], a, 2, desporto).
pergunta(8, 'Em que desporto se utiliza um "shuttlecock"?',
    ['Ténis de Mesa','Badminton','Voleibol','Squash'], b, 2, desporto).

pergunta(9, 'Qual o nome da jogadora portuguesa mais galardoada na história do futebol?',
    ['Ana Borges','Cláudia Neto','Dolores Silva','Jéssica Silva'], c, 3, desporto).
pergunta(10, 'Qual o nome do estádio do Sport Lisboa e Benfica?',
    ['Estádio do Dragão','Estádio de Alvalade','Estádio Nacional','Estádio da Luz'], d, 3, desporto).
pergunta(11, 'Qual a cor da camisola usada pelo líder da classificação geral na Volta à França (Tour de France)?',
    ['Vermelha','Verde','Amarela','Branca'], c, 3, desporto).
pergunta(12, 'Em que cidade se realizam anualmente as 500 Milhas de Indianápolis?',
    ['Detroit','Nova Iorque','Indianápolis','Miami'], c, 3, desporto).

pergunta(13, 'Onde é que o "Haka" é tradicionalmente realizado antes dos jogos de râguebi?',
    ['Austrália','África do Sul','Nova Zelândia','Ilhas Fiji'], c, 4, desporto).
pergunta(14, 'Qual a pontuação máxima possível numa jogada de Snooker ("break")?',
    ['143','147','155','160'], b, 4, desporto).
pergunta(15, 'Qual o nome do recordista mundial dos 100 e 200 metros (velocidade)?',
    ['Usain Bolt','Carl Lewis','Jesse Owens','Justin Gatlin'], a, 4, desporto).
pergunta(16, 'Quantas medalhas de ouro olímpicas ganhou Michael Phelps?',
    ['18','23','28','20'], b, 4, desporto).

pergunta(17, 'Qual país ganhou mais medalhas de ouro nos Jogos Olímpicos de Inverno?',
    ['Rússia','Noruega','Estados Unidos','Alemanha'], b, 5, desporto).
pergunta(18, 'Em que desporto é utilizada a expressão "strike"?',
    ['Bowling','Beisebol','Ténis','Pólo Aquático'], a, 5, desporto).
pergunta(19, 'Quem é considerado o "rei do futebol"?',
    ['Lionel Messi','Cristiano Ronaldo','Pelé','Diego Maradona'], c, 5, desporto).
pergunta(20, 'Qual é o único tenista masculino a completar o "Golden Slam" de carreira (quatro Majors + Ouro Olímpico)?',
    ['André Agassi','Rafael Nadal','Roger Federer','Novak Djokovic'], a, 5, desporto).

% Historia (id 21 a 40)

pergunta(21, 'Em que ano ocorreu o 25 de Abril em Portugal?',
    ['1973','1975','1974','1982'], c, 1, historia).
pergunta(22, 'Quem liderou a Revolução Russa de 1917?',
    ['Stalin','Lenine','Trotsky','Khrushchev'], b, 1, historia).
pergunta(23, 'Qual a função principal do Coliseu de Roma na antiguidade?',
    ['Sede do Senado','Templo Religioso','Mercado Central','Jogos de Gladiadores'], d, 1, historia).
pergunta(24, 'O que marcou o início da Idade Média?',
    ['Queda do Império Romano do Ocidente','Invasões Bárbaras','Descobrimento da América','Revolução Francesa'], b, 1, historia).

pergunta(25, 'Em que ano caiu o Muro de Berlim?',
    ['1987','1989','1991','1990'], b, 2, historia).
pergunta(26, 'Quem foi o primeiro presidente da República Portuguesa?',
    ['Manuel de Arriaga','Teófilo Braga','Bernardino Machado','Sidónio Pais'], a, 2, historia).
pergunta(27, 'Qual dinastia governava Portugal aquando da Crise de Sucessão de 1580?',
    ['Dinastia de Avis','Dinastia de Bragança','Dinastia Filipina','Dinastia Afonsina'], c, 2, historia).
pergunta(28, 'O Tratado de Tordesilhas (1494) dividiu o mundo entre que potências?',
    ['Inglaterra e França','Portugal e Espanha','Portugal e Inglaterra','Espanha e França'], b, 2, historia).

pergunta(29, 'Qual o nome da nave que levou o primeiro homem à Lua?',
    ['Apollo 1','Salyut 1','Vostok 1','Apollo 11'], d, 3, historia).
pergunta(30, 'Qual o nome do último czar da Rússia antes da Revolução?',
    ['Nicolau I','Alexandre III','Nicolau II','Pedro, o Grande'], c, 3, historia).
pergunta(31, 'Qual figura histórica é associada à frase: "Vim, vi, venci"?',
    ['Júlio César','Alexandre, o Grande','Napoleão Bonaparte','Marco Aurélio'], a, 3, historia).
pergunta(32, 'O que se celebra em Portugal a 1 de dezembro?',
    ['Dia da Restauração da Independência','Implantação da República','Fim da Monarquia','Dia da Liberdade'], a, 3, historia).

pergunta(33, 'Quem foi o imperador romano durante a erupção do Vesúvio em 79 d.C.?',
    ['Nero','Calígula','Vespasiano','Tito'], d, 4, historia).
pergunta(34, 'Qual o evento que levou os EUA a entrar na Segunda Guerra Mundial?',
    ['O Holocausto','Batalha da Grã-Bretanha','Invasão da Polónia','Ataque a Pearl Harbor'], d, 4, historia).
pergunta(35, 'Qual foi o primeiro país a declarar guerra durante a Primeira Guerra Mundial?',
    ['França','Alemanha','Áustria-Hungria','Rússia'], c, 4, historia).
pergunta(36, 'O que desencadeou a Guerra dos Cem Anos?',
    ['Disputa religiosa','Invasão espanhola','Disputa pelo trono francês','Conflito territorial'], c, 4, historia).

pergunta(37, 'Qual civilização construiu a cidade de Machu Picchu?',
    ['Maias','Incas','Astecas','Olmecas'], b, 5, historia).
pergunta(38, 'Quem foi D. Sebastião?',
    ['Rei de Espanha','Infante de Portugal','Rei de Portugal que desapareceu em Alcácer-Quibir','Navegador português'], c, 5, historia).
pergunta(39, 'O que foi a "Noite de São Bartolomeu" (século XVI)?',
    ['Massacre de Judeus','Massacre de Protestantes (Huguenotes) em França','Festa popular','Revolta camponesa'], b, 5, historia).
pergunta(40, 'Quem foi o primeiro Papa a visitar Portugal?',
    ['Paulo VI','João Paulo II','Pio XII','Francisco'], a, 5, historia).

% Geografia (id 41 a 60)

pergunta(41, 'Qual é a capital do Canadá?',
    ['Washington D.C.','Toronto','Otava','Vancouver'], c, 1, geografia).
pergunta(42, 'Qual país é o maior produtor mundial de café?',
    ['Colômbia','Vietname','Brasil','Etiópia'], c, 1, geografia).
pergunta(43, 'Qual o rio que atravessa a cidade de Londres?',
    ['Sena','Danúbio','Tamisa','Reno'], c, 1, geografia).
pergunta(44, 'Em que continente está localizado o Vietname?',
    ['África','América do Sul','Ásia','Europa'], c, 1, geografia).

pergunta(45, 'O Rio Nilo desagua em que mar?',
    ['Mar Negro','Mar Cáspio','Mar Mediterrâneo','Oceano Atlântico'], c, 2, geografia).
pergunta(46, 'Qual o deserto mais extenso do mundo (não polar)?',
    ['Deserto do Gobi','Deserto da Arábia','Deserto da Patagónia','Deserto do Saara'], d, 2, geografia).
pergunta(47, 'Qual é a capital da Austrália?',
    ['Sydney','Camberra','Melbourne','Brisbane'], b, 2, geografia).
pergunta(48, 'Qual é a cadeia montanhosa mais longa do mundo?',
    ['Andes','Himalaia','Rochosas','Alpes'], a, 2, geografia).

pergunta(49, 'Qual o país mais populoso da Europa (sem contar a Rússia)?',
    ['França','Reino Unido','Alemanha','Itália'], c, 3, geografia).
pergunta(50, 'Qual o país insular é composto por milhares de ilhas e tem Jacarta como capital?',
    ['Filipinas','Indonésia','Malásia','Japão'], b, 3, geografia).
pergunta(51, 'Qual a maior ilha do mundo?',
    ['Nova Guiné','Bornéu','Madagáscar','Gronelândia'], d, 3, geografia).
pergunta(52, 'Qual é o país que tem a maior linha de costa?',
    ['Rússia','Canadá','Indonésia','Austrália'], b, 3, geografia).

pergunta(53, 'Qual o ponto mais alto do continente africano?',
    ['Monte Kilimanjaro','Monte Quénia','Monte Atlas','Monte Ruwenzori'], a, 4, geografia).
pergunta(54, 'Onde se localiza o Grande Desfiladeiro (Grand Canyon)?',
    ['Texas','Califórnia','Florida','Arizona'], d, 4, geografia).
pergunta(55, 'Qual o nome da passagem que liga o Oceano Atlântico ao Pacífico na ponta da América do Sul?',
    ['Canal do Panamá','Estreito de Magalhães','Estreito de Gibraltar','Canal de Suez'], b, 4, geografia).
pergunta(56, 'Qual a cidade conhecida como "A Cidade Proibida"?',
    ['Pequim','Xangai','Hong Kong','Tóquio'], a, 4, geografia).

pergunta(57, 'Qual país é conhecido como o "País do Sol Nascente"?',
    ['China','Japão','Coreia do Sul','Tailândia'], b, 5, geografia).
pergunta(58, 'Qual o único continente que não tem formigas nativas?',
    ['Europa','América do Sul','Antártida','Austrália'], c, 5, geografia).
pergunta(59, 'Em que cidade se encontra a famosa Ópera (Sydney Opera House)?',
    ['Sydney','Melbourne','Brisbane','Perth'], a, 5, geografia).
pergunta(60, 'Qual o nome da linha imaginária que divide o planeta em hemisfério Norte e Sul?',
    ['Meridiano de Greenwich','Trópico de Câncer','Círculo Polar Ártico','Equador'], d, 5, geografia).

% Literatura (id 61 a 80)

pergunta(61, 'Quem escreveu a obra "O Velho e o Mar"?',
    ['William Faulkner','Ernest Hemingway','John Steinbeck','F. Scott Fitzgerald'], b, 1, literatura).
pergunta(62, 'Qual é o nome do cavaleiro andante da obra de Miguel de Cervantes?',
    ['Sancho Pança','Rocinante','Dom Quixote','Tirante o Branco'], c, 1, literatura).
pergunta(63, 'Qual dramaturgo inglês é autor da peça "Hamlet"?',
    ['Ben Jonson','Christopher Marlowe','John Milton','William Shakespeare'], d, 1, literatura).
pergunta(64, 'Qual o nome do navio capitaneado por Capitão Ahab no livro "Moby Dick"?',
    ['Pequod','Hispaniola','Nautilus','Golden Hind'], a, 1, literatura).

pergunta(65, 'Quem é o autor de "Os Lusíadas"?',
    ['Gil Vicente','Fernando Pessoa','Luís Vaz de Camões','Almeida Garrett'], c, 2, literatura).
pergunta(66, 'Que escritora britânica criou a personagem Jane Eyre?',
    ['Jane Austen','Charlotte Brontë','Emily Brontë','Virginia Woolf'], b, 2, literatura).
pergunta(67, 'O que é a "Divina Comédia", de Dante Alighieri?',
    ['Um poema épico narrando a viagem pela vida após a morte','Uma peça de teatro','Um romance de cavalaria','Uma coletânea de sonetos'], a, 2, literatura).
pergunta(68, 'Qual o conto de Nicolai Gogol que é considerado uma das obras mais influentes da literatura russa?',
    ['O Capote','O Nariz','Almas Mortas','Taras Bulba'], a, 2, literatura).

pergunta(69, 'Quem escreveu o livro "1984"?',
    ['Aldous Huxley','George Orwell','Ray Bradbury','Ernest Hemingway'], b, 3, literatura).
pergunta(70, 'Qual obra é considerada o primeiro romance moderno em língua portuguesa?',
    ['Sermão de Santo António','Peregrinação','Felicidade Clandestina','O Crime do Padre Amaro'], d, 3, literatura).
pergunta(71, 'Qual personagem de Shakespeare exclama "Ser ou não ser, eis a questão"?',
    ['Hamlet','Romeu','Macbeth','Otelo'], a, 3, literatura).
pergunta(72, 'Qual o género literário predominante em "Viagens na Minha Terra", de Almeida Garrett?',
    ['Poesia épica','Romance histórico','Teatro','Prosa romântica'], d, 3, literatura).

pergunta(73, 'Qual a obra de Eça de Queirós que satiriza a vida burguesa em Lisboa?',
    ['O Primo Basílio','A Ilustre Casa de Ramires','Os Maias','O Crime do Padre Amaro'], c, 4, literatura).
pergunta(74, 'Qual o movimento literário associado a Fernando Pessoa e seus heterónimos?',
    ['Classicismo','Romantismo','Realismo','Modernismo'], d, 4, literatura).
pergunta(75, 'Quem é o autor do livro "Cem Anos de Solidão"?',
    ['Mario Vargas Llosa','Gabriel García Márquez','Pablo Neruda','Jorge Luis Borges'], b, 4, literatura).
pergunta(76, 'Qual o país de origem do famoso escritor Franz Kafka?',
    ['Alemanha','República Checa','Áustria','Polónia'], b, 4, literatura).

pergunta(77, 'Que tipo de criaturas são os "Hobbits", criados por J.R.R. Tolkien?',
    ['Elfos','Pessoas pequenas com pés peludos','Anões','Goblins'], b, 5, literatura).
pergunta(78, 'O que é o "Soneto" (forma poética)?',
    ['Um poema de versos livres','Um poema de 20 versos','Um poema de 14 versos','Uma peça teatral curta'], c, 5, literatura).
pergunta(79, 'Quem é a autora do romance "Orgulho e Preconceito"?',
    ['Mary Shelley','Emily Brontë','Louisa May Alcott','Jane Austen'], d, 5, literatura).
pergunta(80, 'Qual é a obra que conta a história de um jovem aprendiz de feiticeiro?',
    ['As Crónicas de Nárnia','O Senhor dos Anéis','A Roda do Tempo','Harry Potter'], d, 5, literatura).

% Ciência (id 81 a 100)

pergunta(81, 'Qual é o principal gás responsável pelo efeito de estufa?',
    ['Azoto','Oxigénio','Dióxido de Carbono','Metano'], c, 1, ciencia).
pergunta(82, 'Qual a fórmula química da água?',
    ['H2O','CO2','O2','NaCl'], a, 1, ciencia).
pergunta(83, 'Qual a função dos glóbulos vermelhos no sangue?',
    ['Transporte de Oxigénio','Defesa do organismo','Coagulação','Produção de anticorpos'], a, 1, ciencia).
pergunta(84, 'Qual é o planeta mais próximo do Sol?',
    ['Vénus','Terra','Marte','Mercúrio'], d, 1, ciencia).

pergunta(85, 'Qual a unidade de medida usada para medir a resistência elétrica?',
    ['Volt','Ampere','Ohm','Watt'], c, 2, ciencia).
pergunta(86, 'Qual o elemento químico com símbolo "Ag"?',
    ['Ouro','Prata','Cobre','Alumínio'], b, 2, ciencia).
pergunta(87, 'Qual o nome da unidade fundamental da hereditariedade?',
    ['Célula','Gene','Neurónio','Molécula'], b, 2, ciencia).
pergunta(88, 'O que é o "ADN"?',
    ['Ácido Desoxirribonucleico','Ácido Desobonucleico','Adenosina trifosfato','Ácido ribonucleico'], a, 2, ciencia).

pergunta(89, 'O que é um "quasar"?',
    ['Um tipo de buraco negro','Uma estrela anã','Um satélite artificial','Um núcleo galáctico ativo e muito luminoso'], d, 3, ciencia).
pergunta(90, 'O que mede a Escala Richter?',
    ['Temperatura','Velocidade do vento','Intensidade de sismos','Pressão atmosférica'], c, 3, ciencia).
pergunta(91, 'O que é a "Lei da Gravitação Universal"?',
    ['Lei da inércia','Lei da termodinâmica','Lei que descreve a atração entre corpos com massa','Lei da conservação de energia'], c, 3, ciencia).
pergunta(92, 'Qual o nome do maior osso do corpo humano?',
    ['Úmero','Tíbia','Rádio','Fêmur'], d, 3, ciencia).

pergunta(93, 'Quem formulou a Teoria da Relatividade Geral?',
    ['Isaac Newton','Niels Bohr','Albert Einstein','Galileu Galilei'], c, 4, ciencia).
pergunta(94, 'Onde ocorre o processo de fotossíntese nas plantas?',
    ['Raízes','Caules','Folhas (Cloroplastos)','Flores'], c, 4, ciencia).
pergunta(95, 'Qual o único metal que é líquido à temperatura ambiente?',
    ['Cobre','Mercúrio','Ouro','Ferro'], b, 4, ciencia).
pergunta(96, 'Qual a velocidade aproximada da luz no vácuo (em km/s)?',
    ['150.000','250.000','290.000','300.000'], d, 4, ciencia).

pergunta(97, 'Quem descobriu a Penicilina?',
    ['Louis Pasteur','Robert Koch','Alexander Fleming','Edward Jenner'], c, 5, ciencia).
pergunta(98, 'Qual o nome da galáxia onde se encontra o nosso sistema solar?',
    ['Andrómeda','Triângulo','Via Láctea','Grande Nuvem de Magalhães'], c, 5, ciencia).
pergunta(99, 'Qual a temperatura de ebulição da água ao nível do mar (em graus Celsius)?',
    ['90ºC','95ºC','105ºC','100ºC'], d, 5, ciencia).
pergunta(100, 'Qual o nome do cientista que descobriu o núcleo atómico?',
    ['Niels Bohr','Max Planck','Ernest Rutherford','John Dalton'], c, 5, ciencia).

% + Desporto (id 101 a 120)

pergunta(101, 'Quantos minutos tem o tempo regulamentar de uma partida de futebol?',
    ['45','60','90','100'], c, 1, desporto).
pergunta(102, 'Em que desporto se utiliza um disco (puck)?',
    ['Hóquei no Gelo','Pólo','Golfe','Curling'], a, 1, desporto).
pergunta(103, 'Qual é a cor da bola de basquetebol oficial da NBA?',
    ['Preta','Branca','Laranja','Verde'], c, 1, desporto).
pergunta(104, 'Quem é conhecido como "The Special One" no futebol?',
    ['Pep Guardiola','Jurgen Klopp','José Mourinho','Alex Ferguson'], c, 1, desporto).

pergunta(105, 'Em que cidade se realizaram os Jogos Olímpicos de 2016?',
    ['Londres','Pequim','Rio de Janeiro','Tóquio'], c, 2, desporto).
pergunta(106, 'Quantos jogadores compõem uma equipa de Voleibol em campo?',
    ['5','6','7','11'], b, 2, desporto).
pergunta(107, 'Qual destas modalidades NÃO faz parte do Triatlo?',
    ['Natação','Ciclismo','Corrida','Equitação'], d, 2, desporto).
pergunta(108, 'Qual é a nacionalidade do tenista Rafael Nadal?',
    ['Italiana','Espanhola','Francesa','Argentina'], b, 2, desporto).

pergunta(109, 'Qual o único país a participar em todas as Taças do Mundo de Futebol até 2022?',
    ['Alemanha','Argentina','Brasil','Itália'], c, 3, desporto).
pergunta(110, 'No ténis, o que significa o termo "Ace"?',
    ['Ponto ganho diretamente no serviço','Falta no serviço','Toque na rede','Empate'], a, 3, desporto).
pergunta(111, 'Quantos buracos tem um campo de golfe regulamentar?',
    ['9','12','15','18'], d, 3, desporto).
pergunta(112, 'Quem venceu o campeonato de Fórmula 1 em 2021 numa última volta polémica?',
    ['Lewis Hamilton','Max Verstappen','Sebastian Vettel','Valtteri Bottas'], b, 3, desporto).

pergunta(113, 'Em que ano Portugal venceu o Campeonato Europeu de Futebol (Euro)?',
    ['2004','2012','2016','2018'], c, 4, desporto).
pergunta(114, 'Qual é a distância de uma piscina olímpica?',
    ['25 metros','50 metros','100 metros','40 metros'], b, 4, desporto).
pergunta(115, 'No Judo, qual a pontuação máxima que termina imediatamente o combate?',
    ['Waza-ari','Yuko','Koka','Ippon'], d, 4, desporto).
pergunta(116, 'Qual equipa da NBA tem mais títulos na história (até 2023, empatada)?',
    ['Chicago Bulls','Boston Celtics','Miami Heat','San Antonio Spurs'], b, 4, desporto).

pergunta(117, 'Quem detém o recorde de mais Grand Slams de ténis masculinos (até início de 2024)?',
    ['Roger Federer','Rafael Nadal','Novak Djokovic','Pete Sampras'], c, 5, desporto).
pergunta(118, 'Qual foi o primeiro desporto a ser praticado na Lua?',
    ['Golfe','Futebol','Ténis','Lançamento do dardo'], a, 5, desporto).
pergunta(119, 'A Taça Davis é uma competição internacional de que modalidade?',
    ['Golfe','Ténis','Vela','Râguebi'], b, 5, desporto).
pergunta(120, 'Quem foi o primeiro atleta a correr a maratona em menos de 2 horas (não oficial)?',
    ['Mo Farah','Haile Gebrselassie','Eliud Kipchoge','Kenenisa Bekele'], c, 5, desporto).

% + História (id 121 a 140)

pergunta(121, 'Quem foi o primeiro Rei de Portugal?',
    ['D. Dinis','D. Afonso Henriques','D. Sancho I','D. Manuel I'], b, 1, historia).
pergunta(122, 'Em que país se situam as Pirâmides de Gizé?',
    ['México','Egito','Peru','Sudão'], b, 1, historia).
pergunta(123, 'Qual navegador descobriu o caminho marítimo para a Índia?',
    ['Cristóvão Colombo','Pedro Álvares Cabral','Vasco da Gama','Bartolomeu Dias'], c, 1, historia).
pergunta(124, 'Que civilização antiga construiu o Partenon?',
    ['Romana','Grega','Egípcia','Persa'], b, 1, historia).

pergunta(125, 'Quem era o líder da Alemanha Nazista durante a Segunda Guerra Mundial?',
    ['Joseph Goebbels','Adolf Hitler','Hermann Göring','Heinrich Himmler'], b, 2, historia).
pergunta(126, 'A Revolução Francesa iniciou-se em que século?',
    ['XVII','XVIII','XIX','XX'], b, 2, historia).
pergunta(127, 'Quem pintou a "Mona Lisa"?',
    ['Michelangelo','Rafael','Donatello','Leonardo da Vinci'], d, 2, historia).
pergunta(128, 'Qual era a capital do Império Romano do Oriente?',
    ['Roma','Atenas','Constantinopla','Alexandria'], c, 2, historia).

pergunta(129, 'Em que ano os Estados Unidos declararam independência?',
    ['1776','1789','1800','1492'], a, 3, historia).
pergunta(130, 'Quem foi o autor das "95 Teses" que iniciaram a Reforma Protestante?',
    ['João Calvino','Martinho Lutero','Henrique VIII','Erasmo de Roterdão'], b, 3, historia).
pergunta(131, 'Que batalha marcou a derrota final de Napoleão Bonaparte?',
    ['Austerlitz','Waterloo','Trafalgar','Leipzig'], b, 3, historia).
pergunta(132, 'Qual a rainha com o reinado mais longo da história do Reino Unido?',
    ['Vitória','Isabel I','Isabel II','Maria I'], c, 3, historia).

pergunta(133, 'Em que ano se deu o terramoto que destruiu Lisboa?',
    ['1500','1640','1755','1820'], c, 4, historia).
pergunta(134, 'Qual o nome do tratado que pôs fim à Primeira Guerra Mundial?',
    ['Tratado de Tordesilhas','Tratado de Versalhes','Tratado de Lisboa','Tratado de Viena'], b, 4, historia).
pergunta(135, 'Quem foi o primeiro ser humano a viajar para o espaço?',
    ['Neil Armstrong','Buzz Aldrin','Yuri Gagarin','John Glenn'], c, 4, historia).
pergunta(136, 'Qual civilização pré-colombiana habitava a região do atual México?',
    ['Incas','Maias','Astecas','Guaranis'], c, 4, historia).

pergunta(137, 'A Guerra dos Trinta Anos ocorreu principalmente em que atual país?',
    ['França','Espanha','Alemanha','Inglaterra'], c, 5, historia).
pergunta(138, 'Quem foi o responsável pela política da "Perestroika" na União Soviética?',
    ['Boris Iéltsin','Mikhail Gorbachev','Leonid Brezhnev','Vladimir Putin'], b, 5, historia).
pergunta(139, 'Qual o nome do assassino do Arquiduque Francisco Fernando (início da 1ª Guerra)?',
    ['Gavrilo Princip','Lee Harvey Oswald','John Wilkes Booth','Brutus'], a, 5, historia).
pergunta(140, 'Em que ano foi assinada a Magna Carta?',
    ['1066','1215','1492','1688'], b, 5, historia).

% + Geografia (id 141 a 160)

pergunta(141, 'Qual é o maior país do mundo em área?',
    ['China','EUA','Canadá','Rússia'], d, 1, geografia).
pergunta(142, 'Em que país fica a Torre Eiffel?',
    ['Itália','Espanha','França','Alemanha'], c, 1, geografia).
pergunta(143, 'Qual é o oceano que banha a costa de Portugal?',
    ['Índico','Pacífico','Atlântico','Ártico'], c, 1, geografia).
pergunta(144, 'Tóquio é a capital de que país?',
    ['China','Coreia do Sul','Japão','Tailândia'], c, 1, geografia).

pergunta(145, 'Qual é o rio mais longo do mundo (disputado com o Nilo)?',
    ['Mississipi','Amazonas','Yangtzé','Danúbio'], b, 2, geografia).
pergunta(146, 'Em que continente fica o deserto do Atacama?',
    ['África','Ásia','América do Sul','Oceano'], c, 2, geografia).
pergunta(147, 'Qual destes países NÃO faz fronteira com Portugal?',
    ['Espanha','França','Nenhum','Todos'], b, 2, geografia).
pergunta(148, 'Qual é a montanha mais alta de Portugal Continental?',
    ['Pico','Estrela','Gerês','Larouco'], b, 2, geografia).

pergunta(149, 'Qual é a capital da Turquia?',
    ['Istambul','Ancara','Antália','Izmir'], b, 3, geografia).
pergunta(150, 'Qual o menor país do mundo?',
    ['Mónaco','San Marino','Vaticano','Malta'], c, 3, geografia).
pergunta(151, 'Em que país se situa a cidade de Machu Picchu?',
    ['Bolívia','Peru','Chile','Equador'], b, 3, geografia).
pergunta(152, 'Qual destes países pertence à Escandinávia?',
    ['Suíça','Áustria','Suécia','Polónia'], c, 3, geografia).

pergunta(153, 'O Estreito de Bering separa a Rússia de que país?',
    ['Canadá','Japão','EUA (Alasca)','China'], c, 4, geografia).
pergunta(154, 'Qual a capital da Nova Zelândia?',
    ['Auckland','Wellington','Christchurch','Hamilton'], b, 4, geografia).
pergunta(155, 'O Lago Baikal, o mais profundo do mundo, fica em que país?',
    ['Canadá','EUA','Rússia','Mongólia'], c, 4, geografia).
pergunta(156, 'Qual é o país africano com maior população?',
    ['Egito','África do Sul','Nigéria','Quénia'], c, 4, geografia).

pergunta(157, 'A ilha de Madagáscar localiza-se em que oceano?',
    ['Atlântico','Índico','Pacífico','Antártico'], b, 5, geografia).
pergunta(158, 'Qual é a capital do Cazaquistão (renomeada e depois revertida)?',
    ['Almaty','Astana','Tashkent','Bishkek'], b, 5, geografia).
pergunta(159, 'O Monte Branco (Mont Blanc) situa-se na fronteira entre que dois países?',
    ['Suíça e Áustria','França e Itália','Itália e Suíça','França e Espanha'], b, 5, geografia).
pergunta(160, 'Qual destes países não tem saída para o mar?',
    ['Bélgica','Paraguai','Portugal','Uruguai'], b, 5, geografia).

% + Literatura (id 161 a 180)

pergunta(161, 'Quem escreveu "Harry Potter"?',
    ['J.R.R. Tolkien','George R.R. Martin','J.K. Rowling','Stephen King'], c, 1, literatura).
pergunta(162, 'Qual é o nome do detetive criado por Arthur Conan Doyle?',
    ['Hercule Poirot','Sherlock Holmes','James Bond','Miss Marple'], b, 1, literatura).
pergunta(163, 'Romeu e Julieta é uma obra de...',
    ['Dante','Cervantes','Shakespeare','Molière'], c, 1, literatura).
pergunta(164, 'Qual o livro sagrado do Islão?',
    ['Bíblia','Torá','Alcorão','Vedas'], c, 1, literatura).

pergunta(165, 'Quem escreveu o "Memorial do Convento"?',
    ['Eça de Queirós','José Saramago','Camilo Castelo Branco','Fernando Pessoa'], b, 2, literatura).
pergunta(166, 'Qual a nacionalidade do escritor Gabriel García Márquez?',
    ['Mexicana','Espanhola','Colombiana','Argentina'], c, 2, literatura).
pergunta(167, 'Qual o heterónimo de Fernando Pessoa que era engenheiro naval?',
    ['Alberto Caeiro','Ricardo Reis','Álvaro de Campos','Bernardo Soares'], c, 2, literatura).
pergunta(168, 'Quem é o autor de "O Principezinho"?',
    ['Victor Hugo','Antoine de Saint-Exupéry','Jules Verne','Albert Camus'], b, 2, literatura).

pergunta(169, 'Em que livro aparece a personagem "Capitão Nemo"?',
    ['A Ilha do Tesouro','Moby Dick','20.000 Léguas Submarinas','Robinson Crusoé'], c, 3, literatura).
pergunta(170, 'Quem escreveu "A Divina Comédia"?',
    ['Maquiavel','Dante Alighieri','Petrarca','Boccaccio'], b, 3, literatura).
pergunta(171, 'Qual foi o primeiro e único Prémio Nobel da Literatura de língua portuguesa?',
    ['Jorge Amado','José Saramago','Lobo Antunes','Fernando Pessoa'], b, 3, literatura).
pergunta(172, 'O romance "Guerra e Paz" é de autoria de...',
    ['Dostoievski','Tolstoi','Chekhov','Pushkin'], b, 3, literatura).

pergunta(173, 'Quem escreveu "O Grande Gatsby"?',
    ['Ernest Hemingway','F. Scott Fitzgerald','Mark Twain','John Steinbeck'], b, 4, literatura).
pergunta(174, 'Qual o verdadeiro nome do escritor George Orwell?',
    ['Eric Blair','Arthur Blair','George Smith','Eric Arthur'], a, 4, literatura).
pergunta(175, 'A obra "Ulisses" (Ulysses) foi escrita por...',
    ['Oscar Wilde','James Joyce','Virginia Woolf','Samuel Beckett'], b, 4, literatura).
pergunta(176, 'Quem escreveu "Os Maias"?',
    ['Almeida Garrett','Camilo Castelo Branco','Eça de Queirós','Júlio Dinis'], c, 4, literatura).

pergunta(177, 'Qual a obra mais famosa de Mary Shelley?',
    ['Drácula','O Médico e o Monstro','Frankenstein','O Retrato de Dorian Gray'], c, 5, literatura).
pergunta(178, 'Quem escreveu "A Metamorfose", onde um homem vira um inseto?',
    ['Friedrich Nietzsche','Franz Kafka','Sigmund Freud','Hermann Hesse'], b, 5, literatura).
pergunta(179, 'Qual o autor de "À Espera de Godot"?',
    ['Eugene O Neill','Samuel Beckett','Harold Pinter','Arthur Miller'], b, 5, literatura).
pergunta(180, 'Em "Os Lusíadas", quem é o gigante que representa o Cabo das Tormentas?',
    ['Polifemo','Adamastor','Golias','Atlas'], b, 5, literatura).

% + Ciência (id 181 a 200)

pergunta(181, 'Qual é o maior órgão do corpo humano?',
    ['Fígado','Coração','Pele','Cérebro'], c, 1, ciencia).
pergunta(182, 'Quantas pernas tem uma aranha?',
    ['6','8','10','12'], b, 1, ciencia).
pergunta(183, 'O que as abelhas produzem?',
    ['Leite','Seda','Mel','Algodão'], c, 1, ciencia).
pergunta(184, 'Qual a fórmula química do dióxido de carbono?',
    ['CO','CO2','C2O','O2C'], b, 1, ciencia).

pergunta(185, 'Qual é o planeta conhecido como o "Planeta Vermelho"?',
    ['Júpiter','Saturno','Marte','Vénus'], c, 2, ciencia).
pergunta(186, 'Qual a velocidade do som no ar (aproximada)?',
    ['340 m/s','300.000 km/s','100 m/s','1000 m/s'], a, 2, ciencia).
pergunta(187, 'O que estuda a Botânica?',
    ['Animais','Rochas','Plantas','Estrelas'], c, 2, ciencia).
pergunta(188, 'Qual o símbolo químico do Oxigénio?',
    ['Ox','O','Og','Om'], b, 2, ciencia).

pergunta(189, 'Quem propôs a teoria da evolução por seleção natural?',
    ['Isaac Newton','Albert Einstein','Charles Darwin','Louis Pasteur'], c, 3, ciencia).
pergunta(190, 'Qual é o metal mais abundante na crosta terrestre?',
    ['Ferro','Ouro','Alumínio','Cobre'], c, 3, ciencia).
pergunta(191, 'O que é o H2O2?',
    ['Água','Água Oxigenada','Sal','Ácido Sulfúrico'], b, 3, ciencia).
pergunta(192, 'Qual a parte da célula responsável pela produção de energia?',
    ['Núcleo','Mitocôndria','Ribossoma','Membrana'], b, 3, ciencia).

pergunta(193, 'Qual o gás nobre mais leve?',
    ['Hélio','Néon','Árgon','Xénon'], a, 4, ciencia).
pergunta(194, 'Quem inventou a lâmpada elétrica incandescente comercial?',
    ['Nikola Tesla','Thomas Edison','Alexander Bell','James Watt'], b, 4, ciencia).
pergunta(195, 'O que significa a sigla "pH"?',
    ['Potencial de Hélio','Potencial de Hidrogénio','Poder Humano','Pressão Hidrostática'], b, 4, ciencia).
pergunta(196, 'Qual a camada da atmosfera que nos protege dos raios UV?',
    ['Troposfera','Estratosfera (Camada de Ozono)','Mesosfera','Termosfera'], b, 4, ciencia).

pergunta(197, 'Qual é a partícula subatómica com carga negativa?',
    ['Protão','Neutrão','Eletrão','Fotão'], c, 5, ciencia).
pergunta(198, 'Quem descobriu a radioatividade (junto com Pierre Curie)?',
    ['Ada Lovelace','Marie Curie','Rosalind Franklin','Lise Meitner'], b, 5, ciencia).
pergunta(199, 'Qual o nome do primeiro satélite artificial lançado para o espaço?',
    ['Apollo 11','Voyager','Sputnik 1','Hubble'], c, 5, ciencia).
pergunta(200, 'Na tabela periódica, qual é o elemento com número atómico 1?',
    ['Hélio','Oxigénio','Hidrogénio','Carbono'], c, 5, ciencia).