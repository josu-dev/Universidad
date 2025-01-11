const
	CANTPUESTOS= 20;
	VALORCOMPARACION= 150.00;

type
	compra= record
		cod: integer;
		dni: integer;
		fecha: string;
		monto: real;
	end;
	
	lista= ^nodoCompra;
	
	nodoCompra= record
		elem: compra;
		sig: lista;
	end;
	
	vector= array[1..CANTPUESTOS] of lista;
	
	
	cliente= record
		dni: integer;
		monto: real;
	end;
	
	arbol= ^nodoCliente;
	
	nodoCliente= record
		elem: cliente;
		hi: arbol;
		hd: arbol;
	end;

procedure iniciarVCompras(var vCompras: vector); // se dispone
	begin end;

procedure leerCompra(var puesto: integer; var c: compra); // se dispone
	begin end;

procedure insertarPorCodigo(var l: lista; c: compra); // se dispone
	begin end;

procedure Compras(var vCompras: vector); // se dispone
	begin end;
// a)
procedure agregarPorMonto(var a: arbol; c: cliente);
	begin
		if (a = nil) then begin
			new(a);
			a^.elem:= c;
			a^.hi:= nil;
			a^.hd:= nil;
		end
		else begin
			if (a^.elem.monto > c.monto) then
				agregarPorMonto(a^.hi, c)
			else
				agregarPorMonto(a^.hd, c)
		end;
	end;

procedure minimoCodigo(var vCompras: vector; var min: compra);
	var
		i, iMin: integer;
	begin
		min.cod:= 9999;
		for i:= 1 to CANTPUESTOS do
			if (vCompras[i] <> nil) and (vCompras[i]^.elem.cod < min.cod) then begin
				iMin:= i;
				min.cod:= vCompras[i]^.elem.cod;
			end;
		if (min.cod <> 9999) then begin
			min:= vCompras[iMin]^.elem;
			vCompras[i]:= vCompras[i]^.sig;
		end;
	end;

procedure mergeAcumulador(vCompras: vector; var aClientes: arbol);
	var
		minimo: compra;
		codigoActual: integer;
		actual: cliente;
	begin
		aClientes:= nil;
		minimoCodigo(vCompras, minimo);
		while (minimo.cod <> 9999) do begin
			codigoActual:= minimo.cod;
			actual.dni:= minimo.dni;
			actual.monto:= 0;
			while (minimo.cod <> 9999) and (minimo.cod = codigoActual) do begin
				actual.monto:= actual.monto + minimo.monto;
				minimoCodigo(vCompras, minimo);
			end;
			agregarPorMonto(aClientes, actual);
		end;
	end;

// b)
function cantidadSuperiorValor(a: arbol; valor: real): integer;
	begin
		if (a = nil) then
			cantidadSuperiorValor:= 0
		else begin
			if (a^.elem.monto <= valor) then
				cantidadSuperiorValor:= cantidadSuperiorValor(a^.hd, valor)
			else
				cantidadSuperiorValor:= 1 + cantidadSuperiorValor(a^.hi, valor) + cantidadSuperiorValor(a^.hd, valor);
		end;
	end;

var
	vCompras: vector;
	aClientes: arbol;

begin
	Compras(vCompras);
	mergeAcumulador(vCompras, aClientes);
	// se pasa por CONSTANTE el valor pero puede ser variable o valor directo
	writeln('La cantidad de clientes que superan $', VALORCOMPARACION:0:2,' invertidos en puestos es de: ', cantidadSuperiorValor(aClientes, VALORCOMPARACION));
end.
