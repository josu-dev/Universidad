{Practica 0

1. Implemente un programa que lea por teclado dos números enteros e imprima en pantalla los
valores leídos en orden inverso. Por ejemplo, si se ingresan los números 4 y 8, debe mostrar el
mensaje: Se ingresaron los valores 8 y 4

program ejer_1;

var
num1,num2: integer;

begin
	writeln('Escriba 2 numeros enteros a continuacíon:');
	readln(num1);
	readln(num2);
	writeln('Se ingresaron los valores ',num2,' y ',num1);
	readln();
end.
 


2. Modifique el programa anterior para que el mensaje de salida muestre la suma de ambos
números:
a. Utilizando una variable adicional
b. Sin utilizar una variable adicional

program ejer_2a;

var
num1,num2,resultado: integer;

begin
	writeln('Escriba 2 numeros enteros a continuacíon:');
	readln(num1);
	readln(num2);
	resultado:= num1+num2;
	writeln('La suma de sus valores es: ',resultado);
	readln();
end.

program ejer_2b;

var
num1,num2: integer;

begin
	writeln('Escriba 2 numeros enteros a continuacíon:');
	readln(num1);
	readln(num2);
	writeln('La suma de sus valores es: ',(num1+num2));
	readln();
end.



3. Implemente un programa que lea dos números reales e imprima el resultado de la división de
los mismos con una precisión de dos decimales. Por ejemplo, si se ingresan los valores 4,5 y 7,2,
debe imprimir: El resultado de dividir 4,5 por 7,2 es 0,62

Recuerde que para imprimir en pantalla números reales puede utilizar la notación:
writeln(X:Y:Z) donde X es el número a imprimir, Y es el ancho (en cantidad de caracteres) que
debe ocupar la impresión, y Z es la cantidad de decimales. Por ejemplo, sea el número
pi=3.141592654 :
3.14 => writeln(pi,1,2);
3.14 => writeln(pi,8,2); (hay 4 espacios delante del 3, para completar 8 caracteres de ancho)
3,1415 => writeln(pi,1,4);

program ejer_3;

var
num1,num2,resultado: real;

begin
	writeln('Ingrese 2 numeros reales a continuacion:');
	readln(num1);
	readln(num2);
	resultado:= num1/num2;
	writeln('El resultado de dividir ',num1:4:2,' por ',num2:4:2,' es ',resultado:4:2);
	readln();
end.


4. Implemente un programa que lea el diámetro D de un círculo e imprima:
	a. El radio (R) del círculo (la mitad del diámetro)
	b. El área del círculo. Para calcular el área de un círculo debe utilizar la fórmula PI x R
2
	c. El perímetro del círculo. Para calcular el perímetro del círculo debe utilizar la fórmula
D*PI (o también PI*R*2)

program ejer_4;

var
dia, rad, area, per: real;

begin
	writeln('Ingrese el diametro de su circulo para saber el radio, area y su perimetro');
	readln(dia);
	rad:= dia/2;
	writeln('Su radio es: ', rad:6:2);
	area:= pi*rad*rad;
	writeln('Su area es: ',area:8:2);
	per:= pi*rad*2;
	writeln('Su perimetro es: ',per:6:2);
	readln();
end.



5. Un kiosquero debe vender una cantidad X de caramelos entre Y clientes, dividiendo
cantidades iguales entre todos los clientes. Los que le sobren se los quedará para él.
	a. Realice un programa que lea la cantidad de caramelos que posee el kiosquero (X),
la cantidad de clientes (Y), e imprima en pantalla un mensaje informando la
cantidad de caramelos que le corresponderá a cada cliente, y la cantidad de
caramelos que se quedará para sí mismo.
	b. Imprima en pantalla el dinero que deberá cobrar el kiosquero si cada caramelo
tiene un valor de $1.60,

program ejer_5;

var
caramelos,clientes: integer;

begin
	writeln('Ingrese los caramelos que tiene:');
	readln(caramelos);
	writeln('Ingrese los clientes que tiene:');
	readln(clientes);
	writeln('A cada cliente le corresponden: ',caramelos div clientes,' caramelos');
	writeln('Te sobran: ', caramelos mod clientes,' caramelos');
	writeln('Y debe cobrar $', (caramelos div clientes)*clientes*1.6:6:2);
	readln();
end.



6. Realice un programa que informe el valor total en pesos de una transacción en dólares.
Para ello, el programa debe leer el monto total en dólares de la transacción, el valor del
1 dólar al día de la fecha y el porcentaje (en pesos) de la comisión que cobra el banco por la
transacción. Por ejemplo, si la transacción se realiza por 10 dólares, el dólar tiene un valor
20,54 pesos y el banco cobra un 4% de comisión, entonces el programa deberá informar:
La transacción será de 213,61 pesos argentinos
(resultado de multiplicar 10*20,54 y adicionarle el 4%)
}
program ejer_6;

var
transaccion, vpeso, comision: real;

begin
	writeln('Ingrese el monto de la transaccion en dolares');
	readln(transaccion);
	writeln('Ingrese el valor de 1 dolar en pesos');
	readln(vpeso);
	writeln('Ingrese el porcentaje de comision sin el %');
	readln(comision);
	comision:= 1+comision*0.01;
	writeln('La transaccion sera de ',transaccion*vpeso*comision:10:2);
	readln();
end.
