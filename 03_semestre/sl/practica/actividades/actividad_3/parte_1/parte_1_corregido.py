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

	nombre = property(get_nombre, set_nombre)
	
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

for vacuna in lista_vacunas:
    if vacuna.cantidad < 90:
        print (f'Faltan vacunas {vacuna.nombre} para {vacuna.tipo}. {vacuna.informacion()}')
        respuesta = input (f'Si ingresaron vacunas de {vacuna.nombre} ingrese cantidad. 0 si no ingresaron: ')
        while not respuesta.isnumeric():
            respuesta = input (f'{respuesta} no es un numero, intente nuevamente: ')
        vacuna.cantidad += int(respuesta)