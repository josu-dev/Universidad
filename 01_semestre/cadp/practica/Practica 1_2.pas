{Practica 1_2

1. Realizar un programa que lea 10 números enteros e informe la suma total de los números leídos.
a. Modifique el ejercicio 1 para que además informe la cantidad de números mayores a 5

program ejer_1;

var
num1,numtotal,i: integer;

begin
	numtotal:=0;
	i:=0;
	writeln('Ingrese 10 numeros por separados para ser sumados');
	repeat
		readln(num1);
		numtotal:= numtotal + num1;
		i:=i +1;
	until i=10;
	writeln('La suma total de los numeros ingresados es: ',numtotal);
	readln();
end.

program ejer_1a;

var
num1,numtotal,i,numgrandes: integer;

begin
	numgrandes:=0;
	numtotal:=0;
	i:=0;
	writeln('Ingrese 10 numeros por separados para ser sumados');
	repeat
		readln(num1);
		if num1>5 then
			numgrandes:= numgrandes +1;
		numtotal:= numtotal + num1;
		i:=i +1;
	until i=10;
	writeln('La suma total de los numeros ingresados es: ',numtotal);
	writeln('La cantidad de numeros ingresados mayores a 5 es: ',numgrandes);
	readln();
end.



2. Realice un programa que lea 10 números e informe cuál fue el mayor número leído. Por ejemplo, si
se lee la secuencia:
3 5 6 2 3 10 98 8 -12 9
deberá informar: “El mayor número leído fue el 98”
a. Modifique el programa anterior para que, además de informar el mayor número leído, se
informe el número de orden, dentro de la secuencia, en el que fue leído. Por ejemplo, si se lee la
misma secuencia:
3 5 6 2 3 10 98 8 -12 9
deberá informar: “El mayor número leído fue el 98, en la posición 7”

program ejer_2;

var
num1,maximo:real;
i: integer;

begin
	maximo:=-99;
	i:=0;
	writeln('Ingrese 10 numeros por separado para saber el mayor');
	repeat
		readln(num1);
		if num1>maximo then
			maximo:= num1;
		i:= i+1;
	until i=10;
	writeln('El mayor numero ingresado fue el: ', maximo:6:2);
	readln();
end.

program ejer_2;

var
num1,maximo:real;
i,numpos: integer;

begin
	maximo:=-99;
	i:=0;
	writeln('Ingrese 10 numeros por separado para saber el mayor');
	repeat
		readln(num1);
		if num1>maximo then begin
			maximo:= num1;
			numpos:=i+1;
		end;
		i:= i+1;
	until i=10;
	writeln('El mayor numero ingresado fue el: ', maximo:6:2,' en la posicion: ',numpos);
	readln();
end.



3. Realizar un programa que lea desde teclado la información de alumnos ingresantes a la carrera
Analista en TIC. De cada alumno se lee nombre y nota obtenida en el módulo EPA (la nota es un
número entre 1 y 10). La lectura finaliza cuando se lee el nombre “Zidane Zinedine“, que debe
procesarse. Al finalizar la lectura informar:
- La cantidad de alumnos aprobados (nota 8 o mayor) y
- la cantidad de alumnos que obtuvieron un 7 como nota

program ejer_3;

var
nombre: string;
nota,alumnos7,alumnos8910: integer;

begin
	alumnos8910:=0;
	alumnos7:=0;
	writeln('Ingrese el nombre y luego la nota del alumno');
	repeat
		readln(nombre);
		readln(nota);
		if nota>=8 then
			alumnos8910:= alumnos8910+1;
		if nota=7 then
			alumnos7:= alumnos7 +1;
	
	until nombre='Zidane Zinedine';
	writeln('Los alumnos con nota 8 o mayor fueron: ', alumnos8910);
	writeln('Los alumnos con nota 7 fueron: ',alumnos7);
	readln();
end.



4. Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son
los dos números mínimos leídos.
a. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
el número 0, el cual debe procesarse.
b. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
el número 0, el cual no debe procesarse

program ejer_4;

var
numi,min1,min2,i: integer;

begin
	min1:=1000;
	min2:=1000;
	writeln('Ingrese numeros para saber los dos minimos');
	for i:=1 to 10 do begin
		readln(numi);
		if numi<min1 then begin
			min2:=min1;
			min1:=numi;
		end;
	end;
	writeln('Los dos numeros minimos leidos son: ', min1,' y ', min2);
	readln();
end.

program ejer_4a;

var
numi,min1,min2: integer;

begin
	min1:=1000;
	min2:=1000;
	writeln('Ingrese numeros para saber los dos minimos');
	repeat
		readln(numi);
		if numi<min1 then begin
			min2:=min1;
			min1:=numi;
		end
		else if numi<min2 then
			min2:=numi;
	until numi=0;
	writeln('Los dos numeros minimos leidos son: ', min1,' y ', min2);
	readln();
end.

program ejer_4b;

var
numi,min1,min2: integer;

begin
	min1:=1000;
	min2:=1000;
	writeln('Ingrese numeros para saber los dos minimos');
	readln(numi);
	while numi<>0 do begin
		if numi<min1 then begin
			min2:=min1;
			min1:=numi;
		end
		else if numi<min2 then
			min2:=numi;
		readln(numi);
	end;
	writeln('Los dos numeros minimos leidos son: ', min1,' y ', min2);
	readln();
end.



5. Realizar un programa que lea números enteros desde teclado. La lectura debe finalizar cuando se
ingrese el número 100, el cual debe procesarse. Informar en pantalla:
◦ El número máximo leído.
◦ El número mínimo leído.
◦ La suma total de los números leídos.

program ejer_5;

var
numi,nummax,nummin,total: integer;

begin
	nummax:=-1;
	nummin:=999;
	total:=0;
	writeln('Ingrese numeros por separado para saber su minimo, maximo y total de la suma entre ellos');
	repeat
		readln(numi);
		if numi>nummax then
			nummax:=numi;
		if numi<nummin then
			nummin:=numi;
		total:= total + numi;
	
	until numi=100;
	writeln('El numero maximo ingresado fue: ', nummax);
	writeln('El numero minimo ingresado fue: ', nummin);
	writeln('La suma total de los numeros ingresados es de: ', total);
	readln();

end.



6. Realizar un programa que lea información de 200 productos de un supermercado. De cada producto
se lee código y precio (cada código es un número entre 1 y 200). Informar en pantalla:
- Los códigos de los dos productos más baratos.

program ejer_6;

var
codigo, codmin1,codmin2,i: integer;
precio,preciomin1,preciomin2: real;

begin
	codmin1:=0;
	preciomin1:=999;
	preciomin2:=999;
	writeln('Ingrese el codigo y precio de cada producto para saber los dos mas baratos');
	for i:=1 to 10 do begin
		readln(codigo,precio);
		if precio<preciomin1 then begin
			codmin2:=codmin1;
			codmin1:=codigo;
			preciomin2:=preciomin1;
			preciomin1:=precio;
		end
		else if precio<preciomin2 then begin
			codmin2:=codigo;
			preciomin2:=precio;
		end;
	end;
	writeln('Los dos codigos de los productos mas baratos son: ', codmin1,' y ', codmin2);
	readln();

end.



7. Realizar un programa que lea desde teclado información de autos de carrera. Para cada uno de los
autos se lee el nombre del piloto y el tiempo total que le tomó finalizar la carrera. En la carrera
participaron 100 autos. Informar en pantalla:
- Los nombres de los dos pilotos que finalizaron en los dos primeros puestos.
- Los nombres de los dos pilotos que finalizaron en los dos últimos puestos.

program ejer_7;

var
nombre, nrapido1,nrapido2,nlento1,nlento2: string;
tiempo, tmin1,tmin2,tmax1,tmax2: real;
i: integer;

begin
	tmin1:=999;
	tmin2:=999;
	tmax1:=-1;
	tmax2:=-1;
	nrapido1:= ' ';
	nlento1:= ' ';
	writeln('Ingrese el nombre del piloto y su tiempo por separado');
	for i:=1 to 5 do begin
		readln(nombre);
		readln(tiempo);
		if tiempo<tmin1 then begin
			nrapido2:= nrapido1;
			nrapido1:= nombre;
			tmin2:=tmin1;
			tmin1:=tiempo;
		end
		else if tiempo<tmin2 then begin
			nrapido2:=nombre;
			tmin2:=tiempo;
		end;
		if tiempo>tmax1 then begin
			nlento2:=nlento1;
			nlento1:=nombre;
			tmax2:=tmax1;
			tmax1:=tiempo;
		end
		else if tiempo>tmax2 then begin
			nlento2:=nombre;
			tmax2:=tiempo;
		end;
	end;
	writeln('Los dos pilotos mas rapidos son: ',nrapido1, ' y ', nrapido2);
	writeln('Los dos pilotos mas lentos son: ',nlento1, ' y ', nlento2);
	readln();
end.



8. Un local de ropa desea analizar las ventas realizadas en el último mes. Para ello se lee por cada día
del mes, los montos de las ventas realizadas. La lectura de montos para cada día finaliza cuando se
lee el monto 0. Se asume un mes de 31 días. Informar la cantidad de ventas por cada día, y el monto
total acumulado en ventas de todo el mes.
a) Modifique el ejercicio anterior para que además informe el día en el que se realizó la
mayor cantidad de ventas.

program ejer_8;

var
monto, montot:real;
i,ventas: integer;


begin
	montot:= 0;
	for i:=1 to 5 do begin
		ventas:=0;
		writeln('Ingrese el monto de las ventas del dia');
		readln(monto);
		while monto<>0 do begin
			ventas:=ventas+1;
			montot:=montot + monto;
			readln(monto)
		end;
		writeln('Hoy se realizaron: ', ventas, ' ventas');
	end;
	writeln('El monto total de las ventas durante el mes es de $', montot:8:2);
	
end.
}
program ejer_8a;

var
monto, montot:real;
i,ventas,mventas: integer;


begin
	montot:= 0;
	mventas:= 0;
	for i:=1 to 31 do begin
		ventas:=0;
		writeln('Ingrese el monto de las ventas del dia');
		readln(monto);
		while monto<>0 do begin
			ventas:=ventas+1;
			montot:=montot + monto;
			readln(monto)
		end;
		writeln('Hoy se realizaron: ', ventas, ' ventas');
		if mventas<ventas then
			mventas:=i;
	end;
	writeln('El monto total de las ventas durante el mes es de $', montot:8:2);
	writeln('El dia en el que mas ventas se realizaron fue el ',mventas);
	
end.
