:- consult('baseConhecimento.pl').

% Regra para obter uma lista de todos os gêneros de filmes na base de dados sem repetições
todos_generos(Generos) :-
    findall(Genre, filme(_, Genre, _, _, _, _), ListaGeneros),
    remove_repeticoes(ListaGeneros, Generos).

% Regra para obter uma lista de todos os diretores de filmes na base de dados sem repetições
todos_diretores(Diretores) :-
    findall(Diretor, filme(_, _, _, _, Diretor, _), ListaDiretores),
    remove_repeticoes(ListaDiretores, Diretores).

% Regra para obter uma lista de todos os estudios de filmes na base de dados sem repetições
todos_estudios(Estudios) :-
    findall(Estudio, filme(_, _, _, _, _, Estudio), ListaEstudios),
    remove_repeticoes(ListaEstudios, Estudios).

% Regra para exibir gêneros
mostrar_generos :-
    todos_generos(Generos),
    formatar_atributos(Generos).

% Regra para exibir diretores
mostrar_diretores :-
    todos_diretores(Diretores),
    formatar_atributos(Diretores).

% Regra para exibir estudios
mostrar_estudios :-
    todos_estudios(Estudios),
    formatar_atributos(Estudios).

% Regra para remover repetições de uma lista
remove_repeticoes([], []).
remove_repeticoes([H | T], Resultado) :-
    (member(H, T) -> remove_repeticoes(T, Resultado) ; Resultado = [H | Resto]),
    remove_repeticoes(T, Resto).

% Regra formatar atributos
formatar_atributos([]).
formatar_atributos([Atributo | OutrosAtributos]) :-
    format("~w~n", [Atributo]),
    formatar_atributos(OutrosAtributos).

ano_minimo_maximo(Minimo, Maximo) :-
    findall(Ano, filme(_, _, Ano, _, _, _), Anos),
    min_list(Anos, Minimo),
    max_list(Anos, Maximo).

avaliacao_minima_maxima(Minima, Maxima) :-
    findall(Avaliacao, filme(_, _, _, Avaliacao, _, _), Avaliacoes),
    min_list(Avaliacoes, Minima),
    max_list(Avaliacoes, Maxima).