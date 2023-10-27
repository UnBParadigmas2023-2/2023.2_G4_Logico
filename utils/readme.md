## Instruções para o uso do Scrapy

Entre na pasta `utils/moviesCrawler` e execute o comando:

``` shell 
scrapy crawl movies 
```

O resultado do Scrapy sairá no arquivo `movies.pl`. O arquivo já está no formato de dados para o `Prolog`. Essa formatação pode ser editada no arquivo `PrologExportPipeline.py`

## Instruções para testes

Caso queira realizar testes, verificar alguma funcionalidade, função ou variável, pode ser executado por meio do comando:

``` shell 
import pdb; pdb.set_trace()
```

Importe o pdb onde for necessário no código e teste por meio do `console`.
