# Temas: modulos y alcanze

- [Modulo](#modulo)
  - [Estructura del programa](#estructura-del-programa)
  - [Parametros](#parametros)
  - [Variables locales](#variables-locales)
  - [Funciones](#funciones)
  - [Procedimientos](#procedimientos)
- [Alcance](#alcance)

## Modulo

Tarea específica bien definida se comunican entre sí adecuadamente y cooperan para conseguir un objetivo común.

Encapsula acciones tareas o funciones.

En ellos se pueden representar los objetivos relevantes del problema a resolver.

### Estructura del programa

```pas
program nombreDelPrograma;

const
    {constantes del programa}

type
    {tipos del programa}

{declaracion de los procedimientos / funciones}
function nombreDeLaFuncion(argumentos): tipoDatoRetorno;
var
    {variables locales a la funcion}
begin
    {cuerpo de la funcion}
end;

procedure nombreDelProcedimiento(argumentos);
var
    {variables locales al procedimiento}
begin
    {cuerpo del procedimiento}
end;

var
    {variables del programa}
begin
    {cuerpo del programa}
end.
```

### Parametros

Los datos compartidos se deben especificar como parámetros que se trasmiten entre módulos.

Dos tipos:

- #### Valor

    Un dato de entrada por valor es llamado parámetro IN y significa que el módulo recibe (sobre una variable local) un valor proveniente de otro módulo (o del programa principal).

    Con él puede realizar operaciones y/o cálculos, pero no producirá ningún cambio ni tampoco tendrá incidencia fuera del módulo.

    ```pas
    function maximo(num1, num2: integer):integer;
    begin
        if (num1 > num2) then
            maximo:= num1
        else
            maximo:= num2;
    end;
    ```


- #### Referencia

    La comunicación por referencia (OUT, INOUT) significa que el módulo recibe el nombre de una variable (referencia a una dirección) conocida en otros módulos del sistema.

    Puede operar con ella y su valor original dentro del módulo, y las modificaciones que se produzcan se reflejan en los demás módulos que conocen la variable.

    ```pas
    procedure contarDigParImp(num: integer; var nPar, nImp: integer):integer;
    begin
        nPar:= 0;
        nImp:= 0;
        repeat
            if ((num mod 10) mod 2 = 0) then
                nPar:= nPar +1
            else
                nImp:= nImp +1;
            num:= num div 10;
        until (num = 0);
    end;
    ```

El número y tipo de los argumentos utilizados en la invocación a un módulo deben coincidir con el número y tipo de parámetros del encabezamiento del módulo.

Un parámetro por valor debiera ser tratado como una variable de la cuál el módulo hace una copia y la utiliza localmente.

### Variables locales

Las variables declaradas dentro de un modulo son solo conocidas por el cuerpo del modulo. Si estan declaradas al inicio de la declaracion del modulo actuan como variables globales al resto de la definicion del modulo.

```pas
program ejemplo;
procedure prueba();
    var
        {global al modulo prueba}
    procedure auxiliar();
        var
            {local al modulo auxiliar}
        begin
            x:= 4;
        end;
    var
        {local al modulo prueba}
    begin
        x:= 5;
    end;

begin
    prueba();
end.
```

### Funciones

Como las funciones solo deben devolver un unico valor:

- Solo corresponde usar parametros por valor

- Solo pueden devolver datos simples

Las funciones son utiles para:

- Validaciones

- Operaciones de calculo

- Operaciones de analizis con un unico resultado

- Tareas simples

### Procedimientos

Los procedimientos son para las tareas que deben devolver mas de un valor y/o hacer tareas que no requieren devolver un valor.

Por lo general son tareas de carga, procesamiento y analizis profundo de datos.


&nbsp;  
&nbsp;


## Alcance

El alcance esta dado por donde se encuentra las variables declaradas respecto al resto del codigo.

Para que una variable pueda ser accesible desde cierto punto, esta debe estar declarada por encima de donde se quiere usar. Ahora bien si se declara el mismo nombre se va a acceder a lo que se encuentre primero.

El orden de importancia es

Local al modulo, parametros, global al modulo, global al programa.

Las variables del programa son solo accesibles al programa principal

**Importante** : las variables globales no van a ser usadas. La declaracion de procedimientos dentro de otros tampoco.
