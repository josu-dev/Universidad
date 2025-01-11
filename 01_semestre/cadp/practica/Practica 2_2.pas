{Practica 2_2

1. Dado el siguiente programa:

program Ejercicio3;
procedure suma(num1: integer;var num2:integer);
	begin
	num2 := num1 + num2;
	num1 := 0;
	writeln(num2);
	end;
var
	i, x : integer;
begin
	read(x); //leo la variable x
	for i:= 1 to 5 do
		suma(i,x);
	write(x); //imprimo las variable x
end.

a. ¿Qué imprime si se lee el valor 10 en la variable x ?
b. ¿Qué imprime si se lee el valor 10 en la variable x y se cambia el encabezado del procedure por:
procedure suma(num1: integer; num2:integer);
c. ¿Qué sucede si se cambia el encabezado del procedure por:
procedure suma(var num1: integer; var num2:integer);

a. 25
b. 10
c. No se puede porque se esta modificando el indice



2. Dado el siguiente programa:
Program ejercicio4;
procedure digParesImpares(num : integer; var par, impar : integer);
var
dig: integer;
begin
while (num <> 0) do begin
dig:= num mod 10;
if((dig mod 2)= 0) then
par := par + 1
else
impar:= impar +1;
num := num DIV 10;
end;
end;
var
dato, par, impar, total, cant : integer;
begin
par := 0;
impar := 0;
repeat
read(dato);
digParesImpares(dato,par,impar);
until (dato = 100);
writeln(‘Pares: ’,par, ‘Ímpares:’, impar);
end.
a. ¿Qué imprime si se lee la siguiente secuencia de valores? 250, 35, 100

a. Imprime pares 4 Impares 4



3. Dado el siguiente programa, encontrar los 6 errores. Utilizar los comentarios entre llaves como guía, indicar
en qué línea se encuentra cada error y en qué consiste:
1. program ejercicio5;
2. // suma los números entre a y b, y retorna el resultado en c 
3. procedure sumar(a, b, c : integer)
4. var
5. suma : integer;
6. begin
7.
8. for i := a to b do
9. suma := suma + i;
10. c := c + suma;
11. end;
12. var
13. result : integer;
14. begin
15. result := 0;
16. readln(a); readln(b);
17. sumar(a, b, 0);
18. write(‘La suma total es ‘,result);
19. // averigua si el resultado final estuvo entre 10 y 30
20. ok := (result >= 10) or (result <= 30);
21. if (not ok) then
22. write (‘La suma no quedó entre 10 y 30’);
23. end.

Linea 3 c tubiera que ser por referencia
Linea 9 no se incializo suma
Linea 8 no se declaro i
Linea 10 no hace falta sumar c
Linea 17 la tercer variable de sumar tiene que ser result
Linea 20 no se declaro ok



4. El siguiente programa intenta resolver un enunciado. Sin embargo, el código posee 5 errores. Indicar en
qué línea se encuentra cada error y en qué consiste el error.
Enunciado: Realice un programa que lea datos de 130 programadores Java de una empresa. De cada
programador se lee el número de legajo y el salario actual. El programa debe imprimir el total del dinero
destinado por mes al pago de salarios, y el salario del empleado mayor legajo.

1. program programadores;
2. procedure leerDatos(var legajo: integer; salario : real);
	3. begin
	4. writeln(‘Ingrese el nro de legajo y el salario”);
	5. read(legajo);
	6. read(salario);
	7. end;
8. procedure actualizarMaximo(nuevoLegajo:integer; nuevoSalario:real; var maxLegajo:integer);
	9. var
	10. maxSalario : real;
	11. begin
	12. if (nuevoLegajo > maxLegajo) then begin
	13. maxLegajo:= nuevoLegajo;
	14. maxSalario := nuevoSalario
	15. end;
	16. end;
17. var
18. legajo, maxLegajo, i : integer;
19. salario, maxSalario : real;
20. begin
	21. sumaSalarios := 0;
	22. for i := 1 to 130 do begin
	23. leerDatos(salario, legajo);
	24. actualizarMaximo(legajo, salario, maxLegajo);
	25. sumaSalarios := sumaSalarios + salario;
	26. end;
	27. writeln(‘En todo el mes se gastan ‘, sumaSalarios, ‘ pesos’);
	28. writeln(‘El salario del empleado más nuevo es ‘,maxSalario);
29. end.

Linea 2 el parametro salario no es por referencia
Linea 8 no se usa parametro para maxSalario
Linea 10 se declara maxSalario que ya habia sido declarada
Linea 23 el orden de los parametros esta al revez
Linea 24 no se introduce el parametro de maxSalario
Linea 25 sumaSalarios no esta declarada



5. a. Realizar un módulo que reciba un par de números (numA,numB) y retorne si numB es el doble de numA.
b. Utilizando el módulo realizado en el inciso a., realizar un programa que lea secuencias de pares de
números hasta encontrar el par (0,0), e informe la cantidad total de pares de números leídos y la cantidad de
pares en las que numB es el doble de numA.
Ejemplo: si se lee la siguiente secuencia: (1,2) (3,4) (9,3) (7,14) (0,0) el programa debe informar los valores
4 (cantidad de pares leídos) y 2 (cantidad de pares en los que numB es el doble de numA).

a.
function paresdoble(numa,numb: integer):boolean;
	begin
		if (numa*2)=numb then
			paresdoble:= true
		else
			paresdoble:=false;
	end;
b.
program parnumeros;

function paresdoble(numa,numb: integer):boolean;
	begin
		if (numa*2)=numb then
			paresdoble:= true
		else
			paresdoble:=false;
	end;
var
cantpares,cantdobles,numa,numb : integer;

begin
	cantpares:=0;
	cantdobles:=0;
	writeln('Ingrese pares de numeros');
	readln(numa);readln(numb);
	while not((numa=0)and(numb=0)) do begin
		cantpares:= cantpares +1;
		if (paresdoble(numa,numb))=true then
			cantdobles:= cantdobles +1;
		readln(numa);readln(numb);
	end;
	writeln('Se leyeron ',cantpares,' pares de numeros y ',cantdobles,' son los pares donde el segundo numero es el doble del primero');
	readln()
end.



8. Realizar un programa modularizado que lea datos de 100 productos de una tienda de ropa. Para cada
producto debe leer el precio, código y tipo (pantalón, remera, camisa, medias, campera, etc.). Informar:
● Código de los dos productos más baratos.
● Código del producto de tipo “pantalón” más caro.
● Precio promedio.

program ejer_8;
const
producto='pantalon';
procedure leer(var codigo: integer; var precio: real; var tipo:string);
	begin
		readln(codigo);
		readln(precio);
		readln(tipo);
	end;
procedure masbaratos(codigo:integer; precio:real; var cmbarato1,cmbarato2: integer; var pmbarato1,pmbarato2: real);
	begin
		if precio<pmbarato1 then begin
			pmbarato2:= pmbarato1;
			pmbarato1:= precio;
			cmbarato2:= cmbarato1;
			cmbarato1:= codigo;
		end
		else if precio<pmbarato2 then begin
			pmbarato2:= precio;
			cmbarato2:= codigo;
		end;
	end;
procedure pantcaro(codigo:integer; precio:real; var cpmcaro:integer; var ppmcaro:real);
	begin
		if precio>ppmcaro then begin
			ppmcaro:= precio;
			cpmcaro:= codigo;
		end;
	end;
function sumap(precio,sumatotal: real):real;
	begin
		sumap:= sumatotal + precio;
	end;

var
i,codigo,cmbarato1,cmbarato2,cpmcaro: integer;
precio,pmbarato1,pmbarato2,ppmcaro,sumatotal: real;
tipo: string;

begin
	cmbarato1:=0;
	pmbarato1:=90000;
	pmbarato2:=90000;
	ppmcaro:=0;
	sumatotal:=0;
	writeln('ingrese el codigo, precio y tipo de producto');
	for i:=1 to 5 do begin
		leer(codigo,precio,tipo);
		masbaratos(codigo,precio,cmbarato1,cmbarato2,pmbarato1,pmbarato2);
		if tipo=producto then
			pantcaro(codigo,precio,cpmcaro,ppmcaro);
		sumatotal:= sumap(precio,sumatotal);
	end;
	writeln('Los codigos de los dos productos mas baratos son: ',cmbarato1,' y ',cmbarato2);
	writeln('El codigo del pantalon mas caro es: ',cpmcaro);
	writeln('El precio promedio de los productos es: $', (sumatotal/100):8:2);
end.



9. a. Realizar un módulo que reciba como parámetro un número entero y retorne la cantidad de dígitos que
posee y la suma de los mismos.
b. Utilizando el módulo anterior, realizar un programa que lea una secuencia de números e imprima la
cantidad total de dígitos leídos. La lectura finaliza al leer un número cuyos dígitos suman exactamente 10, el
cual debe procesarse.

a.
procedure digitalizador(num :integer; var cantdig, sumdig:integer);
	var
	dig: integer;
	begin
		cantdig:=0;
		sumdig:=0;
		while num<>0 then begin
			dig:= num mod 10;
			sumgi:= dig + sumdig;
			cantdig:= cantdig + 1;
			num:= num div 10;
		end;
	end;
b.
program ejer_9b;

procedure digitalizador(num :integer; var cantdig, sumdig:integer);
	var
	dig: integer;
	begin
		cantdig:=0;
		sumdig:=0;
		while num<>0 do begin
			dig:= num mod 10;
			sumdig:= dig + sumdig;
			cantdig:= cantdig + 1;
			num:= num div 10;
		end;
	end;

var
num,cantdig, cantdigtotal,sumdig: integer;

begin
	cantdigtotal:=0;
	writeln('Ingrese numeros enteros');
	repeat
		readln(num);
		digitalizador(num,cantdig,sumdig);
		cantdigtotal:= cantdigtotal + cantdig;
	until sumdig=10;
	writeln('Se an leido un total de: ',cantdigtotal,' digitos.');
	readln();
end.



10. Realizar un programa modularizado que lea secuencia de números enteros. La lectura finaliza cuando llega
el número 123456, el cual no debe procesarse. Informar en pantalla para cada número la suma de sus dígitos
pares y la cantidad de dígitos impares que posee.

program ejer_10;

const
numero= 12345;

procedure analdig(num: integer; var sumdigp,cantdigi: integer);
	var 
	dig:integer;
	begin
		sumdigp:=0;
		cantdigi:=0;
		while num<>0 do begin
			dig:= num mod 10;
			if (dig mod 2)=0 then
				sumdigp:= sumdigp + dig
			else 
				cantdigi:= cantdigi + 1;
			num:= num div 10;
		end;
	end;
	
var
num, sumdigp, cantdigi: integer;

begin
	writeln('Ingrese numeros enteros');
	readln(num);
	while num<>numero do begin
		analdig(num,sumdigp,cantdigi);
		writeln('La suma de los digitos pares de ',num,' es: ',sumdigp,' y la cantidad de digitos impares es: ',cantdigi);
		writeln();
		readln(num);
	end;
	readln();
end.



11. Realizar un programa modularizado que lea información de alumnos de una facultad. Para cada alumno se
lee: nro de inscripción, apellido y nombre. La lectura finaliza cuando se ingresa el alumno con nro de inscripción
1200, que debe procesarse. Se pide calcular e informar:
● Apellido de los dos alumnos con nro de inscripción más chico.
● Nombre de los dos alumnos con nro de inscripción más grande.
● Porcentaje de alumnos con nro de inscripción par

program ejer_11;

const
corte= 1200;
procedure nimc(apellido: string; ninscrip: integer; var apellido1,apellido2: string; var ninscrip1,ninscrip2: integer);
	begin
		if ninscrip<ninscrip1 then begin
			ninscrip2:= ninscrip1;
			ninscrip1:= ninscrip;
			apellido2:= apellido1;
			apellido1:= apellido;
		end
		else if ninscrip<ninscrip2 then begin
			ninscrip2:= ninscrip;
			apellido2:= apellido;
		end;
	end;
procedure nimg(nombre: string; ninscrip: integer; var nombre1,nombre2: string; var ninscrip3,ninscrip4: integer);
	begin
		if ninscrip>ninscrip3 then begin
			ninscrip4:= ninscrip3;
			ninscrip3:= ninscrip;
			nombre2:= nombre1;
			nombre1:= nombre;
		end
		else if ninscrip>ninscrip4 then begin
			ninscrip4:= ninscrip;
			nombre2:= nombre;
		end;
	end;
procedure inscrippar(ninscrip: integer; var cipar: integer);
	begin
		if (ninscrip mod 2)=0 then
			cipar:= cipar + 1;
	end;

var
ninscrip,ninscrip1, ninscrip2, ninscrip3, ninscrip4, cipar,i: integer;
apellido, apellido1, apellido2, nombre, nombre1, nombre2: string;

begin
	ninscrip1:=9999;
	ninscrip2:=9999;
	ninscrip3:=0;
	ninscrip4:=0;
	i:=0;
	writeln('Ingrese la informacion de cada alumno en el siguiente orden:');
	writeln('numero inscripcion');
	writeln('apellido/s');
	writeln('nombre/s');
	repeat
		readln(ninscrip);
		readln(apellido);
		readln(nombre);
		nimc(apellido,ninscrip,apellido1,apellido2,ninscrip1,ninscrip2);
		nimg(nombre,ninscrip,nombre1,nombre2,ninscrip3,ninscrip4);
		inscrippar(ninscrip,cipar);
		i:= i + 1;
	until ninscrip=corte;
	writeln('Los dos alumnos con numero de inscripcion mas chico son respectivamente ', apellido1,' y ', apellido2);
	writeln('Los dos alumnos con numero de inscripcion mas grande son respectivamente ', nombre1,' y ', nombre2);
	writeln('El porcentaje de alumnos con numero de inscripcion par sobre el total de inscriptos es: %',(cipar*100/i):5:2);
	readln()
	
end.



12. Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón
A$B#, donde:
	- A es una secuencia de sólo letras vocales
	- B es una secuencia de sólo caracteres alfabéticos sin letras vocales
	- los caracteres $ y # seguro existen
Nota: en caso de no cumplir, informar que parte del patrón no se cumplió.

program ejer_12;

procedure leerA(var result1:boolean);
	var
	carac: char;
	begin
		result1:= false;
		readln(carac);
		while carac<>'$' do begin
			if (carac<>'a') and (carac<>'e') and (carac<>'i') and (carac<>'o') and (carac<>'u') then 
				result1:= true;
			readln(carac)
		end;
	end;
procedure leerB(var result2:boolean);
	var
	carac: char;
	begin
		result2:= false;
		readln(carac);
		while carac<>'#' do begin
			if not(((carac>='b') and (carac<='z')) or ((carac>='B') and (carac<='Z')) and (carac<>'e') and (carac<>'i') and (carac<>'o') and (carac<>'u') and (carac<>'E') and (carac<>'I') and (carac<>'O') and (carac<>'U')) then 
				result2:= true;
			readln(carac)
		end;
	end;
	
var
result1, result2: boolean;

begin
	writeln('Ingrese caracteres');
	leerA(result1);
	leerB(result2);
	if result1=true then
		write('El patron A$B# no se cumplio en A y ')
	else write('El patron A$B# si se cumplio en A y ');
	if result2=true then
		writeln('el patron no se cumplio en B')
	else writeln('el patron  si se cumplio en B');
	readln();
end.



13. Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón
A%B*, donde:
	- A es una secuencia de caracteres en la que no existe el carácter ‘$’.
	- B es una secuencia con la misma cantidad de caracteres que aparecen en A y en la que aparece a lo sumo
	3 veces el carácter ‘@’.
	- Los caracteres % y * seguro existen
Nota: en caso de no cumplir, informar que parte del patrón no se cumplió.

program ejer_13;
const
corteA= '$';
condB= '@';
procedure leerA(var result1: boolean; var cantcaraca: integer);
	var
	carac: char;
	begin
		result1:=false;
		readln(carac);
		while carac<>'%' do begin
			cantcaraca:=cantcaraca + 1;
			if carac=corteA then
				result1:=true;
			readln(carac);
		end;
	end;
procedure leerB(var result2: boolean; cantcaraca: integer);
	var
	carac: char;
	cantcaracb,i: integer;
	begin
		i:= 0;
		result2:= false;
		cantcaracb:= 0;
		readln(carac);
		while carac<>'*' do begin
			cantcaracb:= cantcaracb + 1;
			if carac=condB then
				i:= i + 1;
			readln(carac);
		end;
		if (i<3) or (cantcaracb<>cantcaraca) then
			result2:= true;
	end;

var
result1, result2: boolean;
cantcaraca: integer;
begin
	writeln('Ingrese caracteres');
	leerA(result1,cantcaraca);
	leerB(result2,cantcaraca);
	if result1=true then
		write('El patron A%B* no se cumplio en A y ')
	else write('El patron A%B* si se cumplio en A y ');
	if result2=true then
		writeln('no se cumplio en B')
	else writeln('si se cumplio en B');
	readln();
end.



14. a. Realizar un módulo que calcule el rendimiento económico de una plantación de soja. El módulo debe
recibir la cantidad de hectáreas (ha) sembradas, el tipo de zona de siembra (1: zona muy fértil, 2: zona estándar,
3: zona árida) y el precio en U$S de la tonelada de soja; y devolver el rendimiento económico esperado de dicha
plantación.
Para calcular el rendimiento económico esperado debe considerar el siguiente rendimiento por tipo de zona:
	Tipo de zona 	Rendimiento por ha
		1 				6 toneladas por ha
		2 				2,6 toneladas por ha
		3				1,4 toneladas por ha
b. ARBA desea procesar información obtenida de imágenes satelitales de campos sembrados con soja en la
provincia de Buenos Aires. De cada campo se lee: localidad, cantidad de hectáreas sembradas y el tipo de zona
(1, 2 ó 3). La lectura finaliza al leer un campo de 900 ha en la localidad ‘Saladillo’, que debe procesarse. El precio
de la soja es de U$S320 por tn. Informar:
	● La cantidad de campos de la localidad Tres de Febrero con rendimiento estimado superior a U$S 10.000.
	● La localidad del campo con mayor rendimiento económico esperado.
	● La localidad del campo con menor rendimiento económico esperado.
	● El rendimiento económico promedio.

a.
procedure rendplant(cantha,tipoz: integer; precio: real;var rendimiento: real);
	begin
		case tipoz of
			1: rendimiento:= 6*cantha*precio;
			2: rendimiento:= 2.6*cantha*precio;
			3: rendimiento:= 1.4*cantha*precio;
		end;
	end;
b.}
program ejer_14b;

const
lcorte= 'Saladillo';
hacorte= 900;
precio= 320;

procedure leer(var localidad:string; var cantha, tipoz: integer);
	begin
		readln(localidad);
		readln(cantha);
		readln(tipoz);
	end;
procedure rendplant(cantha,tipoz: integer; precio: real;var rendimiento: real);
	begin
		case tipoz of
			1: rendimiento:= 6*cantha*precio;
			2: rendimiento:= 2.6*cantha*precio;
			3: rendimiento:= 1.4*cantha*precio;
		end;
	end;

var
localidad,localidadmax,localidadmin: string;
cantha,tipoz,cantrendimiento,i: integer;
rendimiento,rendimientomax,rendimientomin,rendimientototal: real;
begin
	rendimientomax:=0;
	rendimientomin:= 9999;
	cantrendimiento:=0;
	i:=0;
	rendimientototal:=0;
	writeln('Ingrese los datos de cada campo de la siguiente manera:');
	writeln('localidad');
	writeln('cantidad de hectareas sembradas');
	writeln('tipo de zona');
	repeat
		leer(localidad,cantha,tipoz);
		rendplant(cantha,tipoz,precio,rendimiento);
		if (localidad='Tres de Febrero') and (rendimiento>10000) then
			cantrendimiento:= cantrendimiento +1;
		if rendimiento>rendimientomax then begin
			rendimientomax:= rendimiento;
			localidadmax:= localidad;
		end;
		if rendimiento<rendimientomin then begin
			rendimientomin:= rendimiento;
			localidadmin:= localidad;
		end;
		i:= i +1;
		rendimientototal:= rendimientototal + rendimiento;
	until (localidad=lcorte) and (cantha=hacorte);
	writeln('La cantidad de campos de Tres de Febrero con rendimiento superior a los $ 10.000 es: ', cantrendimiento);
	writeln('La localidad del campo con mayor rendimiento es: ',localidadmax);
	writeln('La localidad del campo con menor rendimiento es: ',localidadmin);
	writeln('El rendimiento economico promedio es: $',(rendimientototal/i):8:2);
	readln();
end.

