cblock
TEMP1
TEMP2
TEMP3
endc
DELAY_S movwf TEMP3 
    call DELAY_1S  
    decfsz TEMP3,1 
    goto $-2 
    return
DELAY_1S movlw .250
         call DELAY_MS
	 movlw .250
         call DELAY_MS
	 movlw .250
         call DELAY_MS
	 movlw .250
         call DELAY_MS
	 return
	 
DELAY_MS movwf TEMP1 ;1us
    call DELAY_1MS  ;2us + 995us
    decfsz TEMP1,1 ;1us
    goto $-2 ;2us
    return
DELAY_1MS movlw .247 ;1 us
    movwf TEMP2  ;1us
    nop  ;1 us
    decfsz TEMP2,1  ;1 us
    goto $-2  ;2us
    return