# Temas: memoria, puntero, lista

- [Memoria](#memoria)
- [Puntero](#puntero)
  - [Operaciones](#operaciones)
  - [Dispose vs nil](#dispose-vs-nil)
  - [Comparacion](#comparacion)
- [Lista](#lista)
  - [Acceso](#acceso)
  - [Carga](#carga)
    - [Metodos de carga](#metodos-de-carga)
  - [Busqueda](#busqueda)
  - [Eliminacion](#eliminacion)

## Memoria

La memoria (hablando de variables) es donde se almacenan los datos del programa con los cuales hacer operaciones y demas

Hay dos tipos:

- Estatica

Es la memoria que se reserva al momento de la compilacion del programa ya que se conoce el espacio van a ocupar las variables locales y globales del programa antes de la ejecucion del programa

- Dinamica

Es la memoria que se va reservando y liberando a medida que el programa la necesita para tener nuevas variables a la hora de la ejecucion del programa


&nbsp;  
&nbsp;


## Puntero

Es un tipo de variable usada para almacenar una dirección en memoria. En esa dirección de memoria se encuentra el valor que puede ser de cualquiera de los tipos vistos.

Un puntero es un dato de tipo simple.

Declaracion

```pas
type
    nombreTipoPuntero = ^tipoApuntado;
```

### Operaciones

```pas
program puntero;
type
    tPuntero = ^tipoDatoApuntado;
var
    varPuntero: tPuntero;
    varPuntero2: tPuntero;
    dato: tipoDatoApuntado;
begin
    { creacion
      Implica reservar una dirección memoria dinámica libre para poder
      asignarle contenidos a la dirección que contiene la variable de
      tipo puntero }
    new(varPuntero);

    { eliminacion
      Implica liberar la memoria dinámica que contenía la variable de
      tipo puntero. }
    dispose(varPuntero);

    { liberacion
      Implica cortar el enlace que existe con la memoria dinámica.
      La misma queda ocupada pero ya no se puede acceder. }
    varPuntero:= nil;

    { asignacion
      Implica asignar la dirección de un puntero a otra variable puntero
      del mismo tipo. }
    varPuntero2:= varPuntero;

    { acceder
      Implica poder acceder al contenido que contiene la dirección de
      memoria que tiene una variable de tipo puntero. }
    new(varPuntero);
    varPuntero^:= dato;
end.
```

### Dispose vs nil

- `dispose(puntero)`

    Libera la conexión que existe entre la variable y la posición de memoria.

    Libera la posición de memoria.

    La memoria liberada puede utilizarse en otro momento del programa.

- `puntero := nil`

    Libera la conexión que existe entre la variable y la posición de memoria.

    La memoria sigue ocupada.

    La memoria no se puede referenciar ni utilizar.

### Comparacion

- `p = nil`

    Compara si el puntero p no tiene dirección asignada.

- `p = q`

    Compara si los punteros p y q apuntan a la misma dirección de memoria.

- `p^ = q^`

    Compara si los punteros p y q tienen el mismo contenido.


&nbsp;  
&nbsp;


## Lista

Colección de nodos, donde cada nodo contiene un elemento y en que dirección de memoria se encuentra el siguiente nodo.

Cada nodo de la lista se representa con un puntero, que apunta a un dato (elemento de la lista) y a una dirección (donde se ubica el siguiente elemento de la lista).

Toda lista tiene un nodo inicial.

Declaracion

```pas
type
    nombreTipoLista = ^nombreNodo;
    nombreNodo = record
        elem : tipoElemento;
        sig: nombreTipoLista;
    end;
```

Siempre antes de operar con una variable de lista hay que inicializarla en nil, en el caso que la primera operacion sea asignarle el valor de otro puntero no es necesario.

**IMPORTANTE:** antes de acceder a un nodo de la lista se tiene que validar que la direccion sea una valida.

### Acceso

```pas
{ Acceso al elemento del nodo }
variableLista^.elem

{ Acceso al siguiente nodo }
variableLista^.sig
```

### Carga

Normalmente la carga se realiza con un while dado que el uso comun de las listas es cuando se desconoce la cantidad de elementos por ende el while puede verificar una condicion de carga

```pas
type
    tElemento = record
        { ... }
    end;
    tLista = ^tNodo;
    tNodo = record
        elem: tElemento;
        sig: tLista;
    end;

procedure cargarLista(var lista: tLista);
var
    leido: tElemento;
begin
    leerElemento(leido);
    while (leido.campoCorte <> VALOR_CORTE) do
        metodoCarga(lista, { otros argumentos, } leido);
        leerElemento(leido);
    end;
end;
```

#### Metodos de carga

```pas
{ Agregar al inicio }
procedure agregarAdelante(var lInicio: tLista; elemento: tElemento);
var
    lNueva: tLista;
begin
    new(lNueva);
    nue^.elem := elemento;
    nue^.sig := lInicio;
    lInicio:= lNueva;
end;

{ Agregar al final }
procedure agregarAtras(var lInicio, lFinal: tLista; elemento: tElemento);
var
    lNueva: tLista;
begin
    new(lNueva);
    nue^.elem := elemento;
    nue^.sig := nil;
    if (lInicio = nil) then
        lInicio := lNueva;
    else
        lFinal^.sig := lNueva;
    lFinal := lNueva;
end;

{ Insertar ordenado }
procedure insertarOrdenado(var lista: tLista; elemento: tElemento);
var
    lNueva, lActual, lAnterior: tLista;
begin
    new(lNueva);
    nue^.elem := elemento;
    lActual := lista;
    lAnterior := lista;
    while (
        (lActual <> nil) and
        (elemento.campoOrden > lActual^.elem.campoOrden)
    ) do begin
        lAnterior := lActual;
        lActual:= lActual^.sig;
    end;
    if (lActual = lAnterior) then
        lista := lNueva
    else
        lAnterior^.sig := lNueva;
    lNueva^.sig := lActual;
end;
```

### Busqueda

```pas
function buscar(lista: tLista; valorBuscado: tipo): boolean;
begin
    while (
        (lista <> nil) and
        (lista^.elem.campoValor <> valorBuscado)
    ) do
        lista := lista^.sig;
    buscar := lista <> nil;
end;
```

### Eliminacion

```pas
procedure eliminar(var lista: tLista; valorAEliminar: tipo);
var
    lActual, lAnterior: tLista;
begin
    lActual := lista;
    lAnterior := lista;
    while (
        (lActual <> nil) and
        (lActual^.elem.campoValor <> valorEliminar)
    ) do begin
        lAnterior := lActual;
        lActual:= lActual^.sig;
    end;
    if (lActual <> nil) then begin
        if (lActual = lista) then
            lista := lActual^.sig
        else
            lAnterior^.sig := lActual^.sig;
        dispose(lActual);
    end;
end;
```
