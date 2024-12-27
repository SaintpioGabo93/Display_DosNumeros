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
	movwf	    var_conteo		; 
	
	
	