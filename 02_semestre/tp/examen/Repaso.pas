const
	CANT_SUCURSALES= 5;
	CANT_VENTAS= 200;
	COD_CORTE= -1;
	UNIDADES_COMPARACION= 500;

type
	venta= record
		codigo: integer;
		cantidad: integer;
		montoTotal: real;
	end;
	
	vVentas= array [1..CANT_VENTAS] of venta;
	
	regSucursal= record
		vec: vVentas;
		dl: integer;
	end;

	vSucursales= array [1..CANT_SUCURSALES] of regSucursal;
	
	producto= record
		codigo: integer;
		cantidad: integer;
	end;

	lista= ^nodo;
	nodo= record
		elem: producto;
		sig: lista;
	end;
	
	vIndices= array[1..CANT_SUCURSALES] of integer;

procedure leerVenta( var v: venta );
begin
	write( 'Ingrese codigo: '); readln(v.codigo);
	if (v.codigo<> COD_CORTE) then begin
		write( 'Ingrese cantidad: '); readln(v.cantidad);
		write( 'Ingrese monto total: '); readln(v.montoTotal);
	end;
end;

procedure cargarSucursales(var vSucur: vSucursales);
var
	i: integer;
	ventita: venta;
begin
	for i:= 1 to CANT_SUCURSALES do begin
		leerVenta(ventita);
		vSucur[i].dl:= 0;
		while (vSucur[i].dl< CANT_VENTAS) and (ventita.codigo <> COD_CORTE) do begin
			vSucur[i].dl:= vSucur[i].dl +1;
			vSucur[i].vec[vSucur[i].dl]:= ventita;
			leerVenta(ventita);
		end;
	end;
end;


procedure minimo(vSucur: vSucursales;var vMinima: venta; var vIndis: vIndices);
var
	i,pos: integer;
begin
	vMinima.codigo:= 9999;
	for i:= 1 to CANT_SUCURSALES do begin
		if (vIndis[i]<= vSucur[i].dl) and ( vSucur[i].vec[vIndis[i]].codigo < vMinima.codigo) then begin
			pos:= i;
			vMinima.codigo:= vSucur[i].vec[vIndis[i]].codigo;
		end;
	end;
	
	if ( vMinima.codigo<> 9999 ) then begin
		vMinima:= vSucur[pos].vec[vIndis[pos]];
		vIndis[pos]:= vIndis[pos] +1;
	end;
end;
procedure agregarAtras(var l,ult: lista; p: producto);
var
	nue: lista;
begin
	new(nue);
	nue^.elem:= p;
	nue^.sig:= nil;
	if (l= nil) then
		l:= nue
	else
		ult^.sig:= nue;
	ult:= nue;
end;

procedure iniciarIndices(var v: vIndices);
var
	i: integer;
begin
	for i:= 1 to CANT_SUCURSALES do
		v[i]:= 1;
end;
procedure mergeAcumulador(vSucur: vSucursales; var l: lista);
var
	vIndis: vIndices;
	vMinima: venta;
	vActual: producto;
	ult: lista;
begin
	l:= nil;
	iniciarIndices(vIndis);
	minimo(vSucur, vMinima, vIndis);
	while (vMinima.codigo <> 9999) do begin
		vActual.codigo:= vMinima.codigo;
		vActual.cantidad:= 0;
		while (vMinima.codigo <> 9999) and (vActual.codigo = vMinima.codigo) do begin
			vActual.cantidad:= vActual.cantidad + vMinima.cantidad;
			minimo(vSucur, vMinima, vIndis);
		end;
		agregarAtras(l,ult,vActual);
	end;
end;

function mas500Unidades(l: lista): integer;
begin
	if (l= nil) then
		mas500Unidades:= 0
	else begin
		if (l^.elem.cantidad> UNIDADES_COMPARACION) then
			mas500Unidades:= mas500Unidades(l^.sig) +1
		else
			mas500Unidades:= mas500Unidades(l^.sig);
	end;
end;

var
	vSucur: vSucursales;
	lProductos: lista;
begin
	cargarSucursales(vSucur);
	mergeAcumulador(vSucur, lProductos);
	writeln( 'La cantidad de productos con mas de 500 unidades es: ', mas500Unidades(lProductos));
end.
