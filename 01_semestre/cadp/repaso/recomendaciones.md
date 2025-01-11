# Recomendaciones

- [Estilo del codigo](#estilo-del-codigo)
  - [Identacion](#identacion)
  - [Constantes](#constantes)
  - [Variables](#variables)
  - [Bloque de codigo](#bloque-de-codigo)
  - [Modulos](#modulos)
- [Buenas practicas](#buenas-practicas)
  - [Repeticion](#repeticion)
  - [Nombramiento](#nombramiento)
  - [Modulos](#modulos-1)
  - [Comentarios](#comentarios)
- [Otros](#otros)

## Estilo del codigo

### Identacion

Tamaño de 2 o 4 espacios

Por cada definicion de bloque de codigo y/o sentencia de control se debe identar un nivel

### Constantes

UpperCase:

- ESTO_ES_UNA_CONSTANTE
- estoNoLoEs, tAMpoCoEsTO, estotampoco

### Variables

camelCase:

- estoSiEsUnaVariable
- EStono, EstoTAMPOCO, niesto

### Bloque de codigo

El begin en la misma linea y el end respeta la identacion de esta, lo que se comprenda un nivel mas de identacion

> Si el bloque de codigo es antecedido por una estructura de control y el bloque solo tiene una condicion, no es necesario declarar `begin instruccion end;` al ser una unica instruccion no hace falta denotar un segmento.

```pas
if (condicion) then begin
    {
    ...
    }
end;

{ esto no es legible }
if (condicion) then
begin
    {
    ...
    }
end;

{ esto agrega una linea extra }
if (condicion) then
begin
    {
    ...
    }
end;

{ esto agrega una linea extra, y una identacion extra}
if (condicion) then
    begin
        {
        ...
        }
    end;


{ con else }
if (condicion) then begin
    {
    ...
    }
end
else begin
    {
    ...
    }
end;


{ con else if }
if (condicion) then begin
    {
    ...
    }
end
else if (condicion2) then begin
    {
    ...
    }
end;
```

Esto aplica para cualquier estructura de control.

Cuando se delcara el bloque de codigo del programa principal o funcion:

```pas
program ejemplo;

function unaFuncion():integer;
var
    {variables locales al modulo si tiene}
begin
    {
    ...
    }
end;

var
    {variables del programa}
begin
    {codigo del programa}
end.
```

### Modulos

Para funciones y procedimientos:

- Nombre del modulo en camelCase
- Nombre de argumentos en camelCase
- Argumentos de diferentes tipos un espacio despues del `;`
- Argumentos de igual tipo un espacio despues de la `,`
- Si no tiene argumentos igual se declara con parentesis sin argumentos.
- Aunque no tengan argumentos igual se los llama con parentesis.


```pas
function soyUnEjemplo(arg1: integer; argImportante: boolean): boolean;
begin
    { ... }
end;

procedure soyOtroEjemplo(nombreNuevo: integer; esValido: boolean);
begin
    { ... }
end;
```

Hablando especificamente de las funciones el valor con el que retorna tiene que estar asignado unicamente en los puntos donde termine la ejecucion de la funcion.

```pas
function validarUsuario(nombre: string; posicion: integer): boolean;
var
    estado : boolean;
begin
    {
    ...
    }
    validarUsuario := estado;
end;

{ esto esta mal, no queda claro donde finaliza }
function validarUsuario(nombre: string; posicion: integer): boolean;
var
    estado : boolean;
begin
    validarUsuario := false
    {
    ...
    }
    validarUsuario := estado;
    {
    ...
    }
    validarUsuario := estado;
end;
```

&nbsp;  
&nbsp;


## Buenas practicas

### Repeticion

Si una valor aparece en diferentes partes del codigo y/o representa algo especial es bueno tenerlo en una constante.

Si un segmento de codigo/tarea se repite en muchos lugares puede ser extraida a un modulo y usar el llamado a este para realizarla.

### Nombramiento

El nombramiento de constantes/tipos/variables/modulos debe ser representativo.

```pas
var
{ que simboliza x, no queda claro }
    x: integer;

{ que representa? }
    cantidad: integer;

{ se entiende que representa }
    cantidadColores: integer;
    cantColores: integer;
    cColores: integer;

{ hay informacion adicional que ensi a la variable no le respecta saber ensi }
    cantidadDeColoresIngresadaPorElUsuario: integer;
```

No soy muy partidario de esto pero los tipos de datos definidos pueden ser antecedidos por una t

```pas
type
    tNumeros = 1..10;
    tBolsa = record
        cantCosas : integer;
        cantMax : integer;
        precio: real;
    end;
    tTiempos = array[1..CANT_TIEMPOS] of real;
```

### Modulos

Si una variable solo se utiliza en el modulo esta debe ser local, el resto del codigo no debe conocerla.

### Comentarios

Si el comentario dice lo mismo que leer el codigo que esta por debajo y/o encima de el es inecesario.

Es mejor tratar que el codigo se comente por si solo (con nombres mas claros).


&nbsp;  
&nbsp;


## Otros

El programa principal no tiene que tener todo el codigo del programa.

No estoy a favor de la declaracion de rangos.

No estoy a favor del read(), mejor readln().
