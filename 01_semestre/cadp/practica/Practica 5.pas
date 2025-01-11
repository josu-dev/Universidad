{Practica 5
PARTE CONCEPTUAL
	1) ¿Qué se define como memoria estática?
	2) ¿Qué se define como memoria dinámica?
	3) ¿Qué es una variable de tipo puntero?
	4) ¿Qué hace la operación “NEW” aplicada en una variable del tipo puntero?
	5) ¿Qué hace la operación “DISPOSE” aplicada en una variable del tipo puntero?
	 
	1) Memoria estatica es la memoria que se reserva para almacenar datos del programa que no puede ser alterable en termino de cantidad.
	2) Memoria dinamica es la memoria que el programa puede solicitar usar a medida que necesita almacenar informacion
	3) El tipo puntero es una variable que permite crea una referencia en la memoria estatica a una seccion de almacenamiento en la memoria dinamica
	4) La operacion new genera un espacio en memoria dinamica el cual el puntero referencia
	5) La operacion dispose elimina un espacio en memoria dinamica el cual el puntero hacia referencia

PARTE PRÁCTICA
	Para algunos ejercicios de la parte práctica, se utilizará la función de Pascal “sizeof”, que recibe como
	parámetro una variable de cualquier tipo y retorna la cantidad de bytes que dicha variable ocupa en la
	memoria principal. Para realizar estos ejercicios, considerar la siguiente tabla, que indica la cantidad de bytes
	que ocupa la representación interna de distintos tipos de datos en un compilador de Pascal típico. Se
	recomienda graficar cada una de las situaciones planteadas a partir de una prueba de escritorio.

		TIPO 		CANTIDAD DE BYTES
		Entero 		2 bytes
		Real 		4 bytes
		Char 		1 byte
		String 		Tantos bytes como indique la longitud del String + 1
		Record 		La suma de las longitudes de los campos del registro
		Puntero 	4 bytes
		Boolean 	1 byte

1) Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de
escritorio.
	program punteros;
	type
		cadena = string[50];
		puntero_cadena = ^cadena;
	var
		pc: puntero_cadena;
	begin
		writeln(sizeof(pc), ' bytes');
		new(pc);
		writeln(sizeof(pc), ' bytes');
		pc^:= 'un nuevo nombre';
		writeln(sizeof(pc), ' bytes');
		writeln(sizeof(pc^), ' bytes');
		pc^:= 'otro nuevo nombre distinto al anterior';
		writeln(sizeof(pc^), ' bytes');
	end.

1) Imprime: 4,4,4,51,51



2) Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de
escritorio.
	program punteros;
	type
		cadena = string[9];
		producto = record
			codigo: integer;
			descripcion: cadena;
			precio: real;
		end;
		puntero_producto = ^producto;
	var
		p: puntero_producto;
		prod: producto;
	begin
		writeln(sizeof(p), ' bytes');
		writeln(sizeof(prod), ' bytes');
		new(p);
		writeln(sizeof(p), ' bytes');
		p^.codigo := 1;
		p^.descripcion := 'nuevo producto';
		writeln(sizeof(p^), ' bytes');
		p^.precio := 200;
		writeln(sizeof(p^), ' bytes');
		prod.codigo := 2;
		prod.descripcion := 'otro nuevo producto';
		writeln(sizeof(prod), ' bytes');
	end.

2) Imprime: 4,16,4,16,16,16



3) Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de
escritorio.
	program punteros;
	type
		numeros = array[1..10000] of integer;
		puntero_numeros = ^numeros;
	var
		n: puntero_numeros;
		num: numeros;
		i:integer;
	begin
		writeln(sizeof(n), ' bytes');
		writeln(sizeof(num), ' bytes');
		new(n);
		writeln(sizeof(n^), ' bytes');
		for i:= 1 to 5000 do
			n^[i]:= i;
		writeln(sizeof(n^), ' bytes');
	end.
	
3) Imprime: 4,20000,20000,20000



4) Indicar los valores que imprimen los siguientes programas en Pascal. Justificar mediante prueba de
escritorio.
	a) program punteros;
		type
			cadena = string[50];
			puntero_cadena = ^cadena;
		var
			pc: puntero_cadena;
		begin
			pc^:= 'un nuevo texto';
			new(pc);
			writeln(pc^);
		end.
	
	a) Imprime:  basura.
	
	
	b) program punteros;
		type
			cadena = string[50];
			puntero_cadena = ^cadena;
		var
			pc: puntero_cadena;
		begin
			new(pc);
			pc^:= 'un nuevo nombre';
			writeln(sizeof(pc^), ' bytes');
			writeln(pc^);
			dispose(pc);
			pc^:= 'otro nuevo nombre';
		end.
	
	b) Imprime: 51,un nuevo nombre.
	
	
	c) program punteros;
		type
			cadena = string[50];
			puntero_cadena = ^cadena;
		procedure cambiarTexto(pun: puntero_cadena);
			begin
				pun^:= 'Otro texto';
			end;
		var
			pc: puntero_cadena;
		begin
			new(pc);
			pc^:= 'Un texto';
			writeln(pc^);
			cambiarTexto(pc);
			writeln(pc^);
		end.
		
	c) Imprime: Un texto, Otro texto.
	
	
	d) program punteros;
		type
			cadena = string[50];
			puntero_cadena = ^cadena;
		procedure cambiarTexto(pun: puntero_cadena);
			begin
				new(pun);
				pun^:= 'Otro texto';
			end;
		var
			pc: puntero_cadena;
		begin
			new(pc);
			pc^:= 'Un texto';
			writeln(pc^);
			cambiarTexto(pc);
			writeln(pc^);
		end.

	d) Imprime: Un texto, Un texto.
	
	
	
5) De acuerdo a los valores de la tabla que indica la cantidad de bytes que ocupa la representación
	interna de cada tipo de dato en Pascal, calcular el tamaño de memoria en los puntos señalados a partir
	de(I), suponiendo que las variables del programa ya están declaradas y se cuenta con 400.000 bytes
	libres. Justificar mediante prueba de escritorio.
	
	Program Alocacion_Dinamica;
	Type
		TEmpleado = record
			sucursal: char;
			apellido: string[25];
			correoElectrónico: string[40];
			sueldo: real;
		end;
		Str50 = string[50];
	Var
		alguien: TEmpleado;
		PtrEmpleado: ^TEmpleado;
	Begin
		//Suponer que en este punto se cuenta con 400.000 bytes de memoria disponible (I)
		Readln( alguien.apellido );
		//Pensar si la lectura anterior ha hecho variar la cantidad de memoria (II)
		New( PtrEmpleado );
		//¿Cuánta memoria disponible hay ahora? (III)
		Readln( PtrEmpleado^.Sucursal, PtrEmpleado^.apellido );
		Readln( PtrEmpleado^.correoElectrónico, PtrEmpleado^.sueldo );
		//¿Cuánta memoria disponible hay ahora? (IV)
		Dispose( PtrEmpleado );
		//¿Cuánta memoria disponible hay ahora? (V)
	end.

	II) No hizo variar ya que es memoria estatica.
	III) Ahora hay disponible 400000 bytes - 72 bytes.
	IV) Ahora hay disponible 400000 bytes - 72 bytes.
	V) Ahora hay disponible 400000 bytes.


}
6) Se desea almacenar en memoria una secuencia de 2500 nombres de ciudades, cada nombre podrá
tener una longitud máxima de 50 caracteres.
	a) Definir una estructura de datos estática que permita guardar la información leída. Calcular el tamaño
	de memoria que requiere la estructura.
	b) Dado que un compilador de Pascal típico no permite manejar estructuras de datos estáticas que
	superen los 64 Kb, pensar en utilizar un vector de punteros a palabras, como se indica en la siguiente
	estructura:
			Type
				Nombre = String[50];
				Puntero = ^Nombre;
				ArrPunteros = array[1..2500] of Puntero;
			Var
				Punteros: ArrPunteros;
		b.1) Indicar cuál es el tamaño de la variable Punteros al comenzar el programa.
		b.2) Escribir un módulo que permita reservar memoria para los 2500 nombres. ¿Cuál es la cantidad de
		memoria reservada después de ejecutar el módulo? ¿La misma corresponde a memoria estática o
		dinámica?
		b.3) Escribir un módulo para leer los nombres y almacenarlos en la estructura de la variable Punteros.
	
a)
type
	ciudades= array[1..2500] of string[50];
var
	secuencia: ciudades;
	
	//El tamaño que se necesita es de 127500 bytes


b)1)
	10000 bytes.
	
	
b)2)
	procedure reservarMemPunteros(var Punteros: ArrPunteros);
	var
		i: integer;
	begin
		for i:=1 to 2500 do
			new(Punteros[i]);
	end;
	
	//La memoria reservada despues de ejecutar el modulo es de 127500 bytes
	//La misma corresponde a memoria dinamica


b)3)
	procedure cargarPunteros(Punteros: ArrPunteros);
	var
		i: integer;
	begin
		for i:=1 to 2500 do begin
			write('Nombre: '); readln(Punteros[i]^);
		end;	
	end;
