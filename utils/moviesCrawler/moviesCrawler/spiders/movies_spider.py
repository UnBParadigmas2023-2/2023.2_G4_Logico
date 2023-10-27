import scrapy

from pathlib import Path
import re
import sys
sys.path.append("../")
from movieNameTranslator import get_portuguese_movie_title
from movieGenreTranslator import get_portuguese_movie_genre

# Essa função pega o estúdio do filme. Na maioria dos casos, o estúdio está na terceira posição do li, mas existem casos que ele está na segunda.
# Quando isso acontece, primeiro ele retorna a duração do filme. Portanto, é feito essa verificação por meio de regex.
def getStudio(response):
    studio = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/ul/li[3]/span/text()').get().strip()

    pattern = "\d h \d{2} m"

    if re.search(pattern, studio):
        return response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/ul/li[2]/span/text()').get().strip()

    return studio

class MovieItem(scrapy.Item):
    movie_name = scrapy.Field()
    genre = scrapy.Field()
    year = scrapy.Field()
    rate = scrapy.Field()
    director_name = scrapy.Field()
    studio = scrapy.Field()

class MoviesSpider(scrapy.Spider):
    name = "movies"
    URL_BASE = "https://www.metacritic.com"

    custom_settings = {         
        'DOWNLOAD_DELAY': 0.02, # Esse delay foi necessário devido a API de tradução de nome dos filmes, para não exceder o limite de requisições.
    }

    def start_requests(self):
        url = "https://www.metacritic.com/browse/movie/all/horror/all-time/metascore/?genre=horror"    
        yield scrapy.Request(url=url, callback=self.parseMainPage)

    def parseMainPage(self, response):
        lastPage = response.xpath('//span[@class="c-navigationPagination_pages u-flexbox u-flexbox-alignCenter u-flexbox-justifyCenter"]/span[4]//text()').get()

        for i in range (1, int(lastPage) + 1):
            nextPage = f"https://www.metacritic.com/browse/movie/all/horror/all-time/metascore/?genre=horror&page={i}"
            yield scrapy.Request(url=nextPage, callback=self.parseMovieList, dont_filter=True)
    
    def parseMovieList(self, response): # Foram necessárias duas listas pois a página é dividida em dois grids de filmes, totalizando 24 filmes por página e 12 por grid
        movieList1 = response.xpath('//div[@class="c-productListings_grid g-grid-container u-grid-columns g-inner-spacing-bottom-large"]/div')
        movieList2 = response.xpath('//div[@class="c-productListings_grid g-grid-container u-grid-columns g-inner-spacing-bottom-large g-inner-spacing-top-large"]/div')

        movieListFinal = movieList1 + movieList2

        for movie in movieListFinal:
            movieUrl = self.URL_BASE+movie.xpath('.//a/@href').get()
            yield scrapy.Request(url=movieUrl, callback=self.parseMovie)

    # Para conseguir o xpath, selecione o texto que você quer no site, clique em inspecionar, na área selecionada no inspecionar, clique em Copy > Copy XPath
    def parseMovie(self, response):
        name = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[2]/div[3]/div[1]/div/text()').get().strip()
        year = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/ul/li[1]/span/text()').get().strip()
        studio = getStudio(response)
        rate = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[2]/div[3]/div[2]/div[1]/div/div[1]/div[2]/div/div/span/text()').get().strip()
        director = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[2]/div[1]/div[2]/div[2]/div/p/a/text()').get().strip()
        genre = response.xpath('//*[@id="__layout"]/div/div[2]/div[1]/div[1]/div/div/div[2]/div[1]/div[2]/div[1]/ul/li[1]/div/a/span/text()').get().strip()

        portugueseMovieName = get_portuguese_movie_title(name)
        portugueseMovieGenre = get_portuguese_movie_genre(genre) if get_portuguese_movie_genre(genre) else genre

        movie_item = MovieItem()
        movie_item['movie_name'] = portugueseMovieName
        movie_item['genre'] = portugueseMovieGenre
        movie_item['year'] = year
        movie_item['rate'] = rate
        movie_item['director_name'] = director.replace("'","")
        movie_item['studio'] = studio.replace("'","")

        yield movie_item