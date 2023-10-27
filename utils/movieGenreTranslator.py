# Essa função traduz os gêneros dos filmes de inglês para português

def get_portuguese_movie_genre(movie_genre):
    genre_translator_dictionary = {
        "Drama": "Drama",
        "Comedy": "Comédia",
        "Action": "Ação",
        "Adventure": "Aventura",
        "Sci-Fi": "Ficção Científica",
        "Horror": "Terror",
        "Thriller": "Suspense",
        "Animation": "Animação",
        "Documentary": "Documentário",
        "Romance": "Romance",
        "Fantasy": "Fantasia",
        "Animation": "Animação",
        "Family": "Família",
        "Musical": "Musical",
        "Crime": "Crime"
    }

    return genre_translator_dictionary.get(movie_genre)