from ejer10 import process_file, sep_name, sep_nota

nombres = (
    process_file('nombres_1.txt',sep_name),
    process_file('nombres_2.txt',sep_name)
)

nombres_compartidos = {nom1 for nom1 in nombres[0] if nom1 in nombres[1]}

print('Los nombres que se encuentran en ambas listas son:', *nombres_compartidos, sep='\n  ', end='\n\n')

notas1 = process_file('eval1.txt',sep_nota)
notas2 = process_file('eval2.txt',sep_nota)

print('     {:<16} {:>8} {:>8} {:>8}'.format('Nombre','Eval1','Eval2','Total'))

for i, val in enumerate(zip(nombres[0], notas1, notas2)):
    name, nota1, nota2 = val
    print ('  {:>2} {:<15} {:>8} {:>8} {:>8}'.format(i, name, nota1, nota2, nota1 + nota2))
