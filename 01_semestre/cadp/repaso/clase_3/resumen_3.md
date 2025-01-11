# Temas: estructuras de datos, registro

- [Estructuras de datos](#estructuras-de-datos)
  - [Elementos](#elementos)
  - [Acceso](#acceso)
  - [Tamaño](#tamaño)
  - [Linealidad](#linealidad)
- [Registro](#registro)
  - [Acceso](#acceso-1)
  - [Comparacion](#comparacion)

## Estructuras de datos

Permite al programador definir un tipo al que se asocian diferentes datos que tienen valores lógicamente relacionados y asociados bajo un nombre único.

| Caracteristica | Tipos |
| - | - |
| [Elementos](#elementos) | Homogenea - Heterogenea |
| [Acceso](#acceso) | Secuencial - Directo |
| [Tamaño](#tamaño) | Dinamica - Estatica |
| [Linealidad](#linealidad) | Lineal - No Lineal |

### Elementos

Depende si los elementos son del mismo tipo o no.

- Homogenea

    Los elementos que la componen son del mismo tipo


- Heterogenea

    Los elementos que la componen pueden ser de distinto tipo

### Acceso

Hace referencia a como se pueden acceder a los elementos que la componen.

- Secuencial

    Para acceder a un elemento particular se debe respetar un orden predeterminado, por ejemplo, pasando por todos los elementos que le preceden, por ese orden.

- Directo

    Se puede acceder a un elemento particular, directamente, sin necesidad de pasar por los anteriores a él, por ejemplo, referenciando una posición.

### Tamaño

Hace referencia a si la estructura puede variar su tamaño durante la ejecución del programa.

- Estatica

    El tamaño de la estructura no varía durante la ejecución del programa

- Dinamica

    El tamaño de la estructura puede variar durante la ejecución del programa

### Linealidad

Hace referencia a como se encuentran almacenados los elementos que la componen.

- Lineal

    Está formada por ninguno, uno o varios  elementos que guardan una relación de adyacencia ordenada donde a cada elemento le sigue uno y le precede uno, solamente.

- No lineal

    Para un elemento dado pueden existir 0, 1 ó mas elementos que le suceden y 0, 1 ó mas elementos que le preceden.


&nbsp;  
&nbsp;


## Registro

Es uno de los tipos de datos estructurados, que permiten agrupar diferentes clases de datos en una estructura única bajo un sólo nombre

Declaracion

```pas
type
    nombreDelTipo = record
        campo1: tipo;
        campo2: tipo;
        ...
    end;
```

### Acceso

El acceso a los campos se hace a travez de la variable.nombreDelCampo

```pas
var
    inicioDelProyecto: fecha;
begin
    writeln('Datos del inicio del proyecto: ');
    write('Mes: '); readln(inicioDelProyecto.mes);
    write('Dia: '); readln(inicioDelProyecto.dia);
    write('Hora: '); readln(inicioDelProyecto.hora);

    writeln('El proyecto se incio el dia ', inicioDelProyecto.dia);
end.
```

### Comparacion

La comparacion de registros directamente solo dice si es la misma referencia.

Para comparar los contenidos debe hacerce campo por campo.

Como el registro es una agrupacion de datos, asi como se pueden acceder a sus valores tambien se pueden usar como variables a la hora de pasar parametros a un modulo.

```pas
if (validarCompra(producto, billetera.saldo)) then begin
    writeln('Se puede realizar la compra');
    {...}
end
else begin
    writeln('No se puede realizar la compra');
    {...}
end;
```
