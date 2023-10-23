menu_principal :-
    write("Bem-vindo ao Recomendador de Filmes!"),
    nl,write("1 - Consultar filmes recomendados"),
    nl,write("2 - Sair"),
    nl,read(OpcaoMenu),
    (   OpcaoMenu =:= 1
    ->  write("Você selecionou a opção 1")
    ;   OpcaoMenu =:= 2
    ->  sair
    ;   opcaoInvalida
    ).

sair :- 
    nl,write("Obrigado por usar nosso recomendador!").

opcaoInvalida :-
    nl,write("Voce não digitou uma opção válida!"),
    nl,menu_principal.

main :- menu_principal.