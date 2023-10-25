% consult para recuperar base de conhecimento presente no arquivo baseConhecimento
:- consult('baseConhecimento.pl').

% Exibição do menu
menu_principal :-
    nl, write("Bem-vindo ao Recomendador de Filmes!"),
    nl, write("1 - Consultar filmes recomendados"),
    nl, write("2 - Sair"),
    nl, nl, read(OpcaoMenu),
    (
        OpcaoMenu =:= 1
        -> consultar_filmes_recomendados
        ; OpcaoMenu =:= 2
        -> sair
        ; opcaoInvalida
    ).

% Coletar preferências do usuário
consultar_filmes_recomendados :-
    write("Insira suas preferências!"),
    nl,

    % Preferência de gênero
    perguntar_preferencia(OpcaoGenero, genero),
    nl,
    (
        OpcaoGenero == 'sim'
        -> genero(Genero)
        ; Genero = _
    ),

    % Preferência de avaliacao minima
    nl, perguntar_preferencia(OpcaoAvaliacao, avaliacao),
    nl,
    (
        OpcaoAvaliacao == 'sim'
        -> avaliacao(AvaliacaoMinima)
        ; AvaliacaoMinima = 0
    ),

    % Preferência de ano minimo
    nl, perguntar_preferencia(OpcaoAnoMinimo, anoMinimo),
    nl,
    (
        OpcaoAnoMinimo == 'sim'
        -> anoMinimo(AnoMinimo)
        ; AnoMinimo = 0
    ),

    % Preferência de ano maximo
    nl, perguntar_preferencia(OpcaoAnoMaximo, anoMaximo),
    nl,
    (
        OpcaoAnoMaximo == 'sim'
        -> anoMaximo(AnoMaximo)
        ; AnoMaximo = 2023
    ),

    % Preferência de diretor
    perguntar_preferencia(OpcaoDiretor, diretor),
    nl,
    (
        OpcaoDiretor == 'sim'
        -> diretor(Diretor)
        ; Diretor = _
    ),

    % Preferência de estúdio
    perguntar_preferencia(OpcaoEstudio, estudio),
    nl,
    (
        OpcaoEstudio == 'sim'
        -> estudio(Estudio)
        ; Estudio = _
    ),

% Exibir lista de filmes recomendados e perguntar ao usuário se deseja visualizar informações sobre um filme
nl, write("Filmes para você: "),
nl, findall(X, (filme(X, Genero, Ano, Nota, Diretor, Estudio), Ano >= AnoMinimo, Ano =< AnoMaximo, Nota >= AvaliacaoMinima), Lista),
listar_filmes_numerados(Lista, 1), % Adiciona números à lista de filmes
nl, write("Deseja visualizar informações de um filme recomendado? (Digite o número do filme ou 'nao')"),
read(OpcaoVisualizar),
(
    OpcaoVisualizar == 'nao'
    -> true
    ; atom_number(OpcaoVisualizar, OpcaoNum), % Converte a entrada para um número
    visualizar_informacoes_do_filme(Lista, OpcaoNum)
).

% Loop para forçar o usuário a digitar 'sim' ou 'nao'
perguntar_preferencia(Opcao, Tema) :-
    write("Você possui preferência por "),
    write(Tema),
    write("? (sim/nao)"),
    nl, read(OpcaoTemp),
    ( 
        OpcaoTemp == 'sim'
        -> Opcao = OpcaoTemp
        ; OpcaoTemp == 'nao'
        -> Opcao = OpcaoTemp
        ; nl, write("Você não digitou uma opção válida"), nl,
        perguntar_preferencia(Opcao, Tema)
    ).

% Mostrar todos os gêneros possíveis e usuário digitar o gênero desejado
genero(Genero) :-
    write("Digite o gênero desejado: "),
    nl, read(Genero).

% Usuário digitar a avaliação minima desejada
avaliacao(AvaliacaoMinima) :-
    write("Digite a avaliação mínima desejada (0-100): "),
    nl, read(AvaliacaoMinima).

% Usuário digitar o ano minimo desejado
anoMinimo(AnoMinimo) :-
    write("Digite o ano mínimo desejado: "),
    nl, read(AnoMinimo).

% Usuário digitar o ano maximo desejado
anoMaximo(AnoMaximo) :-
    write("Digite o ano máximo desejado: "),
    nl, read(AnoMaximo).

% Mostrar todos os diretores possíveis e usuário digitar o diretor desejado
diretor(Diretor) :-
    write("Digite o diretor desejado: "),
    nl, read(Diretor).

% Mostrar todos os estúdios possíveis e usuário digitar o estúdio desejado
estudio(Estudio) :-
    write("Digite o estúdio desejado: "),
    nl, read(Estudio).

sair :- 
    nl, write("Obrigado por usar nosso recomendador!").

opcaoInvalida :-
    write("Você não digitou uma opção válida!"),
    nl, menu_principal.

% Exibe a lista de filmes numerada
listar_filmes_numerados([], _).
listar_filmes_numerados([Filme|Resto], Num) :-
    format('~w - ~w~n', [Num, Filme]),
    NovoNum is Num + 1,
    listar_filmes_numerados(Resto, NovoNum).

% Exibe informações de um filme da lista com base no número
visualizar_informacoes_do_filme(ListaFilmes, OpcaoNum) :-
    ( 
        OpcaoNum == 'nao' % Verifica se o usuário digitou 'nao'
        -> menu_principal % Retorna ao menu principal
        ; nth1(OpcaoNum, ListaFilmes, NomeFilmeDesejado) % Verifica se o número está na lista
        -> exibir_informacoes_do_filme(NomeFilmeDesejado),
           continuar_ou_voltar % Pergunta ao usuário se ele deseja continuar ou voltar ao menu principal
        ; write("Filme não encontrado na lista de recomendações.")
    ).

    exibir_informacoes_do_filme(NomeDoFilme) :-
        filme(NomeDoFilme, Genero, Ano, Nota, Diretor, Estudio),
        write("Nome do Filme: "), write(NomeDoFilme), nl,
        write("Gênero: "), write(Genero), nl,
        write("Ano de Lançamento: "), write(Ano), nl,
        write("Avaliação: "), write(Nota), nl,
        write("Diretor: "), write(Diretor), nl,
        write("Estúdio: "), write(Estudio), nl.
    
% Predicado para continuar ou voltar ao menu principal
continuar_ou_voltar :-
    nl, write("O que você deseja fazer a seguir?"),
    nl, write("1 - Continuar procurando filmes"),
    nl, write("2 - Voltar ao menu principal"),
    nl, nl, read(Opcao),
    (
        Opcao =:= 1
        -> consultar_filmes_recomendados
        ; Opcao =:= 2
        -> menu_principal
        ; opcaoInvalida
    ).

    main :- menu_principal.

% Explicação das variáveis:

% OpcaoMenu irá armazenar a opção do menu escolhida pelo usuário
% OpcaoGenero irá armazenar 'sim' ou 'nao' para preferencia por genero
% OpcaoAvaliacao irá armazenar 'sim' ou 'nao' para preferencia por avaliacao minima
% OpcaoAnoMinimo irá armazenar 'sim' ou 'nao' para preferencia por ano minimo
% OpcaoAnoMaximo irá armazenar 'sim' ou 'nao' para preferencia por ano maximo
% OpcaoDiretor irá armazenar 'sim' ou 'nao' para preferencia por diretor
% OpcaoEstudio irá armazenar 'sim' ou 'nao' para preferencia por estudio 
% Genero irá armazenar o genero escolhido pelo usuario. No caso de opcaoGenero armazenar 'nao', Genero receberá _
% AvaliacaoMinima irá armazenar a avaliação minima escolhido pelo usuario. No caso de opcaoAvaliacao armazenar 'nao', AvaliacaoMinima receberá _
% AnoMinimo irá armazenar o ano minimo desejado pelo usuario. No caso de OpcaoAnoMinimo armazenar 'nao', AnoMinimo será 0
% AnoMaximo irá armazenar o ano maximo desejado pelo usuario. No caso de OpcaoAnoMaximo armazenar 'nao', AnoMaximo será 2023
% Diretor irá armazenar o diretor escolhido pelo usuario. No caso de OpcaoDiretor armazenar 'nao', Diretor receberá _
% Estudio irá armazenar o estudio escolhido pelo usuario.No caso de OpcaoEstudio armazenar 'nao', Estudio será _