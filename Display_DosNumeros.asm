; Configuración del PIC16F628A
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

; Indica el modelo de microcontrolador utilizado
LIST P=16F628A
    
; Declaramos las variables
cblock 0x20
    contador_1	; Contadores del programa
    contador_2
    var_conteo
endc
    
; Incluimos el archivo con las definiciones del microcontrolador. 
    #include <p16f628a.inc>
    
    
; Configuracion inicial
	org	    0x00	; Colocamos la direccion 0x00 como el inicio del programa
	movlw	    0x07	; Desactivamos los comparadores del PIC
	movwf	    CMCON	; Configuramos el registro CMCON para deshabilitar los comparadores
	bsf	    STATUS, 5	; Vamos al banco 1
	movlw	    b'00000111'	; Cargamos la configuracion del TMR0
	movwf	    OPTION_REG  ; Movemos la configuracion al OPTION_REG
	clrf	    TRISB	; Configuramos los pines del PORTB como salida
; Vamos a utilizar este PORT para conectarlo a unos transistores y puedan alternar los Display para que parezca que estan encendidos al mismo tiempo
	clrf	    TRISA	; Configuramos los pines del PORTA como salida
	bcf	    STATUS, 5	; Regresamos al banco 0
	
; Programa principal
inicio:	; Reseteamos los bits de los dos espacios que reservamos
	clrf	    contador_1
	clrf	    contador_2

rutina_conteo:
	call	    mostrar_1s	; Llamamos a la subrutina para mostrar el numero durante 1 segundo
	incf	    contador_1	; Incrementamos en uno el espacio f del contador_1 
	movlw	    .10		; Cargamos el valor para compararlo con el contador es el bit W
	subwf	    contador_1, W;Restamos el valod del contador menos el del bit W, o sea: contador_1 - W=10
	btfss	    STATUS, 2	; Si W = 0 salta una instruccion, de lo contrario sigue su curso normal
	goto	    rutina_conteo
	clrf	    contador_1	; Si llega a cero, btfss salta a esta instruccion y reseteamos el contador_1
	incf	    contador_2	; Incrementamos en 1 el valor del contador_2 para que se cambie el display 2
; Fase critica muy importante, volvemos a comparar pero ahora los valores del contador_2
	movlw	    .10
	subwf	    contador_2, W;Restamos el valor del contador_2 en el bit W para poderlo comparar con el STATUS, 2
	btfss	    STATUS, 2	; Y mismo cuento, si W=0 Saltamos una instruccion. 
	goto	    rutina_conteo;Si todavia no es 0, regresamos a la rutina de conteo
	goto	    inicio	; Si ya es cero otra vez, regresamos al inicio para que se reseteen los dos contadores
	
; Esta subrutina nos sive para mostrar los numeros durante 1 segundo
mostrar_1s:
	movlw	    .50		; Cargamos el valor 50 para que nos de el segundo, este se puede modificar deacuerdo con el tiempo que necesitemos
	movwf	    var_conteo	; Asigmanos el valor de 50 a nuestro espacio que nombramos var_conteo
; La siguiente instruccion es muy importante, porque lo que necesitamos es que siempre se este ejecutando nuestra rutina de mostrar los LED
	call	    mostrar	; Llamamos a la subrutina que enciende los leds del display
	decfsz	    var_conteo,F; Decrementa el espacio reservado y verifica si es cero, si =0 salta una instruccion
	goto	    $-2		; Si la instruccion anterior no fue cero regresamos a call mostrar
	return			; Finalizamos la subrituna y regresamos a la instruccions FO de la pila

; Subrutina para mostrar los numero en los displays 
mostrar:
	; Rutina de unidades
	bsf	    PORTA, 0	; Activa el display de las unidades
	bcf	    PORTA, 1	; Desactiva el display de las decenas
	movf	    contador_1,	W;Carga el valor de contador_1 en W
	call	    tabla	; Llama ala tabla de segmentos para convertirlo
	movwf	    PORTB	; Carga el valor obtenido de tabla en el PORTB
	movlw	    .10		; Retardo breve para visualizar el numero 
	call	    delay_ms	; Llama a la rutina de retardo
	; Rutina de decenas
	bcf	    PORTA, 0	; Apagamos el bit 0 del PORTA para desactivar el display de las unidades
	bsf	    PORTA, 1	; Activamos el bit 1 del PORTA para activar el display de decenas
	movf	    contador_2,	W;Cargamos el valor de contador_2 en W
	call	    tabla	; Llamamos a la tabla 
	movwf	    PORTB	; Cargamos el valor que se encuentre en la tabla para el valor del contador
	movlw	    .10		; Volvemos a poner el retardo de 10 milisegundos
	call	    delay_ms	; Llamamos a la rutina de delay 
	return			; Terminamos la subrutina
	
; Tabla de segmentos para el display de 7 segmentos
tabla:
	addwf PCL,F     ; Usa W como índice para seleccionar el valor de la tabla
	retlw b'00111111'  ; Código para el número 0
	retlw b'00000110'  ; Código para el número 1
	retlw b'01011011'  ; Código para el número 2
	retlw b'01001111'  ; Código para el número 3
	retlw b'01100110'  ; Código para el número 4
	retlw b'01101101'  ; Código para el número 5
	retlw b'01111101'  ; Código para el número 6
	retlw b'00000111'  ; Código para el número 7
	retlw b'01111111'  ; Código para el número 8
	retlw b'01100111'  ; Código para el número 9

; Inclusión del archivo para retardos
    #include <delay.inc>

    end	