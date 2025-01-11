program problema_adicional_1;

type
	meses = 1..12;
	dias = 1..31;
	anos = 0..9999;
	fecha = record
		dia: dias;
		mes: meses;
		ano: anos;
	end;
	inmueble = record
		luga: string;
		tipo: string;
		chab: integer;
		cban: integer;
		prec: real;
		fpub: fecha;
	end;
procedure creditos();
	begin
	writeln('--------------------------------');
	writeln('   Evaluador de inmuebles 1.0');
	writeln('        Por Josue Suarez');
	writeln('--------------------------------');
	writeln();
	end;
procedure leer(var inm:inmueble);
	begin
		write('Ingrese la localidad: ');
		readln(inm.luga);
		if inm.luga<>'XXX' then begin
			write('Ingrese el tipo: ');
			readln(inm.tipo);
			write('Ingrese la cant. de habitaciones: ');
			readln(inm.chab);
			write('Ingrese la cant. de banos: ');
			readln(inm.cban);
			write('Ingrese el precio: $');
			readln(inm.prec);
			writeln('Ingrese la fecha de publicacion:');
			write('dia: ');readln(inm.fpub.dia);
			write('mes: ');readln(inm.fpub.mes);
			write('ano: ');readln(inm.fpub.ano);
		end;
	end;
function fpubesverano(a:fecha):boolean;
	begin
		fpubesverano:= (a.dia >= 21)and(a.mes=12)and(a.ano=2020) or (a.mes=1)and(a.ano=2021) or (a.mes=2)and(a.ano=2021) or (a.mes=3)and(a.dia<21)and(a.ano=2021);
	end;
function modrr(a,b:real):real;
	var
		restor: real;
	begin
		if a>=b then begin
			restor:=a/b;
			if restor>=1 then
				repeat        
					if restor>1000000000000 then
						restor:= restor - 1000000000000
					else if restor>1000000000000 then
						restor:= restor - 1000000000000
					else if restor>1000000000 then
						restor:= restor - 1000000000
					else if restor>1000000 then
						restor:= restor - 1000000
					else if restor>1000 then
						restor:= restor - 100
					else restor:= restor -1;
				until (restor<1) or (restor=0);
			restor:= restor*b;
		end
		else restor:= a;
		modrr:=restor;
	end;
procedure coincidencia(a: string; b: string; i: integer; var v: boolean);
	var
		i1,pls,cd: integer;
	begin
		pls:=16;
		v:=false;
		cd:=0;
		if i=1 then begin
			for i1:=i to pls do
				if a[i1]=b[i1] then
					cd:= cd + 1;
		end
		else for i1:= ((i-1)*pls +1) to (i*pls) do begin
			if a[(i1-(i-1)*pls)]=b[i1] then
				cd:= cd + 1;
		end;
		if cd=16 then
				v:=true;
	end;
procedure verlocalidad(a: string; var b: string; var c: real);
	var
		i,ind: integer;
		pls: real;
		v,v2: boolean;
	begin
		i:=0;
		v:=false;
		v2:= false;
		if b[1]=' ' then begin
			b:= a;
			c:= 1;
		end
		else begin
			repeat
				pls:=0.01;
				i:=i +1;
				coincidencia(a,b,i,v);
				for ind:=1 to i do
					pls:= pls*100;
				if v then
					c:= c + pls
				else if (c/(pls*100))<1 then begin
					b:= b + a;
					c:= c + pls*100;
					v2:= true;
				end;
			until (i=16) or v or v2;
		end;
	end;
procedure acortar(var a:string);
	var
	d1,d2: char;
	cant,i: integer;
	aux1: string;
	begin
		aux1:=a;
		cant:=1;
		a:=' ';
		d1:=aux1[cant];
		d2:=aux1[cant+1];
		while ((d1<>' ') or (d2<>' ')) and (cant<17) do begin
			cant:= cant +1;
			d1:=aux1[cant];
			d2:=aux1[cant+1];
		end;
		for i:= 1 to (cant -1) do
			a:= a + ' ';
		for i:= 1 to cant do
			a[i]:=aux1[i];
	end;
procedure decodificar(a: string; c: real);
	var
		i,i2,i3,fijo: integer;
		localidad: string[16];
		x2,x1,x,lugar: real;
	begin
		lugar:=100;
		fijo:=16;
		i2:=0;
		repeat
			i2:=i2+1;
			i3:=0;
			localidad:='                ';
			for i:=(i2*fijo-15) to (fijo*i2) do begin
				i3:= i3 +1;
				localidad[i3]:=a[i];
				end;
			acortar(localidad);
			x1:= modrr(c,lugar);
			if i2=1 then begin
				x:= x1;
				x2:= x1;
			end
			else begin
				x:= (x1-x2)/(lugar/100);
				x2:= x1;
			end;
			writeln('Se ingresaron ',x:1:0,' inmuebles de ',localidad);
			lugar:= lugar * 100;
		until (c/(lugar/100)<1) or (i2=8);;
	end;

procedure completar(var loca:string);
	var
	i,c: integer;
	palabra: string;
	begin
		palabra:=loca;
		c:= length(palabra);
		c:= 16 - c;
		palabra:='';
		for i:=1 to c do
			palabra:= palabra + ' ';
		loca:= loca + palabra;
	end;
var
localidades: string;
cantidades: real;
inmverano: integer;
inme: inmueble;
begin
	localidades[1]:=' ';
	cantidades:= 0;
	inmverano:= 0;
	creditos();
	writeln('Cargue los datos solicitados a continuacion');
	leer(inme);
	while (inme.luga<>'XXX') and (length(localidades)<128) do begin
		completar(inme.luga);
		verlocalidad(inme.luga,localidades,cantidades);
		if fpubesverano(inme.fpub) then
			inmverano:= inmverano + 1;
		leer(inme);
	end;
	decodificar(localidades,cantidades);
	writeln('La cantidad de inmuebles publicados en el verano 2021 es: ',inmverano);
	readln();
end.
