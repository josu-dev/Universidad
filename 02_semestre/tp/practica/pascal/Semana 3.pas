{
program ejer_11;
const
	COD_CORTE= -1;
	CANT_GENERO= 8;
type
	pelicula= record
		codP: integer;
		codG: integer;
		pun: real;
	end;
	lista= ^nodo;
	nodo= record
		elem: pelicula;
		sig: lista;
	end;
	vector= array[1..CANT_GENERO] of lista;

procedure leerPelicula(var p: pelicula);
	begin
		p.codP:= random(101)-1;
		if p.codP<> COD_CORTE then begin
			p.codG:= random(CANT_GENERO) +1;
			p.pun:= random(10) + random(10)*0.1;
		end;
	end;
procedure insertarPorCodigo(var l: lista; p: pelicula);
	var
		ant,act,nue: lista;
	begin
		new(nue);
		nue^.elem:= p;
		act:= l;
		while (act<> nil) and (act^.elem.codP< p.codP) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act= l then
			l:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
procedure iniciarVectorGeneros(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to CANT_GENERO do
			v[i]:= nil;
	end;

procedure cargarPeliculas(var v: vector);
	var
		p: pelicula;
	begin
		iniciarVectorGeneros(v);
		leerPelicula(p);
		while p.codP<> COD_CORTE do begin
			insertarPorCodigo(v[p.codG],p);
			leerPelicula(p);
		end;
	end;

procedure minimoCodigoP(var v: vector; var min: pelicula);
	var
		i,pos: integer;
	begin
		min.codP:= 9999;
		for i:= 1 to CANT_GENERO do
			if (v[i]<> nil) and (v[i]^.elem.codP< min.codP) then begin
				min:= v[i]^.elem;
				pos:= i;
			end;
		if min.codP<> 9999 then
			v[pos]:= v[pos]^.sig;
	end;
procedure agregarUltimo(var l,ult: lista; p: pelicula);
	var
		nue: lista;
	begin
		new(nue);
		nue^.elem:= p;
		nue^.sig:= nil;
		if l= nil then
			l:= nue
		else
			ult^.sig:= nue;
		ult:= nue;
	end;

procedure merge(v: vector; var l: lista);
	var
		min: pelicula;
		ult: lista;
	begin
		l:= nil;
		minimoCodigoP(v,min);
		while min.codP<> 9999 do begin
			agregarUltimo(l,ult,min);
			minimoCodigoP(v,min);
		end;
	end;

procedure imprimirPeliculas(l: lista);
	begin
		while l<> nil do begin
			writeln('  CodP: ',l^.elem.codP,'  CodG: ',l^.elem.codG,'  Pun: ',l^.elem.pun:0:1);
			l:= l^.sig;
		end;
	end;
var
	vPeliculas: vector;
	lTotal: lista;
begin
	cargarPeliculas(vPeliculas);
	merge(vPeliculas,lTotal);
	imprimirPeliculas(lTotal);
end.



program ejer_12;
const
	COD_CORTE= 0;
	CANT_SUCURSALES= 4;
type
	venta= record
		dia: integer;
		codP: integer;
		codS: integer;
		cantV: integer;
	end;
	lista= ^nodo;
	nodo= record
		elem: venta;
		sig: lista;
	end;
	vector= array[1..CANT_SUCURSALES] of lista;
	
	ventaTotal= record
		codP: integer;
		cantT: integer;
	end;
	listaTotal= ^nodoTotal;
	nodoTotal= record
		elem: ventaTotal;
		sig: listaTotal;
	end;

procedure leerVenta(var v: venta);
	begin
		v.codS:= random(CANT_SUCURSALES +1);
		if v.codS<> COD_CORTE then begin
			v.codP:= random(3) +1;
			v.dia:= random(30) +1;
			v.cantV:= random(10) +1;
			writeln(v.codP,' ',v.cantV);
		end;
	end;
procedure insertarPorCodigo(var l: lista; v: venta);
	var
		ant,act,nue: lista;
	begin
		new(nue);
		nue^.elem:= v;
		act:= l;
		while (act<> nil) and (act^.elem.codP< v.codP) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act= l then
			l:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
procedure iniciarVectorVentas(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to CANT_SUCURSALES do
			v[i]:= nil;
	end;
procedure cargarVentas(var vec: vector);
	var
		v: venta;
	begin
		iniciarVectorVentas(vec);
		leerVenta(v);
		while v.codS<> COD_CORTE do begin
			insertarPorCodigo(vec[v.codS],v);
			leerVenta(v);
		end;
	end;

procedure minimoCodigoP(var v: vector; var min: venta);
	var
		i,pos: integer;
	begin
		min.codP:= 9999;
		for i:= 1 to CANT_SUCURSALES do
			if (v[i]<> nil) and (v[i]^.elem.codP< min.codP) then begin
				min:= v[i]^.elem;
				pos:= i;
			end;
		if min.codP<> 9999 then
			v[pos]:= v[pos]^.sig;
	end;
procedure agregarUltimo(var l,ult: listaTotal; v: ventaTotal);
	var
		nue: listaTotal;
	begin
		new(nue);
		nue^.elem:= v;
		nue^.sig:= nil;
		if l= nil then
			l:= nue
		else
			ult^.sig:= nue;
		ult:= nue;
	end;
procedure mergeAcumulador(v: vector; var l: listaTotal);
	var
		min: venta;
		act: ventaTotal;
		ult: listaTotal;
	begin
		l:= nil;
		minimoCodigoP(v,min);
		while min.codP<> 9999 do begin
			act.codP:= min.codP;
			act.cantT:= 0;
			while (min.codP<> 9999) and (act.codP= min.codP) do begin
				act.cantT:= act.cantT + min.cantV;
				minimoCodigoP(v,min);
			end;
			agregarUltimo(l,ult,act);
		end;
	end;

procedure imprimirVentasTotal(l: listaTotal);
	begin
		while l<> nil do begin
			writeln('  CodP: ',l^.elem.codP,'  CantT: ',l^.elem.cantT);
			l:= l^.sig;
		end;
	end;
var
	vVentas: vector;
	lTotal: listaTotal;
begin
	cargarVentas(vVentas);
	mergeAcumulador(vVentas,lTotal);
	imprimirVentasTotal(lTotal);
end.
}


program ejer_13;
const
	COD_CORTE= 0;
	CANT_DIAS= 7;
type
	entrada= record
		dia: integer;
		codO: integer;
		asiento: integer;
		monto: real;
	end;
	lista= ^nodo;
	nodo= record
		elem: entrada;
		sig: lista;
	end;
	vector= array[1..CANT_DIAS] of lista;

	entradaTotal= record
		codO: integer;
		cant: integer;
	end;
	listaTotal= ^nodoTotal;
	nodoTotal= record
		elem: entradaTotal;
		sig: listaTotal;
	end;

procedure leerEntrada(var e: entrada);
	begin
		e.codO:= random(16)-1;
		if e.codO<> COD_CORTE then begin
			e.dia:= random(CANT_DIAS) +1;
			e.asiento:= random(100) +1;
			e.monto:= random(100) + 250;
		end;
	end;
procedure insertarPorObra(var l: lista; e: entrada);
	var
		ant,act,nue: lista;
	begin
		new(nue);
		nue^.elem:= e;
		act:= l;
		while (act<> nil) and (act^.elem.codO< e.codO) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act= l then
			l:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
procedure iniciarVectorEntradas(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to CANT_DIAS do
			v[i]:= nil;
	end;

procedure cargarEntradas(var v: vector);
	var
		e: entrada;
	begin
		iniciarVectorEntradas(v);
		leerEntrada(e);
		while e.codO<> COD_CORTE do begin
			insertarPorObra(v[e.dia],e);
			leerEntrada(E);
		end;
	end;

procedure minimoCodigoO(var v: vector; var min: entrada);
	var
		i,pos: integer;
	begin
		min.codO:= 9999;
		for i:= 1 to CANT_DIAS do
			if (v[i]<> nil) and (v[i]^.elem.codO< min.codO) then begin
				min:= v[i]^.elem;
				pos:= i;
			end;
		if min.codO<> 9999 then
			v[pos]:= v[pos]^.sig;
	end;
procedure agregarUltimo(var l,ult: listaTotal; e: entradaTotal);
	var
		nue: listaTotal;
	begin
		new(nue);
		nue^.elem:= e;
		nue^.sig:= nil;
		if l= nil then
			l:= nue
		else
			ult^.sig:= nue;
		ult:= nue;
	end;
procedure mergeAcumulador(v: vector; var l: listaTotal);
	var
		min: entrada;
		act: entradaTotal;
		ult: listaTotal;
	begin
		l:= nil;
		minimoCodigoO(v,min);
		while min.codO<> 9999 do begin
			act.codO:= min.codO;
			act.cant:= 0;
			while (min.codO<> 9999) and (act.codO= min.codO) do begin
				act.cant:= act.cant + 1;
				minimoCodigoO(v,min);
			end;
			agregarUltimo(l,ult,act);
		end;
	end;

procedure imprimirEntradasTotal(l: listaTotal);
	begin
		while l<> nil do begin
			writeln('  CodO: ',l^.elem.codO,'  Cant: ',l^.elem.cant);
			l:= l^.sig;
		end;
	end;
var
	vEntradas: vector;
	lTotal: listaTotal;
begin
	cargarEntradas(vEntradas);
	mergeAcumulador(vEntradas,lTotal);
	imprimirEntradasTotal(lTotal);
end.
