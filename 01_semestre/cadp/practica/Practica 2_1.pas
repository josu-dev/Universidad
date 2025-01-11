{Practica 2

1. Dado el siguiente programa, indicar qué imprime.
program alcance1;
var a,b: integer;
procedure uno;
var b: integer;
begin
 b := 3;
 writeln(b);
end;
begin
 a:= 1;
 b:= 2;
 uno;
writeln(b, a);
end.

Imprime 3 2 1



2. Dado el siguiente programa, indicar qué imprime.
program alcance2;
var a,b: integer;
procedure uno;
begin
 b := 3;
 writeln(b);
end;
begin
 a:= 1;
 b:= 2;
 uno;
 writeln(b, a);
end.

Imprime 3 3 1



3. Dado el siguiente programa, indicar cuál es el error y su causa.
program alcance3;
var a: integer;
procedure uno;
var b: integer;
begin
 b:= 2;
 writeln(b);
end;
begin
 a:= 1;
 uno;
 writeln(a, b);
end.

El error es imprimir una variable que es local de un proceso en el codigo principal



4.

El de la derecha no anda porque le asigna un valor en el proceso a una variable no declarada



5. Dado el siguiente programa, indicar cuál es el error.
program alcance4;
function cuatro: integer;
begin
 cuatro:= 4;
end;
var a: integer;
begin
 cuatro;
 writeln(a);
end.

Imprime basura porque no se le asigna valor a la variable a



6. a. Realice un módulo que lea de teclado números enteros hasta que llegue un valor negativo. Al finalizar la
lectura el módulo debe imprimir en pantalla cuál fue el número par más alto.
b. Implemente un programa que invoque al módulo del inciso a.

program ejer_6;

function nparmax: integer;
	var
	n, nmax:integer;
	begin
		nmax:=-1;
		readln(n);
		while n>=0 do begin
			if (n>nmax) and (n mod 2 = 0) then
				nmax:=n;
			readln(n);
		end;
		nparmax:=nmax
	end;
begin
	writeln('Escriba numeros enteros para saber el par mayor');
	writeln(nparmax);
	readln();
end.



7. Dado el siguiente programa:
program alcanceYFunciones;
var
 suma, cant : integer;
function calcularPromedio : real
 var
 prom : real;
 begin
 if (cant <> 0) then
 prom := -1
 else
 prom := suma / cant;
 end;
begin //programa principal
 readln(suma);
 readln(cant);
 if (calcularPromedio <> -1) then begin
 cant := 0;
 writeln(‘El promedio es: ’ , calcularPromedio)
 end;
 else
 writeln(‘Dividir por cero no parece ser una buena idea’);
end.
a) La función calcularPromedio calcula y retorna el promedio entre las variables globales suma y cant, pero
parece incompleta. ¿qué debería agregarle para que funcione correctamente?
b) En el programa principal, la función calcularPromedio es invocada dos veces, pero esto podría mejorarse.
¿cómo debería modificarse el programa principal para invocar a dicha función una única vez?
c) Si se leen por teclado los valores 48 (variable suma) y 6 (variable cant), ¿qué resultado imprime el programa?
Considere las tres posibilidades:
i) El programa original
ii) El programa luego de realizar la modificación del inciso a)
iii) El programa luego de realizar las modificaciones de los incisos a) y b)

a) Falta asignarle el valor del promedio a la funcion
b) Asignarle el valor de la funcion a una variable extra que se pueda leer cuando se necesite
c) i) Da error
	ii) Imprime 'Dividir por cero no parece ser una buena idea'
	iii) Imprime 'Dividir por cero no parece ser una buena idea'
	
	

8 Dado el siguiente programa:
program anidamientos;
procedure leer;
	var
	letra : char;
	function analizarLetra : boolean
		begin
		if (letra >= ‘a’) and (letra <= ‘z’) then
		analizarLetra := true;
		else
		if (letra >= ‘A’) and (letra <= ‘Z’) then
		analizarletra := false;
		end; //fin de la funcion analizarLetra
	begin
		readln(letra);
		if (analizarLetra) then
		writeln(‘Se trata de una minúscula’)
		else
		writeln(‘Se trata de una mayúscula’);
	end; //fin del procedure leer
var
ok : boolean;
begin //programa principal
	leer;
	ok := analizarLetra;
	if ok then
	writeln('Gracias, vuelva prontosss’);
end.
a) La función analizarLetra fue declarada como un submódulo dentro del procedimiento leer. Pero esto puede
traer problemas en el código del programa principal.
i) ¿qué clase de problema encuentra?
ii) ¿cómo se puede resolver el problema para que el programa compile y funcione correctamente?
b) La función analizarLetra parece incompleta, ya que no cubre algunos valores posibles de la variable letra.
i) ¿De qué valores se trata?
ii) ¿Qué sucede en nuestro programa si se ingresa uno de estos valores?
iii) ¿Cómo se puede resolver este problema?
}
a) i) Que el submodulo no puede ser llamado por el codigo principal
	ii) Se puede solucionar poniendo la variable letra como global, y el submodulo por separado y encima del proceso leer
b) i) De los valores que no son minisculas ni mayusculas
	ii) Da error en ejecucion
	iii) Cambiando el tipo de funcion analizar letra para que comtemple los demas caracteres y adaptar el resto del codigo a este cambio
