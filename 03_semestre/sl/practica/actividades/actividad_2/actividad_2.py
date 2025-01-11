#Información de cada artículo: precio y cantidades de stock en sucursal 1 y 2
articulos = {
			"pollera": [500, (100,170)],
			"camisa": [700, (50,100)],
			"pantalón": [1200, (30,110)]
			}
def aplicar_descuentos(articulo, porcentaje):
	try:
		for arti in articulo:
			articulo[arti][0] = articulo[arti][0] * porcentaje / 100
	except KeyError:
		print ('Usp.. se produjo un error con el artículo')	
			
porcentaje = int(input('Ingresa el porcentaje de descuento del día a aplicar a los artículos: '))

try:
	aplicar_descuentos(articulos, porcentaje)
	resp = input ('Querés saber a cuánto te quedó un artículo?  S/N   ').upper()
	if resp == 'S':
		try:
			arti = input ('Ingresa pollera, camisa o pantalón     ')
			print (f'El artículo {arti} ahora te queda a {articulos[arti][0] } pesos' )
		except TypeError:
			print("Creo que te equivocaste con los tipos de datos")
		finally:
			print ('Estás contento con el descuento?')
except:
	print("Se produjo un error!!")
