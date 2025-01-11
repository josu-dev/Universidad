# Algunos incisos de la practica

## 7

- boxer, pantalones, medias, zapatos, camisa, cinturon, corbata, saco

- medias, boxer, pantalones, camisa, cinturon, corbata, saco, zapatos

- camisa, boxer, pantalones, medias, zapatos, cinturon, corbata, saco

| boxer | camisa | cinturon | corbata | medias | pantalones | reloj | saco | zapatos |
| - | - | - | - | - | - | - | - | - |
| 0 | 0 | 2 | 2 | 0 | 1 | 0 | 1 | 3 |

| boxer | camisa | cinturon | corbata | medias | pantalones | reloj | saco | zapatos |
| - | - | - | - | - | - | - | - | - |
| 0- | 0- | 0- | 0- | 0- | 0- | 0- | 0- | 0- |
- boxer, camisa, medias, pantalones, cinturon, corbata, reloj, saco, zapatos

## 8

1. Ejemplo

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | inf | 0 | 0 |
    | 3 | 40 | 1 | 0 |
    | 2 | inf | 0 | 0 |
    | 5 | 10 | 1 | 0 |
    | 6 | 5 | 1 | 0 |

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | 25 | 6 | 0 |
    | 3 | 40 | 1 | 0 |
    | 2 | inf | 0 | 0 |
    | 5 | 10 | 1 | 0 |
    | 6 | 5 | 1 | 1 |

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | 25 | 6 | 0 |
    | 3 | 40 | 1 | 0 |
    | 4 | 30 | 5 | 0 |
    | 5 | 10 | 1 | 1 |
    | 6 | 5 | 1 | 1 |

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | 25 | 6 | 1 |
    | 3 | 40 | 1 | 0 |
    | 4 | 30 | 5 | 0 |
    | 5 | 10 | 1 | 1 |
    | 6 | 5 | 1 | 1 |

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | 25 | 6 | 1 |
    | 3 | 35 | 4 | 0 |
    | 4 | 30 | 5 | 1 |
    | 5 | 10 | 1 | 1 |
    | 6 | 5 | 1 | 1 |

    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | 0 | 0 | 1 |
    | 2 | 25 | 6 | 1 |
    | 3 | 35 | 4 | 1 |
    | 4 | 30 | 5 | 1 |
    | 5 | 10 | 1 | 1 |
    | 6 | 5 | 1 | 1 |

---

1. 
    - -
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | i | - | 0 |
        | 1 | i | - | 0 |
        | 2 | i | - | 0 |
        | 3 | i | - | 0 |
        | 4 | i | - | 0 |

    - 3
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | 1 | 3 | 0 |
        | 1 | i | - | 0 |
        | 2 | i | - | 0 |
        | 3 | 0 | 0 | 1 |
        | 4 | 3 | 3 | 0 |

    - 0
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | 1 | 3 | 1 |
        | 1 | i | - | 0 |
        | 2 | 2 | 0 | 0 |
        | 3 | 0 | - | 1 |
        | 4 | 3 | 3 | 0 |

    - 2
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | 1 | 3 | 1 |
        | 1 | i | - | 0 |
        | 2 | 2 | 0 | 1 |
        | 3 | 0 | - | 1 |
        | 4 | 3 | 3 | 0 |

    - 4
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | 1 | 3 | 1 |
        | 1 | 5 | 4 | 0 |
        | 2 | 2 | 0 | 1 |
        | 3 | 0 | - | 1 |
        | 4 | 3 | 3 | 1 |

    - 1
        | V | Dv | Pv | conoc. |
        | - | - | - | - |
        | 0 | 1 | 3 | 1 |
        | 1 | 5 | 4 | 1 |
        | 2 | 2 | 0 | 1 |
        | 3 | 0 | - | 1 |
        | 4 | 3 | 3 | 1 |

    1. No sirve para pesos negativos ya que puede romper el criterio de seleccion de minimos debido a que este funciona asumiendo que los caminos tienen costos incrementales o iguales hacia sus adyacentes (si no puede pasar que un camino evaluado a fuero tenga un costo menor y hubiera que volver a actualizar todo.)

    1. 
        - Arreglo v^2

        - Heap e.log(v)

# 9

1. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - |  i | 40 |  i | 10 |  5 |
    | 2 |  i |  - |  i |  5 |  i |  i |
    | 3 |  i | 10 |  - |  i |  5 |  i |
    | 4 |  i |  i |  5 |  - |  i |  i |
    | 5 |  i |  i |  i | 20 |  - |  i |
    | 6 |  i | 20 |  i |  i | 10 |  - |

2. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - |  i | 40 |  i | 10 |  5 |
    | 2 |  i |  - |  i |  5 |  i |  i |
    | 3 |  i | 10 |  - | 15 |  5 |  i |
    | 4 |  i |  i |  5 |  - |  i |  i |
    | 5 |  i |  i |  i | 20 |  - |  i |
    | 6 |  i | 20 |  i | 25 | 10 |  - |

3. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - | 50 | 40 | 55 | 10 |  5 |
    | 2 |  i |  - |  i |  5 |  i |  i |
    | 3 |  i | 10 |  - | 15 |  5 |  i |
    | 4 |  i | 15 |  5 |  - | 10 |  i |
    | 5 |  i |  i |  i | 20 |  - |  i |
    | 6 |  i | 20 |  i | 25 | 10 |  - |

4. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - | 50 | 40 | 55 | 10 |  5 |
    | 2 |  i |  - | 10 |  5 | 15 |  i |
    | 3 |  i | 10 |  - | 15 |  5 |  i |
    | 4 |  i | 15 |  5 |  - | 10 |  i |
    | 5 |  i | 35 | 25 | 20 |  - |  i |
    | 6 |  i | 20 | 30 | 25 | 10 |  - |

5. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - | 45 | 35 | 30 | 10 |  5 |
    | 2 |  i |  - | 10 |  5 | 15 |  i |
    | 3 |  i | 10 |  - | 15 |  5 |  i |
    | 4 |  i | 15 |  5 |  - | 10 |  i |
    | 5 |  i | 35 | 25 | 20 |  - |  i |
    | 6 |  i | 20 | 30 | 25 | 10 |  - |

6. 
    |   |  1 |  2 |  3 |  4 |  5 |  6 |
    | - |  - |  - |  - |  - |  - |  - |
    | 1 |  - | 25 | 35 | 30 | 10 |  5 |
    | 2 |  i |  - | 10 |  5 | 15 |  i |
    | 3 |  i | 10 |  - | 15 |  5 |  i |
    | 4 |  i | 15 |  5 |  - | 10 |  i |
    | 5 |  i | 35 | 25 | 20 |  - |  i |
    | 6 |  i | 20 | 30 | 25 | 10 |  - |

# 10

1. Dijkstra

1. Arbol:

    ![](dijkstra.png)

# 11

- H
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b | 11 |  h |  0 |
    |  c |  i |  0 |  0 |
    |  d |  i |  0 |  0 |
    |  e |  i |  0 |  0 |
    |  f |  i |  0 |  0 |
    |  g |  1 |  h |  0 |
    |  h |  0 |  0 |  1 |
    |  i |  7 |  h |  0 |

- G
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b | 11 |  h |  0 |
    |  c |  i |  0 |  0 |
    |  d |  i |  0 |  0 |
    |  e |  i |  0 |  0 |
    |  f |  2 |  g |  0 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  6 |  g |  0 |

- F
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b | 11 |  h |  0 |
    |  c |  4 |  f |  0 |
    |  d | 14 |  f |  0 |
    |  e | 10 |  f |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  6 |  g |  0 |

- C
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b |  8 |  c |  0 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  0 |
    |  e | 10 |  f |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  0 |

- I
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b |  8 |  c |  0 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  0 |
    |  e | 10 |  f |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  1 |

- D
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  0 |
    |  b |  8 |  c |  0 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  1 |
    |  e |  9 |  d |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  1 |

- A
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  1 |
    |  b |  4 |  a |  0 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  1 |
    |  e |  9 |  d |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  1 |

- B
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  1 |
    |  b |  4 |  a |  1 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  1 |
    |  e |  9 |  d |  0 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  1 |

- E
    | V | Costo | W | Conoc. |
    |  - |  - |  - |  - |
    |  a |  8 |  h |  1 |
    |  b |  4 |  a |  1 |
    |  c |  4 |  f |  1 |
    |  d |  7 |  c |  1 |
    |  e |  9 |  d |  1 |
    |  f |  2 |  g |  1 |
    |  g |  1 |  h |  1 |
    |  h |  0 |  0 |  1 |
    |  i |  2 |  c |  1 |

# 12

### Tuplas minimas:
- h,g
- g,f
- i,c
- a,b
- c,f
- i,g
- c,d
- h,i
- a,h
- b,c
- d,e
- f,e
- b,h
- f,d

![](krustal.png)


<br>


# Notas

Krustal y Prim hacen lo mismo con diferente algoritmo.

- 
    | V | Dv | Pv | conoc. |
    | - | - | - | - |
    | 1 | i | - | 0 |
    | 2 | i | - | 0 |
    | 3 | i | - | 0 |