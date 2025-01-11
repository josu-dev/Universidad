programa P1_1_a
procesos
  proceso juntarFlor (ES flor: numero; ES noFlor: numero)
  comenzar
    si HayFlorEnLaEsquina
      mientras HayFlorEnLaEsquina
        tomarFlor
        flor:= flor + 1
    sino
      noFlor:= noFlor +1
  fin
  
areas
  ciudad : AreaP(1,1,5,100)
robots 
  robot tipo1
  variables
    flor: numero
    noFlor: numero
    av: numero
  comenzar
    av:= 1
    repetir 3
      flor:= 0
      noFlor:= 0
      Pos(av,1)
      juntarFlor(flor, noFlor)
      repetir 99
        mover
        juntarFlor(flor, noFlor)
      repetir flor
        depositarFlor
      Informar(flor)
      Informar(noFlor)
      av:= av + 2
  fin
variables 
  robot1: tipo1
comenzar 
  AsignarArea(robot1,ciudad)
  Iniciar(robot1, 1, 1)
fin
