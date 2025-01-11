def process_file(name,func):
    result = []
    with open(name,mode='rt',encoding='utf-8') as file:
        s_txt = ''.join(file.readlines())
        result = func(s_txt)
    return result

def sep_name(s):
    s = s.lstrip().rstrip()
    s = s.replace('\'','').replace(',','').split('\n')
    s = list(map(lambda s : s.lstrip(), s))
    return s
def sep_nota(s):
    s = s.replace('\n',' ').replace(',',' ').split()
    s = list(map(lambda s : int(s), s))
    return s

def main():
    nombres = process_file('nombres_1.txt', sep_name)
    notas = (
        process_file('eval1.txt', sep_nota),
        process_file('eval2.txt', sep_nota)
    )
    
    estudiantes = {name : nota1+nota2 for name,nota1,nota2 in zip(nombres,notas[0],notas[1])}
    
    promedio = 0
    for val in estudiantes.values():
        promedio += val
    promedio /= len(estudiantes)
    
    for key,value in estudiantes.items():
        if value < promedio:
            print(f'El alumno {key} tiene menos nota que el promedio')


if __name__ == "__main__":
    main()
