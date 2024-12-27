# Proyecto PIC16F628A: Contador con Display de 7 Segmentos

Este proyecto implementa un contador que utiliza un microcontrolador PIC16F628A para contar de 0 a 99 y mostrar los números en dos displays de 7 segmentos.

## Descripción General
El programa realiza lo siguiente:
- Cuenta unidades y decenas desde 0 hasta 99.
- Muestra los valores en dos displays de 7 segmentos.
- Utiliza retardos para mantener los valores visibles en los displays.

El código está escrito en ensamblador para el PIC16F628A, y utiliza registros, tablas y subrutinas para su funcionamiento.

## Configuración del Microcontrolador
La configuración inicial incluye:
- Desactivación de los comparadores internos.
- Configuración de todos los pines de los puertos A y B como salidas.
- Configuración de las opciones del microcontrolador, como el oscilador interno y otras funciones de hardware.

## Flujo del Programa
1. **Inicialización:**
   - Se configuran los registros y los pines de los puertos.
   - Los contadores de unidades y decenas se inicializan en 0.

2. **Bucle Principal:**
   - Incrementa el contador de unidades hasta llegar a 9.
   - Cuando las unidades alcanzan 10, se reinician a 0 y se incrementa el contador de decenas.
   - Cuando las decenas alcanzan 10, el contador se reinicia.

3. **Mostrado de Valores:**
   - Una subrutina muestra los valores actuales de las unidades y decenas en los displays de 7 segmentos.
   - Utiliza una tabla de conversión para traducir los valores numéricos a los códigos correspondientes para los displays.

4. **Retardos:**
   - Se incluyen retardos para mantener visibles los valores en los displays durante un tiempo adecuado.

## Código Comentado
El código tiene comentarios en cada sección para explicar su funcionamiento detallado. Las partes principales son:

- **Inicialización:** Configura los registros y desactiva los comparadores.
- **Bucle Principal:** Maneja el conteo de unidades y decenas.
- **Subrutinas:**
  - `MOSTRAR_1S`: Muestra los valores en los displays durante 1 segundo.
  - `MOSTRAR`: Muestra los valores actuales en los displays.
  - `TABLA`: Convierte valores numéricos en códigos para los displays de 7 segmentos.

## Hardware Requerido
- Microcontrolador PIC16F628A
- Dos displays de 7 segmentos
- Resistencias de limitación de corriente
- Fuente de alimentación adecuada

## Uso del Proyecto
1. Ensambla el código y carga el archivo .hex en el PIC16F628A.
2. Conecta los displays y componentes según el esquema de hardware.
3. Alimenta el circuito y observa cómo los displays cuentan de 0 a 99.

## Tabla de Segmentos
La tabla en el código mapea valores numéricos a los códigos binarios necesarios para encender los segmentos de los displays:

| Número | Código Binario |
|--------|----------------|
| 0      | `00111111`     |
| 1      | `00000110`     |
| 2      | `01011011`     |
| 3      | `01001111`     |
| 4      | `01100110`     |
| 5      | `01101101`     |
| 6      | `01111101`     |
| 7      | `00000111`     |
| 8      | `01111111`     |
| 9      | `01100111`     |

## Notas
- Este proyecto utiliza ensamblador y está diseñado específicamente para el microcontrolador PIC16F628A.
- Asegúrate de tener las herramientas necesarias para programar el PIC y probar el circuito.

---
Si tienes dudas sobre el funcionamiento del código o del hardware, no dudes en revisarlo aquí o contactarme para más ayuda. ¡Feliz aprendizaje y programación! 😄

