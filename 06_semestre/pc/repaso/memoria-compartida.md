# Parciales memoria compartida


## Semaforos

### 1

Resolver con SEMÁFOROS los problemas siguientes:

#### a

En una estación de trenes, asisten P personas que deben realizar una carga de su tarjeta SUBE en la terminal disponible. La terminal es utilizada en forma exclusiva por cada persona de acuerdo con el orden de llegada. Implemente una solución utilizando sólo emplee procesos Persona.

> Nota: la función UsarTerminal() le permite cargar la SUBE en la terminal disponible.

```txt
sem mutex = 1
cola esperando
sem personas[P] = ([P] 0)
bool libre = true

Process Persona[id:0..P-1] {
  P(mutex)
  if (!libre) {
    esperando.push(id)
    V(mutex)
    P(personas[id])
  }
  else {
    libre = false
    V(mutex)
  }
  UsarTerminal()
  P(mutex)
  if (esperando.empty()) {
    libre = true
  }
  else {
    V(personas[esperando.pop()])
  }
  V(mutex)
}
```

#### b

Resuelva el mismo problema anterior pero ahora considerando que hay T terminales disponibles. Las personas realizan una única fila y la carga la realizan en la primera terminal que se libera. Recuerde que sólo debe emplear procesos Persona. Nota: la función UsarTerminal(t) le permite cargar la SUBE en la terminal t.

```txt
sem mutex = 1
cola esperando
sem personas[P] = ([P] 0)
int personaTerminales[T] = ([T] 0)
cola terminales = (1 .. T)

Process Persona[id:0..P-1] {
  int terminal
  P(mutex)
  if (terminales.empty()) {
    esperando.push(id)
    V(mutex)
    P(personas[id])
    terminal = personaTerminales[id]
  }
  else {
    terminal = terminales.pop()
    V(mutex)
  }

  UsarTerminal(terminal)

  P(mutex)
  if (esperando.empty()) {
    terminales.push(terminal)
  }
  else {
    int idPersona = esperando.pop()
    personaTerminales[idPersona] = terminal
    V(personas[idPersona])
  }
  V(mutex)
}
```

### 2

Resolver con SEMÁFOROS el siguiente problema.

En una empresa hay UN Coordinador y 30 Empleados que formarán 3 grupos de 10 empleados cada uno. Cada grupo trabaja en una sección diferente y debe realizar 345 unidades de un producto. Cada empleado al llegar se dirige al coordinador para que le indique el número de grupo al que pertenece y una vez que conoce este dato comienza a trabajar hasta que se han terminado de hacer las 345 unidades correspondientes al grupo (cada unidad es hecha por un único empleado). Al terminar de hacer las 345 unidades los 10 empleados del grupo se deben juntar para retirarse todos juntos. El coordinador debe atender a los empleados de acuerdo al orden de llegada para darle el número de grupo (a los 10 primeros que lleguen se le asigna el grupo 1, a los 10 del medio el 2, y a los 10 últimos el 3). Cuando todos los grupos terminaron de trabajar el coordinador debe informar (imprimir en pantalla) el empleado que más unidades ha realizado (si hubiese más de uno con la misma cantidad máxima debe informarlos a todos ellos).

> NOTA: maximizar la concurrencia; suponga que existe una función Generar() que simula
la elaboración de una unidad de un producto.

```txt
sem mutex = 1
cola llego
sem coordinador = 0
sem empleados[30] = ([30] 0)
sem grupos[3] = ([3] 0)
int empleadoMensaje[30] = ([30] 0)

Process Empleado[id:0..29] {
  int piezas = 0
  int grupo
  P(mutex)
  llego.push(id)
  V(mutex)
  V(coordinador)
  P(empleados[id])
  grupo = empleadoMensaje[id]
  P(grupos[grupo])
  while (piezasGrupo[grupo] > 0) {
    piezasGrupo[grupo] -= 1
    V(grupos[grupo])
    piezas += 1
    Generar()
    P(grupos[grupo])
  }
  V(grupos[grupo])
  empleadoMensaje[id] = piezas
  P(mutex)
  llego.push(id)
  V(mutex)
}

Process Coordinador {
  int maxPiezas = 0
  for (int i = 0; i < 3; i ++) {
    for (int j = 0; j < 10; j ++) {
      P(coordinador)
      P(mutex)
      int id = llego.pop()
      V(mutex)
      empleadoMensaje[id] = i
      V(empleados[id])
    }
    for (int j = 0; j < 10; j ++) {
      V(grupos[i])
    }
  }

  for (int i = 0; i < 30; i ++) {
    P(mutex)
    int id = llego.pop()
    V(mutex)
    if (empleadoMensaje[id] > maxPiezas) {
      maxPiezas = empleadoMensaje[id]
    }
  }

  for (int i = 0; i < 30; i ++) {
    if (empleadoMensaje[id] == maxPiezas) {
      imprimir(id)
    }
  }
}
```

### 3

Resolver con SEMÁFOROS el siguiente problema.

En un restorán trabajan C cocineros y M mozos. De forma repetida, los cocineros preparan un plato y lo dejan listo en la bandeja de platos terminados, mientras que los mozos toman los platos de esta bandeja para repartirlos entre los comensales. Tanto los cocineros como los mozos trabajan de a un plato por vez. Modele el funcionamiento del restorán considerando que la bandeja de platos listos puede almacenar hasta P platos. No es necesario modelar a los comensales ni que los procesos terminen

```txt
sem mutex = 1
sem cocineros = P
sem platos = 0

Process Cocinero[id:0..C-1] {
  while (true) {
    P(cocineros)

    // preparar plato

    P(mutex)

    // dejar plato

    P(mutex)
    V(platos)
  }
}

Process Mozo[id:0..M-1] {
  while (true) {
    P(platos)
    P(mutex)

    // toma el plato

    V(mutex)
    V(cocineros)

    // repartir plato
  }
}
```

### 4

Resolver con SEMAFOROS el siguiente problema.

Un banco decide entregar promociones a sus clientes por medio de su agente de prensa, el cual lo hace de la siguiente manera: el agente debe entregar 50 premios entre los 1000 clientes, para esto, obtiene al azar un número de cliente y le entrega el premio, una vez que este lo toma continúa con la entrega.

> NOTAS:
> - Cuando los 50 premios han sido entregados el agente y los clientes terminan su ejecución.
> - No se puede utilizar una estructura de tipo arreglo para almacenar los premios de los clientes.

### 5

Resolver con SEMAFOROS el siguiente problema.

Existen 15 sensores de temperatura y 2 módulos centrales de procesamiento. Un sensor mide la temperatura cada cierto tiempo (función medir()), la envía al módulo central para que le indique qué acción debe hacer (un número del 1 al 10) (función determinar() para el módulo central) y la hace (función realizar()). Los módulos atienden las mediciones por orden de llegada.


## Monitores

### 1

Resolver con MONITORES el siguiente problema:

En una elección estudiantil, se utiliza una máquina para voto electrónico. Existen N Personas que votan y una Autoridad de Mesa que les da acceso a la máquina de acuerdo con el orden de llegada, aunque ancianos y embarazadas tienen prioridad sobre el resto. La máquina de voto sólo puede ser usada por una persona a la vez.

> Nota: la función Votar() permite usar la máquina.

```txt
Monitor AutoridadMesa {
  bool maquinaLibre = true
  cond ancianosEmbarazadas
  int ancianosEmbarazadasEsperando = 0
  cond estudiantes
  int estudiantesEsperando = 0

  Procedure VotarAncianoEmbarazada() {
    if (!maquinaLibre) {
      ancianosEmbarazadasEsperando++
      wait(ancianosEmbarazadas)
      ancianosEmbarazadasEsperando--
    }
    maquinaLibre = false
  }

  Procedure VotarEstudiante() {
    if (!maquinaLibre) {
      estudiantesEsperando++
      wait(estudiantes)
      estudiantesEsperando--
    }
    maquinaLibre = false
  }

  Procedure TerminarVoto() {
    if (ancianosEmbarazadasEsperando > 0) {
      signal(ancianosEmbarazadas)
    }
    else if (estudiantesEsperando > 0) {
      signal(estudiantes)
    }
    else {
      maquinaLibre = true
    }
  }
}

Process Persona[id:0..N-1] {
  if (esAncianoOEmbarazada(id)) {
    AutoridadMesa.VotarAncianoEmbarazada()
  }
  else {
    AutoridadMesa.VotarEstudiante()
  }

  Votar()

  AutoridadMesa.TerminarVoto()
}
```

### 2

Resolver el siguiente problema utilizando monitores.

Un equipo de videoconferencia puede ser usado por una persona a la vez Hay P personas que utilizan este equipo (una unica vez cada uno) para su trabajo, de acuerdo a su prioridad. La prioridad de cada persona está dada por un numero entero positivo. Ademas existe un administrador que cada 3hs incrementa en 1 la prioridad de todas las personas que están esperando usar el equipo.

> NOTA: maximizar la concurrencia.

```txt
Monitor Equipo {
  cola esperando // (id, prioridad) ordenada por prioridad
  cond personas[P]
  bool equipoLibre = true

  Procedure usar(int id, int prioridad) {
    if (!equipoLibre) {
      esperando.push((id, prioridad))
      wait(personas[prioridad])
    }
    equipoLibre = false
  }

  Procedure liberar() {
    if (esperando.empty()) {
      equipoLibre = true
    }
    else {
      int id, prioridad = esperando.pop()
      signal(personas[prioridad])
    }
  }

  Procedure incrementarPrioridad() {
    cola nuevaEsperando
    while (!esperando.empty()) {
      int id, prioridad = esperando.pop()
      prioridad++
      nuevaEsperando.push((id, prioridad))
    }
    esperando = nuevaEsperando
  }
}

Process Persona[id:0..P-1] {
  int prioridad = obtenerPrioridad(id)
  Equipo.usar(id, prioridad)
  // usar equipo
  Equipo.liberar()
}

Process Administrador {
  while (true) {
    delay(3 * 60 * 60) // esperar 3hs
    Equipo.incrementarPrioridad()
  }
}
```

### 3

Resolver con monitores la siguiente situación.

En la guardia de traumatología de un hospital trabajan 5 médicos y una enfermera. A la guardia acuden P Pacientes que al llegar se dirigen a la enfermera para que le indique a que médico se debe dirigir y cuál es su gravedad (entero entre 1 y 10). Cuando tiene estos datos se dirige al médico correspondiente y espera hasta que lo termine de atender para retirarse. Cada médico atiende a sus pacientes en orden de acuerdo a la gravedad de cada uno.

> Nota: maximizar la concurrencia.

```txt
Process Paciente[id:0..P-1] {
  int idMedico, gravedad
  Enfermera.solicitar(idMedico, gravedad)
  Guardia.atender(id, medico, gravedad)
}

Process Medico[id:0..4] {
  int idPaciente
  while (true) {
    Guardia.siguientePaciente(id, idPaciente)
    // atiende al paciente
    Guardia.terminarAtencion(id, idPaciente)
  }
}

Monitor Enfermera {
  Procedure solicitar(medico: out int, gravedad: out int) {
    medico = asignarMedico() // asigna un medico al azar del 0 al 4
    gravedad = diagnosticarGravedad()
  }
}

Monitor Guardia {
  cond pacientes[5]
  cola pacientesEsperando[5] // (idPaciente, gravedad) ordenada por gravedad
  cond medicos[5]
  cond terminoAtencion[5]

  Procedure atender(idMedico: in int, idPaciente: in int, gravedad: in int) {
    if (!pacientes[idMedico].empty()) {
      pacientes[idMedico].push((idPaciente, gravedad))
      wait(pacientes[idMedico])
    }
    else {
      signal(medicos[idMedico])
    }
    wait(terminoAtencion[idMedico])
  }

  Procedure siguientePaciente(idMedico: in int, idPaciente: out int) {
    if (pacientesEsperando[idMedico].empty()) {
      wait(medicos[idMedico])
    }
    idPaciente, gravedad = pacientesEsperando[idMedico].pop()
    signal(pacientes[idMedico])
  }

  Procedure terminarAtencion(idMedico: in int) {
    signal(terminoAtencion[idMedico])
  }
}
```

### 4

Resolver con MONITORES el siguiente problema.

En una planta verificadora de vehículos existen 5 estaciones de verificación. Hay 75 vehículos que van para ser verificados, cada uno conoce el número de estación a la cual debe ir. Cada vehículo se dirige a la estación correspondiente y espera a que lo atiendan. Una vez que le entregan el comprobante de verificación, el vehículo se retira. Considere que en cada estación se atienden a los vehículos de acuerdo con el orden de llegada.

> Nota: maximizar la concurrencia.

### 5

Resolver con MONITORES el siguiente problema.

Una boletería vende E entradas para un partido, y hay P personas (P>E) que quieren comprar. Se las atiende por orden de llegada y la función vender() simula la venta. La boletería debe informarle a la persona que no hay más entradas disponibles o devolverle el número de entrada si pudo hacer la compra.
