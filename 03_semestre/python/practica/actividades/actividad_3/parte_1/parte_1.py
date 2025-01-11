class Vacunas:
	def __init__(self, nom, lab):
		self._nombre = nom
		self._laboratorio = lab
		
	def get_nombre(self):
		return self._nombre		
	
	def set_nombre(self, valor):
		self._nombre = valor	
			
	def informacion (self):
		return (f'Laboratorio de fabricación: {self._laboratorio }')

	nombre = property(set_nombre, get_nombre)
	
class VacunaCovid(Vacunas):
	def __init__(self, nom, lab, cant, tip):
		super().__init__ (nom, lab)
		self._cantidad = cant
		self._tipo = tip
	
	@property
	def cantidad (self):
		return self._cantidad

	@cantidad.setter
	def cantidad(self, cant):
		self._cantidad = cant

	@property
	def tipo(self):
		return self._tipo

	@tipo.setter
	def tipo(self, tip):
		self._tipo = tip
		
		
lista_vacunas = [
    VacunaCovid('Sputnik', 'xx',100, 'COVID'),
    VacunaCovid('Moderna', 'zz', 50, 'COVID'),
    VacunaCovid ('Flucelvax','dd', 1000, 'GRIPE')
]

for i in range (3):
	if lista_vacunas[i].cantidad < 90:
		print (f'Faltan vacunas {lista_vacunas[i].nombre} para {lista_vacunas[i].tipo}. {lista_vacunas[i].informacion()}')
		respuesta = input (f'Si ingresaron vacunas de {lista_vacunas[i].nombre} ingrese cantidad. 0 si no ingresaron: ')
		if respuesta.isnumeric():
			lista_vacunas[i].cantidad += int(respuesta)
