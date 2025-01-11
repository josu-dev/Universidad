value_table = {
    'AEIOULNRST' :  1,
    'DG'         :  2,
    'BCMP'       :  3,
    'FHVWY'      :  4,
    'K'          :  5,
    'JK'         :  8,
    'QZ'         : 10
}

palabra = input('Ingrese una palabra: ')

total = 0

for letter in palabra.upper():
    for possible,value in value_table.items():
        if letter in possible:
            total += value
            break

print(f'Para la palabra \'{palabra}\' su puntaje es: {total}')