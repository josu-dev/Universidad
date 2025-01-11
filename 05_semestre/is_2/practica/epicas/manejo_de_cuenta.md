# Título
Cierre de sesión para des autenticarse del sistema

## Narrativa
- **Como** Cliente o Empleado con sesión iniciada
- **Quiero** cerrar mi sesión
- **Para** que se me des habiliten las funcionalidades adecuadas a mis credenciales

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Cierre de sesión exitoso como cliente
  **Dado** un cliente o empleado con sesión iniciada
  **Cuando** selecciona cerrar sesión
  **Entonces** el sistema des autentica al cliente o empleado permitiéndole solo las funcionalidades de un no cliente y lo redirecciona al inicio de sesión


------------------------------------------------------------------------------------------

# Título
Inicio de sesión necesario para autenticarse como cliente o empleado

## Narrativa
- **Como** Usuario
- **Quiero** iniciar mi sesión
- **Para** que se me habiliten las funcionalidades adecuadas a mis credenciales

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Inicio de sesión fallido por correo invalido
  **Dado** un usuario con correo invalido@gmail.com que no corresponde a un cliente o empleado registrado
  **Cuando** ingresa correo invalido@gmail.com y contraseña 12345678
  **Entonces** el sistema luego de validar que no existe cliente o empleado con el correo indicado informa de esto al usuario

- **Escenario:** Inicio de sesión fallido por contraseña invalida
  **Dado** un usuario con correo cliente1.ohmydog19@gmail.com que corresponde a un usuario registrado y contraseña invalida123 que no corresponde al mail indicado
  **Cuando** ingresa correo cliente1.ohmydog19@gmail.com y contraseña invalida123
  **Entonces** el sistema luego de validar que la contraseña indicada no corresponde con el correo indicado informa de esto al usuario

- **Escenario:** Inicio de sesión exitoso como empleado
  **Dado** un usuario con correo vet1.ohmydog19@gmail.com y contraseña 87654321 que corresponden a las credenciales de un empleado
  **Cuando** ingresa correo vet1.ohmydog19@gmail.com y contraseña 87654321
  **Entonces** el sistema luego de validar las credenciales le habilita las funcionalidades de empleado y lo redirige a la pagina de administración

- **Escenario:** Inicio de sesión exitoso como cliente
  **Dado** un usuario con correo cliente1.ohmydog19@gmail.com y contraseña 12345678 que corresponden a las credenciales de un cliente
  **Cuando** ingresa correo cliente1.ohmydog19@gmail.com y contraseña 12345678
  **Entonces** el sistema luego de validar las credenciales le habilita las funcionalidades de cliente y lo redirige a la pagina principal

------------------------------------------------------------------------------------------

# Título
Visualización de cuenta como cliente

## Narrativa
- **Como** Cliente con sesión iniciada
- **Quiero** ver mi cuenta
- **Para** ver mis datos personales y listado de perros registrados

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver cuenta exitoso
  **Dado** un cliente con la sesion iniciada
  **Cuando** selecciona Mi cuenta
  **Entonces** el sistema le muestra al cliente su cuenta con los datos y sus perros registrados


------------------------------------------------------------------------------------------

# Título
Edición de datos de acceso de la cuenta como cliente o empleado

## Narrativa
- **Como** Cliente o Empleado con sesión iniciada
- **Quiero** editar los datos de acceso a mi cuenta
- **Para** actualizarlos en el sistema

## Reglas del negocio
- Correo único
- Nueva contraseña y contraseña confirmación deben coincidir

## Criterios de aceptación
- **Escenario:** Editar cuenta fallido por mail ya registrado
  **Dado** un cliente o empleado y el mail registrado@gmail.com ya registrado
  **Cuando** ingresa la contraseña actual 12345678, nueva contraseña 23456789, contraseña confirmación 23456789, correo actual cliente1.ohmydog19@gmail.com, correo nuevo registrado@gmail.com y selecciona editar cuenta
  **Entonces** el sistema no guarda los datos editados y le informa al cliente o empleado que el mail ya esta en uso

- **Escenario:** Editar cuenta fallido por contraseña actual incorrecta
  **Dado** un cliente o empleado y la contraseña invalida invalida123
  **Cuando** ingresa la contraseña actual invalida123, nueva contraseña 23456789, contraseña confirmación 23456789, correo actual cliente1.ohmydog19@gmail.com, correo nuevo noregistrado1.ohmydog19@gmail.com y selecciona editar cuenta
  **Entonces** el sistema no guarda los datos editados y le informa al cliente o empleado que la contraseña actual es incorrecta

- **Escenario:** Editar cuenta fallido por nueva contraseña no coincide con contraseña confirmación
  **Dado** un cliente o empleado, nueva contraseña 12345678 y contraseña confirmación 123nocoincide la cual no coincide con la nueva contraseña
  **Cuando** ingresa la contraseña actual 123actual, nueva contraseña 12345678, contraseña confirmación 123nocoincide, correo actual cliente1.ohmydog19@gmail.com, correo nuevo noregistrado1.ohmydog19@gmail.com y selecciona editar cuenta
  **Entonces** el sistema no guarda los datos editados y le informa al cliente o empleado que la nueva contraseña no coincide con la contraseña confirmación

- **Escenario:** Editar cuenta exitoso como cliente
  **Dado** un cliente, mail no registrado noregistrado1.ohmydog19@gmail.com y contraseña actual 12345678 valida
  **Cuando** ingresa la contraseña actual 12345678, nueva contraseña 23456789, contraseña confirmación 23456789, correo actual cliente1.ohmydog19@gmail.com, correo nuevo noregistrado1.ohmydog19@gmail.com y selecciona editar cuenta
  **Entonces** el sistema guarda los datos editados y le informa al cliente que se guardaron correctamente

- **Escenario:** Editar cuenta exitoso como empleado
  **Dado** un cliente, mail no registrado vet2.ohmydog19@gmail.com y contraseña actual 87654321 valida
  **Cuando** ingresa la contraseña actual 87654321, nueva contraseña 12345678, contraseña confirmación 12345678, correo actual vet1.ohmydog19@gmail.com, correo nuevo vet2.ohmydog19@gmail.com y selecciona editar cuenta
  **Entonces** el sistema guarda los datos editados y le informa al empleado que se guardaron correctamente


------------------------------------------------------------------------------------------

# Título
Visualización del listado de perros de un cliente como su dueño o empleado

## Narrativa
- **Como** cliente o empleado con sesion iniciada
- **Quiero** ver el listado de perros propios siendo cliente o de un cliente siendo empleado
- **Para** consultarlo como cliente y administrarlo como empleado

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver listado de perros vacio exitoso como empleado
  **Dado** un empleado en el listado de clientes y el cliente de correo cliente4.ohmydog19@gmail.com que no tiene perros registrados
  **Cuando** selecciona Ver cuenta del cliente con correo cliente4.ohmydog@gmail.com
  **Entonces** el sistema le muestra al empleado que el cliente no tiene perros registrados

- **Escenario:** Ver listado de perros exitoso como empleado
  **Dado** un empleado en el listado de clientes y el cliente de correo cliente3.ohmydog19@gmail.com con almenos un perro registrado
  **Cuando** selecciona Ver cuenta del cliente con correo cliente3.ohmydog@gmail.com
  **Entonces** el sistema le muestra al empleado el listado de perros del cliente seleccionado

- **Escenario:** Ver listado de perros exitoso como cliente
  **Dado** un cliente con al menos un perros registrado que se encuentra en el inicio
  **Cuando** selecciona Mi cuenta
  **Entonces** el sistema le muestra al cliente el listado de sus propios perros registrados


------------------------------------------------------------------------------------------

# Título
Visualización del perfil de un perro como su dueño o empleado

## Narrativa
- **Como** Cliente o Empleado con sesión iniciada
- **Quiero** ver el perfil de un perro
- **Para** ver sus datos e historial medico

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver perfil perro exitoso como cliente
  **Dado** un cliente su listado de perros con un perro llamado Firulais con historial medico no vacío
  **Cuando** selecciona ver perfil en el perro Firulais
  **Entonces** el sistema le muestra el perfil del perro seleccionado al cliente junto a su historial medico solo para ver

- **Escenario:** Ver perfil perro exitoso como empleado
  **Dado** un empleado en el listado de perros del cliente con correo noregistrado1.ohmydog19@gmail.com con un perro llamado Firulais con historial medico no vacío
  **Cuando** el empleado selecciona "Ver perfil" en el perro Firulais
  **Entonces** el sistema le muestra el perfil del perro seleccionado al empleado junto a su historial medico para ver y editar

- **Escenario:** Ver perfil perro exitoso con historial medico vacío
  **Dado** un empleado o cliente en el listado de perros del cliente con correo cliente3.ohmydog19@gmail.com un perro llamado Franchesco con historial medico vacío
  **Cuando** el empleado o cliente selecciona "Ver perfil" en el perro Franchesco
  **Entonces** el sistema le muestra el perfil del perro seleccionado al empleado o cliente junto a que no tiene historial medico para ver y/o editar según corresponda


------------------------------------------------------------------------------------------

# Título
Vista de la historial propio de turnos de un usuario cliente, o cualquier historial de turnos por parte de un usuario empleado

## Narrativa
- **Como** usuario con sesión iniciada como empleado o cliente
- **Quiero** ver el historial de turnos de un cliente o propios
- **Para** consultar su contenido

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver historial de turnos exitoso como empleado
  **Dado** un empleado en el perfil de un cliente con correo cliente3.ohmydog19@gmail.com que tiene al menos un turno registrado
  **Cuando** selecciona Ver turnos
  **Entonces** el sistema le muestra el historial de turnos del cliente seleccionado al empleado

- **Escenario:** Ver historial de turnos vacio exitoso
  **Dado** un empleado en el perfil de un cliente con correo cliente2.ohmydog19@gmail.com o el cliente en si mismo en la pagina de inicio sin turnos registrados
  **Cuando** selecciona Ver turnos si es empleado o Turnos si es cliente
  **Entonces** el sistema le muestra que no tiene turnos registrados al cliente o empleado

- **Escenario:** Ver historial de turnos exitoso como cliente
  **Dado** un cliente en la pagina de inicio con al menos un turno registrado
  **Cuando** selecciona Turnos
  **Entonces** el sistema le muestra el historial de turnos al cliente


------------------------------------------------------------------------------------------

# Título
Descargar información medica de un perro como su dueño o empleado

## Narrativa
- **Como** Cliente o Empleado con sesión iniciada
- **Quiero** descargar la información medica de un perro en formato PDF
- **Para** tener un respaldo de la información medica del perro

## Reglas del negocio
- El PDF debe contener el logo de la veterinaria
- El PDF debe contener la fecha de emisión del PDF
- El PDF debe contener la información de contacto del dueño
- El PDF debe contener la información del perro

## Criterios de aceptación
- **Escenario:** Descargar información medica de un perro exitoso como cliente
  **Dado** un cliente con email juancho@gmail.com que esta en el perfil de su perro Pocho
  **Cuando** selecciona descargar en PDF
  **Entonces** el sistema genera un PDF con el logo de la veterinaria, fecha de emisión del mismo, información de contacto del cliente con email juancho@gmail.com, información del perro Pocho y el historial medico del mismo, y lo descarga en el dispositivo del cliente

- **Escenario:** Descargar información medica de un perro exitoso como empleado
  **Dado** un empleado en el perfil de un perro llamado Pocho con dueño de correo juancho@gmail.com
  **Cuando** selecciona descargar en PDF
  **Entonces** el sistema genera un PDF con el logo de la veterinaria, fecha de emisión del mismo, información de contacto del cliente con email juancho@gmail.com, información del perro Pocho y el historial medico del mismo, y lo descarga en el dispositivo del empleado


------------------------------------------------------------------------------------------

# Título
Descargar información medica de los perros de un cliente como el mismo cliente o un empleado

## Narrativa
- **Como** Cliente o Empleado con sesión iniciada
- **Quiero** descargar la información medica de los perros de un cliente en formato PDF
- **Para** tener un respaldo de la información medica de los perros del cliente

## Reglas del negocio
- El PDF debe contener el logo de la veterinaria
- El PDF debe contener la fecha de emisión del PDF
- El PDF debe contener la información de contacto del dueño
- El PDF debe contener la información de todos los perros del cliente

## Criterios de aceptación
- **Escenario:** Descargar información medica de los perros de un cliente exitoso como cliente
  **Dado** un cliente con email lolo@gmail.com que esta en el listado de sus perros
  **Cuando** selecciona Descargar historiales médicos
  **Entonces** el sistema genera un PDF con el logo de la veterinaria, fecha de emisión del mismo, información de contacto del cliente con email lolo@gmail.com y la información de todos los perros del cliente con sus respectivos historiales médicos, y lo descarga en el dispositivo del cliente

- **Escenario:** Descargar información medica de los perros de un cliente exitoso como empleado
  **Dado** un empleado en el listado de perros de un cliente con email lolo@gmail.com
  **Cuando** selecciona Descargar historiales médicos
  **Entonces** el sistema genera un PDF con el logo de la veterinaria, fecha de emisión del mismo, información de contacto del cliente con email lolo@gmail.com y la información de todos los perros del cliente con sus respectivos historiales médicos, y lo descarga en el dispositivo del empleado
