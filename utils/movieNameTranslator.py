import requests

# Essa função recebe o nome em inglês do filme e requisita para a API do themoviedb o nome do filme em português, caso exista

def get_portuguese_movie_title(movie_name):
    api_key = 'SUBSTITUA_SUA_API_KEY' # Você consegue gerar uma chave da api se registrando no site https://developer.themoviedb.org/docs
    search_url = f'https://api.themoviedb.org/3/search/movie?api_key={api_key}&query={movie_name}&language=pt-BR'

    response = requests.get(search_url)
    data = response.json()

    if 'results' in data and data['results']:
        # Assuming the first result is the closest match
        return data['results'][0]['title'].replace("'","")
    else:
        return movie_name.replace("'","")