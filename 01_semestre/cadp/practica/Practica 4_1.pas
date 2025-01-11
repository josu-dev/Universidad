{practica 4_1

1. Dado el siguiente programa:
program sumador;
type
	vnums = array [1..10] of integer;
var
	numeros : vnums;
	i : integer;
begin
	for i:=1 to 10 do //primer bloque for
	numeros[i] := i;
	for i := 2 to 10 do //segundo bloque for
	numeros[i] := numeros[i] + numeros [i-1]
end.
a) ¿Qué valores toma la variable numeros al finalizar el primer bloque for?
b) Al terminar el programa, ¿con qué valores finaliza la variable números?
c) Si se desea cambiar la línea 11 por la sentencia: for i:=1 to 9 do ¿Cómo debe modificarse el
código para que la variable números contenga los mismos valores que en 1.b)?
d) ¿Qué valores están contenidos en la variable numeros si la líneas 11 y 12 se reemplazan por:
for i:=1 to 9 do
numeros[i+1] := numeros[i];

a) 1,2,3,4 ,5, 6, 7, 8, 9, 10
b) 1,3,6,10,15,21,28,36,45,55
c) vnums declarada con rango 0..9;
d) 1,1,1,1, 1, 1, 1, 1, 1, 1



2. Dado el siguiente programa, complete las líneas indicadas, considerando que:
	a) El módulo cargarVector debe leer números reales y almacenarlos en el vector que se pasa como
	parámetro. Al finalizar, debe retornar el vector y su dimensión lógica. La lectura finaliza cuando se ingresa
	el valor 0 (que no debe procesarse) o cuando el vector está completo.
	b) El módulo modificarVectorySumar debe devolver el vector con todos sus elementos incrementados con
	el valor n y también debe devolver la suma de todos los elementos del vector.
program Vectores;
const
	cant_datos = 150;
	
type
	vdatos = array[1..cant_datos] of real;
	
procedure cargarVector(var v:vdatos;var dimL : integer);
	var
	num: real;
	begin
		diml:=0;
		readln(num);
		while (num<>0) and (diml<>cant_datos)do begin
			diml:=diml+1;
			v[diml]:= num;
			readln(num);
		end;
	end;
procedure modificarVectorySumar(var v:vdatos;dimL : integer; n: real; var suma: real);
	var
	i: integer;
	begin
		for i:=1 to diml do begin
			v[i]:= v[i] + n;
			suma:= suma + v[i];
		end;
	end;
var
	datos : vdatos;
	i, dim : integer;
	num, suma : real;
begin
	dim := 0;
	sumaTotal := 0;
	cargarVector(datos,dim);
	writeln(‘Ingrese un valor a sumar’);
	readln(num);
	modificarVectorySumar(datos,dim,num,suma);
	writeln(‘La suma de los valores es: ’, suma);
	writeln(‘Se procesaron: ’,dim, ‘ números’)
end.



3. Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
a) Realizar un módulo que imprima el vector desde la primera posición hasta la última.
b) Realizar un módulo que imprima el vector desde la última posición hasta la primera.
c) Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y
desde la mitad más uno hacia la última posición.
d) Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde la
posición X hasta la Y. Asuma que tanto X como Y son menores o igual a la dimensión lógica. Y considere
que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
e) Utilizando el módulo implementado en el inciso anterior, vuelva a realizar los incisos a, b y c.

a)
procedure imprimirVif(v: vector; dimL: integer);
	var
		i: integer;
	begin
		for i:=0 to dimL do
			writeln(v[i]);
	end;
b)
procedure imprimirVfi(v:vector; dimL: integer);
	var i:integer;
	begin
		for i:= dimL down to 1 do
			writeln(v[i]);
	end
c)
procedure imprimirVmi(v: vector; dimL: integer);
	var
	i: integer;
	begin
		for i:= dimL div 2 downto 1 do
			writeln(v[i]);
		for i:= (dimL div 2 +1) downto dimL do
			writeln(v[i]);
	end;
d)
procedure intercambio(v: vector; x,y: integer);
	var
	i: integer;
	begin
		if x>y then
			for i:= x downto y do
				writeln(v[i])
		else
			for i:= x to y do
				writeln(v[i])
	end;



4. Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
a) posicion: dado un número X y el vector de números, retorna la posición del número X en dicho vector,
o el valor -1 en caso de no encontrarse.
b) intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo vector
donde se intercambiaron los valores de las posiciones x e y.
c) sumaVector: retorna la suma de todos los elementos del vector.
d) promedio: devuelve el valor promedio de los elementos del vector.
e) elementoMaximo: retorna la posición del mayor elemento del vector
f) elementoMinimo: retorna la posicion del menor elemento del vector

a)
procedure posicion(x: integer; v: vector; var pos: integer);
	var
		i: integer;
	begin
		pos:=-1;
		for i:=1 to 100 do
			if v[i]=x then
				pos:= i;
	end;
procedure intercambio(x,y: integer;var v: vector);
	var
		aux: integer;
	begin
		aux:=v[x];
		v[x]:=v[y];
		v[y]:=aux;
	end;
function sumaVector(v:vector):integer;
	var
		total: integer;
	begin
		total:=0;
		for i:=1 to 100 do
			total:= total+v[i];
		sumaVector:=total;
	end;
function promedio(v: vector):real;
	begin
		promedio:= sumaVector(v)/100;
	end;
function elementoMaximo(v:vector):integer;
	var
		max,posmax: integer;
	begin
		max:=-999;
		for i:=1 to 100 do
			if v[i]>max then begin
				max:=v[i];
				posmax:=i;
			end;
		elementoMaximo:=posmax;
	end;
function elementoMinimo(v:vector):integer;
	var
		min,posmin: integer;
	begin
		min:=999;
		for i:=1 to 100 do
			if v[i]<min then begin
				min:=v[i];
				posmin:=i;
			end;
		elementoMinimo:=posmin;
	end;



5. Utilizando los módulos implementados en el ejercicio 3, realizar un programa que lea números enteros
desde teclado (a lo sumo 100) y los almacene en un vector. La carga finaliza al leer el número 0. Al finalizar
la carga, se debe intercambiar la posición del mayor elemento por la del menor elemento, e informe la
operación realizada de la siguiente manera: “El elemento máximo ... que se encontraba en la posición ...
fue intercambiado con el elemento mínimo ... que se encontraba en la posición ...”.

program ejer_5;
type
	vector= array[1..100] of integer;
procedure cargarV(var v:vector; var dimL: integer);
	var
	num: integer;
	begin
		dimL:=0;
		readln(num);
		while (num<>0) and (dimL<100) do begin
			dimL:= dimL + 1;
			v[dimL]:=num;
			readln(num);
		end;
	end;
procedure intercambio(v: vector; x,y: integer);
	var
	i: integer;
	begin
		if x>y then
			for i:= x downto y do
				writeln(v[i])
		else
			for i:= x to y do
				writeln(v[i])
	
	end;
procedure elementoMaximo(v:vector; dimL:integer; var max,posmax: integer);
	var
		i: integer;
	begin
		max:=-999;
		i:=1;
		while i<=dimL do begin
			if v[i]>max then begin
				max:=v[i];
				posmax:=i;
			end;
			i:= i + 1;
		end;
	end;
procedure elementoMinimo(v:vector; dimL:integer; var min,posmin: integer);
	var
		i: integer;
	begin
		min:=999;
		i:=1;
		while i<=diml do begin
			if v[i]<min then begin
				min:=v[i];
				posmin:=i;
			end;
			i:= i + 1;
		end;
	end;
var
vec: vector;
dimL,max,min,posmax,posmin: integer;
begin
	cargarV(vec,dimL);
	elementoMaximo(vec,dimL,max,posmax);
	elementoMinimo(vec,dimL,min,posmin);
	intercambio(vec,posmax,posmin);
	writeln('El elemento máximo ',max,' que se encontraba en la posición ',posmax,' fue intercambiado con el elemento mínimo ',min,' que se encontraba en la posición ',posmin);
end.



6. Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo y
otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva ambas
posiciones.

procedure elementoMaxMin(v: vector; dimL: integer; var posmax,posmin: integer);
	var
		i,min,max: integer;
	begin
		i:=0;
		min:=999;
		max:=-999;
		while i<=dimL do begin
			i:=i+1;
			if v[i]>max then begin
			max:=v[i];
			posmax:=i;
			end;
			if v[i]<min then begin
				min:=v[i];
				posmin:=i;
			end;
		end;
	end;



7. Realizar un programa que lea números enteros desde teclado hasta que se ingrese el valor -1 (que no
debe procesarse) e informe:
a. la cantidad de ocurrencias de cada dígito procesado.
b. el dígito más leído.
c. los dígitos que no tuvieron ocurrencias.

program ejer_7;

type
	naturales= array[0..9] of integer;
	
function setear(v:naturales):naturales;
var
i:integer;
begin
	for i:=0 to 9 do
		v[i]:= 0;
	setear:= v;
end;	
function digi(num:integer):integer;
begin
	digi:=num mod 10;
end;
function redu(num:integer):integer;
begin
	redu:=num div 10;
end;
function maxcan(v:naturales):boolean;
var
i,max,posmax:integer;
begin
	max:=-1;
	for i:=0 to 9 do
		if v[i]>max then begin
			max:=v[i];
			posmax:=i;
		end;
	writeln('El digito mas leido fue el ',posmax);
	maxcan:=true;
end;
function infconc(v:naturales):boolean;
var
i1,i,pos,max: integer;
begin
	for i1:=0 to 9 do begin
		max:=0;
		for i:=0 to 9 do
			if v[i]>max then begin
				max:=v[i];
				pos:=i;
			end;
		if max<>0 then
			writeln('El digito ',pos,' tubo ', max,' concurrencias');
		v[pos]:=0;
	end;
	infconc:=true;
end;
function informarxd(v:naturales):char;
var
i: integer;
begin
	for i:=0 to 9 do begin
		if v[i]=0 then
			write(i);
		if (v[i+1]=0) then
			write(',');
	end;
	informarxd:='.';
end;
var
digitos: naturales;
num,dig:integer;
begin
	digitos:= setear(digitos);
	readln(num);
	while num<>-1 do begin
		if num=0 then
			digitos[0]:=digitos[0]+1;
		while num<>0 do begin
			dig:=digi(num);
			digitos[dig]:=digitos[dig]+1;
			num:=redu(num);
		end;
		readln(num);
	end;
	infconc(digitos);
	maxcan(digitos);
	writeln('Los digitos que no tubieron conccurencias son: ',informarxd(digitos));
end.



8. Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
Informática de la UNLP en el año 2020. De cada alumno se lee: nro de inscripción, DNI, apellido, nombre y
año de nacimiento. Una vez leída y almacenada toda la información, calcular e informar:
a) El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.
b) Apellido y nombre de los dos alumnos de mayor edad.

program ejer_8;
const
	df=4;
type
	fecha= record
		dia: 0..31;
		mes: 0..12;
		ano: 0..9999;
	end;
	estudiante= record
		nro: integer;
		DNI: integer;
		ape: string;
		nom: string;
		nac: fecha;
	end;
	alumno= array[1..df] of estudiante;
procedure cargarAlum(var alum: alumno);
	var
		i: integer;
	begin
		for i:=1 to df do begin
			write('Numero de inscripcion: ');readln(alum[i].nro);
			write('DNI: ');readln(alum[i].dni);
			write('Apellido/s: ');readln(alum[i].ape);
			write('Nombre/s: ');readln(alum[i].nom);
			writeln('Fecha de nacimiento');
			write('Dia: ');readln(alum[i].nac.dia);
			write('Mes: ');readln(alum[i].nac.mes);
			write('Año: ');readln(alum[i].nac.ano);
		end;
	end;
function sonImpares(num:integer):boolean;
	var
	dig:integer;
	v: boolean;
	begin
		v:=false;
		while num<>0 do begin
			dig:=num mod 10;
			if (dig mod 2) = 1 then
				v:=true;
			num:= num div 10;
		end;
		sonImpares:=v;
	end;
procedure dniPares(alum:alumno; var cDniPares: integer);
	var
	i: integer;
	begin
		cDniPares:=0;
		for i:=1 to df do begin
			if not sonImpares(alum[i].dni) then
				cDniPares:= cDniPares +1;
		end;
	end;
procedure masViejos(alum: alumno; var nom1,nom2,ape1,ape2: string);
	var
	i,max1,max2: integer;
	begin
		max1:=9999;
		nom1:='';
		ape1:='';
		for i:=1 to df do begin
			if alum[i].nac.ano<max1 then begin
				max2:=max1;
				max1:=alum[i].nac.ano;
				nom2:=nom1;
				nom1:=alum[i].nom;
				ape2:=ape1;
				ape1:=alum[i].ape;
			end
			else if alum[i].nac.ano<max2 then begin
				max2:=alum[i].nac.ano;
				nom2:=alum[i].nom;
				ape2:=alum[i].ape;
			end;
		end;
	end;
var
alum:alumno;
nom1,nom2,ape1,ape2: string;
cDniPares: integer;
begin
	cargarAlum(alum);
	dniPares(alum,cDniPares);
	masViejos(alum,nom1,nom2,ape1,ape2);
	writeln('El porcentaje de alumnos con solo digitos pares en su DNI es: %',cDniPares*100/df:0:2);
	writeln('Los dos alumnos mas viejos son :',nom1,' ',ape1,' y ',nom2,' ',ape2);
	readln();
end.



9. Modificar la solución del punto anterior considerando que el programa lea y almacene la información de a
lo sumo 400 alumnos. La lectura finaliza cuando se ingresa el DNI -1 (que no debe procesarse).

program ejer_9;
const
	df=4;
type
	fecha= record
		dia: 0..31;
		mes: 0..12;
		ano: 0..9999;
	end;
	estudiante= record
		nro: integer;
		DNI: integer;
		ape: string;
		nom: string;
		nac: fecha;
	end;
	alumno= array[1..df] of estudiante;
procedure cargarAlum(var alum: alumno;var dl:integer);
	begin
		dl:=1;
		write('Numero de inscripcion: ');readln(alum[dl].nro);
		write('DNI: ');readln(alum[dl].dni);
		while (alum[dl].dni <> -1) and (dl<=df) do begin
			write('Apellido/s: ');readln(alum[dl].ape);
			write('Nombre/s: ');readln(alum[dl].nom);
			writeln('Fecha de nacimiento');
			write('Dia: ');readln(alum[dl].nac.dia);
			write('Mes: ');readln(alum[dl].nac.mes);
			write('Año: ');readln(alum[dl].nac.ano);
			dl:=dl+1;
			if dl<=df then begin
				write('Numero de inscripcion: ');readln(alum[dl].nro);
				write('DNI: ');readln(alum[dl].dni);
			end;
		end;
		dl:=dl-1;
	end;
function sonImpares(num:integer):boolean;
	var
	dig:integer;
	v: boolean;
	begin
		v:=false;
		while num<>0 do begin
			dig:=num mod 10;
			if (dig mod 2) = 1 then
				v:=true;
			num:= num div 10;
		end;
		sonImpares:=v;
	end;
procedure dniPares(alum:estudiante; var cDniPares: integer);
	begin
		if not sonImpares(alum.dni) then
			cDniPares:= cDniPares +1;
	end;
procedure masViejos(alum:estudiante;var max1,max2:integer; var nom1,nom2,ape1,ape2: string);
	begin
		if alum.nac.ano<max1 then begin
			max2:=max1;
			max1:=alum.nac.ano;
			nom2:=nom1;
			nom1:=alum.nom;
			ape2:=ape1;
			ape1:=alum.ape;
		end
		else if alum.nac.ano<max2 then begin
			max2:=alum.nac.ano;
			nom2:=alum.nom;
			ape2:=alum.ape;
		end;
	end;
var
alum:alumno;
nom1,nom2,ape1,ape2: string;
dl,i,max1,max2,cDniPares: integer;

begin
	max1:=9000;
	nom1:='';
	ape1:='';
	cargarAlum(alum,dl);
	for i:=1 to dl do begin
		masViejos(alum[i],max1,max2,nom1,nom2,ape1,ape2);
		dniPares(alum[i],cDniPares);
	end;
	writeln('El porcentaje de alumnos con solo digitos pares en su DNI es: %',cDniPares*100/dl:0:2);
	writeln('Los dos alumnos mas viejos son :',nom1,' ',ape1,' y ',nom2,' ',ape2);
	readln();
end.



10. Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo
sumo 300 empleados). La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando se
completa el vector. Una vez finalizada la carga de datos se pide:
a) Realizar un módulo que incremente el salario de cada empleado en un 15%. Para ello, implementar un
módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión lógica y
retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.
b) Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa.

a)
procedure incrementarVecX(x: real; var v:vector;dl:integer);
	var
		i: integer;
	begin
		for i:1 to dl do begin
			v[i]:= v[i]*x;
		end;
	end;
b)
procedure indormarSueldoPromedio(v:vector;dl:integer);
var
	i,tSueldo: integer;
begin
	tSueldo:=0;
	for i:=1 to dl do begin
		tsueldo:= tSueldo + v[i];
	end;
	Writeln('El sueldo promedio de los empleados es: $',tsueldo*100/dl:0:2);
end;


program ejer_10;

const
	tam= 300;
	
type
	vector= array[1..tam] of real;
	
procedure cargarV(var v:vector;var dl:integer);
	var
		sal:real;
	begin
		dl:=0;
		writeln('Ingrese los salarios de sus empleados: ');
		readln(sal);
		while (sal<>0) and (dl<tam) do begin
			dl:= dl+1;
			v[dl]:=sal;
			readln(sal);
		end;
	end;
	
procedure incrementarVecX(x: real; var v:vector;dl:integer);
	var
		i: integer;
	begin
		for i:=1 to dl do begin
			v[i]:= v[i] + v[i]*x/100;
		end;
	end;
	
procedure informarSueldoPromedio(v:vector;dl:integer);
	var
		i: integer;
		tSueldo: real;
	begin
		tSueldo:=0;
		for i:=1 to dl do
			tsueldo:= tSueldo + v[i];
		Writeln('El sueldo promedio de los empleados es: $',tsueldo/dl:0:2);
	end;

var
	empleados:vector;
	dl:integer;
	porcAumento:real;
begin
	porcAumento:=15;
	cargarV(empleados,dl);
	incrementarVecX(porcAumento,empleados,dl);
	informarSueldoPromedio(empleados,dl);
end.



11. El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales. Para
ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez finalizada la
lectura, el programa debe procesar los datos e informar:
	a) Título de la foto más vista (la que posee mayor cantidad de clics).
	b) Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
	c) Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.
	
Echo en clase



12. En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular; 4.
irregular), su masa (medida en kg) y la distancia en pársecs (pc) medida desde la Tierra. La Unión
Astronómica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo
Local. Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:
a) la cantidad de galaxias de cada tipo.
b) la masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el
porcentaje que esto representa respecto a la masa de todas las galaxias.
c) la cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
d) el nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.

program ejer_12;

const
	df=4;
	cTipos=4;
	
type
	cupla= record
		nom1: string;
		nom2: string;
		can1: real;
		can2: real;
	end;
	galaxia= record
		nombre: string;
		tipo: integer;
		masa: real;
		distancia:integer;
	end;
	tipoG= record
		nombre: string;
		cant: integer;
	end;
	ggalaxias= array[1..df] of galaxia;
	tipos= array[1..cTipos] of tipoG;
	
procedure leerG(var g: galaxia);
	begin
		Write('Nombre: ');readln(g.nombre);
		Write('Tipo: ');readln(g.tipo);
		Write('Masa: ');readln(g.masa);
		Write('Distancia: ');readln(g.distancia);
	end;
	
procedure cargarV(var v:ggalaxias);
	var
		g:galaxia;
		i:integer;
	begin
		writeln('Ingrese los datos de cada galaxia');
		for i:=1 to df do begin
			leerG(g);
			v[i]:=g;
		end;
	end;
	
procedure setearCeros(var v:tipos);
	var
		i: integer;
	begin
		for i:=1 to ctipos do
			v[i].cant:= 0;
	end;
	
procedure sumarTipo(tipo: integer;var v:tipos);
	begin
		v[tipo].cant:= v[tipo].cant + 1;
	end;
	
procedure sumarMasa(nom: string; masa: real; var masa3,masat: real);
	begin
		if (nom='Via Lactea') or (nom='Andromeda') or (nom='Triangulo') then
			masa3:= masa3 + masa;
		masat:= masat + masa;
	end;
	
procedure contadorNoIrregulares(var cantNI: integer; tipo,distancia: integer);
	begin
		if (tipo<>4) and (distancia<1000) then
			cantNI:= cantNI +1;
	end;
	
procedure actualizarMaxMin(nom: string; masa: real; var max,min:cupla);
	begin
		if masa>max.can1 then begin
			max.can2:=max.can1;
			max.can1:=masa;
			max.nom2:=max.nom1;
			max.nom1:=nom;
		end
		else if masa>max.can2 then begin
			max.can2:=masa;
			max.nom2:=nom;
		end;
		if masa<min.can1 then begin
			min.can2:=min.can1;
			min.can1:=masa;
			min.nom2:=min.nom1;
			min.nom1:=nom;
		end
		else if masa<min.can2 then begin
			min.can2:=masa;
			min.nom2:=nom;
		end;
	end;

procedure recorrerV(v: ggalaxias; var cantTipos:tipos; var max,min: cupla;var cantNI:integer; var masa3,masat: real);
	var
		i: integer;
	begin
		cantNI:=0;
		masa3:=0;
		masat:=0;
		for i:=1 to df do begin
			sumarTipo(v[i].tipo,cantTipos);
			sumarMasa(v[i].nombre,v[i].masa,masa3,masat);
			contadorNoIrregulares(cantNI,v[i].tipo,v[i].distancia);
			actualizarMaxMin(v[i].nombre,v[i].masa,max,min);
		end;
	end;
	
procedure informarV(t:tipos; max,min:cupla; cantNI:integer; masa3,masat: real);
	var
	i: integer;
	begin
		writeln('La cantidad de galaxias de cada tipo es :');
		for i:=1 to ctipos do
			writeln(t[i].cant,' para ',t[i].nombre);
		writeln('La masa total acumulada de las 3 galaxias principales es: ',masa3:1:2,'kg');
		writeln('El porcentaje que esto representa respecto a la masa de todas las galaxias es: %',masa3*100/masat:1:2);
		writeln('La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc es: ', cantNI);
		writeln('El nombre de las dos galaxias con mayor masa son: ',max.nom1,' y ', max.nom2);
		writeln('El nombre de las dos galaxias con menor masa son: ',min.nom1,' y ', min.nom2);
	end;
	
	
var
	max: cupla;
	min: cupla;
	galaxias: ggalaxias;
	cantNI:integer;
	masa3,masat: real;
	cantTipos: tipos;
begin
	max.can1:=-1;
	max.nom1:='';
	min.can1:=9999;
	min.nom1:='';
	setearCeros(cantTipos);
	cantTipos[1].nombre:='eliptica';
	cantTipos[2].nombre:='espiral';
	cantTipos[3].nombre:='lenticular';
	cantTipos[4].nombre:='irregular';
	cargarV(galaxias);
	recorrerV(galaxias,cantTipos,max,min,cantNI,masa3,masat);
	informarV(cantTipos,max,min,cantNI,masa3,masat);
	readln();
end.



13. El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los
años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares,
obtiene un promedio anual. Este relevamiento se viene realizando desde hace 50 años, y con todos los
datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos. Realizar un
programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la
información se ingresa ordenada por año). Una vez finalizada la carga de la información, obtener:
	a) el año con mayor temperatura promedio a nivel mundial.
	b) el año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.

program ejer_13;
const
	dflug=5;
	dfanos=4;
type
	lugares= array[1..dflug] of real;
	anos= array[1..dfanos] of lugares;

procedure leerLugares(var v : lugares);
	var
		i: integer;
	begin
		for i:=1 to dflug do
			readln(v[i]);
	end;
procedure cargarAnos(var v: anos);
	var
		i:integer;
	begin
		writeln('Proceda a cargar los datos de los ultimos 50 anos');
		for i:= 1 to dfanos do begin
			writeln('Escriba las temperaturas promedio de cada lugar, para el ano ',i);
			leerLugares(v[i]);
		end;
	end;
procedure maxTemp(temp:real; var tmax:real);
	begin
		if temp>tmax then
			tmax:= temp;
	end;
procedure sumarTemp(temp: real;var ttotal:real);
	begin
		ttotal:= ttotal + temp;
	end;
procedure recorrerLugares(v: lugares; var tmax,tprom: real);
	var
		i: integer;
		ttotal:real;
	begin
		tmax:=-1;
		ttotal:=0;
		for i:=1 to dflug do begin
			writeln(v[i]);
			maxTemp(v[i],tmax);
			sumarTemp(v[i],ttotal);
		end;
		tprom:= ttotal/dflug;
	end;
procedure maxTempAnual(tanual:real;var tmax:real;i:integer;var anoMaxTemp:integer);
	begin
		writeln(tanual:1:0,' ',tmax:1:0);
		if tanual>tmax then begin
			tmax:=tanual;
			anoMaxTemp:= i;
		end;
	end;
procedure maxPromAnual(promanual:real;var promMax:real;i:integer;var anoMaxProm:integer);
	begin
		if promanual>promMAx then begin
			promMAx:=promanual;
			anoMaxProm:= i;
		end;
	end;
procedure recorrerAnos(v: anos; var anoMaxProm,anoMaxTemp: integer);
	var
		i: integer;
		tanual,promanual,tmax,prommax: real;
	begin
		tmax:=-1;
		prommax:=-1;
		for i:=1 to dfanos do begin
			recorrerLugares(v[i],tanual,promanual);
			maxTempAnual(tanual,tmax,i,anoMaxTemp);
			maxPromAnual(promanual,promMax,i,anoMaxProm);
		end;
	end;
procedure informar(anoMaxProm,anoMaxTemp:integer);
	begin
		writeln('El año con mayor temperatura promedio a nivel mundial fue cargado en la posicion ',anoMaxProm);
		writeln('El año con la mayor temperatura detectada en algún punto del planeta fue cargado en la posicion ',anoMaxTemp);
	end;
var
	listado:anos;
	anoMaxProm,anoMaxTemp: integer;
begin
	cargarAnos(listado);
	recorrerAnos(listado,anoMaxProm,anoMaxTemp);
	informar(anoMaxProm,anoMaxTemp);
end.



14. El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
		CÓDIGO 		ROL DEL DESARROLLADOR 						VALOR/HORA (USD)
			1 			Analista Funcional 							35,20
			2 			Programador 								27,45
			3 			Administrador de bases de datos 			31,03
			4 			Arquitecto de software 						44,28
			5 			Administrador de redes y seguridad 			39,87
			
		Nota: los valores/hora se incluyen a modo de ejemplo
		
	Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
	proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
	residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
	dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
	-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
		a) El monto total invertido en desarrolladores con residencia en Argentina.
		b) La cantidad total de horas trabajadas por Administradores de bases de datos.
		c) El código del proyecto con menor monto invertido.
		d) La cantidad de Arquitectos de software de cada proyecto.
}
program ejer_14;

const
	dfp= 10;
	NROLES= 5;
type
	rol= record
		nombre: string;
		valor: real;
	end;
	tabla= array[1..NROLES] of rol;
	desarrollador=record
		pais:string;
		codigo:integer;
		nombrep:string;
		rol:integer;
		horas:real;
	end;
	proyecto= record
		cantArq: integer;
		montoTotal: real;
	end;
	proyectos= array[1..dfp] of proyecto;
	
procedure leerRol(var r: rol);	//se dispone
	begin
	end;
procedure cargarTabla(var vT: tabla);	//se dispone
	begin
	end;
procedure leerD(var desa:desarrollador);
	begin
		write('Codigo de proyecto: ');readln(desa.codigo);
		if desa.codigo<>-1 then begin
			write('Nombre de proyecto: ');readln(desa.nombrep);
			write('Rol cumplido: ');readln(desa.rol);
			write('Horas trabajadas: ');readln(desa.horas);
			write('Pais: ');readln(desa.pais);
		end;
	end;
procedure montoDesa(desa:desarrollador; vT: tabla; var monto:real);
	begin
		monto:=desa.horas *vT[desa.rol].valor;
	end;
procedure calcmin(monto:real;codigo:integer; var montoMin:real;var codigoMin:integer);
	begin
		if monto<montoMin then begin
			montoMin:=monto;
			codigoMin:=codigo;
		end;
	end;
procedure infCantAS(codigo,cantArq:integer);
	begin
		writeln('La cantidad de Arquitectos de software para el proyecto ',codigo,' es de: ',cantArq);
	end;
procedure recorrerListado2017(lista: proyectos;var codigoMin: integer);
	var
		i:integer;
		montoMin: real;
	begin
		montoMin:=9999;
		for i:=1 to dfp do begin
			calcmin(lista[i].montoTotal,i,montoMin,codigoMin);
			infCantAS(i,lista[i].cantArq);
		end;	
	end;
procedure actualizarReal(num:real;var numTotal:real);
	begin
		numTotal:= numTotal+num;
	end;
procedure actualizarEntero(num:integer;var numTotal:integer);
	begin
		numTotal:= numTotal+num;
	end;
procedure cargarListado2017(var lista:proyectos;var montoTArg,horasTA:real; vT: tabla);
	var
	desa:desarrollador;
	monto:real;
	begin
		montoTArg:=0;
		horasTA:=0;
		writeln('Proceda a cargar todos los desarrolladores del 2017');
		leerD(desa);
		while desa.codigo<>-1 do begin
			montoDesa(desa,vT,monto);
			actualizarReal(monto,lista[desa.codigo].montoTotal);
			if desa.pais='Argentina' then
				actualizarReal(monto,montoTArg);
			if desa.rol=3 then
				actualizarReal(desa.horas,horasTA);
			if desa.rol=4 then
				actualizarEntero(1,lista[desa.codigo].cantArq);
			leerD(desa);
		end;
	end;
procedure setearCantArq0(var lista:proyectos);
	var
		i:integer;
	begin
		for i:=1 to dfp do
			lista[i].cantArq:=0;
	end;

var
	vT: tabla;
	lista:proyectos;
	montoTArg,horasTA:real;
	codigoMin:integer;
begin
	cargarTabla(vT);
	setearCantArq0(lista);
	cargarListado2017(lista,montoTArg,horasTA,vT);
	recorrerListado2017(lista,codigoMin);
	writeln('El monto total invertido en desarrolladores Argentinos es: $',montoTArg:0:2);
	writeln('La cantidad total de horas trabajadas por ABD es de: ',horasTA:0:2,' horas');
	writeln('El código del proyecto con menor monto invertido es el: ',codigoMin);
	readln();
end.
