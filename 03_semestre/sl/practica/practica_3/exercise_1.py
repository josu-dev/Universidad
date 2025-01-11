import csv
from typing import Iterable

CsvReaderType = Iterable[list[str]]

def show_types_from_country(file:CsvReaderType, country:str) -> set[str]:
    show_types = {line[1] for line in file if country in line[5]}
    return show_types

def print_unique_countryes(file:CsvReaderType) -> None:
    raw_countryes = {line[5] for line in file}
    unique_countryes : set[str] = set()
    for country in raw_countryes:
        if ',' in country:
            countryes = country.split(',')
            for country in countryes:
                unique_countryes.add(country.strip())
        else:
            unique_countryes.add(country)
    unique_countryes.remove('')
    print('Los paises son:', unique_countryes, sep='\n')

def main():
    with open('netflix_titles.csv', mode='r', encoding='utf-8') as csv_file:
        reader = csv.reader(csv_file)
        # show_types = show_types_from_country(reader,'Argentina')
        # print_unique_countryes(reader)
        reader.dialect

    pass

if __name__ == '__main__':
    main()