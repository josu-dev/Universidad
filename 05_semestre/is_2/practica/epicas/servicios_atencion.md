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

> Informacion urgencia

# Título
Informacion util sobre ante una urgencia

## Narrativa
- **Como** Cliente o No cliente
- **Quiero** informarme sobre las sucursales de la veterinaria
- **Para** saber a donde dirigirme en caso de una urgencia

## Criterios de aceptación
- **Escenario:** Informacion ante urgencia exitosa
  **Dado** un cliente o no cliente
  **Cuando** el cliente o no cliente selecciona urgencia
  **Entonces** el sistema le muestra las sucursales al cliente o no cliente

---

> Cancelar turno

# Título
Cancelar turno para atención en la veterinaria

## Narrativa

---

> Gestionar propuesta turno

# Título
Gestionar nuevas propuestas de turnos hechas por los clientes

## Narrativa
- **Como** Empleado con sesión iniciada
- **Quiero** gestionar las propuestas de turnos
- **Para** aceptarlas o proponer una nueva fecha

## Criterios de aceptación
- **Escenario:** Gestionar propuesta de turno exitoso
  **Dado** un empleado, una propuesta de turno con fecha 2021-06-01 en turno mañana y motivo vacuna
  **Cuando** el empleado selecciona la propuesta de turno y la acepta
  **Entonces** el sistema registra la propuesta de turno como un turno confirmado y le notifica al cliente que realizó la propuesta de turno que su turno fue confirmado

- **Escenario:** Gestionar propuesta de turno exitoso con propuesta de nueva fecha
  **Dado** un empleado, una propuesta de turno con fecha 2021-06-01 en turno tarde y motivo vacuna
  **Cuando** el empleado selecciona la propuesta de turno y propone una nueva fecha 2021-06-02 en turno mañana
  **Entonces** el sistema cancela la propuesta de turno original, registra la propuesta de turno con la nueva fecha y le notifica al cliente que realizó la propuesta de turno que su turno fue cancelado y que se le propuso una nueva fecha





