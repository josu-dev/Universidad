evaluar = """ título: Experiences in Developing a Distributed Agent-based Modeling Toolkit with Python
resumen: Distributed agent-based modeling (ABM) on high-performance computing resources provides the promise of capturing unprecedented details of large-scale complex systems. However, the specialized knowledge required for developing such ABMs creates barriers to wider adoption and utilization. Here we present our experiences in developing an initial implementation of Repast4Py, a Python-based distributed ABM toolkit. We build on our experiences in developing ABM toolkits, including Repast for High Performance Computing (Repast HPC), to identify the key elements of a useful distributed ABM toolkit. We leverage the Numba, NumPy, and PyTorch packages and the Python C-API to create a scalable modeling system that can exploit the largest HPC resources and emerging computing architectures.
"""

tipos_titulo = { 
    True: 'titulo esta ok',
    False: 'titulo no esta ok'
}
tipos_oraciones = (
    { 
        'max'  : 12,
        'cant' : 0,
        'desc' : 'facil de leer'
    },
    { 
        'max'  : 17,
        'cant' : 0,
        'desc' : 'aceptable de leer'
    },
    { 
        'max'  : 25,
        'cant' : 0,
        'desc' : 'dificil de leer'
    },
    { 
        'max'  : 999,
        'cant' : 0,
        'desc' : 'muy dificil de leer'
    }
)

estado_input = { 
    'titulo'  : '',
    'resumen' : tipos_oraciones
}


secciones = evaluar.rstrip().lstrip().split('\n')

match secciones:
    case [titulo, resumen]:
        if (titulo.startswith('título:')):
            contenido = titulo[7:].lstrip().split()
            estado_input['titulo'] = tipos_titulo[len(contenido)<=10]
        else:
            print('La primera seccion no contiene \'titulo:\'')
        
        if (resumen.startswith('resumen:')):
            contenido = resumen[8:].lstrip()
            if contenido.endswith('.'):
                contenido = contenido[:-1]
            lines = contenido.split('.')
            for line in lines:
                words = line.split()
                for tipo in estado_input['resumen']:
                    if len(words) <= tipo['max']:
                        tipo['cant'] += 1
                        break
        else:
            print('La segunda seccion no contiene \'resumen:\'')
    case _:
        print('No se ingreso un texto con seccion de titulo y resumen')

print(estado_input['titulo'])
s = ''
for tipo in estado_input['resumen']:
    s += tipo['desc'] + ': ' + str(tipo['cant']) + ', '
s = s[:-2]
print('Cantidad: ' + s)