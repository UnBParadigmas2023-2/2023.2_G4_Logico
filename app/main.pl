menu_principal :-
    write("Bem-vindo ao Recomendador de Filmes!"),
    nl,write("1 - Consultar filmes recomendados"),
    nl,write("2 - Sair"),
    nl,read(OpcaoMenu),
    (   OpcaoMenu =:= 1
    ->  write("Você selecionou a opção 1")
    ;   sair
    ).

sair :- 
    nl,write("Obrigado por usar nosso recomendador!").