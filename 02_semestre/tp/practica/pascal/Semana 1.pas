{
program ejer_1;
const
	TAM_V= 300;
	COD_CORTE= -1;

type
	oficina= record
		Cod: integer;
		Dni: integer;
		Valor: real;
	end;
	vector= array[1..TAM_V] of oficina;

procedure leerOficina(var o: oficina);
	var
		n: integer;
	begin
		n:= random(100);
		o.Cod:= random(301);
		o.Dni:= random(1001) + 3000;
		o.Valor:= random(2501) + 12500;
		if n= 5 then
			o.Cod:= COD_CORTE;
	end;

procedure cargarOficinas(var v: vector; var dL: integer);
	var
		o: oficina;
	begin
		dL:= 0;
		leerOficina(o);
		while (o.Cod<> COD_CORTE) and (dL< TAM_V) do begin
			dL:= dL +1;
			v[dL]:= o;
			leerOficina(o);
		end;
	end;

Procedure Insercion(var v: vector; dimL: integer);
	var
		i, j: integer;
		actual: oficina;
	begin
		for i:=2 to dimL do begin
			actual:= v[i];
			j:= i-1; 
			while (j > 0) and (v[j].Cod > actual.Cod) do begin
				v[j+1]:= v[j];
			j:= j -1;
			end;  
			 v[j+1]:= actual;
		end;
	end;

Procedure Seleccion(var v: vector; dimL: integer);
	var
		i, j, p: integer;
		item: oficina;
	begin
		for i:=1 to dimL-1 do begin
			p := i;
			for j := i+1 to dimL do
				if v[ j ].Cod < v[ p ].Cod then
					p:=j;
			item := v[ p ];   
			v[ p ] := v[ i ];   
			v[ i ] := item;
		end;
	end;



Procedure imprimir(v1,v2: vector; dimL: integer);
	var
		i: integer;
	begin
		for i:=1 to dimL do
			writeln(v1[i].Cod,'  ',v2[i].Cod);
	end;

var
	vOficinas,vCopia: vector;
	dl: integer;
begin
	cargarOficinas(vOficinas,dl);
	vCopia:= vOficinas;
	Insercion(vCopia,dl);
	Seleccion(vOficinas,dl);
	imprimir(vCopia,vOficinas,dl);
end.
}


Program ejer_2;
const
	CANT_G= 8;
	COD_CORTE= -1;

type
	pelicula= record
		CodP: integer;
		CodG: integer;
		Punt: real;
	end;
	
	lista= ^nodo;
	nodo= record
		elem: pelicula;
		sig: lista;
	end;
	
	vector= array[1..CANT_G] of lista;

procedure leerPelicula(var p: pelicula);
	var
		n: integer;
	begin
		n:= random(100);
		p.CodP:= random(101);
		p.CodG:= random(CANT_G) +1;
		p.Punt:= random(101);
		if n= 5 then
			p.CodP:= COD_CORTE;
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
procedure inciarVector(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to CANT_G do
			v[i]:= nil;
	end;
procedure cargarPeliculas(var v: vector);
	var
		p: pelicula;
		vUlt: vector;
	begin
		inciarVector(v);
		leerPelicula(p);
		while p.CodP<> COD_CORTE do begin
			agregarUltimo(v[p.CodG],vUlt[p.CodG],p);
			leerPelicula(p);
		end;
	end;



function puntajeMaximo(l: lista): lista;
	var
		max: lista;
	begin
		max:= l;
		while l<> nil do begin
			if l^.elem.Punt> max^.elem.Punt then
				max:= l;
			l:= l^.sig;
		end;
		puntajeMaximo:= max;
	end;

procedure buscarMaximos(v: vector; var vMax: vector; var dl: integer);
	var
		i: integer;
		aux: lista;
	begin
		dl:= 0;
		for i:= 1 to CANT_G do begin
			aux:= puntajeMaximo(v[i]);
			if (aux<> nil) and (aux^.elem.punt <> 0) then begin
				dl:= dl +1;
				vMax[dl]:= aux;
			end;
		end;
	end;



Procedure Insercion(var v: vector; dimL: integer);
	var
		i, j: integer;
		actual: lista;
	begin
		for i:=2 to dimL do begin
			actual:= v[i];
			j:= i-1; 
			while (j > 0) and (v[j]^.elem.Punt > actual^.elem.Punt) do begin
				v[j+1]:= v[j];
				j:= j -1;
			end;  
			 v[j+1]:= actual;
		end;
	end;


procedure imprimirMaxMin(v: vector; dl: integer);
	begin
		if dl>0 then begin
			writeln('  La pelicula con menor puntaje es: ',v[1]^.elem.CodP,' ',v[1]^.elem.Punt:0:0);
			writeln('  La pelicula con mayor puntaje es: ',v[dl]^.elem.CodP,' ',v[dl]^.elem.Punt:0:0);
		end;
	end;

var
	vGeneros,vPuntajes: vector;
	dl: integer;
begin
	cargarPeliculas(vGeneros);
	buscarMaximos(vGeneros,vPuntajes,dl);
	Insercion(vPuntajes,dl);
	imprimirMaxMin(vPuntajes,dl);
end.



Program ejer_3;

const
	CANT_RUBRO= 8;
	PRECIO_CORTE= 0;
	CANT_ELEM= 30;
	RUBRO_MUESTRA= 3;
	
type
	producto= record
		cod: integer;
		rubro: integer;
		precio: real;
	end;
	
	lista= ^nodo;
	nodo= record
		elem: producto;
		sig: lista;
	end;
	
	vector= array[1..CANT_RUBRO] of lista;

	vectorMuestra= array[1..CANT_ELEM] of producto;

procedure iniciarVector(var v: vector);
	var
		i: integer;
	begin
		for i:=1 to CANT_RUBRO do
			v[i]:= nil;
	end;

procedure leerProducto(var p: producto);
	var
		n: integer;
	begin
		n:= random(150);
		p.cod:= random(10001);
		p.rubro:= random(CANT_RUBRO) +1;
		p.precio:= random(1501) + 500;
		if n= 1 then
			p.precio:= PRECIO_CORTE;
	end;

procedure insertarPorCodigo(var l: lista; p: producto);
	var
		ant,act,nue: lista;
	begin
		new(nue);
		nue^.elem:= p;
		act:= l;
		while (act<> nil) and (act^.elem.cod< p.cod) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act= l then
			l:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;

procedure cargarProductos(var v: vector);
	var
		p: producto;
	begin
		iniciarVector(v);
		leerProducto(p);
		while p.precio<> PRECIO_CORTE do begin
			insertarPorCodigo(v[p.rubro],p);
			leerProducto(p);
		end;
	end;



procedure tomarMuestra(l: lista; var vM: vectorMuestra; var dL: integer);
	begin
		dL:= 0;
		while (l<> nil) and (dL< CANT_ELEM) do begin
			dL:= dL +1;
			vM[dL]:= l^.elem;
			l:= l^.sig;
		end;
	end;



procedure ordenarMuestra(var v: vectorMuestra; dL: integer);
	var
		i, j: integer;
		actual: producto;
	begin
		for i:=2 to dL do begin
			actual:= v[i];
			j:= i-1; 
			while (j > 0) and (v[j].precio > actual.precio) do begin
				v[j+1]:= v[j];
				j:= j -1;
			end;  
			 v[j+1]:= actual;
		end;
	end;


procedure imprimirPrecio(v: vectorMuestra; dl: integer);
	var
		i: integer;
	begin
		for i:=1 to dl do
			writeln('  Precio: ',v[i].precio:0:0);
	end;



var
	vProductos: vector;
	vMuestra: vectorMuestra;
	dLMuestra: integer;
begin
	cargarProductos(vProductos);
	tomarMuestra(vProductos[RUBRO_MUESTRA],vMuestra,dLMuestra);
	ordenarMuestra(vMuestra,dLMuestra);
	imprimirPrecio(vMuestra,dLMuestra);
end.
