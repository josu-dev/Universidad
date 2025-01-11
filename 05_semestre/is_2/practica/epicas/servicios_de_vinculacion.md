# Título
Visualizar el listado de publicaciones de adopción de perros como cliente o usuario no registrado

## Narrativa
- **Como** usuario no registrado o cliente con sesion iniciada
- **Quiero** ver el listado de perros en adopcion
- **Para** poder consultar las publicaciones de adopcion de perros

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver listado de adopcion exitoso vacio
  **Dado** un usuario no registrado o cliente con sesion iniciada en la pagina de inicio
  **Cuando** selecciona adopcion
  **Entonces** el sistema le muestra al usuario o cliente el listado de publicacion de perros en adopcion vacio informando que no hay publicaciones de adopcion

- **Escenario:** Ver listado de adopcion exitoso
  **Dado** un usuario no registrado o cliente con sesion iniciada en la pagina de inicio
  **Cuando** selecciona adopcion
  **Entonces** el sistema le muestra al usuario o cliente el listado de publicación de adopción


------------------------------------------------------------------------------------------

# Título
Nueva publicacion de adopcion por parte de un cliente

## Narrativa
- **Como** cliente con sesion iniciada
- **Quiero** publicar un perro en adopcion
- **Para** que pueda encontrar un nuevo hogar

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Publicar adopcion exitoso con perro registrado
  **Dado** un cliente en el listado de publicaciones de adopcion, teniendo este a la perra registrada liza
  **Cuando** selecciona dar en adopcion, y selecciona dar en adopcion en liza
  **Entonces** el sistema registra la publicacion de adopcion de liza, la remueve de las opciones disponibles para el cliente y le informa que la publicacion fue exitosa

- **Escenario:** Publicar adopcion exitoso con perro no registrado
  **Dado** un cliente en el listado de publicaciones de adopcion, los datos del perro a publicar nombre vermudas, nacimiento estimado 7/3/2020, tamaño mediano, sexo macho, color castaño y raza San bernardo
  **Cuando** selecciona dar en adopcion, ingresa el nombre vermudas, fecha estimada de nacimiento 7/3/2020, selecciona tamaño mediano, selecciona sexo macho, color castaño, selecciona raza San bernardo y selecciona dar en adopcion
  **Entonces** el sistema registra la publicación de adopción de vermudas y le informa que la publicación fue exitosa


------------------------------------------------------------------------------------------

# Título
Visualizacion de una publicacion de vinculacion (adopcion/ busqueda/ cruza) como publicador o no publicador

## Narrativa
- **Como** usuario no registrado, cliente no publicador o cliente publicador con sesion iniciada
- **Quiero** ver la publicacion en mas detalle
- **Para** poder informarme sobre la publicacion si no la publique o poder editarla si la publique

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Ver publicacion de vinculacion exitoso como publicador
  **Dado** un cliente publicador en el listado de publicaciones no vacio de vinculacion
  **Cuando** selecciona Ver publicacion
  **Entonces** el sistema le muestra al cliente publicador la publicacion de vinculacion en mas detalle y le permite editarla

- **Escenario:** Ver publicacion de vinculacion exitoso como no publicador
  **Dado** un usuario no registrado o cliente no publicador en el listado de publicaciones no vacio de vinculacion
  **Cuando** selecciona Ver publicacion
  **Entonces** el sistema le muestra al usuario no registrado o cliente no publicador la publicación de vinculación en mas detalle, no le permite editarla y le habilita contactar al publicador


------------------------------------------------------------------------------------------

# Título
Actualizacion de una publicacion de adopción de un perro cargado por parte del publicador

## Narrativa
- **Como** cliente con sesion iniciada y publicador de la publicacion de adopcion de un perro cargado para adopcion
- **Quiero** actualizar la publicacion de adopcion
- **Para** que los datos en la publicacion sean los correctos

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Actualizar adopcion exitoso
  **Dado** un cliente autor de la publicacion del perro vermudas cargado para adopcion, los nuevos datos para el perro nombre capricho, nacimiento estimado 2/3/2020, tamaño grande, sexo hembra, color manchas negras y raza Terranova
  **Cuando** ingresa el nombre capricho, fecha estimada de nacimiento 2/3/2020, selecciona tamaño grande, selecciona sexo hembra, color manchas negras, selecciona raza Terranova y selecciona actualizar
  **Entonces** el sistema actualiza la publicación de adopción de capricho y le informa que la actualización fue exitosa


------------------------------------------------------------------------------------------

# Título
Resolucion de una adopcion por parte de un cliente autor de la misma

## Narrativa
- **Como** cliente con sesión iniciada autor de una publicación de adopción
- **Quiero** resolver una adopción
- **Para** que ya no figure mas como disponible para adopción o eliminarla

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Resolver adopcion exitoso
  **Dado** un cliente autor de la publicacion del perro vermudas en la publicacion de adopcion
  **Cuando** ingresa una valoracion y selecciona resolver
  **Entonces** el sistema actualiza la publicacion a resuelto, deshabilita la edicion de la publicacion, elimina la posibilidad de eliminar el post e informa el exito de la resolucion de la adopcion al cliente

- **Escenario:** Resolver adopcion exitoso como eliminacion
  **Dado** un cliente autor de la publicacion del perro liza en la publicacion de adopcion
  **Cuando** selecciona eliminar publicaicon
  **Entonces** el sistema elimina la publicación de adopción volviendo a habilitarlo para adopción si era una previamente registrado caso contrario eliminar el registro del perro y le informa el éxito de la eliminación de la publicación al cliente


------------------------------------------------------------------------------------------

# Título
Contacto con el publicador de un perro en adopcion por parte de un usuario no registrado o cliente no publicador

## Narrativa
- **Como** usuario no registrado o cliente no publicador con sesion iniciada
- **Quiero** contactar con el autor de la publicacion
- **Para** poder entrar en detalles sobre el caso y poder adoptar al perro

## Reglas del negocio

## Criterios de aceptación
- **Escenario:** Contactar publicador adopcion exitoso como cliente
  **Dado** un cliente con sesion iniciada de nombre Juan, apellido sanchez, mail cliente5.ohmydog19@gmail.com y telefono 221-456-7890 en la publicacion de adopcion del perro liza cuyo dueño tiene correo cliente6.ohmydog19@gmail.com
  **Cuando** selecciona contactar
  **Entonces** el sistema envia un correo al mail cliente6.ohmydog19@gmail.com informando que la persona de nombre Juan, apellido sanchez, mail cliente5.ohmydog@gmail.com y telefono 221-456-7890 esta interesada en la adopcion de liza y le informa al cliente que el contacto fue exitoso dentro de la aplicación y por el mail del mismo

- **Escenario:** Contactar publicador adopcion exitoso como usuario no registrado
  **Dado** un usuario no registrado en la publicacion de adopcion del perro liza cuyo dueño tiene correo cliente6.ohmydog19@gmail.com, datos del usuario con nombre Pedro, apellido Perez, mail unMail@gmail.com y telefono 221-456-9999
  **Cuando** selecciona ingresa el nombre Pedro, apellido Perez, mail unMail@gmail.com y telefono 221-456-9999 y selecciona contactar
  **Entonces** el sistema envía un correo al mail cliente6.ohmydog@gmail.com informando que la persona de nombre Pedro, apellido Pérez, mail unMail@gmail.com y teléfono 221-456-9999 esta interesada en la adopción de liza y le informa al usuario no registrado que el contacto fue exitoso dentro de la aplicacion y por el mail que ingreso como propio


------------------------------------------------------------------------------------------

# Título
Filtrado de adopciones por raza, por edad, por tamaño, por sexo, por estado o propias si el cliente esta logueado y es el autor de la publicacion

## Narrativa
- **Como** cliente con sesion iniciada o usuario no registrado
- **Quiero** filtrar las publicaciones de adopcion
- **Para** que me resulte mas facil encontrar la publicacion que busco

## Reglas del negocio

## Criterios de aceptación
- - **Escenario:** Filtrar adopciones exitoso usuario no registrado
  **Dado** un usuario no registrado en el listado de adopciones, el conjunto de criterios sexo Macho, raza "Border Collie", edad descendente, tamaño "pequeño"
  **Cuando** selecciona sezo macho, raza "Border Collie", edad descendente y tamaño pequeño
  **Entonces** el sistema muestra al cliente el listado de perros que cumplen con los criterios indicados

- **Escenario:** Éxito en la muestra sin resultados coincidentes
  **Dado** un cliente o usuario no registrado, el conjunto de criterios sexo: hembra, raza: "pitbull", edad descendente, tamaño: "grande"
  **Cuando** selecciona sexo hembra, raza "pitbull", edad descendente y tamaño grande
  **Entonces** el sistema le muestra el listado vacio al cliente o usuario no registrado indicando que no hay resultados coincidentes

- **Escenario:** Filtrar adopciones exitoso cliente
  **Dado** un cliente que posea en adopcion un perro San bernardo de tamaño grande que es macho, que se encuentra en el listado de adopciones, el conjunto de criterios sexo Macho, raza "San bernardo", edad descendente, tamaño "grande" y propio
  **Cuando** selecciona sexo macho, raza "San bernardo", edad descendente, tamaño grande y propio
  **Entonces** el sistema muestra al cliente el listado solo con su perro
