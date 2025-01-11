# Repaso 1

## PMS

### Ejercicio 1

1 - Resolver con PMA el siguiente problema. En un gimnasio hay tres máquinas iguales que pueden ser utilizadas para hacer ejercicio o rehabilitación. 
Hay E personas que quieren usar cualquiera de esas máquinas para hacer ejercicio, y R personas que las quieren usar para hacer rehabilitación. 
Siempre tienen prioridad aquellas que la quieran usar para realizar rehabilitación. Cuando una persona toma una máquina la usa por 10 minutos y se retira.


```txt

chan usar_maquina(int, texto)

chan usar_ejercicio[E](int)
chan usar_rehabilitacion[R](int)

Process Coordinador {
  int maquinaEnUso[3] = ([3], false)
  int enUso = 0;
  int id, idPersona;
  
  queue ejercicio(int)
  queue rehabilitacion(int)

  while (true) {
    receive usar_maquina(id, tipo)
    if (tipo == "liberar") {
      maquinaEnUso[id] = false
      enUso--
    }
    else if (tipo == "ejercicio") {
      ejercicio.push(id)
    }
    else if (tipo == "rehabilitacion") {
      rehabilitacion.push(id)
    }

    if (enUso < 3) {
      if (not rehabilitacion.empty()) {
        idPersona = rehabilitacion.pop()
        id = maquinaEnUso.index(false)
        maquinaEnUso[id] = true
        enUso++
        send usar_rehabilitacion[idPersona](id)
      }
      else if (not ejercicio.empty()) {
        idPersona = ejercicio.pop()
        id = maquinaEnUso.index(false)
        maquinaEnUso[id] = true
        enUso++
        send usar_ejercicio[idPersona](id)
      }
    }
  }
}

Process PRehabilitacion[id:0..R-1] {
  int idMaquina;
  send usar_maquina(id, "rehabilitacion")
  receive usar_rehabilitacion[id](idMaquina)
  // usar maquina
  send usar_maquina(idMaquina, "liberar")
}


Process PEjercicio[id:0..E-1] {
  int idMaquina;
  send usar_maquina(id, "ejercicio")
  receive usar_ejercicio[id](idMaquina)
  // usar maquina
  send usar_maquina(idMaquina, "liberar")
}
```


### Ejercicio 2

Resolver con PMA el siguiente problema.

Se debe modelar el funcionamiento de una casa de venta de repuestos automotores, en la que trabajan V vendedores y que debe atender a C clientes. El modelado debe considerar que:
- (a) cada cliente realiza un pedido y luego espera a que se lo entreguen;
- y (b) los pedidos que hacen los clientes son tomados por cualquiera de los vendedores. Cuando no hay pedidos para atender, los vendedores aprovechan para controlar el stock de los repuestos (tardan entre 2 y 4 minutos para hacer esto).

> Nota: maximizar la concurrencia.

```txt
chan vendedorLibre(int)
chan vendedores[V](id, string)

chan pedidos(int, string)
chan clientes[C](string)

Process Coordinador {
  string pedido;
  int idVendedor, idCliente;

  while (true) {
    receive vendedorLibre(idVendedor)
    if (empty(pedidos)) {
      send vendedores[idVendedor](-1, "controlar stock")
    }
    else {
      receive pedidos(idCliente, pedido)
      send vendedores[idVendedor](idCliente, pedido)
    }
  }
}

Process Vendedor[id:0..V-1] {
  string pedido;
  int idCliente;

  while (true) {
    send vendedorLibre(id)
    receive vendedores[id](idCliente, pedido)
    if (idCliente == -1) {
      delay ((2 + random(2)) * 60) // controlar stock
    }
    else {
      // atender pedido
      send clientes[idCliente](pedido)
    }
  }
}

Process Cliente[id:0..C-1] {
  string pedido = "un pedido"
  send pedidos(id, pedido)
  receive clientes[id](pedido)
  // se va
}
```


## PMS

### Ejercicio 1

Resolver con PMS el siguiente problema: Se debe administrar el acceso para usar en determinado Servidor donde no se permite más de 10 usuarios trabajando al mismo tiempo, por cuestiones de rendimiento. Existen N usuarios que solicitan acceder al Servidor, esperan hasta que se les de acceso para trabajar en él y luego salen del mismo.

> Nota: suponga que existe una función TrabajarEnServidor() que llaman los usuarios para representar que están trabajando en el Servidor

```txt
Process Persona[id:0..N-1] {
  Coordinador!acceso(id)
  Coordinador?usar()

  TrabajarEnServidor()
  
  Coordinador!liberar()
}

Process CoordinadorConOrden {
  int enUso = 0;
  queue acceso(int)

  do (enUso < 10 and acceso.empty()); Persona[*]?acceso(idPersona) -> {
    enUso++
    Persona[idPersona]!usar()
  }
  [] (not acceso.empty()); Persona[*]?acceso(idPersona) -> {
    acceso.push(idPersona)
  }
  [] Persona[*]?liberar() -> {
    enUso--
    if (not acceso.empty()) {
      idPersona = acceso.pop()
      Persona[idPersona]!usar()
      enUso++
    }
  }
}

Process CoordinadorSinOrden {
  int enUso = 0;
  int idPersona;

  do (enUso < 10); Persona[*]?acceso(idPersona) -> {
    enUso++
    Persona[idPersona]!usar()
  }
  [] Persona[*]?liberar() -> {
    enUso--
  }
}
```

### Ejercicio 2

Resolver con PASAJE DE MENSAJES SINCRÓNICO (PMS).

En una estación de comunicaciones se cuenta con 10 Radares, UNA Unidad de Detección, y UN Reconocedor. Cada radar repetidamente detecta señales de radio durante 15 segundos y le envía esos datos a la Unidad de Detección para que los analice. Los radares no deben esperar ningún resultado (deben volver a tomar señales lo antes posible). La Unidad de Detección, toma de a una las señales enviadas por los radares (según el orden de llegada), realiza un preprocesamiento para limpiar la señal (simular esta operación mediante la función PREPROCESAR(señal)) y envía el resultado al Reconocedor para que termine de analizar la señal (simular esta operación mediante la función ANALIZAR(señal)) y se queda esperando el resultado de este análisis para determinar el resultado final.

> Nota: Maximizar la concurrencia.

```txt
Process Reconocedor {
  string resultado
  while (true) {
    UnidadDeteccion?analizar(señal)
    resultado = ANALIZAR(señal)
    UnidadDeteccion!resultado(resultado)
  }
}

Process UnidadDeteccion {
  string señal, resultado
  while (true) {
    Coordinador!solicitud()
    Coordinador?señal(señal)

    señal = PREPROCESAR(señal)
    
    Reconocedor!analizar(señal)
    Reconocedor?resultado(resultado)
    
    // hacer algo con el resultado
  }
}

Process Radar[id:0..9] {
  string señal
  while (true) {
    delay 15 // tomar señales
    Coordinador!señal(señal)
  }
}

Process Coordinador {
  string señal
  queue señales(string)

  do Radar[*]?señal(señal) -> {
    señales.push(señal)
  }
  [] (not señales.empty()); UnidadDeteccion?solicitud() -> {
    señal = señales.pop()
    UnidadDeteccion!señal(señal)
  }
  od
}
```

## Rendezvous

### Ejercicio 1

Resolver con ADA la siguiente situación.

En una obra social que tiene 15 sedes en diferentes lugares se tiene información de las enfermedades de cada uno de sus clientes (cada sede tiene sus propios datos). Se tiene una Central donde se hacen estadísticas, y para esto repetidamente elige una enfermedad y debe calcular la cantidad total de clientes que la han tenido. Esta información se la debe pedir a cada Sede. Maximizar la concurrencia.

> Nota: existe una función ElegirEnfermos(e) que es llamada por cada Sede y devuelve la cantidad de clientes de esa sede que han tenido la enfermedad e.

```ada
Procedure ObraSocial is
  task type Sede is
    -- entry Identificador(id: out Integer)
  end Sede;

  sedes: array(1..15) of Sede;

  task Central is
    entry Listo;
    entry Pedido(e: in String)
    entry Enfermos(c: in Integer)
  end Central;

  task body Sede is
    id: Integer;
    enfermos: integer;
  begin
    accept Identificador(identificador: out Integer) do
      id := identificador;
    end Identificador;

    loop
      -- Central.Listo;
      Central.Pedido(e);
      enfermos := ElegirEnfermos(e);
      Central.Enfermos(enfermos);
    end loop;
  end Sede;

  task body Central is
    totalEnfermos: int;
  begin
    loop
      for i in 1..15 loop
        accept Pedido(e: in String) do
          e := UnaEnfermedad();
        end Pedido;
      end loop;

      totalEnfermos = 0;

      for i in 1..15 loop
        accept Enfermos(c: in Integer) do
          totalEnfermos := totalEnfermos + c;
        end Enfermos;
      end loop;

      -- hacer algo con totalEnfermos
    end loop;
  end Central;

  tasl body CentralMasEficiente is
    totalEnfermos: int;
    enfermedad: String;
  begin
    loop
      for i in 1..15 loop
        accept Listo();
      end loop;

      enfermedad := UnaEnfermedad();
      totalEnfermos := 0;

      for i in 1..30 loop
        select
          accept Pedido(e: in String) do
            e := UnaEnfermedad();
          end Pedido;
        or
          accept Enfermos(c: in Integer) do
            totalEnfermos := totalEnfermos + c;
          end Enfermos;
        end select;
      end loop;

      -- hacer algo con totalEnfermos
    end loop;
  end Central;

begin
  -- for i in 1..15 loop
  --   sedes(i).Identificador(i);
  -- end loop;
  null;
end;
```

### Ejercicio 2

Resolver con ADA el siguiente problema.

Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar un pago y llevarse su comprobante. Los clientes se dividen entre los regulares y los premium, habiendo R clientes regulares y P clientes premium. Existe un único empleado en el banco, el cual atiende de acuerdo al orden de llegada, pero dando prioridad a los premium sobre los regulares. Si a los 30 minutos de llegar un cliente regular no fue atendido, entonces se retira sin realizar el pago. Los clientes premium siempre esperan hasta ser atendidos

```ada
procedure Banco is
  task type ClienteRegular is
    entry Identificador(id: out Integer)
    entry Pagar
  end ClienteRegular;

  clientesRegulares: array(1..R) of ClienteRegular;

  task type ClientePremium is
    entry Identificador(id: out Integer)
    entry Pagar
  end ClientePremium;

  clientesPremium: array(1..P) of ClientePremium;

  task Empleado is
    entry Recibo(recibo: in String)
  end Empleado;

  task MesaEntrada is
    entry llegoRegular(id: in Integer)
    entry llegoPremium(id: in Integer)
  end MesaEntrada;

  task body ClienteRegular is
    id: Integer;
    reciboPago : String;
  begin
    accept Identificador(identificador: out Integer) do
      id := identificador;
    end Identificador;
    
    MesaEntrada.llegoRegular(id);
    
    select
      accept Pagar(recibo: in String) do
        reciboPago := recibo
      end Pagar;
    or delay 30 * 60;
      null;
    end select;
  end ClienteRegular;

  task body ClientePremium is
    id: Integer;
    reciboPago : String;
  begin
    accept Identificador(identificador: out Integer) do
      id := identificador;
    end Identificador;
    
    MesaEntrada.llegoPremium(id);
    
    accept Pagar(pago: out String) do
      pago := "un pago"
    end Pagar;
    Empleado.Recibo(reciboPago);
  end ClientePremium;

  task body Empleado is
    id: Integer;
    recibo, pago : String;
  begin
    loop
      MesaEntrada.siguiente(id, tipo, pago);
      if (tipo == "regular") then
        clientesRegulares(id).Pagar(pago);
        recibo = generarRecibo(pago)
        accept Recibo(recibo: in String) do
          reciboPago := recibo
        end clientesRegulares;
      else
        clientesPremium(id).Pagar(reciboPago);
        recibo = generarRecibo(pago)
        accept Recibo(recibo: in String) do
          reciboPago := recibo
        end clientesPremium;
      end if;
    end loop;
  end Empleado;

  task body MesaEntrada is
    queue regulares(Integer)
    queue premium(Integer)
    id: Integer;
    tipo: String;
  begin
    loop
      select
        when (llegoPremium'Count = 0) => accept llegoRegular(id: in Integer) do
          regulares.push(id);
        end llegoRegular;
      or
        accept llegoPremium(id: in Integer) do
          premium.push(id);
        end llegoPremium;
      or
        when (not premium.empty() or not regular.empty()) =>
          accept siguiente(id: out Integer, tipo: out String) do
            if (not premium.empty()) then
              id = premium.pop();
              tipo = "premium";
            else
              id = regulares.pop();
              tipo = "regular";
            end if;
        end siguiente;
      end select;
    end loop;
  end MesaEntrada;

begin
  for i in 1..R loop
    ClienteRegular(i);
  end loop;
  for i in 1..P loop
    ClientePremium(i);
  end loop;
end;
```
