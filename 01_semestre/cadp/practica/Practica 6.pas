{Practica 6

1)
a Almacena una cantidad desnocida de numeros distintos de 0 y luego imprime todos los valores
b La lista queda conformada en este orden 48 13 21 10
c 
procedure imprimirL( L: lista);
begin
	while L<>nil do begin
		writeln(L^.num,' ');
		L:= L^.sig;
	end;
end;
d
procedure incrementarLenN( L: lista; n: integer);
begin
	while L<>nil do begin
		L^.num:= L^.num + n;
		L:= L^.sig;
	end;
end;
 
 

2)
1 - p:persona no esta por referencia
2 - l: lista no esta por referencia si no se agrega por adelante
3 - no se hizo el new(aux);
4 - no se llama a leerPersona(p) al final del while
5 - p tiene que ser de tipo persona
6 - l:lista es parametro por referencia cuando tiene que ser por valor
7 8 - cuando se imprime el nombre y apellido tiene que ser l^.dato.nombre y .apellido
9 - no se inicializa la variable l con nil



3)
a procedure armarNodo(var l:lista; v integer);
	var
		aux: lista;
	begin
		new(aux);
		aux^.num:=v;
		aux^.sig:= nil;
		if l = nil then
			l:= aux
		else begin
			while l^.sig <> nil do
				l:= l^.sig;
			l^.sig:= aux;
		end;
	end;
b procedure armarNodo(var l:lista; v integer; var ult: lista);
	var
		aux: lista;
	begin
		new(aux);
		aux^.num:=v;
		aux^.sig:= nil;
		if l = nil then
			l:= aux
		else
			ult^.sig:= aux;
		ult:= aux;
	end;



4)
a procedure maximoL( L: lista; var max: integer);
	begin
		max:= -999;
		while L <> nil do begin
			if L^.num > max then
				max:= L^.num;
			L:= L^.sig;
		end;
	end;
b procedure minimoL( L: lista; var min: integer);
	begin
		max:= 999;
		while L <> nil do begin
			if L^.num < min then
				min:= L^.num;
			L:= L^.sig;
		end;
	end;
c procedure multiplosL( L: lista; A: integer; var cantM: integer);
	begin
		cantM:= 0;
		while L <> nil do begin
			if (L^.num mod A) = 0 then
				cantM:= cantM +1;
			L:= L^.sig;
		end;
	end;



5) 	Realizar un programa que lea y almacene la información de productos de un supermercado.
	De cada producto se lee: código, descripción, stock actual, stock mínimo y precio.
	La lectura finaliza cuando se ingresa el código -1, que no debe procesarse.
	Una vez leída y almacenada toda la información, calcular e informar:
a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
c. Código de los dos productos más económicos.

const
	CLECTURA = -1;
type
	producto = record
		codigo: integer;
		descripcion: string;
		stockA: integer;
		stockM: integer;
		precio: real;
	end;
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista;
	end;
	dupla = record
		min1: real;
		cod1: integer;
		min2: real;
		cod2: integer;
	end;
procedure leerProducto(var p: producto);
	begin
		write('Codigo del producto: ');readln(p.codigo);
		if p.codigo <> CLECTURA then begin
			write('Descripcion: ');readln(p.descripcion);
			write('Stock actual: ');readln(p.stockA);
			write('Stock minimo: ');readln(p.stockM);
			write('Precio: $');readln(p.precio);
		end;
	end;
procedure agregarAtrasL(var L,Ult: lista; p: producto);
	var
		aux: lista;
	begin
		new(aux);
		aux^.dato:= p;
		aux^.sig:= nil;
		if L = nil then
			L:= aux
		else
			Ult^.sig:= aux;
		Ult:=aux;
	end;
procedure generarL(var L,Ult: lista);
	var
		p: producto;
	begin
		leerProducto(p);
		while p.codigo <> CLECTURA do begin
			agregarAtrasL(L,Ult,p);
			leerProducto(p);
		end;
	end;
function esPar3(num: integer):boolean;
	var
		cant: integer;
	begin
		cant:=0;
		if (num>99) then
			while num<>0 do begin
				if (num mod 2) = 0 then
					cant:= cant +1;
				num:= num div 10;
			end;
		esPar3:= cant>=3;
	end;
procedure actMinimos( cod: integer; precio: real; var mins: dupla);
	begin
		if precio < mins.min1 then begin
			mins.min2:= mins.min1;
			mins.min1:= precio;
			mins.cod2:= mins.cod1;
			mins.cod1:= cod;
		end
		else if precio < mins.min2 then begin
			mins.min2:= precio;
			mins.cod2:= cod;
		end;
	end;
procedure recorrerL(L: lista; var porc: real; var pEconomicos: dupla);
	var
		cPTotal,cPMin: integer;
	begin
		cPTotal:=0;
		cPMin:=0;
		pEconomicos.min1:= 999;
		pEconomicos.cod1:= 0;
		while L<> nil do begin
			cPTotal:= cPtotal + 1;
			if L^.dato.stockA < L^.dato.stockM then
				cPMin:= cPMin +1;
			if esPar3(L^.dato.codigo) then
				writeln('El producto de codigo ',L^.dato.codigo,' tiene la descripcion: ',L^.dato.descripcion);
			actMinimos(L^.dato.codigo,L^.dato.precio,pEconomicos);
			L:= L^.sig;
		end;
		porc:= cPMin*100/cPTotal;
	end;
procedure informarR(porc: real; cod1,cod2: integer);
	begin
		writeln('El porcentaje de producots con stock actual por debajo de su minimo es de: ',porc:0:2, '%');
		writeln('Los dos productos mas economicos son: ', cod1,' y ', cod2);
	end;
var
	L,Ult: lista;
	pEconomicos: dupla;
	porc: real;
begin
	L:= nil;
	generarL(L,Ult);
	recorrerL(L,porc,pEconomicos);
	informarR(porc,pEconomicos.cod1,pEconomicos.cod2);
end.



6) La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas
al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la misión (cantidad
de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y rango del
espectro electromagnético sobre el que realizará estudios. Dicho rango se divide en 7 categorías:
1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma
Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura finaliza al
ingresar la sonda llamada “GAIA”, que debe procesarse.
Una vez finalizada la lectura, informar:
a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse una única vez.

const
	CLECTURA = 'GAIA';
	DIMFT = 7;
type
	sonda = record
		nombre: string;
		tiempo: integer;
		costo: real;
		costoM: real;
		rango: integer;
	end;
	espectro= record
		nombre: string;
		cant: integer;
	end;
	tabla= array[1..DIMFT] of espectro;
	lista= ^nodo;
	nodo= record
		dato: sonda;
		sig: lista;
	end;
procedure leerE(var E: espectro);
	begin
	end;
procedure cargarT(var T: tabla);
	begin
	end;
procedure inicializarT(var T: tabla);
	begin
	end;
procedure leerS(var S: sonda);
	begin
		write('Nombre: ');readln(s.nombre);
		write('Duracion de mision: ');readln(s.tiempo);
		write('Costo construccion: ');readln(s.costo);
		write('Costo mantenimiento: ');readln(s.costoM);
		write('Rango del estudio: ');readln(s.rango);
	end;
procedure agregarNAdelante(var L: lista; S: sonda);
	var
		aux: lista;
	begin
		new(aux);
		aux^.dato:= S;
		aux^.sig:= L;
		L:= aux;
	end;
procedure generarL(var L: lista; var tProm,cProm: real);
	var
		S: sonda;
		cant: integer;
	begin
		cant:= 0;
		cProm:=0;
		tProm:=0;
		repeat
			cant:= cant +1;
			leerS(S);
			cProm:= cProm + S.costo;
			tProm:= tProm + S.tiempo;
			agregarNAdelante(L,S);
		until S.nombre = CLECTURA;
		tProm:= tProm/cant;
		cProm:= cProm/cant;
	end;
function sumatoria(d: sonda):real;
	begin
		sumatoria:= d.tiempo*d.costoM + d.costo;
	end;
procedure SMasCostosa(costo: real; nombre: string; var max: real; var nombreMC: string);
	begin
		if costo>max then begin
			max:= costo;
			nombreMC:= nombre;
		end;
	end;
procedure sumarER(var T: tabla; rango: integer);
	begin
		T[rango].cant:= T[rango].cant +1;
	end;
procedure recorrerL(L: lista;var nombreMC: string; var T: tabla; var cantD: integer; tProm, cProm: real);
	var
		max: real;
	begin
		max:=-999;
		cantD:=0;
		while L<> nil do begin
			SMasCostosa( sumatoria(L^.dato),L^.dato.nombre,max,nombreMC);
			sumarER(T,L^.dato.rango);
			if L^.dato.tiempo > tProm then
				cantD:= cantD +1;
			if L^.dato.costo> cProm then
				writeln('La sonda ',L^.dato.nombre,' supera el costo promedio de construccion');
			L:= L^.sig;
		end;
	end;
procedure informarS(T: tabla; nombreMC: string; cantD: integer);
	var
		i: integer;
	begin
		writeln('La sonda mas costosa se llama: ', nombreMC);
		for i:=1 to DIMFT do
			writeln('La cantidad de sondas que estudian el espectro ',T[i].nombre,' es de: ',T[i].cant);
		writeln('La cantidad de sondas que superan la duracion promedio es: ', cantD);
	end;

var
	L: lista;
	T: tabla;
	nombreMC: string;
	cantD: integer;
	tProm,cProm: real;
begin
	L:= nil;
	inicializarT(T);
	cargarT(T);
	generarL(L,tProm,cProm);
	recorrerL(L,nombreMC,T,cantD,tProm,cProm);
	informarS(T,nombreMC,cantD);
end.



7. El Programa Horizonte 2020 (H2020) de la Unión Europea ha publicado los criterios para financiar proyectos
de investigación avanzada. Para los proyectos de sondas espaciales vistos en el ejercicio anterior, se han
determinado los siguientes criterios:
	-sólo se financiarán proyectos cuyo costo de mantenimiento no supere el costo de construcción.
	- no se financiarán proyectos espaciales que analicen ondas de radio, ya que esto puede realizarse desde la
	superficie terrestre con grandes antenas.
A partir de la información disponible de las sondas espaciales (la lista generada en ejercicio 6), implementar
un programa que:
	a. Invoque un módulo que reciba la información de una sonda espacial, y retorne si cumple o no con los nuevos
	criterios H2020.
	b. Utilizando el módulo desarrollado en a) implemente un módulo que procese la lista de sondas de la ESA y
	retorne dos listados, uno con los proyectos que cumplen con los nuevos criterios y otro con aquellos que no
	los cumplen.
	c. Invoque a un módulo que reciba una lista de proyectos de sondas espaciales e informe la cantidad y el costo
	total (construcción y mantenimiento) de los proyectos que no serán financiados por H2020. Para ello, utilice
	el módulo realizado en b

a)
function apta(S: sonda):boolean;
	begin
		apta:= (S.costoM*S.tiempo <= S.costo) and (S.rango<>1);
	end;
b)
procedure validarL(L: lista; var LAptas,LNoAptas: lista);
	var
		aux: lista;
	begin
		while L<>nil do begin
			if apta(L^.dato) then
				agregarNAdelante(LAptas, L^.dato);
			else
				agregarNAdelante(LNoAptas, L^.dato);
		end;
	end;
c)
procedure analizarL(LNoAptas: lista);
	var
		cant: integer;
		cTotal: real;
	begin
		cant:= 0;
		cTotal:=0;
		while LNoAptas <> nil do begin
			cant:= cant +1;
			cTotal:= cTotal + sumatoria(LNoAptas^.dato);
			LNoAptas:= LNoAptas^.sig;
		end;
		writeln('La cantidad de proyectos que no seran finaciados es de: ',cant);
		writeln('No financiarlos supone no gastar $',cTotal:0:2);
	end;

------------------------------------------------------------------------------------------------
const
	CLECTURA = 'GAIA';
	DIMFT = 7;
type
	sonda = record
		nombre: string;
		tiempo: integer;
		costo: real;
		costoM: real;
		rango: integer;
	end;
	espectro= record
		nombre: string;
		cant: integer;
	end;
	tabla= array[1..DIMFT] of espectro;
	lista= ^nodo;
	nodo= record
		dato: sonda;
		sig: lista;
	end;
procedure leerE(var E: espectro);
	begin
	end;
procedure cargarT(var T: tabla);
	begin
	end;
procedure inicializarT(var T: tabla);
	begin
	end;
procedure leerS(var S: sonda);
	begin
		write('Nombre: ');readln(s.nombre);
		write('Duracion de mision: ');readln(s.tiempo);
		write('Costo construccion: ');readln(s.costo);
		write('Costo mantenimiento: ');readln(s.costoM);
		write('Rango del estudio: ');readln(s.rango);
	end;
procedure agregarNAdelante(var L: lista; S: sonda);
	var
		aux: lista;
	begin
		new(aux);
		aux^.dato:= S;
		aux^.sig:= L;
		L:= aux;
	end;
procedure generarL(var L: lista; var tProm,cProm: real);
	var
		S: sonda;
		cant: integer;
	begin
		cant:= 0;
		cProm:=0;
		tProm:=0;
		repeat
			cant:= cant +1;
			leerS(S);
			cProm:= cProm + S.costo;
			tProm:= tProm + S.tiempo;
			agregarNAdelante(L,S);
		until S.nombre = CLECTURA;
		tProm:= tProm/cant;
		cProm:= cProm/cant;
	end;
function sumatoria(d: sonda):real;
	begin
		sumatoria:= d.tiempo*d.costoM + d.costo;
	end;
procedure SMasCostosa(costo: real; nombre: string; var max: real; var nombreMC: string);
	begin
		if costo>max then begin
			max:= costo;
			nombreMC:= nombre;
		end;
	end;
procedure sumarER(var T: tabla; rango: integer);
	begin
		T[rango].cant:= T[rango].cant +1;
	end;
procedure recorrerL(L: lista;var nombreMC: string; var T: tabla; var cantD: integer; tProm, cProm: real);
	var
		max: real;
	begin
		max:=-999;
		cantD:=0;
		while L<> nil do begin
			SMasCostosa( sumatoria(L^.dato),L^.dato.nombre,max,nombreMC);
			sumarER(T,L^.dato.rango);
			if L^.dato.tiempo > tProm then
				cantD:= cantD +1;
			if L^.dato.costo> cProm then
				writeln('La sonda ',L^.dato.nombre,' supera el costo promedio de construccion');
			L:= L^.sig;
		end;
	end;
procedure informarS(T: tabla; nombreMC: string; cantD: integer);
	var
		i: integer;
	begin
		writeln('La sonda mas costosa se llama: ', nombreMC);
		for i:=1 to DIMFT do
			writeln('La cantidad de sondas que estudian el espectro ',T[i].nombre,' es de: ',T[i].cant);
		writeln('La cantidad de sondas que superan la duracion promedio es: ', cantD);
	end;
//ejer 7
function apta(S: sonda):boolean;
	begin
		apta:= (S.costoM*S.tiempo <= S.costo) and (S.rango<>1);
	end;
procedure validarL(L: lista; var LAptas,LNoAptas: lista);
	begin
		while L<>nil do begin
			if apta(L^.dato) then
				agregarNAdelante(LAptas, L^.dato)
			else
				agregarNAdelante(LNoAptas, L^.dato);
			L:= L^.sig;
		end;
	end;
procedure analizarL(LNoAptas: lista);
	var
		cant: integer;
		cTotal: real;
	begin
		cant:= 0;
		cTotal:=0;
		while LNoAptas <> nil do begin
			cant:= cant +1;
			cTotal:= cTotal + sumatoria(LNoAptas^.dato);
			LNoAptas:= LNoAptas^.sig;
		end;
		writeln('La cantidad de proyectos que no seran finaciados es de: ',cant);
		writeln('No financiarlos supone no gastar $',cTotal:0:2);
	end;


var
	L,LAptas,LNoAptas: lista;
	T: tabla;
	nombreMC: string;
	cantD: integer;
	tProm,cProm: real;
begin
	L:= nil;
	LAptas:= nil;
	LNoAptas:= nil;
	inicializarT(T);
	cargarT(T);
	generarL(L,tProm,cProm);
	recorrerL(L,nombreMC,T,cantD,tProm,cProm);
	informarS(T,nombreMC,cantD);
	validarL(L,LAptas,LNoAptas);
	analizarL(LNoAptas);
end.



8) Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la lista
queden ordenados de manera ascendente (insertar ordenado).

procedure armarNodo(var L:lista; v: integer);
	var
		ant,act,nuevo: lista;
	begin
		new(nuevo);
		nuevo^.num:= v;
		if L=nil then begin
			nuevo^.sig:= nil;
			L:= nuevo;
		end
		else begin
			ant:= L;
			act:= L;
			while (act <> nil) and (act^.num < v) do begin
				ant:=act;
				act:= act^.sig;
			end;
			if act=L then begin
				nuevo^.sig:= L;
				L:= nuevo;
			end
			else begin
				nuevo^.sig:= ant^.sig;
				ant^.sig:= nuevo;
			end;
		end;
	end;

---------------------------------------------
program JugamosConListas;
type
	lista = ^nodo;
	nodo = record
		num : integer;
		sig : lista;
	end;
procedure armarNodo(var L:lista; v: integer);
	var
		ant,act,nuevo: lista;
	begin
		new(nuevo);
		nuevo^.num:= v;
		if L=nil then begin
			nuevo^.sig:= nil;
			L:= nuevo;
		end
		else begin
			ant:= L;
			act:= L;
			while (act <> nil) and (act^.num < v) do begin
				ant:=act;
				act:= act^.sig;
			end;
			if act=L then begin
				nuevo^.sig:= L;
				L:= nuevo;
			end
			else begin
				nuevo^.sig:= ant^.sig;
				ant^.sig:= nuevo;
			end;
		end;
	end;
var
	pri : lista;
	valor : integer;
begin
	pri := nil;
	writeln('Ingrese un numero');
	read(valor);
	while valor <> 0 do begin
		armarNodo(pri, valor);
		writeln('Ingrese un numero');
		readln(valor);
	end;
	while pri <> nil do begin
		writeln(pri^.num,', ');
		pri:= pri^.sig;
	end;
end.



9. Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
	a. EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o false en
	caso contrario.
	b. Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si existe). Nota:
	la lista podría no estar ordenada.
	c. Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista con todos
	los elementos de la lista L mayores que A y menores que B.
	d. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de manera
	ascendente.
	e. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de manera
	descendente

a
function EstaOrdenada(L: lista):boolean;
	var
		num1: integer;
	begin
		if L<> nil then begin
			num1:= L^.num;
			while (L<>nil) and (num1 <= L^.num) do begin
				num1:= L^.num;
				L:= L^.sig;
			end;
			EstaOrdenada:= L = nil;
		end
		else
			EstaOrdenada:= true;
	end;
	
b
procedure Eliminar(var L:lista; v: integer);
	var
		aux,aux2: lista;
	begin
		aux2:=L;
		while L^.num<> v do
			aux2:=L;
			L:= L^.sig;
		aux:= L;
		aux2^.sig:=L^.sig;
		dispose(aux);
	end;
	
c
procedure agregasNAtras(var L,Ult: lista; Nodo: lista);
	begin
		Nodo^.sig:= nil;
		if L = nil then
			L:= Nodo
		else
			Ult^.sig:= Nodo;
		Ult:= Nodo;
	end;
procedure Sublista(L: lista; var LN: lista; A,B: integer);
	var
		Ult: lista;
	begin
		while L<> nil do begin
			if (L^.num > A) and (L^.num < B) then
				agregarNAtras(LN,Ult,L);
			L:= L^.sig;
		end;
	end;
	
d
procedure Sublista(L: lista; var LN: lista; A,B: integer);
	var
		Ult: lista;
	begin
		while (L<> nil) and (L^.num <= A) do 
			L:= L^.sig;
		end;
		while (L<> nil) and (L^.num < B) do begin
			agregarNAtras(LN,Ult,L);
			L:= L^.sig;
		end;
	end;

e
procedure Sublista(L: lista; var LN: lista; A,B: integer);
	var
		Ult: lista;
	begin
		while (L<> nil) and (L^.num >= B) do 
			L:= L^.sig;
		end;
		while (L<> nil) and (L^.num > A) do begin
			agregarNAtras(LN,Ult,L);
			L:= L^.sig;
		end;
	end;



10. Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un número
(que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado por su número,
en cuyo caso sale de la lista de espera. Se pide:
	a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
	b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes
	en espera, asigna un número al cliente y retorna la lista de espera actualizada.
	c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera, y retorna
	el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe eliminarse de la lista
	de espera.
	d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero llegarán todos
	los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se los atenderá de a uno por
	vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no debe procesarse

a
type
	cliente= record
		num: integer;
		dni: string;
	end;
	lista=^nodo;
	nodo= record
		dato: cliente;
		sig: lista;
	end;
b
procedure RecibirCliente( dni: string; var LE: lista; var num: string);
	var
		aux: lista;
	begin
		num:= num +1;
		new(aux);
		aux^.dato.num:= num;
		aux^.dato.dni:= dni;
		aux^.sig:= LE;
		LE:= aux;
	end;
c
procedure AtenderCliente(var LE: lista; var dni: string; var num: integer);
	var
		ant,act: real
	begin
		if LE^.sig = nil then begin
			dni:= LE^.dato.dni;
			num:= LE^.dato.num;
			act:= LE;
			LE:= nil;
		end else begin
			act:= LE;
			ant:= LE;
			while act^.sig<>nil do begin
				ant:=act;
				act:= act^.sig;
			end;
			dni:= ant^.dato.dni;
			num:= ant^.dato.num;
			act:=ant;
			ant:=nil;
		end;
		dispose(act);
	end;

const
	CDNI= '0';
type
	cliente= record
		num: integer;
		dni: string;
	end;
	lista=^nodo;
	nodo= record
		dato: cliente;
		sig: lista;
	end;
	
procedure leerDni( var dni: string);
	begin
		write('Ingrese su dni: ');readln(dni);
	end;
procedure RecibirCliente( dni: string; var LE: lista; var num: integer);
	var
		aux: lista;
	begin
		num:= num +1;
		new(aux);
		aux^.dato.num:= num;
		aux^.dato.dni:= dni;
		aux^.sig:= LE;
		LE:= aux;
		writeln('Su numero de espera es el: ',num);
	end;
procedure generarLE(var LE:lista; var num: integer);
	var
		dni:string;
	begin
		num:=0;
		leerDni(dni);
		while dni<> CDNI do begin
			RecibirCliente(dni,LE,num);
			leerDni(dni);
		end;
	end;
procedure AtenderCliente(var LE: lista; var dni: string; var num: integer);
	var
		ant,act: lista;
	begin
		if LE^.sig = nil then begin
			dni:= LE^.dato.dni;
			num:= LE^.dato.num;
			act:= LE;
			LE:= nil;
		end
		else begin
			act:= LE;
			ant:= LE;
			while act^.sig <> nil do begin
				ant:=act;
				act:= act^.sig;
			end;
			dni:= act^.dato.dni;
			num:= act^.dato.num;
			ant^.sig:= nil;
		end;
		dispose(act);
	end;
procedure terminarLE(var LE:lista; num: integer);
	var
		i,numAtender:integer;
		rta,dni: string;
	begin
		for i:=1 to num do begin
			writeln('Para saber que cliente atender escriba siguiente');
			readln(rta);
			AtenderCliente(LE,dni,numAtender);
			writeln('El numero de cliente a atender es el: ',numAtender,' y su dni es el: ',dni);
		end;
		writeln('Se atendieron todos los clientes');
	end;

var
	LE: lista;
	num: integer;
begin
	LE:= nil;
	num:=0;
	generarLE(LE, num);
	terminarLE(LE, num);
end.



11) La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les
entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y el
promedio obtenido durante toda su carrera.
	Implementar un programa que:
	a. Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
	b. Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los egresados
	que recibirán el premio. La información debe imprimirse ordenada según el promedio del egresado (de mayor
	a menor).

const
	CCORTE= 0;
	DIMFE=10;
type
	alumno= record
		codigo: integer;
		apellido: string;
		prom: real;
	end;
	lista=^nodo;
	nodo= record
		dato: alumno;
		sig: lista;
	end;

procedure leerA(var A: alumno);
	begin
		write('Numero de alumno: ');readln(A.codigo);
		if A.codigo<>CCORTE then begin
			write('Apellido: ');readln(A.apellido);
			write('Promedio: ');readln(A.prom);
		end;
	end;
procedure insertarOProm(var L:lista; A: alumno);
	var
		aux,ant,act: lista;
	begin
		new(aux);
		aux^.dato:= A;
		ant:=L;
		act:=L;
		while (act <> nil) and (act^.dato.prom > A.prom) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if ant= act then
			L:= aux;
		else
			ant^.sig:= aux;
		aux^.sig:= act;
	end;
procedure generarL(var L:lista);
	var
		A: alumno;
	begin
		leerA(A);
		while A.codigo<>CCORTE do begin
			insertarOProm(L, A);
			leerA(A);
		end;
	end;

procedure informarMejProm(L: lista);
	var	
		i: integer;
	begin
		for i:=1 to DIMFE do begin
			writeln('El promedio ',L^.dato.prom:0:2,' es del alumno ',L^.dato.apellido);
			L:= L^.sig;
		end;
	end;

var
	L: lista;
begin
	L:= nil;
	generarL(L);
	informarMejProm(L);
end.



12) Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de Android
instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee (medida en GB). La
información disponible se encuentra ordenada por versión de Android. Realizar un programa que procese la
información disponible de todos los dispositivos e informe:
	a. La cantidad de dispositivos para cada versión de Android.
	b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
	c. El tamaño promedio de las pantallas de todos los dispositivos

const
	GBM= 3;
	PP= 5;
type
	telefono= record
		version: string;
		tamPantalla: real;
		memRam: integer;
	end;
	listaT= ^nodoT;
	nodoT= record
		dato:telefono;
		sig: listaT;
	end;
	
	versionA= record
		version: string;
		cant: integer;
	end;
	listaV= ^nodoV;
	nodoV= record
		dato:versionA;
		sig: listaV;
	end;
procedure leerTelefono(var T: telefono);
	begin
	end;
procedure agregarTOrdenado(var LT: listaT; T: Telefono);
	begin
	end;
procedure generarLT(var LT: listaT);
	begin
	end;
procedure sumarVLV(var LV: listaV; version: string);
	var
		aux,ant,act: listaV;
	begin
		new(aux);
		aux^.dato.version:= version;
		aux^.dato.cant:=1;
		aux^.sig:=nil;
		if LV= nil then
			LV:= aux
		else begin
			ant:=LV;
			act:=LV;
			while (act<>nil) and (act^.dato.version<> version) do begin
				ant:=act;
				act:= act^.sig;
			end;
			if act^.dato.version= version then
				act^.dato.cant:= act^.dato.cant +1
			else
				ant^.sig:=aux;
		end;
	end;
procedure sumarTAltaGama(T: telefono; var cantTAG: integer);
	begin
		if (T.memRam>GBM) and (T.tamPantalla>= PP) then
			cantTAG:= cantTAG +1;
	end;
procedure recorrerLT( LT: listaT; var LV: listaV; var cantTAG: integer; var tamProm: real);
	var
		cantT: integer;
	begin
		cantTAG:=0;
		cantT:=0;
		tamProm:=0;
		while LT<>nil do begin
			cantT:= cantT +1;
			tamProm:= tamProm + LT^.dato.tamPantalla;
			sumarTAltaGama(LT^.dato,cantTAG);
			sumarVLV(LV,LT^.dato.version);
			LT:= LT^.sig;
		end;
		tamProm:= tamProm/cantT;
	end;
procedure informarDatos(LV: listaV; cantTAG: integer; tamProm: real);
	begin
		while LV<>nil do begin
			writeln('La cantidad de telefonos con la version ',LV^.dato.version,' es de ',LV^.dato.cant);
			LV:= LV^.sig;
		end;
		writeln('La cantidad de telefonos con mas de 3 GB de ram y al menos 5" de pantalla es ', cantTAG);
		writeln('El tamaño promedio de pantalla es de ', tamProm:0:2);
	end;

var
	LT: listaT;
	LV: listaV;
	cantTAG: integer;
	tamProm: real;
begin
	LT:=nil;
	LV:=nil;
	generarLT(LT);
	recorrerLT(LT,LV,cantTAG,tamProm);
	informarDatos(LV,cantTAG,tamProm);
end.



13) El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de
los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De cada usuario
se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que participa y cantidad de
días desde el último acceso.
	a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios de la revista
	Económica. El listado debe ordenarse a partir de la cantidad de días desde el último acceso (orden ascendente).
	b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
	c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.

const
	DIMFU= 3600;
	DIMFR= 4;
	REVISTA= 'Economica';
type
	dupla= record
		cD1:integer;
		cD2:integer;
		email1: string;
		email2: string;
	end;
	usuario= record
		email: string;
		rol: integer;
		revista: string;
		diasUA: integer;
	end;
	rol= record
		nombre: string;
		cant: integer;
	end;
	usuarios= array[1..DIMFU] of usuario;
	roles= array[1..DIMFR] of rol;
	lista= ^nodo;
	nodo= record
		dato: usuario;
		sig: lista;
	end;

procedure leerUsuario(var U: usuario);
	begin
	end;
procedure cargarUsuarios(var VecU: usuarios);
	begin
	end;
procedure leerRol(var R: rol);
	begin
	end;
procedure cargarRoles(var VR: roles);
	begin
	end;
procedure agregarOrdenado(var L:lista; u: usuario);
	var
		ant,act,nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= u;
		ant:=L;
		act:=L;
		while (act<>nil) and (act^.dato.diasUA < u.diasUA) do begin
			ant:=act;
			act:= act^.sig;
		end;
		if ant= act then
			L:= nuevo
		else
			ant^.sig:= nuevo;
		nuevo^.sig:= act;
	end;
procedure iniciarVR(var VR: roles);
	var
		i:integer;
	begin
		for i:=1 to DIMFR do
			VR[i].cant:=0;
	end;
procedure sumarRol(var VR: roles; num: integer);
	begin
		VR[num].cant:= VR[num].cant +1;
	end;
procedure actMax(dias:integer; email:string; var Max: dupla);
	begin
		if dias>Max.cD1 then begin
			Max.cD2:= Max.cD1;
			Max.cD1:= dias;
			Max.email2:= Max.email1;
			Max.email1:= email;
		end
		else if dias>Max.cD2 then begin
			Max.cD2:= dias;
			Max.email2:= email;
		end;
	end;
procedure recorrerUsuarios( VU: usuarios; var VR: roles; var L:lista; var Max: dupla);
	var
		i: integer;
	begin
		Max.cD1:=-999;
		Max.email1:='';
		iniciarVR(VR);
		for i:=1 to DIMFU do begin
			if VU[i].revista= REVISTA then
				agregarOrdenado(L,VU[i]);
			sumarRol(VR,VU[i].rol);
			actMax(VU[i].diasUA,VU[i].email,Max);
		end;
	end;
procedure informarDatos(L:lista; VR: roles; Max:dupla);
	var
		i: integer;
	begin
		while L<> nil do begin
			writeln('El usuario con email ',L^.dato.email,' lleva sin conectarse ',L^.dato.diasUA);
			L:= L^.sig;
		end;
		for i:=1 to DIMFR do
			writeln('El rol ', VR[i].nombre, ' tiene ', VR[i].cant, ' usuarios entre todas las revistas');
		writeln('Los dos usuarios mas inactivos son ', Max.email1, ' y ', Max.email2);
	end;

var
	VU: usuarios;
	VR: roles;
	L: lista;
	Max: dupla;
begin
	L:=nil;
	cargarUsuarios(VU);
	cargarRoles(VR);
	recorrerUsuarios(VU,VR,L,Max);
	informarDatos(L,VR,Max);
end.



14) La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a
alumnos de la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes realizados por
una muestra de 1300 alumnos durante el mes de marzo. De cada viaje se conoce el código de alumno (entre 1
y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1. colectivo urbano; 2. colectivo
interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta). Tener en cuenta que un alumno puede utilizar más
de un medio de transporte en un mismo día.
Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una estructura de
datos apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe procesarse.
	Una vez finalizada la lectura, informar:
	a. La cantidad de alumnos que realizan más de 6 viajes por día
	b. La cantidad de alumnos que gastan en transporte más de $80 por día
	c. Los dos medios de transporte más utilizados.
	d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte
}
const
	CCORTE= -1;
	DIMFA= 1300;
	DIMFT= 5;
	CANTV= 6;
	MONTODIA= 80;

type
	viaje= record
		codigo: integer;
		facultad: string;
		dia: integer;
		transporte: integer;
	end;
	
	info= record
		dia: integer;
		transporte: integer;
	end;
	lista= ^nodo;
	nodo= record
		dato: info;
		sig: lista;
	end;
	
	alumno= record
		facultad: string;
		viajes: lista;
	end;
	alumnos= array[1..DIMFA] of alumno;
	
	transporte= record
		nombre: string;
		precio: real;
	end;
	transportes= array[1..DIMFT] of transporte;
	cantTransportes= array[1..DIMFT] of integer;

procedure leerTransporte(var t: transporte);
	begin
	end;
procedure cargarVTransportes(var vT: transportes);
	begin
	end;
procedure leerViaje(var v: viaje);
	begin
		write('Codigo alumno: ');readln(v.codigo);
		if v.codigo<>CCORTE then begin
			write('Facultad: ');readln(v.facultad);
			write('Dia: ');readln(v.dia);
			write('Codigo Transporte: ');readln(v.transporte);
		end;
	end;
procedure iniciarVAlumnos(var vA: alumnos);
	var
		i: integer;
	begin
		for i:=1 to DIMFA do 
			vA[i].viajes:= nil;
	end;
procedure agregarOrdDia(var L: lista; dia: integer; transporte: integer);
	var
		ant,act,nuevo:lista;
	begin
		new(nuevo);
		nuevo^.dato.dia:= dia;
		nuevo^.dato.transporte:= transporte;
		ant:= L;
		act:= L;
		while (act<> nil) and (act^.dato.dia< dia) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if ant= act then
			L:= nuevo
		else
			ant^.sig:=nuevo;
		nuevo^.sig:= act;
	end;
procedure cargarVAlumnos(var vA: alumnos);
	var
		v: viaje;
	begin
		iniciarVAlumnos(vA);
		leerViaje(v);
		while v.codigo<> CCORTE do begin
			vA[v.codigo].facultad:= v.facultad;
			agregarOrdDia(vA[v.codigo].viajes,v.dia,v.transporte);
			leerViaje(v);
		end;
	end;
procedure sumarMasViajes( cViajes: integer; var cMasViajes: integer; var unaVez: boolean);
	begin
		if (not unaVez) and (cViajes> CANTV) then begin
			cMasViajes:= cMasViajes +1;
			unaVez:= true;
		end;
	end;
procedure sumarMas80( monto: real; var cMas80: integer; var unaVez: boolean);
	begin
		if (not unaVez) and (monto>MONTODIA) then begin
			cMas80:= cMas80 +1;
			unaVez:=true;
		end;
	end;
procedure iniciarVCantTransportes(var vCT: cantTransportes);
	var
		i: integer;
	begin
		for i:=1 to DIMFT do
			vCT[i]:= 0;
	end;
procedure sumarTransporte( tipo: integer; var vCT: cantTransportes);
	begin
		vCT[tipo]:= vCT[tipo] +1;
	end;

procedure recorrerVAlumnos(vA: alumnos; vT: transportes; var vCT: cantTransportes; var cMasViajes,cMas80,cBiciOtros: integer);
	var
		i,cViajesDia,dia: integer;
		monto: real;
		unaVez1,unaVez2,bici,otro:boolean;
	begin
		cMasViajes:= 0;
		cMas80:= 0;
		cBiciOtros:= 0;
		iniciarVCantTransportes(vCT);
		for i:=1 to DIMFA do begin
			bici:= false;
			otro:= false;
			while vA[i].viajes <> nil do begin
				monto:=0;
				unaVez1:= false;
				unaVez2:= false;
				dia:= vA[i].viajes^.dato.dia;
				cViajesDia:=0;
				while (vA[i].viajes <> nil) and (dia= vA[i].viajes^.dato.dia) do begin
					cViajesDia:= cViajesDia +1;
					monto:= monto + vT[vA[i].viajes^.dato.transporte].precio;
					vCT[vA[i].viajes^.dato.transporte]:= vCT[vA[i].viajes^.dato.transporte] +1;
					if vA[i].viajes^.dato.transporte = 5 then
						bici:= true
					else otro:= true;
					vA[i].viajes:= vA[i].viajes^.sig;
				end;
				sumarMasViajes(cViajesDia,cMasViajes,unaVez1);
				sumarMas80(monto, cMas80, unaVez2);
			end;
			if bici and otro then
				cBiciOtros:= cBiciOtros +1;
		end;
	end;
procedure mediosMasUsados(vCT: cantTransportes; vT: transportes; var nom1,nom2: string);
	var
		i,max1,max2: integer;
	begin
		max1:=-1;
		nom1:='';
		for i:=1 to DIMFT do begin
			if vCT[i]> max1 then begin
				max2:= max1;
				max1:= vCT[i];
				nom2:= nom1;
				nom1:= vT[i].nombre;
			end
			else if vCT[i]> max2 then begin
				max2:= vCT[i];
				nom2:= vT[i].nombre;
			end;
		end;
	end;
procedure informarDatos(cMasViajes, cMas80, cBiciOtros: integer; nom1,nom2: string);
	begin
		writeln('La cantidad de alumnos con mas de 6 viajes por dia es ',cMasViajes);
		writeln('La cantidad de alumnos que gastan mas de 80$ por dia es ',cMas80);
		writeln('Los dos transportes mas utilizados son ', nom1,' y ',nom2);
		writeln('La cantidad de alumnos que usan bicicleta y algun otro transporte es de ',cBiciOtros);
	end;
var
	vA: alumnos;
	vT: transportes;
	vCT: cantTransportes;
	nom1,nom2: string;
	cMasViajes,cMas80,cBiciOtros: integer;
begin
	cargarVTransportes(vT);
	cargarVAlumnos(vA);
	recorrerVAlumnos(vA,vT,vCT,cMasViajes,cMas80,cBiciOtros);
	mediosMasUsados(vCT,vT,nom1,nom2);
	informarDatos(cMasViajes,cMas80,cBiciOtros,nom1,nom2);
end.
