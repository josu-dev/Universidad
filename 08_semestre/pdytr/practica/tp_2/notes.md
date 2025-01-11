## vagrant

```sh
# deletes vms and associated resources
vagrant destroy
```

## exercices

1) Buscar y utilizar en vagrant una version mas reciente de Ubuntu LTS que la dada en la explicacion de practica. Identificar version, origen y si tuviera diferencias, explicar brevemente.

La box provista por la practica es `hashicorp/bionic64`, la cual es una version de Ubuntu 18.04 LTS la cual parte de un template provisto por el proyecto Bento. Hosteada en Vagrant Cloud.

Para utilizar una version mas reciente de Ubuntu LTS, se puede utilizar la box `ubuntu/jammy64`, la cual es una version de Ubuntu 22.04 LTS. Esta box es provista por el proyecto oficial de Ubuntu. Hosteada en cloud-images.ubuntu.com

Entre las diferencias mas notables entre ambas versiones se encuentran las siguientes:

- Kernel: Ubuntu 22.04 LTS utiliza el kernel 5.15, mientras que Ubuntu 18.04 LTS utiliza el kernel 4.15.
- Soporte: Ubuntu 22.04 LTS tiene soporte hasta 2027, mientras que Ubuntu 18.04 LTS tiene soporte hasta 2023.
- 

2) En caso de haber hecho los experimentos de tiempos de comunicaciones de la practica 1 en una unica computadora, rehacer el experimento de manera tal que se utilicen 2 computadoras. Aclare si las computadoras estan en la misma red local o en dos redes locales diferentes (en este ultimo caso, es posible que deban modificar al menos un router si ambas computadoras tienen acceso vıa NAT). Pueden utilizar las computadoras del aula o sus propias computadoras. En todos los casos provean una descripcion mınima de las computadoras usadas (CPU, RAM, OS).

Se utilizaron dos computadoras en la misma red local para realizar los experimentos de tiempos de comunicaciones. Las caracteristicas de las computadoras son las siguientes:

- **PC Servidor**
  - CPU: Intel Celeron N4000 (2 cores, 2 threads, 1.1 GHz)
  - RAM: 4GB
  - OS: Linux Mint (Version 21.2)
- **PC Cliente**
  - CPU: AMD Ryzen 7 1700 (8 cores, 16 threads, 3.0 GHz)
  - RAM: 16GB
  - OS: Windows 11 Pro N (Version 23H2)

En cuanto al experimento realizado, los programas del servidor y cliente son los mismos utilizados previamente. Para la ejecucion se utilizaron los scripts bash previos modificados para poder pasar la IP del servidor como argumento. Se ejecuto el servidor en la PC Servidor y el cliente en la PC Cliente realizando las cien mediciones por escenario de comunicacion (10^1, ..., 10^6 bytes de tranferencia en ambos sentidos).

Los resultados obtenidos en el experimento con computadoras diferentes son representados por los siguientes graficos

A modo de referencia adjuntamos los graficos de ejecucion en la misma maquina

Se puede observar que los tiempos de comunicacion son mayores, en el orden de una magnitud mayor, en la ejecucion en computadoras diferentes con respecto a la ejecucion dentro de una misma, lo cual es esperable debido a que la comunicacion se realiza a traves de la red local implicando que los mensajes deban salir de un equipo y llegar al otro con lo que esto representa, como la latencia de la red, la congestion de la misma, entre otros motivos. A su vez, los tiempos tambien se ven afectados por la diferencia en capacidades de procesamiento de las computadoras utilizadas en el experimento ya que la PC Servidor posee caracteristicas inferiores a la PC Cliente por lo que puede ser un factor a tener en cuenta en la degradacion de los tiempos de comunicacion.


3) Teniendo en cuenta los experimentos de tiempos realizados, desarrollar scripts para desplegar un ambiente de experimentacion de comunicaciones en una computadora con Vagrant para los siguientes escenarios:
a. Dos maquinas virtuales, cada una con un proceso de comunicaciones.

Para la ejecucion del experimento en el escenario de dos maquinas virtuales se utilizo el script de PowerShell `run_a.ps1` el cual se encarga de levantar dos maquinas virtuales identicas. Luego en la primera de ellas se levanta el servidor atraves de la ejecucion remota mediante ssh a esta maquina, poteriormete despues de un delay con la funcion principal de esperar a que el servidor este listo para recibir conexiones, se levanta el cliente en la segunda maquina virtual siguiendo el mismo procedimiento que el servidor.

Los resultados obtenidos en el experimento con dos maquinas virtuales, una para cada proceso de comunicacion, son representados por los siguientes graficos

b. Una maquina virtual con uno de los procesos de comunicaciones y el otro proceso de comunicaciones en el host.

Para la escucion del experimento en el escenario de una maquina virtual con uno de los procesos de comunicaciones y el otro proceso de comunicaciones en el host se utilizo el script de PowerShell `run_b.ps1` el cual se encarga de levantar una maquina virtual en la cual se levanta el servidor y luego en el host se levanta el cliente. A la hora de la ejecucion del cliente por algun motivo que se desconoce no era posible que funcionara bien el cliente desde el script por lo que para el experimento solo se levanto el servidor con el script y luego se ejecuto el cliente manualmente desde el host.

Los resultados obtenidos en el experimento con una maquina virtual con uno de los procesos de comunicaciones y el otro proceso de comunicaciones en el host son representados por los siguientes graficos

En todos los casos deberıan dejar los resultados disponibles para su posterior analisis.

4) Explique si los resultados de tiempo de comunicaciones del experimento del ej. anterior se ven afectados por el orden de ejecucion y las diferencias de tiempo de ejecucion iniciales de los programas utilizados ¿que sucede si por alguna razon hay una diferencia de 10 segundos en el inicio de la ejecucion entre un programa y otro?. Sugerencia: incluya un “sleep” de 10 segundos entre la ejecucion de diferentes partes de los programas y comente.

ee

## Referencias

- [Vagrant boxes](https://developer.hashicorp.com/vagrant/docs/boxes)
- [Ubuntu boxes](https://app.vagrantup.com/ubuntu/boxes)
- [Ubuntu versions](https://wiki.ubuntu.com/Releases)
