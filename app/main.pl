% consult para recuperar base de conhecimento presente no arquivo baseConhecimento
:- consult('baseConhecimento.pl').

% Exibição do menu
menu_principal :-
    nl,write("Bem-vindo ao Recomendador de Filmes!"),
    nl,write("1 - Consultar filmes recomendados"),
    nl,write("2 - Sair"),
    nl,nl,read(OpcaoMenu),
    (   OpcaoMenu =:= 1
    ->  consultar_filmes_recomendados
    ;   OpcaoMenu =:= 2
    ->  sair
    ;   opcaoInvalida
    ).

% Coletar preferências do usuário
consultar_filmes_recomendados :-
    write("Insira suas preferências!"),
    nl,

    % Preferência de gênero
    perguntar_preferencia(OpcaoGenero,genero),
    nl,
    (
        OpcaoGenero == 'sim'
    ->  genero(Genero)
    ;   Genero = _
    ),

    % Preferência de avaliacao minima
    nl,perguntar_preferencia(OpcaoAvaliacao,avaliacao),
    nl,
    (
        OpcaoAvaliacao == 'sim'
    ->  avaliacao(AvaliacaoMinima)
    ;   AvaliacaoMinima = 0
    ),

    % Preferência de ano minimo
    nl,perguntar_preferencia(OpcaoAnoMinimo,anoMinimo),
    nl,
    (
        OpcaoAnoMinimo == 'sim'
    ->  anoMinimo(AnoMinimo)
    ;   AnoMinimo = 0
    ),

    % Preferência de ano maximo
    nl,perguntar_preferencia(OpcaoAnoMaximo,anoMaximo),
    nl,
    (
        OpcaoAnoMaximo == 'sim'
    ->  anoMaximo(AnoMaximo)
    ;   AnoMaximo = 2023
    ),

    % Preferência de diretor
    perguntar_preferencia(OpcaoDiretor,diretor),
    nl,
    (
        OpcaoDiretor == 'sim'
    ->  diretor(Diretor)
    ;   Diretor = _
    ),

    % Preferência de estúdio
    perguntar_preferencia(OpcaoEstudio,estudio),
    nl,
    (
        OpcaoEstudio == 'sim'
    ->  estudio(Estudio)
    ;   Estudio = _
    ),

    nl,write("Filmes para você: "),
    nl,findall(X,(filme(X,Genero,Ano,Nota,Diretor,Estudio), Ano >= AnoMinimo, Ano =< AnoMaximo, Nota >= AvaliacaoMinima), Lista),
    write(Lista).

% Loop para forçar o usuário a digitar 'sim' ou 'nao'
perguntar_preferencia(Opcao,Tema) :-
    write("Voce possui preferência por "),
    write(Tema),
    write("? (sim/nao)"),
    nl,read(OpcaoTemp), % use uma nova variável temporária aqui
    ( 
        OpcaoTemp == 'sim'
    ->  Opcao = OpcaoTemp % copie o valor para Opcao
    ;   OpcaoTemp == 'nao'
    ->  Opcao = OpcaoTemp % copie o valor para Opcao
    ;   nl,write("Voce não digitou uma opção válida"), nl,
        perguntar_preferencia(Opcao,Tema) % Continua perguntando até receber resposta válida
    ).

% Mostrar todos os gêneros possíveis e usuário digitar o gênero desejado
genero(Genero) :-
    % Listar todos os gêneros
    write("Digite o gênero desejado: "),
    nl,read(Genero).
    % Verificar se valor inserido é válido

% Usuário digitar a avaliação minima desejada
avaliacao(AvaliacaoMinima) :-
    write("Digite a avaliação mínima desejada (0-100): "),
    nl,read(AvaliacaoMinima).
    % Verificar se valor inserido é válido

% Usuário digitar o ano minimo desejado
anoMinimo(AnoMinimo) :-
    write("Digite o ano mínimo desejado: "),
    nl,read(AnoMinimo).
    % Verificar se valor inserido é válido

% Usuário digitar o ano maximo desejado
anoMaximo(AnoMaximo) :-
    write("Digite o ano máximo desejado: "),
    nl,read(AnoMaximo).
    % Verificar se valor inserido é válido

% Mostrar todos os diretores possíveis e usuário digitar o diretor desejado
diretor(Diretor) :-
    % Listar todos os diretores
    write("Digite o diretor desejado: "),
    nl,read(Diretor).
    % Verificar se valor inserido é válido

% Mostrar todos os estúdios possíveis e usuário digitar o estúdio desejado
estudio(Estudio) :-
    % Listar todos os estúdios
    write("Digite o estúdio desejado: "),
    nl,read(Estudio).
    % Verificar se valor inserido é válido

sair :- 
    nl,write("Obrigado por usar nosso recomendador!").

opcaoInvalida :-
    write("Voce não digitou uma opção válida!"),
    nl,menu_principal.

main :- menu_principal.

% Explicação das variáveis:

% OpcaoMenu irá armazenar a opção do menu escolhida pelo usuário
% OpcaoGenero irá armazenar 'sim' ou 'nao' para preferencia por genero
% OpcaoAvaliacao irá armazenar 'sim' ou 'nao' para preferencia por avaliacao minima
% OpcaoAnoMinimo irá armazenar 'sim' ou 'nao' para preferencia por ano minimo
% OpcaoAnoMaximo irá armazenar 'sim' ou 'nao' para preferencia por ano maximo
% OpcaoDiretor irá armazenar 'sim' ou 'nao' para preferencia por diretor
% Genero irá armazenar o genero escolhido pelo usuario. No caso de opcaoGenero armazenar 'nao', Genero receberá _
% AvaliacaoMinima irá armazenar a avaliação minima escolhido pelo usuario. No caso de opcaoAvaliacao armazenar 'nao', AvaliacaoMinima receberá _
% AnoMinimo irá armazenar o ano minimo desejado pelo usuario. No caso de OpcaoAnoMinimo armazenar 'nao', AnoMinimo será 0
% AnoMaximo irá armazenar o ano maximo desejado pelo usuario. No caso de OpcaoAnoMaximo armazenar 'nao', AnoMaximo será 2023
% Diretor irá armazenar o diretor escolhido pelo usuario. No caso de OpcaoDiretor armazenar 'nao', Diretor receberá _
