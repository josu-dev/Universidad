class Pila:
   """ Implementa el tipo de datos Pila """

   def __init__(self):
       self.items = []

   def es_vacia(self):
       return self.items == []

   def apilar(self, item):
       self.items.append(item)

   def desapilar(self):
       return self.items.pop()

   def tope(self):
       return self.items[len(self.items) - 1]

   def cantidad_elementos(self):
       return len(self.items)
