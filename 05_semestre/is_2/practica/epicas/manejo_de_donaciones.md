# Título
Agregar campaña de donación como empleado

## Narrativa
- **Como** empleado con sesión iniciada 
- **Quiero** agregar una campaña de donación 
- **Para** que pueda ser comenzada en algún momento

## Reglas del negocio:
- El título de la campaña de donación no puede exceder los 80 caracteres 
- La descripción de la campaña de donación no puede exceder las 200 palabras 

## Criterios de aceptación
- **Escenario:** Éxito al agregar una campaña de donación 
  **Dado** un empleado que posee los datos de una nueva campaña de donación de nombre: "¡Patitas solidarias!: ayúdanos a pagar los gastos en medicamentos", una descripción de 180 palabras y un banner
  **Cuando** el empleado selecciona agregar campaña de donación, nombre: "¡Patitas solidarias!: ayúdanos a pagar los gastos en medicamentos", una descripción de 180 palabras y un banner, luego selecciona que se guarden los datos
  **Entonces** el sistema registra la campaña como creada, informa del éxito al empleado y lo redirecciona a la campaña que acaba de registrar

- **Escenario:** Fallo al agregar una campaña de donación por exceso de caracteres en el título 
  **Dado** un empleado que posee los datos de una nueva campaña de donación de nombre: "¡Juntos por los perros!: ayúdanos para conseguirles un hogar a estos hermosos perros", una descripción de 170 palabras y un banner
  **Cuando** el empleado selecciona agregar campaña de donación, nombre: "¡Juntos por los perros!: ayúdanos para conseguirles un hogar a estos hermosos perros", una descripción de 170 palabras y un banner, luego selecciona que se guarden los datos
  **Entonces** el sistema informa al empleado que el título excede los 80 caracteres

- **Escenario:** Fallo al agregar una campaña de donación por exceso de palabras en la descripción 
  **Dado** un empleado que posee los datos de una nueva campaña de donación de nombre: "¡Dale una segunda oportunidad a un perro, Doná hoy!", una descripción de 250 palabras y un banner
  **Cuando** el empleado selecciona agregar campaña de donación, nombre: "¡Dale una segunda oportunidad a un perro, Doná hoy!", una descripción de 250 palabras y un banner, luego selecciona que se guarden los datos
  **Entonces** el sistema informa al empleado que la descripción excede las 200 palabras


------------------------------------------------------------------------------------------

# Título
Editar campaña de donación no terminada como empleado

## Narrativa
- **Como** empleado con sesión iniciada 
- **Quiero** editar una campaña de donación no terminada
- **Para** reflejar la información adecuadamente 

## Reglas del negocio:
- El título de la campaña de donación no puede exceder los 80 caracteres 
- La descripción de la campaña de donación no puede exceder las 200 palabras 

## Criterios de aceptación
- **Escenario:** Éxito al editar la información de la campaña de donación
  **Dado** una campaña de donación seleccionada del listado de campañas de donación
  **y** un empleado que posee los datos de una campaña de donación a editar la cual ahora el título será: "¡Todos merecen un hogar: Ayudanos a encontrarles hogar a los perros!"
  **Cuando** el empleado selecciona la opción de editar campaña de donación, ingresa título: "¡Todos merecen un hogar: Ayudanos a encontrarles hogar a los perros!" y selecciona actualizar
  **Entonces** el sistema actualiza la información de la campaña en el listado de campañas de donación e informa el éxito de la edición al empleado 

- **Escenario:** Fallo al editar la información de la campaña de donación por que el titulo excede el límite de caracteres
  **Dado** una campaña de donación seleccionada del listado de campañas de donación
  **y** un empleado que posee los datos de una campaña de donación a editar la cual ahora el título será: "¡Todos merecen un hogar: Ayudanos a encontrarles hogar a los perros que se encuentran en situación de calle!"
  **Cuando** el empleado selecciona la opción de editar campaña de donación, ingresa título: "¡Todos merecen un hogar: Ayudanos a encontrarles hogar a los perros que se encuentran en situación de calle!" y selecciona actualizar
  **Entonces** el sistema informa el fallo de la edición al empleado por que el titulo excede el límite de 80 caracteres

- **Escenario:** Fallo al editar la información de la campaña de donación por que la descripción excede el límite de palabras
  **Dado** una campaña de donación seleccionada del listado de campañas de donación
  **y** un empleado que posee los datos de una campaña de donación a editar la cual ahora la descripción será de 230 caracteres
  **Cuando** el empleado selecciona la opción de editar campaña de donación, ingresa la nueva descripción y selecciona actualizar
  **Entonces** el sistema informa el fallo de la edición al empleado porque la descripción excede el límite de 200 caracteres


------------------------------------------------------------------------------------------

# Título
Visualizar listado de campañas de donación como usuario

## Narrativa
- **Como** usuario (cliente con sesión iniciada o no cliente)
- **Quiero** visualizar el listado de campañas de donación
- **Para** poder elegir una campaña de donación a la cual donar

## Criterios de aceptación
- **Escenario:** Éxito al visualizar el listado de campañas de donación
  **Dado** un usuario en alguna página de la veterinaria
  **Cuando** selecciona la opción donacion
  **Entonces** el sistema redirige al usuario a la página de campañas de donación y le muestra el listado de las mismas

- **Escenario:** Éxito al visualizar el listado vacío de campañas de donación 
  **Dado** un usuario en alguna página de la veterinaria y no existen campañas de donación
  **Cuando**  selecciona la opción de donacion
  **Entonces** el sistema redirige al usuario a la página de campañas de donación e informa que no existen campañas de donación


------------------------------------------------------------------------------------------

# Título
Ver listado de donantes cliente como empleado

## Narrativa
- **Como** empleado con sesión iniciada
- **Quiero** visualizar el listado de clientes que sonaron
- **Para** poder ver el saldo positivo que tiene acumulado

## Criterios de aceptación
- **Escenario:** Éxito al visualizar el listado de donantes
  **Dado** un empleado en alguna página de la veterinaria
  **Cuando** el empleado selecciona donaciones 
  **Entonces** el sistema redirige al empleado a la página de campañas de donación y le muestra el listado de los donantes con su respectivo saldo positivo

- **Escenario:** Éxito al visualizar el listado de donantes vacío
  **Dado** un empleado en alguna página de la veterinaria
  **y** no existen donantes
  **Cuando** el empleado selecciona donaciones 
  **Entonces** el sistema redirige al empleado a la página de campañas de donación e informa que no existen donantes


------------------------------------------------------------------------------------------

# Título:
Vista del historial propio de donaciones como cliente o el historial de cualquier cliente como empleado

## Narrativa:
- Como usuario con sesión iniciada como empleado o cliente
- Quiero ver la lista de donaciones de un cliente o propias
- Para consultar su contenido

## Reglas de negocio

## Criterios de aceptación:
- **Escenario:** Éxito con donaciones existentes
  **Dado** un cliente previamente seleccionado y un listado de donaciones no vacío
  **Cuando** el usuario indica que quiere ver el listado
  **Entonces** el sistema muestra el mismo en pantalla

- **Escenario:** Éxito sin donaciones existentes
  **Dado** un cliente previamente seleccionado y un listado de donaciones vacío
  **Cuando** el usuario indica que quiere ver el listado
  **Entonces** el sistema indica al usuario que no hay donaciones relacionadas al usuario


------------------------------------------------------------------------------------------

# Título
Habilitar campaña de donación como empleado

## Narrativa
- **Como** empleado con sesión iniciada 
- **Quiero** empezar o continuar una campaña de donación no terminada
- **Para** que sea visible y pueda recibir donaciones

## Reglas del negocio:

## Criterios de aceptación
- **Escenario:** Éxito al Habilitar campaña de donación creada
  **Dado** un empleado que se encuentra en una campaña de donación que no fue comenzada
  **Cuando** selecciona comenzar campaña
  **Entonces** el sistema actualiza la campaña a activa, la agrega al listado de campañas activas y le informa del éxito al empleado

- **Escenario:** Éxito al Habilitar campaña de donación pausada
  **Dado** un empleado que se encuentra en una campaña de donación que no fue comenzada
  **Cuando** selecciona reanudar campaña
  **Entonces** el sistema actualiza la campaña a activa, la agrega al listado de campañas activas y le informa del éxito al empleado


------------------------------------------------------------------------------------------

# Título
Pausar campaña de donación como empleado

## Narrativa
- **Como** empleado con sesión iniciada
- **Quiero** pausar una campaña de donación activa
- **Para** que no sea visible a los usuarios

## Reglas del negocio:

## Criterios de aceptación
- **Escenario:** Éxito al pausar campaña de donación
  **Dado** un empleado que se encuentra en una campaña de donación que se encuentra activa
  **Cuando** selecciona pausar campaña
  **Entonces** el sistema actualiza la campaña a pausada, la remueve del listado de campañas activas y le informa del éxito al empleado


------------------------------------------------------------------------------------------

# Título
Terminar campaña de donación como empleado

## Narrativa
- **Como** empleado con sesión iniciada
- **Quiero** terminar una campaña de donación activa o pausada
- **Para** que no sea visible a los usuarios y se inhabiliten las funcionalidades asociadas

## Reglas del negocio:

## Criterios de aceptación
- **Escenario:** Éxito al pausar campaña de donación activa
  **Dado** un empleado que se encuentra en una campaña de donación que se encuentra activa
  **Cuando** selecciona terminar campaña
  **Entonces** el sistema actualiza la campaña a terminada, la remueve del listado de campañas activas, desactiva las funcionalidades para la misma y le informa del éxito al empleado

- **Escenario:** Éxito al pausar campaña de donación pausada
  **Dado** un empleado que se encuentra en una campaña de donación que se encuentra pausada
  **Cuando** selecciona terminar campaña
  **Entonces** el sistema actualiza la campaña a terminada, la remueve del listado de campañas activas, desactiva las funcionalidades para la misma y le informa del éxito al empleado


------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------


