{Practica 3

1. Dado el siguiente programa:
program Registros;
type
	str20 = string[20];
	alumno = record
		codigo : integer;
		nombre : str20;
		promedio : real;
	end;
procedure leer(var alu : alumno);
	begin
		writeln(‘Ingrese el código del alumno’);
		read(alu.codigo);
		if (alu.codigo <> 0) then begin
			writeln(‘Ingrese el nombre del alumno’); read(alu.nombre);
			writeln(‘Ingrese el promedio del alumno’); read(alu.promedio);
		end;
	end;
var
	a : alumno;
begin
	...
end.
	a. Completar el programa principal para que lea información de alumnos (código, nombre, promedio) e informe
la cantidad de alumnos leídos. La lectura finaliza cuando ingresa un alumno con código 0, que no debe
procesarse. Nota: utilizar el módulo leer.
	b. Modificar al programa anterior para que, al finalizar la lectura de todos los alumnos, se informe también el
nombre del alumno con mejor promedio

a.
	talum:=0;
	leer(a);
	while a.codigo<>0 do begin
		talum:= talum +1;
		leer(a);
	end;
b. 
	procedure maxpromedio(alum: alumno; var maxprom:real; var maxnombre:strin;);
		begin
			if alum.promedio>maxprom then begin
				maxprom:= alum.maxprom;
				maxnombre:=	alum.nombre;
			end;
		end;
	var
		talum: integer;
		maxprom: real;
		maxnombre: string[20];
	begin
		maxprom:=0;
		talum:=0;
		leer(a);
		while a.codigo<>0 do begin
			talum:= talum +1;
			maxpromedio(a,maxprom,maxnombre);
			leer(a);
		end;
		writeln('El total de alumnos ingresados fue: ',talum);
		writeln('El alumno con mayor promedio fue: ',maxnombre);
	end.
	
	
	
2. El registro civil de La Plata ha solicitado un programa para analizar la distribución de casamientos durante el año
2019. Para ello, cuenta con información de las fechas de todos los casamientos realizados durante ese año.
	a) Analizar y definir un tipo de dato adecuado para almacenar la información de la fecha de cada casamiento.
	b) Implementar un módulo que lea una fecha desde teclado y la retorne en un parámetro cuyo tipo es el definido
	en el inciso a).
	c) Implementar un programa que lea la fecha de todos los casamientos realizados en 2019. La lectura finaliza al
	ingresar el año 2020, que no debe procesarse, e informe la cantidad de casamientos realizados durante los
	meses de verano (enero, febrero y marzo) y la cantidad de casamientos realizados en los primeros 10 días de
	cada mes. Nota: utilizar el módulo realizado en b) para la lectura de fecha.
	
a)
	type
	fecha = record;
		dia: integer;
		mes: integer;
		ano: integer;
	end;
b) 
procedure leer(var a: fecha);
	begin
		writeln('Por favor ingrese la fecha de su casamiento');
		write('Dia: ');readln(a.dia);
		write('Mes: ');readln(a.mes);
		write('Ano: ');readln(a.ano);
	end;
c)
program ejer_2c;
type
	fecha = record
		dia: integer;
		mes: integer;
		ano: integer;
	end;
procedure leer(var a: fecha);
	begin
		writeln('Por favor ingrese la fecha de su casamiento');
		write('Dia: ');readln(a.dia);
		write('Mes: ');readln(a.mes);
		write('Ano: ');readln(a.ano);
	end;
function es2019(a:fecha):boolean;
	begin
	es2019:= a.ano=2019;
	end;
function esverano(a:fecha):boolean;
	begin
		esverano:= (a.mes=1) or (a.mes=2) or (a.mes=3);
	end;
function es10(a:fecha):boolean;
	begin
		es10:= a.dia<=10;
	end;
var
casamiento: fecha;
tcasaverano, tcasa10: integer;
begin
	tcasaverano:=0;
	tcasa10:=0;
	leer(casamiento);
	while casamiento.ano<>2020 do begin
		if es2019(casamiento) then begin
			if esverano(casamiento) then
				tcasaverano:= tcasaverano +1;
			if es10(casamiento) then
				tcasa10:= tcasa10 +1;
		end;
		leer(casamiento);
	end;
	writeln('En el verano de 2019 se realizaron ', tcasaverano,' casamientos');
	writeln('Dentro de los primeros 10 dias de cada mes en el 2019 se realizaron ',tcasa10,' casamientos');
	readln();
end.



3. El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs. As,
con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO para el año
2015 (1 docente cada 23,435 alumnos). Para ello, se cuenta con información de: CUE (código único de
establecimiento), nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad. Se pide
implementar un programa que procese la información y determine:
● Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO.
● CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.
El programa debe utilizar:
	a) Un módulo para la lectura de la información de la escuela.
	b) Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la cantidad
	de alumnos y la cantidad de docentes).

a)
procedure leer(var esta: establecimiento);
	begin
		write('Nombre: ');readln(esta.nombre);
		write('CUE: ');readln(esta.cue);
		write('Cantidad docentes: ');readln(esta.cantd);
		write('Cantidad alumnos: ');readln(esta.canta);
		write('Localidad: ');readln(esta.lugar);
	end;
b) 
function relacion(d: integer; a: integer):real;
	begin
		relacion:= a/d;
	end;

program ejer_3;
const
	cantcorte= 4;
	esccomp= 'La Plata';
	promunesco= 23.435;
type
	mejores = record
		nom1: string;
		nom2: string;
		cue1: integer;
		cue2: integer;
		prom1: real;
		prom2: real;
	end;
	establecimiento = record
		nombre: string;
		cue: integer;
		cantd: integer;
		canta: integer;
		lugar: string;
		relaad: real;
	end;
procedure leer(var esta: establecimiento);
	begin
		write('Nombre: ');readln(esta.nombre);
		write('CUE: ');readln(esta.cue);
		write('Cantidad docentes: ');readln(esta.cantd);
		write('Cantidad alumnos: ');readln(esta.canta);
		write('Localidad: ');readln(esta.lugar);
	end;
function relacion(a: integer; d: integer):real;
	begin
		relacion:= a/d;
	end;
procedure maxprom(esta: establecimiento; var mejor:mejores);
	begin
		if esta.relaad<mejor.prom1 then begin
			mejor.prom2:= mejor.prom1;
			mejor.prom1:= esta.relaad;
			mejor.cue2:= mejor.cue1;
			mejor.cue1:= esta.cue;
			mejor.nom2:= mejor.nom2;
			mejor.nom1:= esta.nombre;
		end else if esta.relaad<mejor.prom2 then begin
			mejor.prom2:= esta.relaad;
			mejor.cue2:= esta.cue;
			mejor.nom2:= esta.nombre;
		end;
	end;
var
	escuela: establecimiento;
	mejor:mejores;
	i,cantlp: integer;
begin
	mejor.prom1:=100;
	mejor.cue1:=0;
	mejor.nom1:=' ';
	cantlp:=0;
	writeln('Ingrese los datos de cada escuela');
	for i:=1 to cantcorte do begin
		leer(escuela);
		escuela.relaad:= relacion(escuela.canta,escuela.cantd);
		if (escuela.nombre=esccomp) and (escuela.relaad>promunesco) then
			cantlp:= cantlp +1;
		maxprom(escuela,mejor);
		if i<cantcorte then
			writeln('Siguiente escuela:');
	end;
	writeln('Las escuelas con relacion Alumno-Docente superior a 23,435 en La Plata es: ',cantlp);
	writeln('Las dos escuelas con mejor relacion Alumno-Docente son: ',mejor.nom1,' CUE: ',mejor.cue1,' y ',mejor.nom2,' CUE: ',mejor.cue2);
	readln();
end.



4. Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de
consumo ilimitados (clientes que pagan por lo que consumen). Para cada cliente se conoce su código de cliente y
cantidad de líneas a su nombre. De cada línea se tiene el número de teléfono, la cantidad de minutos consumidos
y la cantidad de MB consumidos en el mes. Se pide implementar un programa que lea los datos de los clientes de
la compañía e informe el monto total a facturar para cada uno. Para ello, se requiere:
	a. Realizar un módulo que lea la información de una línea de teléfono.
	b. Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el
	módulo desarrollado en el inciso a. ) y retorne la cantidad total de minutos y la cantidad total de MB a facturar
	del cliente.
	Nota: para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.
	
a.
procedure tomarlinea(var a:linea);
	begin
		write('Numero de linea: ');readln(a.numero);
		write('Cantidad minutos: ');readln(a.cantmin);
		write('Cantidad MB: ');readln(a.cantmb);
	end;
b.
procedure leer(var a:cliente);
	begin
		write('Codigo de cliente: ');readln(a.codigo);
		write('Cantidad de lineas: ');readln(a.cantlin);
		for i:= 1 to a.cantlin do begin
			tomarlinea(a.lin);
			a.monto:= 3.40*a.lin.cantmin + 1.35*a.lin.cantmb;
		end;
	end;

program ejer_4;
const 
	ccorte = 3;
type
	linea = record
		numero: integer;
		cantmin: real;
		cantmb: real;
	end;
	cliente = record
		codigo: integer;
		cantlin: integer;
		lin: linea;
		monto: real;
	end;
procedure tomarlinea(var a:linea);
	begin
		write('Numero de linea: ');readln(a.numero);
		write('Cantidad minutos: ');readln(a.cantmin);
		write('Cantidad MB: ');readln(a.cantmb);
	end;
procedure leer(var a:cliente);
	var
		i: integer;
	begin
		write('Codigo de cliente: ');readln(a.codigo);
		write('Cantidad de lineas: ');readln(a.cantlin);
		for i:= 1 to a.cantlin do begin
			tomarlinea(a.lin);
			a.monto:= 3.40*a.lin.cantmin + 1.35*a.lin.cantmb;
		end;
	end;
var
usuario:cliente;
i: integer;
begin
	writeln('Ingrese cada cliente para conocer su estado');
	for i:=1 to ccorte do begin
		leer(usuario);
		writeln('El cliente ',usuario.codigo,' debe pagar $',usuario.monto:1:2);
		writeln();
		if i<ccorte then
			writeln('Siguiente');
	end;
	readln();
end.



5. Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee:
marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La
información se ingresa ordenada por marca. Se pide calcular e informar:
a. El precio promedio por marca.
b. Marca y modelo del auto más caro.

program ejer_5;
const
	mcorte= 'ZZZ';
type
	auto = record
		marca: string;
		modelo: string;
		precio: real;
	end;
procedure leer(var a: auto);
	begin
		write('Marca: ');readln(a.marca);
		if a.marca<>mcorte then begin
			write('Modelo: ');readln(a.modelo);
			write('Precio: ');readln(a.precio);
		end;
	end;
procedure preprom(a:real;var ptotal,pprom:real;cant:integer);
	begin
		ptotal:=ptotal+a;
		pprom:= ptotal/cant;
	end;
procedure mascaro(a:auto; var b:auto);
	begin
		if a.precio>b.precio then begin
			b.marca:=a.marca;
			b.modelo:=a.modelo;
			b.precio:=a.precio;
		end;
	end;
var
	carro: auto;
	carrocaro: auto;
	ptotal,pprom: real;
	cant: integer;
	aux: string;
begin
	ptotal:= 0;
	cant:=0;
	carrocaro.precio:=0;
	writeln('Ingrese la informacion solicitada para cada marca');
	leer(carro);
	aux:=carro.marca;
	while carro.marca<>mcorte do begin
		if carro.marca=aux then	begin
			cant:= cant +1;
			preprom(carro.precio,ptotal,pprom,cant);
		end else begin
			writeln('El precio promedio para ',aux,' es $',pprom:1:2);
			writeln();
			ptotal:=0;
			cant:=1;
			preprom(carro.precio,ptotal,pprom,cant);
			aux:= carro.marca;
		end;
		mascaro(carro,carrocaro);
		leer(carro);
	end;
	writeln('El auto mas caro correponde a la marca ',carrocaro.marca,' con el modelo ',carrocaro.modelo);
	readln();
end.



6. Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la
información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de
los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.),
cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en
nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de
forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con 0 cores (que no
debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa
importadora e informe:
	● Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.
	● Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
	● Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de
	al menos 2 Ghz.

program ejer_6;
const
	CCORTE=0;
type
	procesador = record
		marca: string;
		linea: string;
		cores: integer;
		ghz: real;
		nm: integer;
	end;
procedure leer(var a:procesador);
	begin
		write('Marca: ');readln(a.marca);
		write('Linea: ');readln(a.linea);
		write('Cores: ');readln(a.cores);
		write('Ghz: ');readln(a.ghz);
		write('nm: ');readln(a.nm);
	end;
procedure inf222(a: procesador);
	begin
		if (a.cores>1) and (a.nm<=22) then
			writeln(a.marca,' con la linea ',a.linea,' tiene un buen procesador');
	end;
procedure mayor14(mact:string; cact:integer; var m1,m2:string; var cant1,cant2:integer);
	begin
		if cact>cant1 then begin
			cant2:=cant1;
			cant1:=cact;
			m2:=m1;
			m1:=mact;
		end else if cact>cant2 then begin
			cant2:=cact;
			m2:=mact;
		end;
	end;
function buenosmulti(a: string;b : real; c:integer):integer;
	begin
		if ((a='AMD') or (a='Intel')) and (b>=2) then
			buenosmulti:= c + 1
		else buenosmulti:= c;
	end;
var
proce: procesador;
m1,m2,aux: string;
cant1,cant2,cact,cantbm: integer;
begin
	m1:=' ';
	cant1:=0;
	cantbm:=0;
	writeln('Cargue los datos de todos sus procesadores por marca');
	leer(proce);
	while proce.cores<>CCORTE do begin
		aux:=proce.marca;
		cact:=0;
		while (proce.cores<>CCORTE) and (proce.marca=aux) do begin
			inf222(proce);
			if proce.cores>1 then
				cantbm:= buenosmulti(proce.marca,proce.ghz,cantbm);
			if proce.nm=14 then
				cact:= cact +1;
			leer(proce);
		end;
		mayor14(aux,cact,m1,m2,cant1,cant2);
	end;
	writeln();
	writeln('Las dos marcas con mas procesadores de 14nm son: ',m1,' y ',m2);
	writeln('La cantidad de procesadores AMD y Intel buenos son: ',cantbm);
	readln();
end.




7. Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:
	● Cantidad total de centros para cada universidad.
	● Universidad con mayor cantidad de investigadores en sus centros.
	● Los dos centros con menor cantidad de becarios.

program ejer_7;

type
	maximo= record
		nombre: string;
		inves: integer;
	end;
	cchico= record
		nom1: string;
		nom2: string;
		bec1: integer;
		bec2: integer;
	end;
	centro= record
		nombre: string;
		universidad: string;
		cantinves: integer;
		cantbec: integer;
	end;
procedure leer(var a: centro);
	begin
		write('Nombre del centro: ');readln(a.nombre);
		write('Universidad: ');readln(a.universidad);
		write('Cantidad Investigadores: ');readln(a.cantinves);
		write('Cantidad Becarios: ');readln(a.cantbec);
	end;
procedure menosbec(a: string; b: integer; var c:cchico);
	begin
		if b<c.bec1 then begin
			c.bec2:=c.bec1;
			c.bec1:=b;
			c.nom2:=c.nom1;
			c.nom1:=a;
		end
		else if b<c.bec2 then begin
			c.bec2:=b;
			c.nom2:=a;
		end;
	end;
procedure ctuni(var a:integer);
	begin
		a:= a +1;
	end;
procedure esgrande(a: string; b: integer;var c: maximo);
	begin
		if b>c.inves then
			c.nombre:= a;
	end;
var
grupo: centro;
gmin: cchico;
uni: maximo;
aux: string;
ctotal,itotal: integer;
begin
	ctotal:= 0;
	itotal:= 0;
	gmin.bec1:= 999;
	gmin.nom1:=' ';
	uni.inves:= 0;
	leer(grupo);
	aux:= grupo.universidad;
	while grupo.cantinves<>0 do begin
		if grupo.universidad=aux then begin
			ctuni(ctotal);
			itotal:= itotal + grupo.cantinves;
			menosbec(grupo.nombre,grupo.cantbec,gmin);
			esgrande(aux,itotal,uni);
			leer(grupo)
		end
		else begin
			writeln('La Universidad "',aux,'" tiene ',ctotal,' centros de investigacion');
			ctotal:= 0;
			itotal:=0;
			aux:= grupo.universidad;
		end;
	end;
	writeln('La Universidad "',aux,'" tiene ',ctotal,' centros de investigacion');
	writeln('La universidad con mayor cantidad de investigadores es: ',uni.nombre);
	writeln('Los dos centros con menor cantidad de becados son: ',gmin.nom1,' y ', gmin.nom2);
	readln();
end.



8. La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa
Jóvenes y Memoria durante la convocatoria 2020. Cada proyecto posee un código único, un título, el docente
coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el nombre de la
escuela y la localidad a la que pertenecen. Cada escuela puede presentar más de un proyecto. La información se
ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. Realizar un programa que
lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse), e
informe:
	● Cantidad total de escuelas que participan en la convocatoria 2018 y cantidad de escuelas por cada localidad.
	● Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
	● Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.

program ejer_8;

const
	ccorte= -1;
	lmatch= 'Daireaux';
type
	persona= record
		dni: real;
		nombre: string;
		apellido: string;
		email: string;
	end;
	proyecto= record
		codigo: integer;
		titulo: string;
		docente: persona;
		calum: integer;
		escuela: string;
		localidad: string;
	end;
	maxescuela= record
		nom1: string;
		nom2: string;
		can1: integer;
		can2: integer;
	end;

procedure leer(var a: proyecto);
	begin
		writeln();
		writeln('Informacion solicitada del proyecto');
		write('Codigo: '); readln(a.codigo);
		if a.codigo<>ccorte then begin
			write('Titulo: '); readln(a.titulo);
			writeln('Datos del docente coordinador');
			write('		DNI: '); readln(a.docente.dni);
			write('		Nombre: '); readln(a.docente.nombre);
			write('		Apellido: '); readln(a.docente.apellido);
			write('		E-mail: '); readln(a.docente.email);
			write('Cantidad alumnos: '); readln(a.calum);
			write('Nombre de la escuela: '); readln(a.escuela);
			write('Localidad: '); readln(a.localidad);
		end;
	end;
procedure contador(var a: integer);
	begin
		a:= a +1;
	end;
procedure maxparticipantes(a: string; b: integer; var escuelas: maxescuela);
	begin
		if b>escuelas.can1 then begin
			escuelas.can2:= escuelas.can1;
			escuelas.can1:= b;
			escuelas.nom2:= escuelas.nom1;
			escuelas.nom1:= a;
		end
		else if b>escuelas.can2 then begin
			escuelas.can2:= b;
			escuelas.nom2:= a;
		end;
	end;
procedure esdaireaux(cod: integer; nom: string);
	var
	p,i,d:integer;
	begin
		p:= 0;
		i:= 0;
		while cod<>0 do begin
			d:= cod mod 10;
			if (d mod 2)=0 then
				p:=p+1
			else
				i:=i+1;
			cod:= cod div 10;
		end;
		if p=i then
			writeln(nom,' tiene su codigo tan par como impar');
	end;
var
	proye: proyecto;
	mescue: maxescuela;
	cetotal,cetlocalidad,catescuela: integer;
	aux1,aux2: string;
begin
	cetotal:= 1;
	cetlocalidad:= 1;
	catescuela:=0;
	writeln('Cargue los proyectos para obtener conclusiones');
	leer(proye);
	aux1:= proye.localidad;
	aux2:= proye.escuela;
	while proye.codigo<>ccorte do begin
		if (proye.localidad=lmatch) and (proye.localidad=aux1) then
			esdaireaux(proye.codigo,proye.titulo);
		if proye.localidad=aux1 then begin
			if proye.escuela=aux2 then begin
				catescuela:= catescuela + proye.calum;
			end
			else begin
				maxparticipantes(aux2,catescuela,mescue);
				contador(cetotal);
				contador(cetlocalidad);
				catescuela:= 0;
				aux2:= proye.escuela;
			end;
			leer(proye);
		end
		else begin
			writeln('Participaron ',cetlocalidad,' escuelas en ',aux1);
			cetlocalidad:=1;
			contador(cetotal);
			aux1:= proye.localidad;
			aux2:= proye.escuela;
		end;
	end;
	writeln('Participaron ',cetlocalidad,' escuelas en ',aux1);
	writeln('Participaron ',cetotal,' escuelas en el ano 2020');
	writeln('Las dos escuelas con mayor cantidad de alumnos participantes son: ',mescue.nom1,' y ',mescue.nom2);
end.



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Adicionales

9. Realizar un programa que lea información de los candidatos ganadores de las últimas elecciones a intendente de
la provincia de Buenos Aires. Para cada candidato se lee: localidad, apellido del candidato, cantidad de votos
obtenidos y cantidad de votantes de la localidad. La lectura finaliza al leer la localidad ‘Zárate’, que debe procesarse.
Informar:
	● El intendente que obtuvo la mayor cantidad de votos en la elección.
	● El intendente que obtuvo el mayor porcentaje de votos de la elección

program ejer_9;

const
	lcorte= 'Zarate';
	
type
	candidato= record
		localidad: string;
		apellido: string;
		cvotos: real;
		cvotantes: real;
	end;
procedure leer(var inte: candidato);
	begin
		write('Localidad: ');readln(inte.localidad);
		write('Apellido: ');readln(inte.apellido);
		write('Votos a favor: ');readln(inte.cvotos);
		write('Total votantes: ');readln(inte.cvotantes);
	end;
procedure maxvotos(inten: candidato; var a: string; var b: real);
	begin
		if inten.cvotos>b then begin
			b:= inten.cvotos;
			a:= inten.apellido;
		end;
	end;
procedure mejorrela(inten: candidato; var a: string; var b: real);
	begin
		if (inten.cvotantes/inten.cvotos)<b then begin
			b:=inten.cvotantes/inten.cvotos;
			a:= inten.apellido;
		end;
	end;
var
	inten:candidato;
	apevotos,aperelacion: string;
	mvotos,mrela: real;
begin
	mvotos:=0;
	mrela:=999;
	writeln('Ingrese todos los intendentes ganadores de la prov. Bs. As.');
	repeat
		leer(inten);
		maxvotos(inten,apevotos,mvotos);
		mejorrela(inten,aperelacion,mrela)
	until inten.localidad=lcorte;
	writeln('El intendente que obtuvo la mayor cantidad de votos es: ',apevotos);
	writeln('El intendente que obtuvo el mayor porcentaje de votos es: ',aperelacion);
	readln();
end.



10. Un centro de investigación de la UNLP está organizando la información de las 320 especies de plantas con las
que trabajan. Para cada especie se ingresa su nombre científico, tiempo promedio de vida (en meses), tipo de
planta (por ej. árbol, conífera, arbusto, helecho, musgo, etc.), clima (templado, continental, subtropical, desértico,
etc.) y países en el mundo donde se las encuentra. La información de las plantas se ingresa ordenada por tipo de
planta y, para cada planta, la lectura de países donde se las encuentra finaliza al ingresar el país 'zzz'. Al finalizar la
lectura, informar:
	● El tipo de planta con menor cantidad de plantas.
	● El tiempo promedio de vida de las plantas de cada tipo.
	● El nombre científico de las dos plantas más longevas.
	● Los nombres de las plantas nativas de Argentina que se encuentran en regiones con clima subtropical.
	● El nombre de la planta que se encuentra en más países.

program ejer_10;

const
	pcorte= 'zzz';
	mpais= 'Argentina';
	mclima= 'subtropical';
	cespecies= 6;
type
	maximos= record
		nom1: string;
		nom2: string;
		can1: integer;
		can2: integer;
	end;
	especie= record
		nombre: string;
		vida: integer;
		tipo: string;
		clima: string;
		pais: string;
	end;
function esarg(a:string;b:string):boolean;
	begin
		esarg:= (a=mpais) and (b=mclima);
	end;
procedure leer(var a:especie; var nommp:string; var b:integer);
	var
	i: integer;
	begin
		i:=0;
		write('Nombre cientifico: ');readln(a.nombre);
		write('Tiempo promedio de vida: ');readln(a.vida);
		write('Tipo: ');readln(a.tipo);
		write('Clima: ');readln(a.clima);
		writeln('Ingrese los paises donde se encuentra 1 por 1');
		write('- ');readln(a.pais);
		while a.pais<>pcorte do begin
			i:= i +1;
			if esarg(a.pais,a.clima) then
				writeln(a.nombre,' es de argentina del norte papa');
			write('- ');readln(a.pais);
		end;
		if i>b then begin
			b:=i;
			nommp:=a.nombre;
		end;
	end;
procedure dosmax(a: especie;var b: maximos);
	begin
		if a.vida>b.can1 then begin
			b.can2:=b.can1;
			b.can1:=a.vida;
			b.nom2:=b.nom1;
			b.nom2:=a.nombre;
		end
		else if a.vida>b.can2 then begin
			b.can2:=a.vida;
			b.nom2:=a.nombre;
		end;
	end;
var
	planta: especie;
	plonjevas: maximos;
	mpaises,aux,nmin: string;
	cmpaises,cplantas,vtotal,i,cmin: integer;
begin
	plonjevas.nom1:= ' ';
	plonjevas.can1:= 0;
	cmpaises:=0;
	cmin:= 999;
	cplantas:=0;
	vtotal:=0;
	writeln('Proceda a cargar cada una de las plantas en el sistema');
	leer(planta,mpaises,cmpaises);
	aux:=planta.tipo;
	for i:= 0 to cespecies do begin
		if planta.tipo= aux then begin
			cplantas:= cplantas+1;
			vtotal:= vtotal + planta.vida;
			dosmax(planta,plonjevas);
			if i<cespecies then begin
				writeln();
				writeln('Siguiente planta');
				leer(planta,mpaises,cmpaises);
			end;
		end
		else begin
			if cplantas<cmin then begin
				cmin:=cplantas;
				nmin:=aux;
			end;
			writeln('El tiempo promedio de vida para el tipo ',aux,' es de: ',(vtotal/cplantas):1:1,' meses');
			vtotal:=0;
			cplantas:=0;
			aux:= planta.tipo;
		end;
	end;
	writeln();
	writeln('Las plantas de tipo ',nmin,' son las que menos tiempo de vida tienen');
	writeln('Los nombres cientificos de las dos plantas mas lonjevas son: ',plonjevas.nom1, ' y ', plonjevas.nom2);
	writeln('La planta que se encuentra en mas paises es: ',mpaises);
	readln();
end.



11. Una compañía de vuelos internacionales está analizando la información de todos los vuelos realizados por sus
aviones durante todo el año 2019. De cada vuelo se conoce el código de avión, país de salida, país de llegada,
cantidad de kilómetros recorridos y porcentaje de ocupación del avión. La información se ingresa ordenada por
código de avión y, para cada avión, por país de salida. La lectura finaliza al ingresar el código 44. Informar:
	● Los dos aviones que más kilómetros recorrieron y los dos aviones que menos kilómetros recorrieron.
	● El avión que salió desde más países diferentes.
	● La cantidad de vuelos de más de 5.000 km que no alcanzaron el 60% de ocupación del avión.
	● La cantidad de vuelos de menos de 10.000 km que llegaron a Australia o a Nueva Zelanda.
}
program ejer_11;

const
	CCORTE= 44;
	KMMAX= 5000;
	PORCMAX= 60;
	KMMIN= 10000;
	PM1= 'Australia';
	PM2= 'Nueva Zelanda';
type
	cupla= record
		cod1: integer;
		cod2: integer;
		km1: integer;
		km2: integer;
	end;
	vuelo= record
		codigo: integer;
		pais_s: string;
		pais_l: string;
		c_km: integer;
		ocupacion: real;
	end;
procedure leer(var avion: vuelo);
	begin
		write('Codigo: ');readln(avion.codigo);
		write('Pais salida: ');readln(avion.pais_s);
		write('Pais llegada: ');readln(avion.pais_l);
		write('Kilometros recorridos: ');readln(avion.c_km);
		write('Porcentaje ocupacion: ');readln(avion.ocupacion);
	end;
procedure calcmax(km: integer; cod: integer;var avion_max: cupla);
	begin
		if km>avion_max.km1 then begin
			avion_max.km2:=avion_max.km1;
			avion_max.km1:=km;
			avion_max.cod2:=avion_max.cod1;
			avion_max.cod1:=cod;
		end else
			if km>avion_max.km2 then begin
			avion_max.km2:=km;
			avion_max.cod2:=cod;
		end;
	end;	
procedure calcmin(km: integer; cod: integer;var avion_min: cupla);
	begin
		if km<avion_min.km1 then begin
			avion_min.km2:=avion_min.km1;
			avion_min.km1:=km;
			avion_min.cod2:=avion_min.cod1;
			avion_min.cod1:=cod;
		end else
			if km<avion_min.km2 then begin
			avion_min.km2:=km;
			avion_min.cod2:=cod;
		end;
	end;
procedure maspaises(cant: integer; cod: integer; var c_max_p,cod_max_p: integer);
	begin
		if cant>c_max_p then begin
			c_max_p:=cant;
			cod_max_p:=cod;
		end;
	end;
procedure evalvuelos(avion: vuelo;var c_5000,c_10000: integer);
	begin
		if (avion.c_km>KMMAX) and (avion.ocupacion<PORCMAX) then
			c_5000:= c_5000 + 1;
		if (avion.c_km<KMMIN) and ((avion.pais_l=PM1) or (avion.pais_l=PM2)) then
			c_10000:= c_10000 + 1;
	end;
procedure informar(a_max,a_min: cupla; cod_max_p,c_5000,c_10000: integer);
	begin
		writeln('Los dos aviones que mas kilometros recorrieron son: ',a_max.cod1,' y ',a_max.cod2);
		writeln('Los dos aviones que menos kilometros recorrieron son: ',a_min.cod1,' y ',a_min.cod2);
		writeln('El avion que salio de mas paises diferentes es: ',cod_max_p);
		writeln(c_5000, ' fueron los vuelos de más de 5.000 km que no alcanzaron el 60% de ocupación del avión');
		writeln(c_10000, ' fueron los vuelos de menos de 10.000 km que llegaron a Australia o a Nueva Zelanda');
	end;
var
avion: vuelo;
a_max,a_min: cupla;
aux2: string;
aux1,c_5000,c_10000,c_max_p,cod_max_p,c_paises,c_km_total: integer;
begin
	a_max.km1:=0;
	a_min.km1:=9999;
	c_5000:= 0;
	c_10000:=0;
	c_max_p:= 0;
	writeln('Ingrese los vuelos a evaluar');
	leer(avion);
	while avion.codigo<>CCORTE do begin
		aux1:=avion.codigo;
		c_paises:=0;
		c_km_total:=0;
		while (avion.codigo<>CCORTE) and (avion.codigo=aux1) do begin
			c_paises:= c_paises +1;
			aux2:= avion.pais_s;
			while (avion.codigo<>CCORTE) and (avion.codigo=aux1) and (avion.pais_s=aux2) do begin
				c_km_total:= c_km_total + avion.c_km;
				evalvuelos(avion,c_5000,c_10000);
				leer(avion);
			end;
		end;
		maspaises(c_paises,aux1,c_max_p,cod_max_p);
		calcmax(c_km_total,aux1,a_max);
		calcmin(c_km_total,aux1,a_min);
	end;
	informar(a_max,a_min,cod_max_p,c_5000,c_10000);
	readln();
end.
