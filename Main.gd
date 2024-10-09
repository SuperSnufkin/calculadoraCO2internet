extends Control

# Referencias a los nodos de la interfaz
var dato_input
var unidad_input
var resultado_text

# Se llama cuando la escena es cargada
func _ready():
	# Asignar las referencias de los nodos de UI
	dato_input = $LineEditDato
	unidad_input = $LineEditUnidad
	resultado_text = $TextEditResultado
	$ButtonCalcular.connect("pressed", self, "_on_calcular_pressed")

# Función para redondear un número a un número específico de decimales
func round_to_decimals(number, places):
	var factor = pow(10, places)
	return int(number * factor) / factor

# Función para calcular las emisiones de CO2
func calcular_emisiones(dato, unidad):
	var mb = 0
	
	if unidad.to_lower() == 'kb':
		mb = dato / 1024 # Convertir KB a MB
	elif unidad.to_lower() == 'mb':
		mb = dato # Los datos ya están en MB
	elif unidad.to_lower() == 'gb':
		mb = dato * 1024 # Convertir GB a MB
	else:
		return "Unidad no válida. Ingrese kb, mb o gb."
	
	# Cálculo de emisiones de CO2 (en gramos)
	var emisiones_gramos = mb * 0.059
	var emisiones_kg = emisiones_gramos / 1000 # Convertir a kg
	
	# Comparaciones
	var arboles_necesarios = emisiones_kg / 22  # Un árbol absorbe 22 kg de CO2 al año
	var autos_equivalentes = emisiones_kg / 4.6 # Un auto emite 4.6 toneladas (4600 kg) al año
	var hogares_energia = emisiones_kg / 7.5    # Un hogar genera 7.5 toneladas de CO2 al año por energía
	
	# Crear el texto de salida con valores redondeados a 4 decimales
	var resultado = "Total de datos: " + str(dato) + " " + unidad.to_upper() + "\n"
	resultado += "Emisiones de CO2 estimadas: " + str(round_to_decimals(emisiones_kg, 4)) + " kg\n"
	resultado += "Equivalente a " + str(round_to_decimals(arboles_necesarios, 4)) + " árboles en un año.\n"
	resultado += "Equivalente a " + str(round_to_decimals(autos_equivalentes, 4)) + " automóviles al año.\n"
	resultado += "Equivalente al consumo energético de " + str(round_to_decimals(hogares_energia, 4)) + " hogares en un año.\n"
	
	return resultado

# Función que se llama cuando el usuario presiona el botón
func _on_calcular_pressed():
	# Obtener valores de los LineEdit
	var dato = dato_input.text.to_float()
	var unidad = unidad_input.text
	
	# Calcular emisiones y mostrar resultado
	var resultado = calcular_emisiones(dato, unidad)
	resultado_text.text = resultado
