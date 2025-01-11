# Temas: variables, cosas basicas y estructuras de control

- [Datos](#datos)
- [Variables](#variables)
- [Estructura de un programa](#estructura-de-un-programa)
- [Intrucciones basicas / operaciones](#intrucciones-basicas--operaciones)
- [Estructuras de control](#estructuras-de-control)
- [Maximo y minimo](#maximo-y-minimo)
- [Tipos](#tipos)
  - [Estructura del programa con tipos](#estructura-del-programa-con-tipos)
  - [Rangos](#rangos)
  - [Alias](#alias)

## Datos

Es una clase de objetos de datos ligados a un conjunto de operaciones para crearlos y manipularlos

- Simples

  Aquellos que toman un único valor, en un momento determinado, de todos los permitidos para ese tipo.

  - Nativos

    Son provistos por el lenguaje y tanto la representación como sus operaciones y valores son reservadas al mismo

  - Programador

    Permiten definir nuevos tipos de datos a partir de los tipos simples.

- Compuestos

  Pueden tomar varios valores a la vez que guardan alguna relación lógica entre ellos, bajo un único nombre.

Algunos datos simples son:

- boolean
- integer
- real
- char


&nbsp;  
&nbsp;


## Variables

Son referencias a zonas de memoria que contienen algun dato.

Existen dos tipos

- Variables

    La dirección inicial de esta zona se asocia con el nombre de la variable en su declaracion.

    Puede cambiar su valor durante el programa.

- Constante

    La dirección inicial de esta zona se asocia con el nombre de la constante en su declaracion.

    NO puede cambiar su valor durante el programa.


&nbsp;  
&nbsp;


## Estructura de un programa

```pas
program nombreDelPrograma;

const
    {constantes del programa}

var
    {variables del programa}
begin
    {cuerpo del programa}
end.
```


&nbsp;  
&nbsp;


## Intrucciones basicas / operaciones

- ### :=

    Asigna un valor a una variables, el valor debe ser una expresion que al resolverse, el tipo resultante sea el mismo que el de la variable.

    ```pas
    diasParaElParcial := 2*7 - 8;
    ```

- ### read / readln

    Leen desde la terminal el texto ingresado y lo guardan en una variable si el valor ingresado representa el tipo de dato de la variable, de lo contrario se genera un error de ejecucion.

    > Preferencia readln

    ```pas
    readln(diasParaElParcial);
    ```

- ### write / writeln

    Escribe en la terminal un valor o secuencia de valores. La diferencia entre write y writeln

    ```pas
    writeln('Los dias para rendir que quedan son: ', diasParaElParcial);
    ```


&nbsp;  
&nbsp;


## Estructuras de control

- ### if

    La sentencia `if` permite ejecutar un segmento de codigo condicionalmente.

    ```pas
    if (estudieMucho) then
        writeln('Puede ser que apruebe');
    ```

    Como bien permite ejecutar codigo si su condicion es verdadera tambien puede hacerlo si no se cumple.

    ```pas
    if (estudieMucho) then
        writeln('Puede ser que apruebe')
    else
        writeln('Seguro la quedo');
    ```

    Como lo que se ejecuta es un segmento de codigo se pueden hacer condiciones compuestas

    ```pas
    if (nota = 10) then
        writeln('Soy buenisimo')
    else if (nota > 4) then
        writeln('Por lo menos aprobe')
    else
        writeln('Se pico en el mal sentido');
    ```

- ### for

    La sentencia `for` permite ejecutar un segmento de codigo una determinada cantidad de veces.

    ```pas
    for clase := 1 to CANT_CLASES do begin
        write('Cuanto sabes de la clase ', clase);
        readln(conocimiento);
        if (conocimiento < 5) then
            writeln('Complicado el asunto')
        else
            writeln('Tamo chelo');
    end;
    ```

    La cantidad de veces que se ejecute un for esta de veces que se ejecute el codigo esta determinado por el rango definido en `variable:= valorInicial to/downto valorFinal`

    Por cada iteracion la `variable` toma el valor correspondiente a la iteracion el cual puede ser usado en lo que se necesite al representar la iteracion actual.

- ### while

    La sentencia `while` permite ejecutar un segmento de codigo siempre y cuando la condicion sea verdadera.

    ```pas
    write('Estudiaste (si/no): '); readln(estado);
    while (estado = 'no') do begin
        writeln('Dale ponele onda');
        writeln();
        write('Estudiaste: '); readln(estado);
    end;
    ```

- ### repeat ... until

    La sentencia `repeat ... until` permite ejecutar un segmento de codigo hasta que la condicion se cumpla

    ```pas
    repeat
        write('Estudiaste (si/no): '); readln(estado);
        if (estado = "no") then
            writeln('Dale ponele onda');
        writeln();
    until (estado = 'si');
    ```

- ### case

    La sentencia case nos permite matchear ciertos valores para que se ejecute codigo relaionado al valor.

    > Los valores a comparar en el case deben ser ordinales y los casos posibles deben ser disjuntos

    ```pas
    case contador of
        1: writeln('Valor pequeño');
        2..5: begin
            writeln('Un valor significativo');
            writeln('Ingrese otro: ');
            readln(contador);
        end;
        else
            writeln('Valor muy alto');
    end;
    ```


&nbsp;  
&nbsp;


## Maximo y minimo

Para almacenar un dato ya sea por minimo o maximo sobre un anterior solo hay que validar si se cumple la condicion y actulizar segun corresponda.

```pas
maximo := valorInicial;
read(valor);
if (valor > maximo) then
    maximo := valor;

minimo := valorInicial;
read(valor);
if (valor < minimo) then
    minimo := valor;
```

Si se quiere obtener un dato asociado a un maximo/minimo solo hay que almacenarlo al momento que se conoce el maximo/minimo.

```pas
id := 0;
maximo := valorInicial;

for i := 10 downto 1 do begin
    readln(valor);
    if (valor > maximo) then begin
        maximo := valor;
        id := i;
    end;
end;
```

Para tener varios maximos/minimos solo respecta actualizar adecuadamente varias variables.

```pas
nomMin1 := '';
nomMin2 := '';
cantMin1 := valorInicial;
cantMin2 := valorInicial;

readln(nombre)
while (nombre <> '') do begin
    readln(cantidad);
    if (cantidad < cantMin1) do begin
        cantMin2 := cantMin1;
        nomMin2 := nomMin1;
        cantMin1 := cantidad;
        nomMin1 := nombre;
    end
    else if (cantidad < cantMin2) do begin
        cantMin2 := cantidad;
        nomMin2 := nombre;
    end;
    readln(nombre);
end;
```


&nbsp;  
&nbsp;


## Tipos

La seccion de tipos es donde se pueden definir nuevos tipos de datos para usar en el programa.

Los tipos de datos pueden aportar mayor legibilidad, flexibilidad y mejor capacidad de modelizacion.

### Estructura del programa con tipos

```pas
program nombreDelPrograma;

const
    {constantes del programa}

type
    {tipos del programa}

var
    {variables del programa}
begin
    {cuerpo del programa}
end.
```

### Rangos

Es un tipo ordinal que consiste de una sucesión de valores de un tipo ordinal (predefinido o definido por el usuario) tomado como base.

```pas
type
    mayusculas = 'A'..'Z';
    primer_decena = 1..10;
    caracDigitos = '0'..'9';
```

> No los recomiendo, es mas el trabajo de usarlos que los beneficios

### Alias

Es un tipo de dato que hace referencia a otro, de manera que lo unico que cambia es bajo que nombre se esta diciendo que es de tal tipo de dato.

```pas
type
    texto = string;
    puntaje = integer;
    mejoresPuntajes = puntaje;
```

> No los recomiendo aunque puedan aportar legibilidad al codigo
