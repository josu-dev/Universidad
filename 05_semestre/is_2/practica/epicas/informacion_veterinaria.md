Template de historias de usuario:

```md
> {nombre historia}

# Título
{descripción historia}

## Narrativa
- **Como** {rol}
- **Quiero** {funcionalidad}
- **Para** {beneficio}

## Criterios de aceptación
- **Escenario:** {nombre escenario}
  **Dado** {precondición}
  **Cuando** {evento}
  **Entonces** {resultado esperado}

> Repetir para cada escenario necesario
```

---

> Mostrar inicio

# Título
Mostrar la pagina de inicio de la veterinaria

## Narrativa
- **Como** cliente o no cliente
- **Quiero** ver la pagina de inicio
- **Para** ver la información de la veterinaria

## Reglas del negocio
- Mostrar las campañas de donación activas en el inicio de haber

## Criterios de aceptación
- **Escenario:** Mostrar inicio exitoso con campañas de donación
  **Dado** un cliente o no cliente en alguna pagina de la veterinaria
  **Cuando** selecciona el logo de la veterinaria
  **Entonces** el sistema redirige al cliente o no cliente a la pagina de inicio y muestra las campañas activas al comienzo de la pagina

- **Escenario:** Mostrar inicio exitoso sin campañas de donación
  **Dado** un cliente o no cliente en alguna pagina de la veterinaria
  **Cuando** selecciona el logo de la veterinaria
  **Entonces** el sistema redirige al cliente o no cliente a la pagina de inicio y no muestra ninguna campaña de donación

---

> Mostrar sucursales

# Título
Mostrar las sucursales de la veterinaria y sus ubicaciones

## Narrativa

- **Como** cliente o no cliente
- **Quiero** ver la pagina de sucursales
- **Para** ver la información de las sucursales de la veterinaria

## Criterios de aceptación
- **Escenario:** Mostrar pagina de sucursales exitoso
  **Dado** un cliente o no cliente en alguna pagina de la veterinaria
  **Cuando** el cliente o no cliente selecciona la opción de mostrar la pagina de sucursales
  **Entonces** el sistema redirige al cliente o no cliente a la pagina de sucursales y muestra un mapa con las sucursales de la veterinaria

---

> Ver listado sucursales

# Título
Visualizar el listado de sucursales de la veterinaria

## Narrativa
- **Como** Empleado con sesion iniciada
- **Quiero** ver el listado de sucursales
- **Para** poder ver las sucursales registradas en la veterinaria pudiendo realizar modificaciones

## Criterios de aceptación
- **Escenario:** Ver listado de sucursales exitoso
  **Dado** un empleado
  **Cuando** el empleado selecciona la opción de mostrar el listado de sucursales
  **Entonces** el sistema redirige al empleado a la pagina de sucursales y muestra el listado de las mismas

---

> Agregar sucursal

# Título
Agregar una sucursal al listado de sucursales registradas

## Narrativa
- **Como** Empleado con sesión iniciada
- **Quiero** agregar una sucursal
- **Para** poder reflejar la adición de una nueva sucursal

## Criterios de aceptación
- **Escenario:** Agregar sucursal exitoso
  **Dado** un empleado el listado de sucursales, con una dirección "Calle 4 entre 1 y 2" y hora de apertura "08:00" y hora de cierre "18:00"
  **Cuando** el empleado selecciona la opción de agregar una sucursal e ingresa dirección "Calle 4 entre 1 y 2", hora de apertura "08:00", hora de cierre "18:00" y luego confirma la creación de la sucursal
  **Entonces** el sistema crea la sucursal con los datos ingresados por el empleado registrándola en el listado de sucursales y notifica del éxito al empleado

---

> Actualizar sucursal

# Título
Actualizar una sucursal del listado de sucursales registradas

## Narrativa
- **Como** Empleado con sesión iniciada
- **Quiero** actualizar la información de una sucursal
- **Para** poder reflejar los cambios realizados en la sucursal

## Criterios de aceptación
- **Escenario:** Actualizar sucursal exitoso
  **Dado** una sucursal en el listado de sucursales seleccionada por el empleado, con una dirección "Calle 40 entre 10 y 11" y hora de apertura "09:00" y hora de cierre "17:00"
  **Cuando** el empleado modifica la dirección por "Calle 40 entre 10 y 11", hora de apertura por "09:00", hora de cierre por "17:00" y luego confirma la actualización de la sucursal
  **Entonces** el sistema guarda los cambios realizados a la sucursal y notifica del éxito al empleado

---

> Eliminar sucursal

# Título
Eliminar una sucursal del listado de sucursales registradas

## Narrativa
- **Como** Empleado con sesión iniciada
- **Quiero** eliminar una sucursal
- **Para** poder reflejar que la sucursal ya no existe

## Criterios de aceptación
- **Escenario:** Eliminar sucursal exitoso
  **Dado** una sucursal en el listado de sucursales seleccionada por el empleado
  **Cuando** el empleado selecciona la opción de eliminar la sucursal seleccionada y luego confirma la eliminación
  **Entonces** el sistema elimina la sucursal seleccionada y notifica del éxito al empleado
