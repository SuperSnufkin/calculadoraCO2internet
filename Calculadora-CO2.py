def calcular_emisiones(dato, unidad):
    # Definimos las conversiones
    if unidad.lower() == 'kb':
        mb = dato / 1024  # Convertimos KB a MB
    elif unidad.lower() == 'mb':
        mb = dato  # Si es MB, ya está en la unidad correcta
    elif unidad.lower() == 'gb':
        mb = dato * 1024  # Convertimos GB a MB
    else:
        print("Unidad no válida, por favor ingrese kb, mb o gb.")
        return

    # Emisiones aproximadas por MB (0.059 gramos por MB)
    emisiones_gramos = mb * 0.059
    emisiones_kg = emisiones_gramos / 1000  # Convertir a kilogramos

    # Comparaciones
    arboles_necesarios = emisiones_kg / 22  # Un árbol absorbe 22 kg de CO2 al año
    autos_equivalentes = emisiones_kg / 4.6  # Un auto emite 4.6 toneladas (4600 kg) de CO2 al año
    hogares_energia = emisiones_kg / 7.5  # Un hogar promedio genera 7.5 toneladas de CO2 al año por energía

    # Mostrar resultados
    print(f"\nTotal de datos: {dato} {unidad.upper()}")
    print(f"Emisiones de CO2 estimadas: {emisiones_kg:.4f} kg")
    print(f"Equivalente a {arboles_necesarios:.4f} árboles en un año.")
    print(f"Equivalente a las emisiones de {autos_equivalentes:.4f} automóviles al año.")
    print(f"Equivalente al consumo energético de {hogares_energia:.4f} hogares en un año.\n")

# Solicitar datos al usuario
dato = float(input("Ingrese la cantidad de datos transferidos (solo número): "))
unidad = input("Ingrese la unidad (kb, mb, gb): ")

# Ejecutar el cálculo
calcular_emisiones(dato, unidad)
