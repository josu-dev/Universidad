from typing import Counter


string_ingresada = input('Ingrese una palabra o frase: ')

string_lower = string_ingresada.lower()

letras = filter(lambda letter: letter.isalpha(), string_lower)

acumuladas = Counter(letras).most_common()

es_heterograma = True

for cant in acumuladas:
    if cant[1]>1:
        es_heterograma = False
        break
print(f'{es_heterograma = }')