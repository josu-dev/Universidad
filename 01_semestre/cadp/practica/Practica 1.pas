{Practica 1

1. Realizar un programa que lea 2 números enteros desde teclado e informe en pantalla cuál de los
dos números es el mayor. Si son iguales debe informar en pantalla lo siguiente: “Los números leídos
son iguales

program ejer_1;

var
num1, num2: integer;

begin
	writeln('Ingrese dos numero enteros');
	readln(num1);
	readln(num2);
	if num1>num2 then
		writeln(num1, ' es el mayor de los numeros ingresados');
	if num2>num1 then
		writeln(num2, ' es el mayor de los numeros ingresados');
	if num2=num1 then
		writeln('Los numeros ingresados son iguales');
	readln();
end.



2. Realizar un programa que lea un número real e imprima su valor absoluto. El valor absoluto de un
número X, se escribe |X| y se define como:
|X| = X cuando X es mayor o igual a cero
|X| = -X cuando X es menor a cero

program ejer_2;

var
num1: real;

begin
	writeln('Ingrese un numero real para saber su valor absoluto');
	readln(num1);
	if num1<0 then
		num1:= num1*-1;
	if num1>=0 then
		num1:= num1;
	writeln('El modulo del numero ingresado es: ', num1:10:2);
	readln();
end.



3. Realizar un programa que lea 3 números enteros y los imprima en orden descendente.
Por ejemplo, si se ingresan los valores 4, -10 y 12, deberá imprimir:
12 4 -10

program ejer_3;

var
num1,num2,num3: integer;

begin
	writeln('Ingrese 3 numeros enteros');
	readln(num1);
	readln(num2);
	readln(num3);
	if (num1>num2) and (num2>num3) then
		writeln(num1, ' ', num2, ' ', num3);
	if (num1>num3) and (num3>num2) then
		writeln(num1, ' ', num3, ' ', num2);
	if (num2>num1) and (num1>num3) then
		writeln(num2, ' ', num1, ' ', num3);
	if (num2>num3) and (num3>num1) then
		writeln(num2, ' ', num3, ' ', num1);
	if (num3>num1) and (num1>num2) then
		writeln(num3, ' ', num1, ' ', num2);
	if (num3>num2) and (num2>num1) then
		writeln(num3, ' ', num2, ' ', num1);
	readln();
end.



4. Realizar un programa que lea un número real X. Luego, deberá leer números reales hasta que se
ingrese uno cuyo valor sea exactamente el doble de X (el primer número leído)

program ejer_4;

var
num1,num2: real;

begin
	writeln('Ingrese un primer numero real');
	readln(num1);
	writeln('Ingrese numeros reales hasta encontrar el doble del primero');
	readln(num2);
	while not(num1*2=num2)do
		readln(num2);
	writeln('es el doble de ', num1:10:2);
	readln();
end.



5. Modifique el ejercicio anterior para que, luego de leer el número X, se lean a lo sumo 10 números
reales. La lectura deberá finalizar al ingresar un valor que sea el doble de X, o al leer el décimo
número, en cuyo caso deberá informarse “No se ha ingresado el doble de X”.

program ejer_5;

var
num1,num2: real;
contador:integer;

begin
	contador:= 1;
	writeln('Ingrese un primer numero real');
	readln(num1);
	writeln('Ingrese numeros reales hasta encontrar el doble del primero');
	readln(num2);
	while not(num1*2=num2) and (contador<10) do
		begin
			readln(num2);
			contador:= contador +1;
			if contador=10 then
				writeln('No se ingreso el doble de ', num1:10:2);
		end;
	if num1*2=num2 then
	writeln(num2:10:2,' es el doble de ', num1:10:2);
	readln();
end.



6. Realizar un programa que lea el número de legajo y el promedio de cada alumno de la facultad. La
lectura finaliza cuando se ingresa el legajo -1, que no debe procesarse.
Por ejemplo, se lee la siguiente secuencia:
33423
8.40
19003
6.43
-1
En el ejemplo anterior, se leyó el legajo 33422, cuyo promedio fue 8.40, luego se leyó el legajo
19003, cuyo promedio fue 6.43, y finalmente el legajo -1 (para el cual no es necesario leer un
promedio).
Al finalizar la lectura, informar:
○ La cantidad de alumnos leída (en el ejemplo anterior, se debería informar 2)
○ La cantidad de alumnos cuyo promedio supera 6.5 (en el ejemplo anterior, se debería informar
1)
○ El porcentaje de alumnos destacados (alumnos con promedio mayor a 8.5) cuyo legajo sean
menor al valor 2500 (en el ejemplo anterior se debería informar 0%).

program ejer_6;

var
nlegajo,promedio: real;
talumnos,talumnos_regulares,talumnos_destacados: integer;

begin
	talumnos:=0;
	talumnos_regulares:=0;
	talumnos_destacados:=0;
	writeln('Ingrese numero de legajo del alumno y luego su promedio');
	readln(nlegajo);
	while not(nlegajo=-1) do
		begin
			readln(promedio);
			talumnos:= talumnos +1;
			if promedio>6.5 then
				talumnos_regulares:= +1;
			if promedio>8.5 then
				talumnos_destacados:= +1;
			readln(nlegajo);
		end;
	writeln('Se pudieron leer ',talumnos, ' alumnos');
	writeln(talumnos_regulares, ' fueron los alumnos ingresados con promedio superior a 6.5');
	writeln(talumnos_destacados*100/talumnos:4:1, '% de alumnos destacados en el total ingresado');
	readln();
end.



7. Realizar un programa que lea el código, el precio actual y el nuevo precio de los productos de un
almacén. La lectura finaliza al ingresar el producto con el código 32767, el cual debe procesarse.
Para cada producto leido, el programa deberá indicar si el nuevo precio del producto supera en un
10% al precio anterior.
Por ejemplo:
○ Si se ingresa el código 10382, con precio actual 40, y nuevo precio 44, deberá imprimir: “el
aumento de precio del producto 10382 no supera el 10%”
○ Si se ingresa el código 32767, con precio actual 30 y nuevo precio 33,01, deberá imprimir: “el
aumento de precio del producto 32767 es superior al 10%”

program ejer_7;

var
codigo,precio_a,precio_n: real;

begin
	writeln('Ingrese el codigo de su producto, luego su precio actual y finalmente su nuevo precio');
	repeat
		readln(codigo);
		readln(precio_a);
		readln(precio_n);
		if precio_n>precio_a*1.1 then
			writeln('El aumento de precio del producto ', codigo:10:0, ' es superior al 10%');
		if precio_n<precio_a*1.1 then
			writeln('El aumento de precio del producto ', codigo:10:0, ' no supera el 10%');
	until codigo=32767;
	readln();
end.



8. Realizar un programa que lea tres caracteres, e informe si los tres eran letras vocales o si al menos
uno de ellos no lo era. Por ejemplo, si se leen los caracteres “a e o” deberá informar “Los tres son
vocales”, y si se leen los caracteres “z a g” deberá informar “al menos un carácter no era vocal”.

program ejer_8;

var
car1, car2, car3: char;

begin
	writeln('Ingrese 3 caracteres');
	readln(car1);
	readln(car2);
	readln(car3);
	if ((car1='a') or (car1='e') or (car1='i') or (car1='o') or (car1='u')) and ((car2='a') or (car2='e') or (car2='i') or (car2='o') or (car2='u')) and
	 ((car3='a') or (car3='e') or (car3='i') or (car3='o') or (car3='u')) then
		writeln('Los tres son vocales')
	else
		writeln('Al menos un caracter no era vocal');
	readln();
end.



9. Realizar un programa que lea un carácter, que puede ser “+” (suma) o “-” (resta); si se ingresa otro
carácter, debe informar un error y finalizar. Una vez leído el carácter de suma o resta, deberá leerse
una secuencia de números enteros que finaliza con 0. El programa deberá aplicar la operación leída
con la secuencia de números, e imprimir el resultado final.
Por ejemplo:
○ Si se lee el carácter “-” y la secuencia 4 3 5 -6 0 , deberá imprimir: 2 (4 – 3 – 5 - (-6) )
○ Si se lee el carácter “+” y la secuencia -10 5 6 -1 0, deberá imprimir 0 ( -10 + 5 + 6 + (-1) )
}
program ejer_9;

var 
car: char;
num, total: integer;

begin
	total:=0;
	writeln('Ingrese + para sumar numero o - para restar numeros');
	readln(car);
	if (car<>'+') and (car<>'-') then
		writeln('Caracter ingresado invalido, finalizando jecutable')
	else
		begin
			if car='+' then
				begin
					readln(num);
					while num<>0 do
						begin
							total:= total+num;
							readln(num);
						end;
					writeln('El resultado de sumar los numeros es: ', total);
				end;
			if car='-' then
				begin
					readln(num);
					while num<>0 do
						begin
							total:= total-num;
							readln(num);
						end;	
					writeln('El resultado de restar los numeros es: ', total);
				end;
		end;
	readln();
end.

