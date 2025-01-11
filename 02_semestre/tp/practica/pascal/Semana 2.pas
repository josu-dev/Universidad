{
program ejer_4;
type
	lista= ^nodo;
	nodo= record
		elem: integer;
		sig: lista;
	end;


procedure agregarAdelante(var l: lista; n: integer);
	var
		nue: lista;
	begin
		new(nue);
		nue^.elem:= n;
		nue^.sig:= l;
		l:= nue;
	end;
// a
procedure generarLista(var l: lista);
	var
		n: integer;
	begin
		l:= nil;
		n:= random(33) -1;
		while n<> -1 do begin
			agregarAdelante(l,n);
			n:= random(101) -1;
		end;
	end;
// b
procedure minimoLista(l: lista; var min: integer);
	begin
		if l<> nil then begin
			minimoLista(l^.sig,min);
			if l^.elem< min then
				min:= l^.elem;
		end
		else
			min:= 9999;
	end;
// c
procedure maximoLista(l: lista; var max: integer);
	begin
		if l<> nil then begin
			maximoLista(l^.sig,max);
			if l^.elem> max then
				max:= l^.elem;
		end
		else
			max:= -9999;
	end;
// d
function buscar(l: lista; n: integer): boolean;
	begin
		if l<> nil then begin
			if l^.elem<> n then
				buscar:= buscar(l^.sig,n)
			else
				buscar:= true;
		end
		else
			buscar:= false;
	end;



program ejer_5;
const
	DIMF= 20;
type
	vector= array[1..DIMF] of integer;

// a
procedure generarVector(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to DIMF do
			v[i]:= random(32);
	end;
// b
procedure maximoVector(var v: vector; diml: integer; var max: integer);
	begin
		if diml> 0then begin
			maximoVector(v,diml -1,max);
			if v[diml]> max then
				max:= v[diml];
		end
		else
			max:= -9999;
	end;
// c
procedure sumaVector(var v: vector; diml: integer; var sum: integer);
	begin
		if diml> 0then begin
			sumaVector(v,diml -1,sum);
			sum:= sum + v[i];
		end
		else
			sum:= 0;
	end;


program ejer_6;

procedure busquedaDicotomica(v: vector; ini,fin: integer; dato:integer; var pos: integer);
	begin
		if ini<> fin then begin
			pos:= (ini+fin) div 2;
			if (v[pos] <> dato) then begin
				if v[pos] < dato then
					busquedaDicotomica(v,pos +1,fin,dato,pos)
				else
					busquedaDicotomica(v,ini,pos -1,dato,pos);
			end;
		end
		else if v[fin]= dato then
			pos:= fin
		else
			pos:= -1;
	end;


program ejer_7;

procedure binario(n: integer);
    begin
        if n>1 then
            binario(n div 2);
		write(n mod 2);
    end;

var
	n: longint;
begin
	write('  Ingrese un numero: '); readln(n);
	while n<> 0 do begin
		binario(n);
		writeln;
		write('  Ingrese un numero: '); readln(n);
	end;
end.


program ejer_8;
const
	CORTE= 0;
type
	arbol= ^nodo;
	nodo= record
		elem: integer;
		hi: arbol;
		hd: arbol;
	end;

// a
procedure insertarNodo(var a: arbol; n: integer);
	begin
		if a<> nil then begin
			if a^.elem< n then
				insertarNodo(a^.hd,n)
			else
				insertarNodo(a^.hi,n);
		end
		else begin
			new(a);
			a^.elem:= n;
			a^.hi:= nil;
			a^.hd:= nil;
		end;
	end;
function buscarValor(a: arbol; n: integer): boolean;
	begin
		if a<> nil then begin
			if a^.elem< n then
				buscarValor:= buscarValor(a^.hd,n)
			else if a^.elem> n then
				buscarValor:= buscarValor(a^.hi,n)
			else
				buscarValor:= true;
		end
		else
			buscarValor:= false;
	end;
procedure generarArbol(var a: arbol);
	var
		n: integer;
	begin
		a:= nil;
		write('  Numero a cargar: '); readln(n);
		while n<> CORTE do begin
			if not buscarValor(a,n) then
				insertarNodo(a,n)
			else
				writeln('  El ',n,' ya esta en el arbol');
			write('  Numero a cargar: '); readln(n);
		end;
	end;
// b
function max (a,b : integer) : integer; 
	begin
		if (a >= b) then
			max := a
		else
			max := b
	end;
function maximoArbol(a: arbol): integer;
	begin
		if a<> nil then
			maximoArbol:= max(a^.elem,maximoArbol(a^.hd))
		else
			maximoArbol:= -9999;
	end;
// c
function min (a,b : integer) : integer; 
	begin
		if (a <= b) then
			min := a
		else
			min := b
	end;
function minimoArbol(a: arbol): integer;
	begin
		if a<> nil then
			minimoArbol:= min(a^.elem,minimoArbol(a^.hi))
		else
			minimoArbol:= 9999;
	end;
// d
function cantidadArbol(a: arbol): integer;
	begin
		if a<> nil then
			cantidadArbol:= 1 + cantidadArbol(a^.hi) + cantidadArbol(a^.hd)
		else
			cantidadArbol:= 0;
	end;
// e
procedure imprimirArbolCreciente(a: arbol);
	begin
		if a<> nil then begin
			imprimirArbolCreciente(a^.hi);
			writeln(a^.elem);
			imprimirArbolCreciente(a^.hd);
		end;
	end;
procedure imprimirArbolDecreciente(a: arbol);
	begin
		if a<> nil then begin
			imprimirArbolDecreciente(a^.hd);
			writeln(a^.elem);
			imprimirArbolDecreciente(a^.hi);
		end;
	end;
var
	a: arbol;
begin
	generarArbol(a);
	writeln('  Maximo: ',maximoArbol(a));
	writeln('  Minimo: ',minimoArbol(a));
	writeln('  Cantidad: ',cantidadArbol(a));
	imprimirArbolCreciente(a);
	imprimirArbolDecreciente(a);
end.


program ejer_9;
const
	CORTE= 'ZZZ';
type
	arbol= ^nodo;
	nodo= record
		elem: string;
		hi: arbol;
		hd: arbol;
	end;


procedure insertarNodo(var a: arbol; n: string);
	begin
		if a<> nil then begin
			if a^.elem< n then
				insertarNodo(a^.hd,n)
			else
				insertarNodo(a^.hi,n);
		end
		else begin
			new(a);
			a^.elem:= n;
			a^.hi:= nil;
			a^.hd:= nil;
		end;
	end;
function buscarValor(a: arbol; n: string): boolean;
	begin
		if a<> nil then begin
			if a^.elem< n then
				buscarValor:= buscarValor(a^.hd,n)
			else if a^.elem> n then
				buscarValor:= buscarValor(a^.hi,n)
			else
				buscarValor:= true;
		end
		else
			buscarValor:= false;
	end;
procedure generarArbol(var a: arbol);
	var
		n: string;
	begin
		a:= nil;
		write('  Nombre a cargar: '); readln(n);
		while n<> CORTE do begin
			if not buscarValor(a,n) then
				insertarNodo(a,n)
			else
				writeln('  El ',n,' ya esta en el arbol');
			write('  Nombre a cargar: '); readln(n);
		end;
	end;
procedure imprimirArbolCreciente(a: arbol);
	begin
		if a<> nil then begin
			imprimirArbolCreciente(a^.hi);
			writeln(a^.elem);
			imprimirArbolCreciente(a^.hd);
		end;
	end;

var
	a: arbol;
	nom: string;
begin
	generarArbol(a);
	writeln;
	writeln;
	write('  Nombre a buscar: '); readln(nom);
	writeln;
	if buscarValor(a,nom) then
		writeln('    El nombre se encuentra en el arbol')
	else
		writeln('    El nombre no se encuentra en el arbol');
	writeln;
	writeln;
	imprimirArbolCreciente(a);
end.
}

program ejer_10;
const
	CONDICION_CARGA= 2010;
	LEGAJO_MENORES= 15853;
	LEGAJO_RANGO_MIN= 1258;
	LEGAJO_RANGO_MAX= 7692;
type
	alumno= record
		leg: integer;
		ape: string;
		nom: string;
		dni: integer;
		ing: integer;
	end;

	arbol= ^nodo;
	nodo= record
		elem: alumno;
		hi: arbol;
		hd: arbol;
	end;

// a
procedure insertarNodo(var a: arbol; alum: alumno);
	begin
		if a<> nil then begin
			if a^.elem.leg< alum.leg then
				insertarNodo(a^.hd,alum)
			else
				insertarNodo(a^.hi,alum);
		end
		else begin
			new(a);
			a^.elem:= alum;
			a^.hi:= nil;
			a^.hd:= nil;
		end;
	end;
function buscarLegajo(a: arbol; leg: integer): boolean;
	begin
		if a<> nil then begin
			if a^.elem.leg< leg then
				buscarLegajo:= buscarLegajo(a^.hd,leg)
			else if a^.elem.leg> leg then
				buscarLegajo:= buscarLegajo(a^.hi,leg)
			else
				buscarLegajo:= true;
		end
		else
			buscarLegajo:= false;
	end;
procedure leerAlumno(var a: alumno);
	begin
		write('    Anio ingreso: '); readln(a.ing);
		if a.ing<> CONDICION_CARGA then begin
			write('    Legajo: '); readln(a.leg);
			write('    Apellido: '); readln(a.ape);
			write('    Nombre: '); readln(a.nom);
			write('    DNI: '); readln(a.dni);
		end;
	end;
procedure generarArbol(var a: arbol);
	var
		alum: alumno;
	begin
		a:= nil;
		writeln('  Carga Datos');
		leerAlumno(alum);
		while alum.ing<> CONDICION_CARGA do begin
			if not buscarLegajo(a,alum.leg) then
				insertarNodo(a,alum)
			else
				writeln('  El alumno con legajo ',alum.leg,' ya esta cargado');
			writeln;
			leerAlumno(alum);
		end;
	end;

// b
procedure informarNomApe(nom,ape: string);
	begin
		writeln;
		writeln('  El alumno ',nom,' ',ape,' tiene');
		writeln('  un numero de legajo inferior a ',LEGAJO_MENORES);
	end;
procedure informarLegajosMenores(a: arbol; leg: integer);
	begin
		if a<> nil then begin
			informarLegajosMenores(a^.hi,leg);
			if a^.elem.leg< leg then begin
				informarNomApe(a^.elem.nom,a^.elem.ape);
				informarLegajosMenores(a^.hd,leg);
			end;
		end;
	end;

// c
procedure informarLegajosRango(a: arbol; legMax,legMin: integer);
    begin
        if a<> nil then begin
            if a^.elem.leg>= legMin then begin
                informarLegajosRango(a^.hi,legMax,legMin);
                if  a^.elem.leg<= legMax then begin
                    informarNomApe(a^.elem.nom,a^.elem.ape);
                    informarLegajosRango(a^.hd,legMax,legMin);
                end;
            end
            else if a^.elem.leg<= legMax then
                informarLegajosRango(a^.hd,legMax,legMin);
        end;
    end;

var
	a: arbol;
begin
	generarArbol(a);
	informarLegajosMenores(a,LEGAJO_MENORES);
	informarLegajosRango(a,LEGAJO_RANGO_MAX,LEGAJO_RANGO_MIN);
end.
	
