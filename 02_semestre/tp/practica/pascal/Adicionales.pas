{
program Ejer_1;
const
	MAX_CAT= 250;
	
type
	empLargo= record
		nLeg: integer;
		dni: integer;
		cat: integer;
		ing: integer;
	end;
	arbol= ^nodo;
	nodo= record
		elem: empLargo;
		hi: arbol;
		hd: arbol;
	end;
	
	empCorto= record
		nLeg: integer;
		dni: integer;
	end;
	vector= array[1..MAX_CAT] of empCorto;

// a
procedure agregarAtrasVector(var v: vector; var dL: integer; nLeg,dni: integer);
	begin
		if dL< MAX_CAT then begin
			dL:= dL +1;
			v[dL].nLeg:= nLeg;
			v[dL].dni:= dni;
		end;
	end;
// vector se inicia afuera del proceso igual que dl
procedure buscarLegajosAB(a: arbol; legA,legB,nCat: integer; var vLegAB: vector; var dL: integer);
	begin
		if a<> nil then begin
			if a^.elem.nLeg>= legA then begin
				buscarLegajosAB(a^.hi,legA,legB,nCat,vLegAB,dl);
				if a^.elem.nLeg<= legB then begin
					if a^.elem.cat= nCat then
						agregarAtrasVector(vLegAB,dL,a^.elem.nLeg,a^.elem.dni);
					buscarLegajosAB(a^.hd,legA,legB,nCat,vLegAB,dl);
				end;
			end;
		end;
	end;

// b
// se llama al proceso con cont= 0
function promDNIs(v: vector; dL: integer; cont: integer): integer;
	begin
		if cont= 0 then
			promDNIs:= promDNIs(v,dL,cont+1) div dL
		else if cont<= dL then
			promDNIs:= v[cont].dni + promDNIs(v,dL,cont+1)
		else
			promDNIs:= 0;
	end;


program Ejer_2;
const
  CANT_DIAS= 7;
  OBRA_CORTE= 0;
type
  entrada= record
    dia: integer;
    obra: integer;
    asiento: integer;
    monto: real;
  end;
  listaEntradas= ^nodoEntradas;
  nodoEntradas= record
    elem: entrada;
    sig: listaEntradas;
  end;
  vector= array[1..CANT_DIAS] of listaEntradas;
  obra= record
    cod: integer;
    ventas: integer;
  end;
  listaObras= ^nodoObras;
  nodoObras= record
    elem: obra;
    sig: listaObras;
  end;
procedure leerEntrada(var e: entrada);
begin
  e.obra:= random(32);
  if e.obra<> OBRA_CORTE then begin
    e.dia:= random(CANT_DIAS) +1;
    e.asiento:= random(100) +1;
    e.monto:= e.obra*10 + 250;
  end;
 end;
procedure insertarObra(var l: listaEntradas; e: entrada);
var
  ant,act,nue: listaEntradas;
begin
  new(nue);
  nue^.elem:= e;
  act:= l;
  while (act<> nil) and (act^.elem.obra< e.obra) do begin
    ant:= act;
    act:= act^.sig;
  end;
  if act= l then
    l:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;
procedure iniVecEntradas(var v: vector);
var
  i: integer;
begin
  for i:= 1 to CANT_DIAS do
    v[i]:= nil;
end;
procedure generarEntradas(var v: vector);
var
  e: entrada;
begin
  leerEntrada(e);
  while e.obra<> OBRA_CORTE do begin
    insertarObra(v[e.dia],e);
    leerEntrada(e);
  end;
end;
procedure minimaObra(var v: vector; var obra: integer);
var
  i,pos: integer;
begin
  obra:= 9999;
  for i:= 1 to CANT_DIAS do
    if (v[i]<> nil) and (v[i]^.elem.obra< obra) then begin
      pos:= i;
      obra:= v[i]^.elem.obra;
    end;
  if obra<> 9999 then
    v[pos]:= v[pos]^.sig;
end;
procedure agregarUlt(var l,ult: listaObras; o: obra);
var
  nue: listaObras;
begin
  new(nue);
  nue^.elem:= o;
  if l= nil then
    l:= nue
  else
    ult^.sig:= nue;
  ult:= nue;
end;
procedure mergeObras(v: vector; var lObras: listaObras);
var
  min: integer;
  o: obra;
  ult: listaObras;
begin
  lObras:= nil;
  minimaObra(v,min);
  while min<> 9999 do begin
    o.cod:= min;
    o.ventas:= 0;
    while (min<> 9999) and (min= o.cod) do begin
      o.ventas:= o.ventas +1;
      minimaObra(v,min);
    end;
    agregarUlt(lObras,ult,o);
  end;
end;
procedure informarVentasObras(l: listaObras);
begin
  if l<> nil then begin
    writeln('Para la obra: ',l^.elem.cod,' se vendieron: ',l^.elem.ventas,' entradas');
    informarVentasObras(l^.sig);
  end;
end;
var
  vecEntradas: vector;
  listObras: listaObras;
begin
  generarEntradas(vecEntradas);
  mergeObras(vecEntradas,listObras);
  informarVentasObras(listObras);
end.


program Ejer_3;
const
	CANT_OFI= 300;
	COD_CORTE= -1;
	COD_BUSQUEDA= 32;

type
	oficina= record
		cod: integer;
		dni: integer;
		valor: real;
	end;
	vector= array[1..CANT_OFI] of oficina;
	
procedure leerOficina(var o: oficina);
	begin
		readln(o.cod);
		if o.cod<> COD_CORTE then begin
			o.dni:= random(10000) + 10000;
			o.valor:= random(1000) + 1500;
		end;
		writeln(o.dni,'  ',o.valor:0:2);
	end;
procedure cargarOficinas(var v: vector; var dL: integer);
	var
		o: oficina;
	begin
		dL:= 0;
		leerOficina(o);
		while o.cod<> COD_CORTE do begin
			dL:= dL +1;
			v[dL]:= o;
			leerOficina(o);
		end;
	end;

procedure insercionPorCod(var v: vector; dL: integer);
	var
		i, j: integer;
		act: oficina;
	begin
		for i:=2 to dL do begin
			act:= v[i];
			j:= i-1; 
			while (j > 0) and (v[j].cod > act.cod) do begin
				v[j+1]:= v[j];
				j:= j -1;
			end;  
			v[j+1]:= act;
		end;
	end;

function busqCod(v: vector; ini,fin,cod: integer): integer;
	var
		med: integer;
	begin
		if ini< fin then begin
			med:= (ini + fin) div 2;
			if v[med].cod= cod then
				busqCod:= med
			else if v[med].cod< cod then
				busqCod:= busqCod(v,med +1,fin,cod)
			else
				busqCod:= busqCod(v,ini,med -1,cod);
		end
		else if v[ini].cod= cod then
			busqCod:= ini
		else
			busqCod:= -1;
	end;

var
	vOfis: vector;
	cantOfis: integer;
	pos: integer;
begin
	cargarOficinas(vOfis, cantOfis);
	insercionPorCod(vOfis, cantOfis);
	pos:= busqCod(vOfis,1,cantOfis,COD_BUSQUEDA);
	if pos<> -1 then
		writeln('  El propietario de la oficina ',COD_BUSQUEDA,' tiene el DNI: ',vOfis[pos].dni)
	else
		writeln('  La oficina de codigo ',COD_BUSQUEDA,' no existe');
end.


program Ejer_4;
const
	FAB_INI= 2010;
	FAB_FIN= 2018;
type
	auto= record
		patente: string;
		fab: integer;
		marca: string;
		modelo: string;
	end;
	arbol= ^nodoA;
	nodoA= record
		elem: auto;
		hi: arbol;
		hd: arbol;
	end;
	
	lista= ^nodoL;
	nodoL= record
		elem: auto;
		sig: lista;
	end;
	vector= array[FAB_INI..FAB_FIN] of lista;
	
procedure leerAuto(var a: auto);
	begin
		readln(a.patente);
		a.fab:= random(9) + 2010;
		readln(a.marca);
		a.modelo:= 'modelito';
	end;
procedure insertarPorPatente(var a: arbol; au: auto);
	begin
		if a= nil then begin
			new(a);
			a^.elem:= au;
			a^.hi:= nil;
			a^.hd:= nil;
		end
		else if a^.elem.patente< au.patente then
			insertarPorPatente(a^.hd,au)
		else
			insertarPorPatente(a^.hi,au);
	end;
procedure cargarVentas(var a: arbol);
	var
		i: integer;
		au: auto;
	begin
		for i:= 1 to 8 do begin
			leerAuto(au);
			insertarPorPatente(a,au);
		end;
	end;

function contarMarca(a: arbol; marca: string): integer;
	begin
		if a<> nil then begin
			if a^.elem.marca= marca then
				contarMarca:= 1 + contarMarca(a^.hi,marca) + contarMarca(a^.hd,marca)
			else
				contarMarca:= contarMarca(a^.hi,marca) + contarMarca(a^.hd,marca);
		end
		else
			contarMarca:= 0;
	end;

procedure agregarAdelante(var l: lista; au: auto);
	var
		nue: lista;
	begin
		new(nue);
		nue^.elem:= au;
		nue^.sig:= l;
		l:= nue;
	end;
procedure iniciarVecAnios(var v: vector);
	var
		i: integer;
	begin
		for i:= FAB_INI to FAB_FIN do
			v[i]:= nil;
	end;
procedure agruparPorAnio(a: arbol; var v: vector);
	begin
		if a<> nil then begin
			agruparPorAnio(a^.hd,v);
			agregarAdelante(v[a^.elem.fab],a^.elem);
			agruparPorAnio(a^.hi,v);
		end;
	end;

function buscarPatente(a: arbol; patente: string): integer;
	begin
		if a<> nil then begin
			if a^.elem.patente> patente then
				buscarPatente:= buscarPatente(a^.hi,patente)
			else if a^.elem.patente< patente then
				buscarPatente:= buscarPatente(a^.hd,patente)
			else
				buscarPatente:= a^.elem.fab;
		end
		else
			buscarPatente:= -1;
	end;

var
	aAutos: arbol;
	vAnios: vector;
	marcaContar,patenteBuscada: string;
begin
	cargarVentas(aAutos);
	iniciarVecAnios(vAnios);
	write('  Marca a contar: '); readln(marcaContar);
	writeln('  La marca ',marcaContar,' tiene: ',contarMarca(aAutos,marcaContar),' autos vendidos');
	agruparPorAnio(aAutos,vAnios);
	writeln;
	write('  Patente a buscar: '); readln(patenteBuscada);
	writeln('  El auto de patente ',patenteBuscada,' se fabrico en el anio: ',buscarPatente(aAutos,patenteBuscada));
end.
}

program Ejer_5;
const
	COD_CORTE= -1;
	CANT_SUCURSALES= 5;
type
	asistencia= record
		cod: integer;
		dni: integer;
		fecha: string;
		min: integer;
		suc: integer;
	end;
	lista= ^nodoL;
	nodoL= record
		elem: asistencia;
		sig: lista;
	end;
	vector= array[1..CANT_SUCURSALES] of lista;
	
	cliente= record
		dni: integer;
		asis: integer;
	end;
	arbol= ^nodoA;
	nodoA= record
		elem: cliente;
		hi: arbol;
		hd: arbol;
	end;
	
procedure leerAsistencia(var a: asistencia);
	begin
		a.cod:= random(120)-1;
		if a.cod<> COD_CORTE then begin
			a.dni:= random(1001) + 30000;
			a.fecha:= chr(48 + random(10));
			a.min:= random(61) + 30;
			a.suc:= random(CANT_SUCURSALES) +1;
		end;
	end;
procedure insertarPorCod(var l: lista; a: asistencia);
	var
		ant,act,nue: lista;
	begin
		new(nue);
		nue^.elem:= a;
		act:= l;
		while (act<> nil) and (act^.elem.cod< a.cod) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act= l then
			l:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
procedure iniciarVectorSucursales(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to CANT_SUCURSALES do
			v[i]:= nil;
	end;
procedure cargarAsistencias(var v: vector);
	var
		a: asistencia;
	begin
		iniciarVectorSucursales(v);
		leerAsistencia(a);
		while a.cod<> COD_CORTE do begin
			insertarPorCod(v[a.suc],a);
			leerAsistencia(a);
		end;
	end;

procedure minimoCod(var v: vector; var min: integer; var dni: integer);
	var
		i,pos: integer;
	begin
		min:= 9999;
		for i:= 1 to CANT_SUCURSALES do
			if (v[i]<> nil) and (v[i]^.elem.cod< min) then begin
				pos:= i;
				min:= v[i]^.elem.cod;
			end;
		if min<> 9999 then begin
			dni:= v[pos]^.elem.dni;
			v[pos]:= v[pos]^.sig;
		end;
	end;
procedure insertarPorDNI(var a: arbol; c: cliente);
	begin
		if a= nil then begin
			new(a);
			a^.elem:= c;
			a^.hi:= nil;
			a^.hd:= nil;
		end
		else if a^.elem.dni< c.dni then
			insertarPorDNI(a^.hd,c)
		else
			insertarPorDNI(a^.hi,c);
	end;
procedure contarAsistenciaCliente(v: vector; var a: arbol);
	var
		c: cliente;
		min,dni: integer;
	begin
		a:= nil;
		minimoCod(v,min,dni);
		while min<> 9999 do begin
			c.dni:= dni;
			c.asis:= 0;
			while (min<> 9999) and (dni= c.dni) do begin
				c.asis:= c.asis +1;
				minimoCod(v,min,dni);
			end;
			insertarPorDNI(a,c);
		end;
	end;

var
	vAsistencias: vector;
	aClientes: arbol;
begin
	cargarAsistencias(vAsistencias);
	contarAsistenciaCliente(vAsistencias,aClientes);
end.
