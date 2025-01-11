from typing import Counter

frase = 'hola, como estas?, hola todo bien tambien por cierto hola pedro'

palabra = input('Ingrese una palabra: ')

resultado = Counter(filter(lambda word : palabra in word,frase.split()))

print(sum(resultado.values()))