# Título
Visualizacion del listado de clientes para un empleado

## Narrativa
- **Como** Empleado con sesion iniciada
- **Quiero** ver el listado de lcientes registrados
- **Para** poder consultarlo y administrarlo

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver listado de clientes exitoso
  **Dado** un empleado en la pagina de administración y que hay al menos un cliente registrado
  **Cuando** selecciona clientes
  **Entonces** el sistema muestra el listado de clientes registrados al empleado y la funcionalidad de registrar uno nuevo

- **Escenario:** Ver listado de clientes exitoso vacio
  **Dado** un empleado en la pagina de administracion y que no hay ningun cliente registrado
  **Cuando** selecciona clientes
  **Entonces** el sistema informa que no hay clientes registrados y muestra la funcionalidad de registrar uno nuevo


------------------------------------------------------------------------------------------

# Título
Registro de un nuevo cliente por parte de un empleado

## Narrativa
- **Como** empleado con sesion iniciada
- **Quiero** registrar a un nuevo cliente
- **Para** que el mismo quede en el sistema y pueda utilizar su cuenta

## Reglas del negocio
- El mail no puede repetirse
- El DNI no puede repetirse
- Debe cargase con al menos un perro

## Criterios de aceptación
- **Escenario:** Registrar cliente fallido por mail ya registrado
  **Dado** un empleado en el listado de clientes, el mail cliente4.ohmydog19@gmail.com que se encuentra registrado
  **Cuando** selecciona nuevo cliente e ingresa el mail cliente4@ohmydog19@gmail.com, el dni 30000000, el nombre Juan, apellido Sánchez, teléfono 221-456-7890 y nacimiento 01/02/2003 y el perro a cargar con nombre Lola, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil y selecciona registrar cliente
  **Entonces** el sistema le informa al empleado que el mail ya se encuentra registrado

- **Escanario:** Registrar cliente fallido por mail ya registrado
  **Dado** un empleado en el listado de clientes, el dni 40000000 que ya se encuentra registrado
  **Cuando** selecciona nuevo cliente e ingresa el mail cliente5@ohmydog19@gmail.com, el dni 40000000, el nombre Juan, apellido Sánchez, teléfono 221-456-7890 y nacimiento 01/02/2003 y el perro a cargar con nombre Lola, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil y selecciona registrar cliente
  **Entonces** el sistema le informa al empleado que el mail ya se encuentra registrado

- **Escenario:** Registrar cliente exitoso
  **Dado** un empleado en el listado de clientes, el mail cliente5.ohmydog19@gmail.com que no se encuentra registrado, el dni 30000000 sin registrar, el nombre Juan, apellido Sánchez, teléfono 221-456-7890 y nacimiento 01/02/2003 y un perro a cargar con nombre Lola, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil
  **Cuando** selecciona nuevo cliente e ingresa el mail cliente5@ohmydog19@gmail.com, el dni 30000000, el nombre Juan, apellido Sánchez, teléfono 221-456-7890 y nacimiento 01/02/2003 y el perro a cargar con nombre Lola, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil y selecciona registrar cliente
  **Entonces** el sistema crea la cuenta del cliente, con una contraseña aleatoria, se registra el perro, envía un mail a cliente5.ohmydog19@gmail.com con la contraseña asignada, informa del exito de la operación al empleado y  lo redirecciona a la cuenta del cliente que acaba de registrar

- **Escenario:** Registrar cliente exitoso con mas de un perro
  **Dado** un empleado en el listado de clientes, el mail cliente6.ohmydog19@gmail.com que no se encuentra registrado, el dni 30000001 sin registrar, el nombre Pablo, apellido Mendivez, teléfono 221-456-2222 y nacimiento 01/01/2003 y dos perros a cargar, el primero con nombre Liza, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil, el segundo con nombre Lolo, raza Caniche, tamaño pequeño, sexo macho, fecha de nacimiento 01/02/2019 y foto de perfil
  **Cuando** selecciona nuevo cliente e ingresa el mail cliente6.ohmydog19@gmail.com, el dni 30000001, el nombre Pablo, apellido Mendivez, teléfono 221-456-2222 y nacimiento 01/01/2003 y los dos perros a cargar, el primero con nombre Liza, raza Caniche, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil, el segundo con nombre Lolo, raza Caniche, tamaño pequeño, sexo macho, fecha de nacimiento 01/02/2019 y foto de perfil y selecciona registrar cliente
  **Entonces** el sistema crea la cuenta del cliente, con una contraseña aleatoria, se registran los perros, envía un mail a cliente6.ohmydog19@gmail con la contraseña asignada, informa del exito de la operación al empleado y  lo redirecciona a la cuenta del cliente que acaba de registrar


------------------------------------------------------------------------------------------

# Título
Registrar perro de un cliente por parte de un empleado

## Narrativa
- **Como** empleado con sesión iniciada
- **Quiero** registrar a un perro
- **Para** que pueda figure en el sistema y pueda ser utilizado

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Registro de perro exitoso
  **Dado** un empleado en la cuenta de un cliente, los datos de un perro nombre Bombom, raza Bullterier, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil
  **Cuando** selecciona nuevo perro, ingresa nombre Bombom, raza Bullterier, tamaño pequeño, sexo hembra, fecha de nacimiento 01/02/2019 y foto de perfil y selecciona registrar
  **Entonces** el sistema registra el perro, le informa al empleado del éxito de la operación y lo redirecciona al perfil del perro

- **Escenario:** Registro de perro fallido por fecha inválida
  **Dado** un empleado en la cuenta de un cliente, los datos de un perro nombre Nesta, raza Golden Retriever, tamaño grande, sexo hembra, fecha de nacimiento 01/02/2024  (fecha mayor a hoy) y foto de perfil
  **Cuando** selecciona nuevo perro, ingresa nombre Nesta, raza Golden Retriever, tamaño grande, sexo hembra, fecha de nacimiento 01/02/2024 y foto de perfil y selecciona registrar
  **Entonces** el sistema no registra el perro y le informa al empleado que la fecha debe ser previa o igual a la de hoy


------------------------------------------------------------------------------------------

# Título
Modificar los datos de un cliente por parte de un empleado

## Narrativa
- **Como** empleado con sesion iniciada
- **Quiero** modificar los datos de un cliente
- **Para** que los mismos queden actualizados en el sistema

## Reglas del negocio
- DNI no puede repetirse

## Criterios de aceptación
- **Escenario:** Modificar cliente fallido por DNI ya registrado
  **Dado** un empleado en la cuenta del cliente con dni 30000001, el dni 30000000 que ya se encuentra registrado
  **Cuando** ingresa el dni 30000000, el nombre Emilio, apellido Capusoto, nacimiento 02/02/2003 y el telefono 221-444-7890 y selecciona actualizar
  **Entonces** el sistema le informa al empleado que el dni ya se encuentra registrado

- **Escenario:** Modificar cliente exitoso
  **Dado** un empleado en la cuenta del cliente con dni 30000001, el dni 30000002 sin registrar, el nombre Emilio, apellido Capusoto, nacimiento 02/02/2003 y el telefono 221-444-7890
  **Cuando** ingresa el dni 30000002, el nombre Emilio, apellido Capusoto, nacimiento 02/02/2003 y el telefono 221-444-7890 y selecciona actualizar
  **Entonces** el sistema actualiza los datos del cliente y le informa al empleado del éxito de la operación


------------------------------------------------------------------------------------------

# Título
Modificar el perfil de un perro por parte de un empleado

## Narrativa
- **Como** empleado con sesion iniciada
- **Quiero** modificar el perfil de un perro
- **Para** que los mismos queden actualizados en el sistema

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Modificar perro exitoso
  **Dado** un empleado en el perfil del perro Lolo, el nombre Travieso, nacimiento 01/05/2019, raza Caniche, tamaño pequeño, sexo hembra y foto de perfil
  **Cuando** ingresa el nombre Travieso, nacimiento 01/05/2019, raza Caniche, tamaño pequeño, sexo hembra y foto de perfil y selecciona actualizar
  **Entonces** el sistema actualiza los datos del perro y le informa al empleado del éxito de la operación y lo redirige al listado de perros

- **Escenario:** Modificar perro fallido por fecha inválida
  **Dado** un empleado en el perfil del perro Lolo, el nombre Travieso, nacimiento 01/01/2024 (fecha mayor a hoy), raza Caniche, tamaño pequeño, sexo hembra y foto de perfil
  **Cuando** ingresa el nombre Travieso, nacimiento 01/01/2024, raza Caniche, tamaño pequeño, sexo hembra y foto de perfil y selecciona actualizar
  **Entonces** el sistema informa que los datos no pueden actualizarse por fecha inválida


------------------------------------------------------------------------------------------

# Título
Inhabilitación de un perro por parte de un empleado

## Narrativa
- **Como** empleado con sesion iniciada
- **Quiero** inhanilitar el perro de un cliente
- **Para** que este no pueda ser utilizado en el sistema para las acciones posibles de un perro y quede registrado en el sistema

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Inhabilitar perro exitoso
  **Dado** un empleado en el perfil del perro Travieso que no se encuentra inhabilitado
  **Cuando** selecciona inhabilitar perro
  **Entonces** el sistema inhabilita el perro, removiendo la posibilidad de inhabilitarlo y le informa al empleado del éxito de la operación
