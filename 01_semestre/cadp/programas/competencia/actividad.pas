program actividad;


uses
	CADPDataLoader;


const 
	ARCHIVO = 'DatosGrupo';  { Nombre del archivo con la informacion de los empleados }


{ MÓDULOS }

{ Recibe una variable entera y le suma 1 } 
procedure incrementar1(var variable:integer);
begin
	variable := variable + 1;
end;


{ Recibe como argumento un número entero y devuelve True en caso de ser par, o False en caso de no serlo }
function esPar(numero: Integer): Boolean;
begin
	esPar := (numero MOD 2) = 0;
end;


{ Recibe como argumento un número entero y devuele True si todos sus dígitos son pares o impares, o False en caso de que encuentre un dígito que sea diferente }
function sonTodosParesOImpares(numero: Integer): Boolean;
var 
	digito: Integer;
	esPrimerDigPar: Boolean;
begin
	digito := numero MOD 10;
	esPrimerDigPar := esPar(digito);	
	repeat
		numero := numero DIV 10;
		digito := numero MOD 10;
	until (esPar(digito) <> esPrimerDigPar) or (numero = 0);
	{ Si se llega a descomponer todo el número quiere decir que todos los numeros son pares o impares }
	sonTodosParesOImpares := numero = 0;
end;


{ Compara los valores ingresados con los maximos existentes y, en caso de superarlos, los actualiza }
procedure calcularMayor (numero, dato: integer; var max,maxDato: integer);
begin
	if numero > max then 
		begin
			max:= numero;
			maxDato:= dato;
		end;
end;


{ Recibe un número entero y un dígito y devuelve la cantidad de veces que aparece el dígito en el numero }
procedure cantDig(dato,numero: integer; var cant: integer);
var
	dig: integer;
begin
	while dato <> 0 do 
		begin
			dig:= dato mod 10;
			if dig = numero then  { si el dígito es igual al numero buscado sumara 1 a la variable cant }
				incrementar1(cant);
			dato:= dato div 10;
		end;
end;


{ Lee todos los empleados, calcula y devuelve el legajo del empleado con mayor salario }
function legMaxSalario(): integer;
var
	fin: boolean; 
	empleado: TDatos;
	max,maxLeg: integer;
begin
	max:= -9999;
	maxLeg:= 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		calcularMayor(empleado.salario,empleado.legajo,max,maxLeg);
	until fin;
	CADPfinalizarLectura();
	legMaxSalario:= maxLeg;
end;


{ Recibe un numero entero y una string, verifica si es el mas minimo o el segundo mas minimo, en caso de que sea actuliza el correspondiente }
procedure calcularMenores(numero: integer; dato: string; var min1,min2: integer; var minDato1,minDato2: string);
begin
	if numero < min1 then 
		begin
			min2:=min1;
			min1:= numero;
			minDato2:= minDato1;
			minDato1:= dato;
		end
	else
		if numero < min2 then 
			begin
				min2:= numero;
				minDato2:= dato;
			end;
end;


{ Lee los empleados del archivo que los contiene e imprime la cantidad total empleados }
procedure totalEmpleados();
var
	fin: boolean;
	empleado: Tdatos;
	cantTotalEmpleados: Integer;
begin
	cantTotalEmpleados := 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		incrementar1(cantTotalEmpleados);
	until fin;
	CADPfinalizarLectura();
	WriteLn('El total de empleados en la empresa es ', cantTotalEmpleados);
end;


{ Lee todos los empleados del archivo y muestra la cantidad cuyo salario es menor a 300 }
procedure cantSalariosMenor300();
var
	fin : boolean;
	empleado : Tdatos;
	salariosMenor300 : integer;
begin
	salariosMenor300:= 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		if empleado.salario < 300 then
			incrementar1(salariosMenor300);
	until fin;
	CADPfinalizarLectura();
	WriteLn('La cantidad de empleados con salarios menores a 300 dolares es ', salariosMenor300);
end;


{ Lee los empleados de un archivo y calcula el salario promedio }
procedure promedioSalarios();
var
	fin: Boolean;
	empleado: Tdatos;
	cantTotalEmpleados: Integer;
	totalSalarios: Real;
begin
	cantTotalEmpleados := 0;
	totalSalarios := 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		incrementar1(cantTotalEmpleados);
		totalSalarios:= totalSalarios + empleado.salario;
	until(fin);
	CADPfinalizarLectura();
	WriteLn('El promedio de salario de los empleados es de ', (totalSalarios/cantTotalEmpleados):0:2, ' dolares.');
end;


{ Calcula la cantidad de unos en el legajo del empleado con mayor salario }
procedure cant1enMayorSalario ();
var
	cant1: integer; 
begin
	cant1:= 0;
	cantDig(legMaxSalario(), 1, cant1);
	WriteLn('La cantidad de veces que aparece el digito 1 en el legajo del empleado con mayor salario es: ', cant1);
end;


{ Lee los empleados del archivo donde esta la informacion para encontrar el dni del empleado con menor salario }
procedure empleadoMenorSalario();
var
	fin: boolean;
	empleado: Tdatos;
	salMin1,salMin2: integer;
	dniSalMin1,dniSalMin2: string;
begin
	salMin1:= 9999;
	dniSalMin1:= ' ';
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		calcularMenores(empleado.salario,empleado.dni,salMin1,salMin2,dniSalMin1,dniSalMin2);
	until fin;
	CADPfinalizarLectura();
	WriteLn('Los dos DNI de los empleados con menor salario son: ',dniSalMin1,' y ',dniSalMin2);
end;


{ Lee todos los empleados e imprime la cantidad total de legajos con todos números pares o impares }
procedure cantLegSoloParesImpares();
var
	fin: Boolean;
	empleado: TDatos;
	total: Integer;
begin
	total := 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
	  CADPleerDato(empleado, fin);
	  if sonTodosParesOImpares(empleado.legajo) then
			incrementar1(total);
	until fin;
	CADPfinalizarLectura();
	WriteLn('La cantidad de legajos con todos numeros pares o impares es de: ', total);
end;


{ Lee todos los empleados e imprime el porcentaje de empleados con  más de 50 años y que cobran menos de 600 dólares }
procedure porc50menos600sal();
var 
	fin: Boolean;
	empleado: TDatos;
	cantEmpleados, cantCondicion: Integer;
begin
	cantEmpleados := 0; cantCondicion := 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado, fin);
		incrementar1(cantEmpleados);
		if (empleado.edad > 50) and (empleado.salario < 600) then 
			incrementar1(cantCondicion);
	until fin;
	CADPfinalizarLectura();
	WriteLn('Un ', ((cantCondicion * 100)/cantEmpleados):0:2, '% de los empleados tiene mas de 50 annos y cobran menos de 600 dolares');
end;


{ Lee todos los empleados, cuenta y devuelve la cantidad total de ceros que hay en cada legajo }
procedure cantDig0Legajos();
var
	fin: boolean;
	empleado: Tdatos;
	canTotal: integer;
begin
	canTotal:= 0;
	CADPVolverAlInicio(ARCHIVO);
	repeat
		CADPleerDato(empleado,fin);
		cantDig(empleado.legajo,0,canTotal);
	until fin;
	CADPfinalizarLectura();
	WriteLn('La cantidad de veces que aparece el digito 0 entre todos los legajos es de: ', canTotal);
end;


{ Evalua cuantas veces un empleado tiene un salario que supera por mas del doble al empleado que lo
antecede en la lista }
procedure cantSalDobleAnterior();
var
	fin: Boolean;
	empleado: Tdatos;
	salAnt,cantSalDobleAnt: Integer;
begin
	cantSalDobleAnt := 0;
	CADPVolverAlInicio(ARCHIVO);
	CADPleerDato(empleado,fin);
	salAnt := empleado.salario;
	repeat
		CADPleerDato(empleado,fin);
		if empleado.salario > (salAnt * 2) then
			incrementar1(cantSalDobleAnt);
		salAnt := empleado.salario;
	until fin;
	CADPfinalizarLectura();
	writeln('La cantidad de veces que un empleado de la lista cobra mas que el empleado anterior es: ', cantSalDobleAnt);
end;


{ Imprime las opciones que dispone el usuario y lee la que elija }
procedure eleccion(var opcion: char);
begin
	WriteLn();
	WriteLn();
	WriteLn('Escriba el numero correspondiente para calcular lo que necesita');
	WriteLn('  1. Cantidad total de empleados');
	WriteLn('  2. Cantidad de empleados cuyo salario es menor a 300 dolares');
	WriteLn('  3. Salario promedio de los empleados');
	WriteLn('  4. Cantidad de veces que aparece el digito 1 en el legajo del empleado con mayor salario');
	WriteLn('  5. DNI de los dos empleados con menor salario');
	WriteLn('  6. Cantidad de empleados cuyos legajos posee todos digitos pares o todos digitos impares');
	WriteLn('  7. Porcentaje de empleados de mas de 50 annos y que cobran menos de 600 dolares');
	WriteLn('  8. Cantidad de veces que aparece el digito 0 entre todos los legajos.');
	WriteLn('  9. Cantidad de veces en las que un empleado cobra mas del doble del empleado anterior del listado');
	WriteLn('  0. Salir del programa'); 
	Write('Opcion: '); ReadLn(opcion);
  WriteLn();
end;


{ PROGRAMA PRINCIPAL }

var
	opcion: char;
begin
	WriteLn('PIE v1.0, Procesamiento de Informacion de Empleados v1.0');
	eleccion(opcion);
	while opcion <> '0' do begin
		case opcion of
			'1': totalEmpleados();
			'2': cantSalariosMenor300();
			'3': promedioSalarios();
			'4': cant1enMayorSalario();
			'5': empleadoMenorSalario();
			'6': cantLegSoloParesImpares();
			'7': porc50menos600sal();
			'8': cantDig0Legajos();
			'9': cantSalDobleAnterior();
			else WriteLn('Opcion ingresada invalida, intentelo nuevamente');
		end;
		eleccion(opcion);
	end;
	WriteLn('Presione enter para salir');
	ReadLn();
end.
