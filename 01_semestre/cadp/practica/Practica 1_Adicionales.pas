{Practica 1 adicionales

Actividad 1: Revisando Inversiones
Realizar un programa que analice las inversiones de las empresas más grandes del país. Para cada
empresa se lee su código (un número entero), la cantidad de inversiones que tiene, y el monto
dedicado a cada una de las inversiones. La lectura finaliza al ingresar la empresa con código 100,
que debe procesarse.
El programa deberá informar:
● Para cada empresa, el monto promedio de sus inversiones
● Código de la empresa con mayor monto total invertido
● Cantidad de empresas con inversiones de más de $50000
Por ejemplo:
Ingrese un código de empresa: 33
Ingrese la cant. de inversiones: 4
Ingrese el monto de cada inversión: 33200 56930 24500.85 10000
Resultado del análisis: Empresa 33 Monto promedio 31157,71
Ingrese un código de empresa: 41
Ingrese la cant. de inversiones: 3
Ingrese el monto de cada inversión: 102000.22 53000 12000
Resultado del análisis: Empresa 41 Monto promedio 55666,74
Ingrese un código de empresa: 100
Ingrese la cant. de inversiones: 1
Ingrese el monto de cada inversión: 84000.34
Resultado del análisis: Empresa 100 Monto promedio 84000.34
(Fin de la lectura)
La empresa 41 es la que mayor dinero posee invertido ($167000.22).
Hay 3 empresas con inversiones por más de $50000

program ejer_1;

var
codigo,i,inversiones,mayorempresa,montomas50: integer;
monto,montototal,montopromedio,montomax: real;

begin
	montomax:=0;
	montomas50:=0;
	repeat
		montototal:=0;
		write('Ingrese el codigo de la empresa: ');
		readln(codigo);
		write('Ingrese la cantidad de inversiones de la misma: ');
		readln(inversiones);
		write('Ingrese los montos de todas las inversiones: ');
		for i :=1 to inversiones do begin
			readln(monto);
			montototal:= montototal + monto;
		end;
		montopromedio:= montototal/inversiones;
		if montototal>montomax then begin
			montomax:=montototal;
			mayorempresa:= codigo;
		end;
		if montototal>50000 then
			montomas50:= montomas50 + 1;
		write('El monto promedio de las inversiones para la empresa ', codigo,' es: ');
		writeln(montopromedio:10:2);
	until codigo=100;
	writeln('La empresa ',mayorempresa,' es la que mas invertio con un monto de ', montomax:10:2);
	writeln('La cantidad de empresas que invirtieron mas de $50000 son: ',montomas50);
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
CADP – Actividades Adicionales - Est. de Control - Máximos y Mínimos - 2021
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

program ejer_2;

var
c1: boolean;
legajo,i,nota,notatotal,nota0t,notas0,notas0max1,notas0max2,notas10,notas10max1,notas10max2,aprob,aprobtodo,aprobi,aprobr,ingre,recur,nota65,legajomax1,legajomax2,legajomin1,legajomin2: integer;
notaprom: real;
condicion: char;
begin
	ingre:=0;
	recur:=0;
	aprobtodo:=0;
	aprob:=0;
	aprobi:=0;
	aprobr:=0;
	nota65:=0;
	notas10:=0;
	notas10max1:=0;
	notas10max2:=0;
	nota0t:=0;
	notas0:=0;
	notas0max1:=0;
	notas0max2:=0;
	legajomax1:=0;
	legajomin1:=0;
	writeln('Ingrese el legajo del alumno');
	readln(legajo);
	while legajo<>-1 do begin
		notatotal:=0;
		aprob:=0;
		c1:=false;
		notas10:=0;
		notas0:=0;
		repeat
			writeln('Ingrese la condicion del alumno');
			readln(condicion);
		until (condicion='I') or (condicion='R');
		if condicion='I' then
			ingre:= ingre +1
		else 
			recur:= recur +1;
		writeln('Ingrese las notas del alumno');
		for i:=1 to 5 do begin
			readln(nota);
			if nota=-1 then
				nota:=0;
			notatotal:= notatotal+nota;
			if nota>=4 then
				aprob:= aprob+1;
			if nota=10 then begin
				notas10:= notas10+1;
				if notas10>notas10max1 then begin
					notas10max2:= notas10max1;
					notas10max1:=notas10;
					legajomax2:=legajomax1;
					legajomax1:=legajo;	
				end
				else if notas10>notas10max2 then begin
					notas10max2:= notas10;
					legajomax2:=legajomax2;
				end;
			end;
			if nota=0 then begin
				if c1=false then begin
					nota0t:= nota0t+1;
					c1:=true;
				end;
				notas0:= notas0+1;
				if notas0>notas0max1 then begin
					notas0max2:= notas0max1;
					notas0max1:=notas0;
					legajomin2:=legajomin1;
					legajomin1:=legajo;	
				end
				else if notas0>notas0max2 then begin
					notas0max2:= notas0;
					legajomin2:=legajo;
				end;
			end;
		end;
		if aprob=5 then
			aprobtodo:= aprobtodo +1;
		if aprob>=4 then begin
			if condicion='I' then
				aprobi:=aprobi +1
			else
			 aprobr:= aprobr +1;
		end;
		notaprom:= notatotal/5;
		if notaprom>6.5 then
			nota65:= nota65+1;
		writeln('Ingrese el legajo del alumno');
		readln(legajo);
	end;
	writeln('Los ingresantes que pueden rendir el parcial son: ',aprobi,' y representan el ',(aprobi*100/ingre):4:2,'% de los alumnos ingresados');
	writeln('Los recursantes que pueden rendir el parcial son: ',aprobr,' y representan el ',(aprobr*100/recur):4:2,'% de los alumnos recursantes');
	writeln('La cantidad de alumnos que aprobaron todas las autoevaluaciones son: ',aprobtodo);
	writeln('La cantidad de alumnos con promedio mayor a 6.5 son: ',nota65);
	writeln('La cantidad de alumnos con al menos una nota 0 son: ', nota0t);
	writeln('Los dos alumnos con mayor cantidad de notas 10 en las autoevaluaciones son: ',legajomax1,' y ',legajomax2);
	writeln('Los dos alumnos con mayor cantidad de notas 0 en las autoevaluaciones son: ',legajomin1,' y ',legajomin2);
	readln();
end.



Actividad 3: Ventas de tanques de agua
Un fabricante de tanques de agua está analizando las ventas de sus tanques durante el 2020. La
empresa fabrica tanques a medida, que pueden ser rectangulares (tanques ‘R’) o cilíndricos (tanques
‘C’) .
- De cada tanque R se conoce su ancho (A), su largo (B) y su alto (C)
- De cada tanque C se conoce su radio y su alto
Todas las medidas se ingresan en metros. Realizar un programa que lea la información de los
tanques vendidos por la empresa. La lectura finaliza al ingresar un tanque de tipo ‘Z’. Al finalizar la
lectura, el programa debe informar:
- Volumen de los dos mayores tanques vendidos
- Volumen promedio de todos los tanques cilíndricos vendidos
- Volumen promedio de todos los tanques rectangulares vendidos
- Cantidad de tanques cuyo alto sea menor a 1.40 metros
- Cantidad de tanques cuyo volumen sea menor a 800 metros cúbicos
}
program ejer_3;

var
tipo:char;
ancho,largo,alto,radio,volumen,vttr,vttc,volumenmax1,volumenmax2:real;
ttr,ttc,tbajitos,tchiquitos:integer;

begin
	ttr:=0;
	ttc:=0;
	tchiquitos:=0;
	tbajitos:=0;
	volumenmax1:=0;
	vttr:=0;
	vttc:=0;
	repeat
		writeln('Ingrese el tipo de tanque,');
		writeln('	" R " para rectangular');
		writeln('	" C " para cilindrico');
		writeln('Si quiere cerrar el programa ingrese " Z "');
		readln(tipo);
		writeln();
	until (tipo='R') or (tipo='C') or (tipo='Z');
	while tipo<>'Z' do begin
		if tipo='R' then begin
			writeln('Ingrese el ancho en metros');
			readln(ancho);
			writeln('Ingrese el largo en metros');
			readln(largo);
			writeln('Ingrese el alto en metros');
			readln(alto);
			volumen:= ancho*largo*alto;
			vttr:= vttr+volumen;
			ttr:= ttr+1;
		end
		else begin
			writeln('Ingrese el radio en metros');
			readln(radio);
			writeln('Ingrese el alto en metros');
			readln(alto);
			volumen:= pi*radio*radio*alto;
			vttc:= vttc+volumen;
			ttc:= ttc+1;
		end;
		if alto<1.4 then
			tbajitos:= tbajitos+1;
		if volumen<800 then
			tchiquitos:= tchiquitos+1;
		if volumen>volumenmax1 then begin
			volumenmax2:=volumenmax1;
			volumenmax1:=volumen;
		end
		else if volumen>volumenmax2 then
			volumenmax2:=volumen;
		repeat
			writeln('Ingrese el tipo de tanque,');
			writeln('	" R " para rectangular');
			writeln('	" C " para cilindrico');
			writeln('Si quiere cerrar el programa ingrese " Z "');
			readln(tipo);
			writeln();
		until (tipo='R') or (tipo='C') or (tipo='Z');
	end;
	writeln('Las medidas de los 2 tanques mas grandes vendidos son: ', volumenmax1:5:2,'m^3 y ',volumenmax2:5:2,'m^3');
	writeln('El volumen promedio de los tanques cilindricos vendidos es: ',(vttc/ttc):5:2,'m^3');
	writeln('El volumen promedio de los tanques rectangulares vendidos es: ',(vttr/ttr):5:2,'m^3');
	writeln('La cantidad de tanques vendidos menores a 1.4 de altura es: ',tbajitos);
	writeln('La cantidad de tanques vendidos menores a 800m^3 de volumen es: ',tchiquitos);
	readln()
end.
