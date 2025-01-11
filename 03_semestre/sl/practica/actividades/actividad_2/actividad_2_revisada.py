#Información de cada artículo: precio y cantidades de stock en sucursal 1 y 2
articulos = {
			"pollera": [500, (100,170)],
			"camisa": [700, (50,100)],
			"pantalón": [1200, (30,110)]
			}

def aplicar_descuentos(articulo:dict[str,list[int, tuple[int,int]]], porcentaje: int):
    for arti in articulo:
        articulo[arti][0] = articulo[arti][0] * porcentaje // 100

try:
    porcentaje = int(input('Ingresa el porcentaje de descuento del día a aplicar a los artículos: '))

    aplicar_descuentos(articulos, porcentaje)
    resp = input('Querés saber a cuánto te quedó un artículo?  S/N: ').upper()
    if resp in ('S', 'SI'):
        arti = input ('Ingresa pollera, camisa o pantalón     ')

        if arti in articulos:
            print (f'El artículo {arti} ahora te queda a {articulos[arti][0] } pesos' )
            print ('Estás contento con el descuento?')
        else:
            print('No se ingreso un articulo valido')
    
except ValueError:
    print('Se ingreso un valor que no es un numero')

