{Practica 2_adicionales
 

1. Dado el siguiente programa:
program Ejercicio1_ad;
procedure intercambio(var num1,num2 : integer);
	var
	aux : integer;
	begin
		aux := num1;
		num1 := num2;
		num2 := aux;
	end;
procedure sumar(num1 : integer; var num2 : integer);
	begin
		num2 := num1 + num2;
	end;
var
i, num1, num2 : integer;
begin
	read(num1);
	read(num2);
	for i := 1 to 3 do begin
	intercambio(num1,num2);
	sumar(i,num1);
	end;
	writeln(num1);
end.
a. ¿Qué imprime si se leen los valores num1=10 y num2=5 ?
b. ¿Qué imprime si se leen los valores num1=5 y num2=10 ? 

a. Imprime 8
b. Imprime 13



2. Realice un programa modularizado que lea 10 pares de números (X,Y) e informe, para cada par de
números, la suma y el producto de todos los números entre X e Y.
Por ejemplo, dado el par (3,6), debe informar:
“La suma es 18“ (obtenido de calcular 3+4+5+6)
“El producto es 360“ (obtenido de calcular 3*4*5*6)

program ejer_2;

procedure tomar(var num1,num2: integer; var eval: boolean);
	begin
		readln(num1);
		readln(num2);
		if num1<num2 then
			eval:=true
		else eval:=false;
	end;
procedure suma(num1: integer; var sumat:integer);
	begin
		sumat:= sumat + num1;
	end;
procedure multi(num1: integer; var multit:integer);
	begin
		multit:= multit * num1;
	end;
var
eval: boolean;
i,i2,num1,num2,sumat,multit: integer;
begin
	for i:=1 to 10 do begin
		sumat:=0;
		multit:=1;
		writeln('Ingrese par de numeros por separado');
		tomar(num1,num2,eval);
		if eval=true then begin
			for i2:=num1 to num2 do begin
				suma(i2,sumat);
				multi(i2,multit);
			end;
		end
		else begin
			for i2:=num1 downto num2 do begin
				suma(i2,sumat);
				multi(i2,multit);
			end;
		end;
		writeln('La suma es: ',sumat);
		writeln('El producto es: ', multit);
	end;
end.



3. Realizar un programa modularizado que lea información de 200 productos de un supermercado. De cada
producto se lee código y precio (cada código es un número entre 1 y 200). Informar en pantalla:
	● Los códigos de los dos productos más baratos.
	● La cantidad de productos de más de 16 pesos con código par.

program ejer_3;
procedure par(codigo:integer; var eval:boolean);
	begin
		eval:=false;
		if (codigo mod 2)=0 then
			eval:=true;
	end;
procedure baratos(codigo: integer; precio:real; var codigo1,codigo2: integer; var precio1,precio2:real);
	begin
		if precio<precio1 then begin
			precio2:=precio1;
			precio1:=precio;
			codigo2:=codigo1;
			codigo1:=codigo;
		end
		else if precio<precio2 then begin
			precio2:=precio;
			codigo2:=codigo;
		end;
	end;
procedure dieciseis( codigo: integer; var  cantseis: integer);
	var
	eval:boolean;
	begin
		par(codigo,eval);
		if eval=true then
			cantseis:= cantseis + 1;
	end;
var
i,codigo,codigo1,codigo2,cantseis:integer;
precio,precio1,precio2:real;
begin
	cantseis:=0;
	codigo1:=0;
	precio1:=9999;
	precio2:=9999;
	writeln('Introdusca el codigo y precio de cada producto');
	for i:=1 to 5 do begin
		readln(codigo);
		readln(precio);
		baratos(codigo,precio,codigo1,codigo2,precio1,precio2);
		if precio>16 then
			dieciseis(codigo,cantseis);
	end;
	writeln('Los dos productos mas baratos son: ',codigo1, ' y ', codigo2);
	writeln('La cantidad de productos de mas de $16 con codigo par son: ',cantseis);
	readln();
end.



4.  a. Realizar un módulo que reciba como parámetro el radio de un círculo y retorne su diámetro y su
	perímetro.
	b. Utilizando el módulo anterior, realizar un programa que analice información de planetas obtenidas del
	Telescopio Espacial Kepler. De cada planeta se lee su nombre, su radio (medido en kilómetros) y la distancia
	(medida en años luz) a la Tierra. La lectura finaliza al leer un planeta con radio 0, que no debe procesarse.
	Informar:
		● Nombre y distancia de los planetas que poseen un diámetro menor o igual que el de la Tierra (12.700
		km) y mayor o igual que el de Marte (6.780 km).
		● Cantidad de planetas con un perímetro superior al del planeta Júpiter (439.264 km).

a.
procedure circulo(rad: real; var dia, per: real);
	begin
		dia:= rad*2;
		per:= 2*pi*rad;
	end;
b.
program ejer_4b;

procedure circulo(rad: real; var dia, per: real);
	begin
		dia:= rad*2;
		per:= 2*pi*rad;
	end;

var
nombre: string;
radio,dia,per,distancia:real;
i: integer;
begin
	i:=0;
	writeln('Ingrese nombre, radio y distancia a los planetas');
	readln(nombre);
	readln(radio);
	readln(distancia);
	while radio<>0 do begin
		circulo(radio,dia,per);
		if (dia<=12.7) and (dia>=6.78) then
			writeln('El planeta ',nombre,' es menor que la Tierra y mayor que Marte y se encuentra a ', distancia:1:1,' anios luz');
		if per>439.264 then
			i:= i + 1;
		writeln('Siguiente planeta');
		readln(nombre);
		readln(radio);
		readln(distancia);
	end;
	writeln('La cantidad de planetas analizados con perimetro mayor al de jupiter es de: ', i);
	readln();
end.



5. En la “Práctica 1 - Ejercicios Adicionales” se resolvieron 3 problemas complejos sin utilizar módulos. Al
carecer de herramientas para modularizar, esos programas resultaban difíciles de leer, de extender y de
depurar.
	a) Analice sus soluciones a dichos problemas, e identifique:
		- qué porciones de su código podrían modularizarse? en qué casos propondría una estructura de módulos
		anidada?
		- qué tipo de módulo (función o procedimiento) conviene utilizar en cada caso? existe algún caso en los que
		sólo un tipo de módulo es posible?
		- qué mecanismos de comunicación conviene utilizar entre los módulos propuestos?
	b) Implemente nuevamente los 3 programas, teniendo en cuenta los módulos propuestos en el inciso
	anterior

a.
	ejer 1
			Se podria hacer una funcion para la sumatoria de inversiones y dos procedimientos, uno para calcular la emprese que mas invirtio y el otro para el conteo de las empresas de mas de 50000
	ejer 2
			Se podria modularizar los maximos de notas 10 y 0 en un solo modulo procedure y un modulo para leer los datos de entrada
	ejer 3
			Un modulo procedure para la eleccion del tipo de tanque y otro modulo para calcular los maximos de volumen
b.

program practica_1_adicionales_ejer_1;
const
	ccorte=100;
procedure calculo(cinversiones: integer; var mas50:boolean; var monto: real);
	var
	i: integer;
	a: real;
	begin
		mas50:=false;
		monto:=0;
		writeln('Monto de las inversiones: ');
		for i:=1 to cinversiones do begin
			readln(a);
			if a>=50000 then
				mas50:=true;
			monto:= a + monto;
		end;
	end;
procedure leer(var codigo,cinversiones: integer; var monto: real; var mas50: boolean);
	begin
	write('Codigo de la empresa: '); readln(codigo);
	write('Cantidad inversiones: '); readln(cinversiones);
	calculo(cinversiones,mas50,monto);
	end;
procedure empresamax(codigo:integer; monto: real; var codmax: integer; var montomax: real);
	begin
		if monto>montomax then begin
			montomax:= monto;
			codmax:= codigo;
		end;
	end;
var
mas50: boolean; 
codigo,cinversiones,cant50,codmax: integer;
monto,montomax: real;
begin
	montomax:= 0;
	cant50:= 0;
	writeln('Escriba los datos solicitados');
	repeat
		leer(codigo,cinversiones,monto,mas50);
		if mas50 then
			cant50:= cant50 +1;
		empresamax(codigo,monto,codmax,montomax);
		writeln('Para la empresa ',codigo,' el promedio de inversiones es: $ ',(monto/cinversiones):1:2);
		if codigo<>ccorte then
			writeln('Siguiente empresa'); 
	until codigo=ccorte;
	writeln('La empresa con mayor inversion es: ',codmax,' con un total de: $ ',montomax:1:2);
	writeln('Hay ',cant50,' empresas con almenos una inversion mayor a $ 50000');
	readln();
end.
Actividad 2: procesamiento de las autoevaluaciones de CADP
La cátedra de CADP está analizando los resultados de las autoevaluaciones que realizaron los
alumnos durante el cuatrimestre. Realizar un programa que lea, para cada alumno, su legajo, su
condición (I para INGRESANTE, R para RECURSANTE), y la nota obtenida en cada una de las 5
autoevaluaciones. Si un alumno no realizó alguna autoevaluación en tiempo y forma, se le cargará la
nota -1. La lectura finaliza al ingresar el legajo -1. Por ejemplo, si la materia tuviera dos alumnos, un
ingresante y un recursante, la lectura podría ser así:
Legajo: 19003
Condición: R
Notas: 8 10 6 -1 8
Legajo 21020
Condición: I
Notas: 4 0 6 10 -1
Legajo -1
(Fin de la lectura)
Una vez ingresados todos los datos, el programa debe informar:
- Cantidad de alumnos INGRESANTES en condiciones de rendir el parcial y porcentaje sobre el
total de alumnos INGRESANTES.
- Cantidad de alumnos RECURSANTES en condiciones de rendir el parcial y porcentaje sobre el
total de alumnos RECURSANTES.
- Cantidad de alumnos que aprobaron todas las autoevaluaciones
- Cantidad de alumnos cuya nota promedio fue mayor a 6.5 puntos
- Cantidad de alumnos que obtuvieron cero puntos en al menos una autoevaluación.
- Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 10 (diez)
- Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 0 (cero)
Nota: recuerde que, para poder rendir el EXAMEN PARCIAL, el alumno deberá obtener “Presente” en al
menos el 75% del total de las autoevaluaciones propuestas. Se considera “Presente” la autoevaluación que se
entrega en tiempo y forma y con al menos el 40% de respuestas correctas.
}
program practica_1_adicionales_ejer_2;

