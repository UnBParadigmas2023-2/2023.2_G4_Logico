# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter


class MoviescrawlerPipeline:
    def process_item(self, item, spider):
        return item

class PrologExportPipeline:
    def process_item(self, item, spider):
        with open('movies.pl', 'a', encoding='utf-8') as f:
            prolog_data = f"filme('{item['movie_name']}', '{item['genre']}', {item['year']}, {item['rate']}, '{item['director_name']}', '{item['studio']}').\n"
            f.write(prolog_data)
        return item