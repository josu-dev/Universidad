text = '''The constants defined in this module are:The constants defined in␣
↪→this module are:
string.ascii_letters
The concatenation of the ascii_lowercase and ascii_uppercase constants␣
↪→described below. This value is not locale-dependent.
string.ascii_lowercase
The lowercase letters 'abcdefghijklmnopqrstuvwxyz'. This value is not␣
↪→locale-dependent and will not change.
string.ascii_uppercase
The uppercase letters 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'. This value is not␣
↪→locale-dependent and will not change.
'''

words_lowercase = text.split()

letter = ''

while True:
    letter = input('Ingrese una letra: ')
    if not letter.isalpha():
        print('Lo ingresado no es una letra')
    elif len(letter) != 1:
        print('Se pidio una sola letra')
    else:
        break

words_with_letter = list(filter(lambda word: word[0] == letter, words_lowercase))

print(f'Las palabras que empiezan con {letter} son:', *words_with_letter, sep=' ')
