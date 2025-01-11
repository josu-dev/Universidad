# Historias de usuario

## Plantilla

### n

- id: _verbo_ _sustantivo_
- titulo: **Como** _rol_ **quiero** _algo_ **para poder** _beneficio_
- reglas:
  - 1
  - 2
  - 3
  - 4

### dorso (criterios)

- _titulo_
- **Dado** _un contexto inicial_
- **Cuando** _ocurre un evento_
- **Entonces** _garantiza uno o mas resultados_

- _titulo_
- **Dado** _un contexto inicial_
- **Cuando** _ocurre un evento_
- **Entonces** _garantiza uno o mas resultados_

- _titulo_
- **Dado** _un contexto inicial_
- **Cuando** _ocurre un evento_
- **Entonces** _garantiza uno o mas resultados_


## Ejercicio 1

Problema 1: Alquiler de mobiliario

Suponga que trabaja en una consultora la cual ha sido recientemente contactada por una empresa de alquiler de mobiliario para eventos para la realización de una app.
De las diferentes entrevistas se ha obtenido la siguiente información:
El gerente nos dijo que resulta fundamental tener una aplicación móvil que nos permita manejar la agenda de la empresa, sabiendo qué disponibilidad tenemos y permitiendo que nuestros clientes alquilen a través de la app. Para esta primera versión de la app, el **gerente** nos pidió que _sea posible dar de alta los diferentes mobiliarios, así como la posibilidad de que los usuarios puedan realizar una reserva de alquiler desde sus dispositivos_. Para el detalle de cómo se realiza la carga de los muebles, el gerente nos sugirió hablar con el encargado del departamento de mobiliario. El **encargado** de mobiliario nos comentó que de cada mueble se debe cargar código de inventario, tipo de mueble, fecha de creación, fecha de último mantenimiento, estado (libre, de baja, alquilado) y el precio de alquiler. Además, no pueden existir códigos repetidos y por el contrato de la franquicia, el precio debe cargarse en dólares. Para que el encargado pueda dar de alta el mobiliario debe _autenticarse en el sistema_. El registro de los usuarios de carga no debe modelarse.
El encargado del departamento de alquileres no comentó acerca de las reservas de los alquileres. Por una política comercial de la marca una reserva tiene que incluir como mínimo 3 muebles. La reserva debe tener una fecha, lugar del evento, cantidad de días y mobiliario junto a su cantidad. Para realizar una reserva se debe abonar el 20% del total del alquiler. El pago de la reserva se realiza únicamente con tarjeta de crédito validando número de tarjeta y fondos a través de un servicio del banco. Luego de efectuado el pago, se emite un número de reserva único que será luego utilizado por el
cliente para hacer efectivo el alquiler

### 1 - escenario 1

- id: alta mobiliario
- titulo: **Como** encargado **quiero** dar de alta muebles **para poder** alquilarlos
- reglas:
  - no pueden existir códigos repetidos
  - debe autenticarse en el sistema

### 1 - escenario 1 - criterios

- alta exitosa
- **Dado** que el encargado esta autorizado, y los datos del inmueble se cargaron con un codigo no registrado
- **Cuando** se carga la informacion
- **Entonces** se da de alta el nuevo inmueble

- alta fallida por autorizacion
- **Dado** que el encargado no esta autorizado, y los datos son igual que arriva
- **Cuando** se carga la informacion
- **Entonces** no se da de alta el nuevo inmueble

- alta fallida por inmueble existente
- **Dado** igual que el primero pero con codigo ya registrado
- **Cuando** se carga la informacion
- **Entonces** no se da de alta ya que el inmueble ya fue registrado


### 1 - escenario 2

- id: autenticar persona
- titulo: **Como** persona **quiero** autenticarme **para poder** usar el sistema
- reglas:

### 1 - escenario 2 - criterios

- autenticacion exitosa
- **Dado** usuario Pedro, contraseña *******
- **Cuando** el usuario y contraseña son validos
- **Entonces** se autoriza el uso de la aplicacion con los permisos referentes a la cuenta

- autenticacion fallida
- **Dado** usuario Pedrito, contraseña *********
- **Cuando** el usuario y/o contraseña son invalidos
- **Entonces** no se autoriza el uso de la aplicacion


### 1 - hu 3

- id: validar tarjeta
- titulo: **Como** persona **quiero** validar mi tarjeta **para poder** realizar un pago
- reglas:

### 1 - hu 3 - escenarios

- validacion exitosa
- **Dado** numero 3232 3233 2323, con fondos suficientes
- **Cuando** se le envian los datos al servicio del banco
- **Entonces** el banco devuelve que es una cuenta valida

- autenticacion fallida por numero
- **Dado** numero 3232 3232 1111, con fondos suficientes
- **Cuando** se le envian los datos al servicio del banco
- **Entonces** el banco devuelve que es una cuenta invalida ya que no existe cuenta con tal numero

- autenticacion fallida por fondos
- **Dado** numero 3232 3232 1111, con fondos insuficientes
- **Cuando** se le envian los datos al servicio del banco
- **Entonces** el banco devuelve que es una cuenta invalida ya que no posee los fondos suficientes


### 1 - hu 4

- id: reservar inmueble
- titulo: **Como** usuario **quiero** reservar un inmueble **para poder** usarlo
- reglas:
  - incluir como mínimo 3 muebles
  - únicamente con tarjeta de crédito
  - abonar 20% del pago

### 1 - hu 4 - criterios

- reserva exitosa
- **Dado** un usuario con medio de pago valido
- **Cuando** reserva
- **Entonces** se autoriza el uso de la aplicacion con los permisos referentes a la cuenta

- autenticacion fallida
- **Dado** usuario Pedrito, contraseña *********
- **Cuando** el usuario y/o contraseña son invalidos
- **Entonces** no se autoriza el uso de la aplicacion


---


## Ejercicio 4

**Enunciado**: Se desea modelar un sistema para el manejo de venta de bebidas alcohólicas en linea. Para poder empezar a comprar en el sitio, es necesario que las **personas** se _registren_ ingresando nombre, apellido, mail (será utilizado como nombre de usuario por lo tanto debe ser único) y edad. Solo se permite que se registren al sitio personas mayores a 18 años, de lo contrario el sistema debe mostrar en pantalla el texto de la ley que impide la venta de bebidas alcohólicas a menores. Si el registro es exitoso el sistema genera una contraseña que es enviada al mail ingresado en el registro.

Para _comprar_ el **usuario** debe _iniciar sesión_ y una vez logueado el sistema muestra una lista de bebidas, una vez que el usuario selecciona todos los productos que desea comprar, si el usuario es premium se le hace un descuento del 20% y se informa en pantalla el total menos el 20%. Ademas si el usuario seleccionó productos por un monto superior a los $4500 se le hace un 10% de descuento y se informa en pantalla el total menos el 10%. Tenga en cuenta que si el usuario es premium y compra por un monto superior a $4500 se deben aplicar ambos descuentos.

### hu 1

- id: registrar usuario
- titulo: **Como** persona **quiero** registrarme en el sistema **para poder** usarlo
- reglas:
  - mail unico
  - mayor de 18 años

#### escenarios

- registro exitoso
- **Dado** nombre pedro, apellido sanchez, mail perdo, edad 18
- **Cuando** se intenta registrar
- **Entonces** se le envia al mail la contraseña generada

- registro fallido por edad
- **Dado** nombre juan, apellido sanchez, mail shancez, edad 12
- **Cuando** se intenta registrar
- **Entonces** se muestra en pantalla el texto de la ley que impide la venta de bebidas alcoholicas a menores y no se efectua el registro

- registro fallido por mail repetido
- **Dado** nombre juana, apellido sanchez, mail shancez, edad 90
- **Cuando** se intenta registrar
- **Entonces** no se efectua el registro ya que el mail ya fue utlizado

### hu 2

- id: iniciar sesion
- titulo: **Como** persona **quiero** iniciar sesion **para poder** ingresar al sistema
- reglas:

#### escenarios

- inicio exitoso
- **Dado** mail pedro@ contraseña ******
- **Cuando** se ingresan los datos y son validados correctamente
- **Entonces** se le otorga acceso al sistema y se le muestra una lista de bebidas

- inicio fallido no registrado
- **Dado** mail juan@ contraseña ******
- **Cuando** se ingresan los datos y se valida que el correo no fue registrado
- **Entonces** se le deniega el acceso al sistema e informa que no fue registrado

- inicio fallido contraseña no valida
- **Dado** mail juanes@ contraseña *******
- **Cuando** se ingresan los datos y se valida que la contraseña no corresponde al mail
- **Entonces** se le deniega el acceso al sistema e informa que la contraseña no corresponde

### hu 3

- id: cerrar sesion
- titulo: **Como** usuario **quiero** cerrar sesion **para poder** salir del sistema
- reglas:

#### escenarios

- cerrado exitoso
- **Dado** un usuario logueado
- **Cuando** solicita salir de el sistema
- **Entonces** se le cerrara la sesion

### hu 4

- id: realizar compra
- titulo: **Como** usuario **quiero** comprar bebida/s **para poder** poseerlas
- reglas:
  - es premium se le hace un descuento del 20%
  - seleccionó productos por un monto superior a los $4500 se le hace un 10% de descuento


#### escenarios

-
  - compra exitosa
  - **Dado** un usuario logueado que es premium y selecciono $ 10000 en bebidas
  - **Cuando** termino de seleccionar
  - **Entonces** se le informa 7000 de total

-
  - compra exitosa
  - **Dado** un usuario logueado que es premium y selecciono $ 2000 en bebidas
  - **Cuando** termino de seleccionar
  - **Entonces** se le informa 1600 de total

-
  - compra exitosa
  - **Dado** un usuario logueado que no es premium y selecciono $ 10000 en bebidas
  - **Cuando** termino de seleccionar
  - **Entonces** se le informa 9000 de total

-
  - compra exitosa
  - **Dado** un usuario logueado que no es premium y selecciono $ 2000 en bebidas
  - **Cuando** termino de seleccionar
  - **Entonces** se le informa $ 2000 de total

-
  - compra fallida
  - **Dado** un usuario logueado que no es premium y selecciono $ 2000 en bebidas
  - **Cuando** termino de seleccionar y no hay stock
  - **Entonces** se le informa que no se puede efectuar la compra


---


## Ejercicio 8

**Enunciado**: Se desea modelar un sistema de gestión de ventas de entradas para un teatro. Las personas compran sus entradas a través de una página web, o personalmente.

El sistema permite, sólo de modo personal en el teatro, la reserva de entradas de forma gratuita. El empleado debe ingresar los datos de la obra (fecha, hora, y nombre) junto el nombre y DNI del espectador. En este caso, sólo se podrá reservar hasta 2 entradas. Las entradas reservadas no compradas caducarán tres horas antes del evento. Para seleccionar el nombre de la obra, el sistema muestra una grilla de funciones disponibles para que el usuario seleccione una.

Para comprar una entrada vía web, el sistema muestra la grilla de funciones disponibles.

El usuario selecciona una opción, ingresa su DNI, la cantidad de lugares solicitados y selecciona la opción “pagar”. El pago se realiza con tarjeta de crédito. Para esto debe ser autorizada a través del sistema del banco. Este pide el número de tarjeta, vencimiento, y código de seguridad. Verifica todos los campos y autoriza la compra. Autorizada la tarjeta, se emite un código de compra con el que el cliente podrá retirar sus entradas en la boletería del cine.

Para comprar una entrada personalmente, el vendedor de la boletería solicita los datos de la función al cliente, procediendo de un modo similar a la compra web, con la diferencia que en este caso no se muestra el código de compra sino que se imprimen directamente la/s entrada/s. El pago es unicamente con tarjeta de crédito, igual que en el caso
anterior.

Para retirar las entradas reservadas previamente, el empleado solicita nombre y DNI del espectador, el sistema valida que la persona posea entradas reservadas, y que no estén caducas. El resto del procedimiento se realiza igual que la compra de entradas descriptas anteriormente.

Cuando una persona llega con el código de compra, el vendedor debe ingresar el código para que el sistema, luego de verificarlo, imprima las entradas correspondientes.

Además se desea administrar la programación de las salas. El administrador ingresa la distribución semanal de las obras en las salas de manera que se encuentre disponible para la realización de la venta de entradas.

### hu 1

- id: reservar entrada
- titulo: **Como** empleado **quiero** efectuar reservas **para poder** dar reservas a clientes
- reglas:
  - 2 entradas maximo


#### escenarios

-
  - reserva exitosa
  - **Dado** los datos de una obra con funciones disponibles, nombre pedro dni 43100122, cantidad 2
  - **Cuando** el empleado ingresa los datos
  - **Entonces** se le muestra al usuario las grilla de funciones asi confirma la que quiere

-
  - reserva fallida por cantidad
  - **Dado** los datos de una obra con funciones disponibles, nombre pedro dni 43100122, cantidad 3
  - **Cuando** el empleado ingresa los datos
  - **Entonces** el sistema le informa que el maximo de entradas es 2 y no se efectua la reserva

### hu 2

- id: autenticar tarjeta
- titulo: **Como** usuario **quiero** autenticar mi tarjeta **para poder** realizar un pago
- reglas:


#### escenarios

-
  - autenticacion exitos
  - **Dado** numero de tarjeta 787238239293782 vencimiento 22/2/2030 codigo 3233
  - **Cuando** se ingresan los datos y el sistema del banco los valida
  - **Entonces** la tarjeta puede realizar la transaccion

-
  - autenticacion exitos
  - **Dado** numero de tarjeta 787238232323232 vencimiento 22/2/2020 codigo 1111
  - **Cuando** se ingresan los datos y el sistema del banco no los puede validar
  - **Entonces** la tarjeta no puede realizar transacciones


### hu 3

- id: comprar web
- titulo: **Como** persona **quiero** comprar entrada/s **para poder** asistir al teatro
- reglas:
  - 2 entradas maximo


#### escenarios

-
  - compra exitosa
  - **Dado** dni 43100122 cantidad 3 tarjeta de credito valida
  - **Cuando** el usuario selecciona una opcion de la grilla, carga sus datos y de la tarjeta
  - **Entonces** se emite el codigo de compra para retirar las entradas en la boleteria

-
  - compra fallida
  - **Dado** dni 43100122 cantidad 3 tarjeta de credito valida
  - **Cuando** el usuario selecciona una opcion de la grilla, carga sus datos y de la tarjeta
  - **Entonces** se emite el codigo de compra para retirar las entradas en la boleteria

