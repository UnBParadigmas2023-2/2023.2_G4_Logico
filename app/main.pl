
% Fatos
filme('Gato de Botas 2', 'animacao', 2022).
filme('Pantera Negra', 'acao', 2018).
filme('Vingadores Ultimato', 'acao', 2019).
filme('Se Beber Nao Case', 'comedia', 2009).
filme('Barbie', 'comedia', 2023).

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
    perguntar_preferencia(OpcaoGenero,genero),
    nl,
    (
        OpcaoGenero == 'sim'
    ->  genero(Genero)
    ;   Genero = _
    ),
    % nl,write("Gênero escolhido: "),
    % write(Genero),nl,

    % Adicionar mais opções de preferência...

    nl,write("Filmes para você: "),
    nl,findall(X,filme(X,Genero,_),Lista),
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

% Mostrar todos os gêneros possíveis e usuário digitar qual gênero desejado
genero(Genero) :-
    % Listar todos os gêneros
    write("Digite o gênero desejado: "),
    nl,read(Genero).
    % Verificar se valor inserido é válido

sair :- 
    nl,write("Obrigado por usar nosso recomendador!").

opcaoInvalida :-
    write("Voce não digitou uma opção válida!"),
    nl,menu_principal.

main :- menu_principal.
