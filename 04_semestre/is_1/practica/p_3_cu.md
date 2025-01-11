# Casos de Uso

Template

## Ejercicio x

enunciado

- Nombre del caso de uso:
- Descripcion:
- Actores
- Precondiciones
- Curso Normal:
  | Acciones del actor | Acciones del sistema |
  | :-: | :-: |
  |     |     |
- Curso Alterno:
  - :
  - :
- Poscondicion:



## Ejercicio 3

Contratos

Suponga que trabaja en un grupo en el área de sistemas de una organización y está por comenzar un nuevo proyecto para desarrollar un sistema que depende del departamento contable.

El sistema deberá administrar los contratos realizado con terceros. En una de las reuniones con el jefe de departamento nos dijo que él no usará el sistema pero que recibirá listados del personal contratado ya que deberá firmarlos para elevarlos a las autoridades.

Para obtener más información generamos una reunión con el empleado de mesa de entradas. Nos contó que el problema que tienen actualmente es que realizan todas las minutas a mano por lo cual desean automatizar esta tarea. Las minutas son el paso previo a un contrato. Para confeccionar una minuta, el empleado de mesa de entradas debe ingresar nombre y número de CUIT de una persona a contratar, tipo de contrato, fecha de comienzo, duración y monto, a lo que el sistema le asociará un número de minuta automáticamente. Nos recomendó leer la reglamentación vigente acerca de contratos de la que obtuvimos que los montos de los mismos no pueden superar los $25.000 y que la duración debe ser como máximo de
6 meses.

Una vez confeccionada la minuta por parte del empleado de mesa de entradas, la misma queda pendiente de aprobación. El que puede aprobar una minuta es el empleado de rendiciones. Realizamos una reunión con él y nos contó que su tarea consiste en evaluar las minutas para determinar su aprobación. También nos dijo que en otro trabajo que tiene usan un sistema llamado MiMiNuTa al que nos puede dar acceso para ver como hacen esa tarea. Después del análisis de este sistema, se concluyó que para aprobar una minuta necesitaría ingresar un número de minuta y que el sistema muestre los datos de la misma para poder aprobarla. Nos dijo que no puede aprobar la minuta si la persona a contratar tiene 3 contratos vigentes (minutas aprobadas) ni tampoco si el CUIT de la persona a contratar está inhabilitado por la AFIP.

Actualmente se comunica telefónicamente con la AFIP para realizar esta verificación, pero sabe que ésta provee un servicio para aplicaciones que permite hacer la verificación en línea. Esto último nos obligó a generar una reunión con el administrador de servidores de la AFIP. Nos dijo que para poder conectarnos con un servidor de la AFIP, el sistema debe mandar un token (código que identificará de manera única a nuestra aplicación) y CUIT, si el token es correcto, el servidor responde si el CUIT está habilitado o no.

Por último el empleado de rendiciones será el responsable de imprimir los listados con las minutas aprobadas, es decir, un listado con el personal contratado para poder dárselo al jefe de departamento para
que lo firme

![Ejercicio 3](c__Users_suare_Documents_Universidad_4%C2%B0%20Semestre_IS1_p3_cu_sketch.png)

- Nombre del caso de uso: crear minuta
- Descripcion: en este caso de uso se describe como el empleado de entrada crea una minuta
- Actores: empleado de entrada
- Precondiciones: -
- Curso Normal:
  | Acciones del actor | Acciones del sistema |
  | :-: | :-: |
  | 1) el empleado selecciona la opcion de confeccionar minuta | 2 el sistema le pide nombre y número de CUIT de una persona a contratar, tipo de contrato, fecha de comienzo, duración y monto |
  | 3 el empleado ingresa los datos | 4 sistema verifica que el monto no supera los 25k, que el contrato sea menor a 6 meses |
  |   | 5 se le asocia un numero unico a la minuta creada |
- Curso Alterno:
  - 4 se informa al empleado que supero los 25k de monto. fin cu
  - 4 se informa al empleado que supero los 6 meses. fin de cu
- Poscondicion: La minuta fue cargada al sistema con estado esperando aprobacion

