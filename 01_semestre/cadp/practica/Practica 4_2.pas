{Practica 4_2

1. a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un
valor n y retorne si n se encuentra en el vector o no.
b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
ascendente.

a)
function buscar(v: vector; dl,n:integer):boolean;
	var
		i:integer;
	begin
		i:=1;
		while (i<=dl) and (v[i]<>n) do 
			i:=i+1;
		buscar:= v[i]=n
	end;
b)
function buscar(v: vector; dl,n:integer):boolean;
	var
		i:integer;
	begin
		i:=1;
		while (i<=dl) and (v[i]<>n) and (v[i]<n) do 
			i:=i+1;
		buscar:= v[i]=n
	end;



2. Realice un programa que resuelva los siguientes incisos:
	a. Lea nombres de alumnos y los almacene en un vector de a lo sumo 500 elementos. La lectura finaliza
	cuando se lee el nombre ‘ZZZ’, que no debe procesarse.
	b. Lea un nombre y elimine la primera ocurrencia de dicho nombre en el vector.
	c. Lea un nombre y lo inserte en la posición 4 del vector.
	d. Lea un nombre y lo agregue al vector.
	Nota: Realizar todas las validaciones necesarias.

program ejer_2;

const
	df= 500;
	ccarga= 'ZZZ';
type
	alumnos= array[1..df] of string;

procedure cargar(var v: alumnos; var dl: integer);
	var
		nom: string;
	begin
		dl:=0;
		readln(nom);
		while (nom<>ccarga) and (dl<df)do begin
			dl:= dl +1;
			v[dl]:=nom;
			writeln(v[dl]);
			readln(nom);
		end;
	end;
procedure eliminarNom(var v: alumnos;var dl: integer);
	var
		nom: string;
		i: integer;
	begin
		i:=1;
		readln(nom);
		while (v[i]<>nom) and (i<dl) do
			i:= i +1;
		if v[i]=nom then begin
			dl:=dl-1;
			for i:=i to dl do begin
				v[i]:=v[i+1];
			end;
		end;
	end;
procedure insertar4(var v: alumnos;var dl:integer);
	var
		nom:string;
		i:integer;
	begin
		readln(nom);
		if dl<df then begin
			for i:=dl downto 4 do	
				v[i+1]:= v[i];
			v[4]:=nom;
			dl:= dl+1;
		end;
	end;
procedure agregarNom(var v: alumnos;var dl:integer);
	var
		nom:string;
	begin
		readln(nom);
		if dl<df then begin
			dl:= dl+1;
			v[dl]:= nom;
		end;
	end;
var
	v:alumnos;
	dl:integer;
begin
	cargar(v,dl);
	eliminarNom(v,dl);
	insertar4(v,dl);
	agregarNom(v,dl);
end.



3. Una empresa de transporte de caudales desea optimizar el servicio que brinda a sus clientes. Para ello,
cuenta con información sobre todos los viajes realizados durante el mes de marzo. De cada viaje se cuenta
con la siguiente información: día del mes (de 1 a 31), monto de dinero transportado y distancia recorrida
por el camión (medida en kilómetros).
	a) Realizar un programa que lea y almacene la información de los viajes (a lo sumo 200). La lectura finaliza
	cuando se ingresa una distancia recorrida igual a 0 km, que no debe procesarse.
	b) Realizar un módulo que reciba el vector generado en a) e informe:
	- El monto promedio transportado de los viajes realizados
	- La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero.
	- La cantidad de viajes realizados cada día del mes.
	c) Realizar un módulo que reciba el vector generado en a) y elimine todos los viajes cuya distancia recorrida
	sea igual a 100 km.
	Nota: para realizar el inciso b, el vector debe recorrerse una única vez

program ejer_3;

const
	df=200;
	
type
	viaje= record
		dia: integer;
		monto: real;
		distancia: real;
	end;
	viajes= array[1..df] of viaje;
	vpordias= array[1..31] of integer;

procedure leerViaje(var via: viaje);
	begin
		writeln('Ingrese los datos del viaje:');
		write('Distancia: ');readln(via.distancia);
		if via.distancia<>0 then begin
			write('Dia: ');readln(via.dia);
			write('Monto: ');readln(via.monto);
		end;
	end;
procedure cargarViajes(var vMarzo: viajes; var dl: integer);
	var
		via: viaje;
	begin
		dl:= 0;
		leerViaje(via);
		while (via.distancia<>0) and (dl<df) do begin
			dl:= dl +1;
			vMarzo[dl]:=via;
			leerViaje(via);
		end;
	end;
procedure setearCeros(var v:vpordias);
	var
		i: integer;
	begin
		for i:=1 to 31 do
			v[i]:=0;
	end;
procedure sumarMonto(monto: real; var montoTotal:real);
	begin
		montoTotal:= monto + montoTotal;
	end;
procedure calcMin(via: viaje; var menos: viaje);
	begin
		if via.monto<menos.monto then begin
			menos:= via;
		end;
	end;
procedure recorrerViajes(via: viajes; dl: integer);
	var
		i: integer;
		montoT:real;
		menos: viaje;
		viajesPorDia: vpordias;
	begin
		montoT:=0;
		menos.monto:=9999;
		setearCeros(viajesPorDia);
		for i:=1 to dl do begin
			sumarMonto(via[i].monto,montoT);
			calcMin(via[i],menos);
			viajesPorDia[via[i].dia]:= viajesPorDia[via[i].dia] + 1;
		end;
		writeln('El monto promedio de los viajes realizados es de: $',(montoT/dl):0:2);
		writeln('El día del mes en que se realizó el viaje que transportó menos dinero fue',menos.dia,' y su distancia recorrida fue ',menos.distancia);
		for i:=1 to 31 do begin
			writeln('La cantidad de viajes realizados para el dia ',i,' es de ',viajesPorDia[i],' viajes');
		end;
	end;
procedure eliminarPos(var v: viajes; var dl:integer; pos: integer);
	begin
		dl:=dl-1;
		for pos:=pos to dl do
			v[pos]:= v[pos+1];
	end;
procedure eliminarViajes100(var v:viajes;var dl: integer);
	var
		i:integer;
	begin
		for i:=1 to dl do
			if v[i].distancia=100 then
				eliminarPos(v,dl,i);
	end;
var
	vMarzo: viajes;
	dl:integer;
begin
	cargarViajes(vMarzo,dl);
	recorrerViajes(vMarzo,dl);
	eliminarViajes100(vMarzo,dl);
end.



4. Una cátedra dispone de información de sus alumnos (a lo sumo 1000). De cada alumno se conoce nro de
alumno, apellido y nombre y cantidad de asistencias a clase. Dicha información se encuentra ordenada por
nro de alumno de manera ascendente. Se pide:
	a. Un módulo que retorne la posición del alumno con un nro de alumno recibido por parámetro. El
	alumno seguro existe.
	b. Un módulo que reciba un alumno y lo inserte en el vector.
	c. Un módulo que reciba la posición de un alumno dentro del vector y lo elimine.
	d. Un módulo que reciba un nro de alumno y elimine dicho alumno del vector
	e. Un módulo que elimine del vector todos los alumnos con cantidad de asistencias en 0.
	Nota: Realizar el programa principal que invoque los módulos desarrollados en los incisos previos con
	datos leídos de teclado.

program ejer_4;

const
	df= 1000;

type
	alumno= record
		numero: integer;
		apellido: string;
		nombre: string;
		asistencias: integer;
	end;
	alumnos= array[1..df] of alumno;

procedure buscarAlum(v: alumnos;dl,num: integer; var pos: integer;var ok: boolean);
	begin
		pos:=1;
		while (v[pos].numero<>num) and (pos<dl) do 
			pos:= pos+1;
		ok:= v[pos].numero=num;
	end;
procedure insertarAlum(var v: alumnos; var dl: integer; alum: alumno;var ok:boolean);
	var
		i,pos:integer;
	begin
		pos:=1;
		ok:=dl<df;
		if ok then begin
			while (pos<=dl) and (v[pos].numero<alum.numero)  do
				pos:= pos +1;
			for i:=dl downto pos do
				v[dl+1]:=v[dl];
			dl:= dl+1;
			v[pos]:=alum;
		end;
	end;
procedure eliminarAlumPos(var v: alumnos; var dl: integer; pos: integer);
	begin
		dl:=dl-1;
		for pos:=pos to dl do
			v[pos]:= v[pos+1];
	end;
procedure eliminarAlumNum(var v: alumnos; var dl: integer; num: integer);
	var
		pos:integer;
		ok:boolean;
	begin
		buscarAlum(v,dl,num,pos,ok);
		if ok then
			eliminarAlumPos(v,dl,pos);
	end;
procedure eliminarAlumAsis0(var v: alumnos; var dl: integer);
	var
		i:integer;
	begin
		for i:=1 to dl do
			if v[i].asistencias = 0 then
				eliminarAlumPos(v,dl,i);
	end;


procedure eleccion(var c:char);
	begin
		writeln('Ingrese el numero de la operacion a realizar');
		writeln('1-Buscar la posicion del alumno en el listado segun su numero');
		writeln('2-Insertar nuevo alumno al listado por su numero');
		writeln('3-Eliminar alumno segun su posicion en el listado');
		writeln('4-Eliminar alumno segun su numero de alumno');
		writeln('5-Eliminar alumnos con 0 asistencias del listado');
		writeln('0-Salir del programa');
		readln(c);
		writeln();
	end;
procedure cargarListado(var v:alumnos; var dl: integer);
	begin
		v[1].nombre:='sape el peluca';
		v[1].asistencias:= 10;
		v[1].numero:=3;
		dl:=1;
	end;
procedure leerAlum(var alum: alumno);
	begin
		writeln('Ingrese los datos del alumno:');
		write('Numero: ');readln(alum.numero);
		write('Nombre: ');readln(alum.nombre);
		write('Apellido: ');readln(alum.apellido);
		write('Cantidad asistencias: ');readln(alum.asistencias);
	end;
var
	listado: alumnos;
	dl,num,pos:integer;
	opcion:char;
	ok:boolean;
	alum:alumno;
begin
	cargarListado(listado,dl);
	repeat
		eleccion(opcion);
		case opcion of
			'1': begin
					write('Ingrese el numero: ');readln(num);
					buscarAlum(listado,dl,num,pos,ok);
						if ok then
							writeln('El alumno buscado esta en la posicion ',pos)
						else writeln('No se encontro');
					writeln();
				end;
			'2': begin
					leerAlum(alum);
					insertarAlum(listado,dl,alum,ok);
					if ok then 
						writeln('Se inserto correctamente')
					else
						writeln('No se puede insertar');
					writeln();
				end;
			'3': begin
					write('Ingrese la posicion a eliminar: ');readln(pos);
					eliminarAlumPos(listado,dl,pos);
					writeln();
				end;
			'4': begin
					write('Ingrese el numero a eliminar: ');readln(num);
					eliminarAlumNum(listado,dl,num);
					writeln();
				end;
			'5': begin
					eliminarAlumAsis0(listado,dl);
					writeln('Todos los alumnos con 0 asistencias fueron eliminados del listado');
					writeln();
				end;
		end;
	until opcion='0';
end.



5) 	La empresa Amazon Web Services (AWS) dispone de la información de sus 500 clientes monotributistas más
	grandes del país. De cada cliente conoce la fecha de firma del contrato con AWS, la categoría del monotributo
	(entre la A y la F), el código de la ciudad donde se encuentran las oficinales (entre 1 y 2400) y el monto mensual
	acordado en el contrato. La información se ingresa ordenada por fecha de firma de contrato (los más antiguos
	primero, los más recientes últimos).
	Realizar un programa que lea y almacene la información de los clientes en una estructura de tipo vector. Una
	vez almacenados los datos, procesar dicha estructura para obtener:
		1) Cantidad de contratos por cada mes y cada año, y año en que se firmó la mayor cantidad de contratos
		2) Cantidad de clientes para cada categoría de monotributo
		3) Código de las 10 ciudades con mayor cantidad de clientes
		4) Cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes

program ejer_5;
	
const
	dfclientes=5;
	dfciudades=2400;
	
type
	ciudad= record
		codigo: 1..2400;
		cantidad: integer;
	end;
	
	fecha= record
		dia: 0..31;
		mes: 0..12;
		ano: 0..9999;
	end;
	
	cliente= record
		firma: fecha;
		categoria: 'A'..'F';
		oficina: 1..2400;
		monto: real;
	end;
	
	clientes= array[1..dfclientes] of cliente;
	categorias= array['A'..'F'] of integer;
	ciudades= array[1..dfciudades] of integer;
	maxciudades= array[1..10] of ciudad;
	
	
procedure leerCliente(var c: cliente);
	begin
		writeln('Ingrese los datos solicitados');
		writeln('Fecha de firma:');
		write('	Dia: ');readln(c.firma.dia);
		write('	Mes: ');readln(c.firma.mes);
		write('	Ano: ');readln(c.firma.ano);
		write('Categoria Monotributo: ');readln(c.categoria);
		write('Codigo ciudad: ');readln(c.oficina);
		write('Monto Mensual: ');readln(c.monto);
	end;
	
procedure cargarClientes(var v: clientes);
	var
		i:integer;
		c: cliente;
	begin
		for i:=1 to dfclientes do begin
			leerCliente(c);
			v[i]:=c;
		end;
	end;
	
procedure setear0Ciu(var ciu: ciudades);
	var
		i: integer;
	begin
		for i:=1 to dfciudades do
			ciu[i]:= 0;
	end;
	
procedure sumarMonto(monto: real; var montoT: real);
	begin
		montoT:= monto + montoT;
	end;
	
procedure contar(v: clientes; prom: real; var cantMaxProm:integer);
	var
		i:integer;
	begin
		for i:=1 to dfclientes do
			if v[i].monto>prom then
				cantMaxProm:= cantMaxProm +1;
	end;

procedure setear0MaxCiu(var maxciu:maxciudades);
	var
		i:integer;
	begin
		for i:=1 to 10 do
			maxciu[i].cantidad:=0;
	end;
	
procedure calc10Max(ciu: ciudades; var maxciu: maxciudades);
	var
		i,i2:integer;
	begin
		setear0maxciu(maxciu);
		for i:=1 to dfciudades do begin
			i2:=10;
			while (i2>0) and (ciu[i]>maxciu[i2].cantidad) do begin
				if i2<10 then begin
					maxciu[i2+1].cantidad:= maxciu[i2].cantidad;
					maxciu[i2+1].codigo:= maxciu[i2].codigo;
				end;
				maxciu[i2].cantidad:=ciu[i];
				maxciu[i2].codigo:=i;
				i2:=i2-1;
			end;
		end;
	end;
	
procedure anoMaxContrato(cant,ano: integer; var cantMax,anoMax:integer);
	begin
		if cant>cantmax then begin
			cantmax:= cant;
			anoMax:= ano;
		end;
	end;
	
procedure sumarCategoria(cat: char;var cate: categorias);
	begin
		cate[cat]:=cate[cat] +1;
	end;
	
procedure recorrerClientes(var v: clientes;var anoMax:integer;var cate: categorias;var ciu: ciudades;var cantMaxProm: integer);
	var
		i,ano,mes,cantAno,cantMes,cantMax:integer;
		montoT:real;
	begin
		i:=1;
		cantMaxProm:=0;
		cantMax:=0;
		setear0Ciu(ciu);
		while i<=dfclientes do begin
			ano:=v[i].firma.ano;
			cantAno:=0;
			while (i<=dfclientes) and (v[i].firma.ano=ano) do begin
				mes:=v[i].firma.mes;
				cantMes:=0;
				while (i<=dfclientes) and (v[i].firma.ano=ano) and (v[i].firma.mes=mes) do begin
					cantMes:= cantMes +1;
					sumarCategoria(v[i].categoria,cate);
					ciu[v[i].oficina]:= ciu[v[i].oficina]+1;
					sumarMonto(v[i].monto,montoT);
					i:= i +1;
				end;
				writeln('La cantidad de contratos para el mes ',mes,' en el ano ',ano,' es de: ',cantMes);
				cantAno:= cantAno + cantMes;
			end;
			writeln('La cantidad de contratos para el ano ',ano,' es de: ',cantAno);
			anoMaxContrato(cantAno,ano,cantMax,anoMax);
		end;
		contar(v,montoT/dfclientes,cantMaxProm);
	end;
	
procedure informarCategorias(v: categorias);
	var
		i:char;
	begin
		for i:='A' to 'F' do
			writeln('La cantidad de monotributistas de categoria ',i,' es de: ',v[i]);
	end;
	
procedure informar10(v: maxciudades);
	var
		i:integer;
	begin
		for i:=1 to 10 do
			writeln('El puesto ',i,' en cantidad de clinetes corresponde a la ciudad con codigo: ',v[i].codigo);
	end;
	
procedure informar(anoMax:integer;cate: categorias; maxciu: maxciudades; cantMaxProm: integer);
	begin
		writeln('El ano con mayor cantidad de clientes es: ',anoMax);
		informarCategorias(cate);
		informar10(maxciu);
		writeln('La cantidad de clientes que supera el monto promedio es: ',cantMaxProm);
	end;
	

var
	socios: clientes;
	anoMax,cantMaxProm:integer;
	cate: categorias;
	ciu: ciudades;
	maxciu: maxciudades;
begin
	cargarClientes(socios);
	recorrerClientes(socios,anoMax,cate,ciu,cantMaxProm);
	calc10Max(ciu,maxciu);
	informar(anoMax,cate,maxciu,cantMaxProm);
end.



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Extras
}
1) La compañía Canonical Llt. desea obtener estadísticas acerca del uso de Ubuntu Linux en La Plata. Para ello,
debe realizar un programa que lea y almacene información sobre las computadoras con este sistema
operativo (a lo sumo 10.000). De cada computadora se conoce código de computadora, la versión de Ubuntu
que utilizan (18.04, 17.10, 17.04, etc.), la cantidad de paquetes instalados y la cantidad de cuentas de usuario
que poseen. La información debe almacenarse ordenada por código de computadora de manera
ascendente. La lectura finaliza al ingresar el código de computadora -1, que no debe procesarse. Una vez
almacenados todos los datos, se pide:
	a) Informar la cantidad de computadoras que utilizan las versiones 18.04 o 16.04.
	b) Informar el promedio de cuentas de usuario por computadora.
	c) Informar la versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados.
	d) Eliminar la información de las computadoras con código entre 0 y 500.











	
	
2) Continuando con los 3 ejercicios adicionales de la Guía opcional de actividades adicionales, ahora
utilizaremos vectores para almacenar la información ingresada por teclado. Consideraciones
importantes:
	- Los datos ingresados por teclado deberán almacenarse en una estructura de tipo vector
	apropiada. Dado que en ninguno de los ejercicios se indica la cantidad máxima de datos a leer,
	para poder utilizar un vector asumimos que en todos los casos se ingresarán a lo sumo 5000
	datos (donde cada dato será o bien una inversión, un alumno o un tanque de agua, según lo
	indica cada ejercicio).
	- Una vez leídos y almacenados los datos, deberán procesarse (recorrer el vector) para resolver
	cada inciso. Al hacerlo, deberán reutilizarse los módulos ya implementados en la práctica
	anterior. En la medida de lo posible, el lector deberá recorrerse una única vez para resolver
	todos los incisos.
}
