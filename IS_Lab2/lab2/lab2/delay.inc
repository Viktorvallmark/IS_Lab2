/*
 * delay.inc
 *
 * Author:	Viktor Vallmark, Elsa Olsson
 *
 * Date:	2024-11-28
 */ 

;==============================================================================
; Delay of 1 µs (including RCALL)
; 
; make comments according to question 3.2.5-3.2.8
;==============================================================================
delay_1_micros:   /* UPPGIFT: komplettera med ett antal NOP-instruktioner!!! */
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	RET


;==============================================================================
; Delay of X µs
;	LDI + RCALL = 4 cycles
; make comments according to question 3.2.5-3.2.8
;==============================================================================
delay_micros:   /* UPPGIFT: komplettera med ett antal NOP-instruktioner!!! */
	NOP
	NOP
	NOP
	NOP
	NOP	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP	
	NOP
	DEC R24
	CPI R24, 0	; more loops to do?
		
	BRNE delay_micros	;	continue!
	RET

;==============================================================================
; Delay of X ms
;	LDI + RCALL = 4 cycles
; make comments according to question 3.2.5-3.2.8
;==============================================================================
delay_ms:
	MOV R18, R24
loop_dms:
	LDI R24, 250
	RCALL delay_micros
	LDI R24, 250
	RCALL delay_micros
	LDI R24, 250
	RCALL delay_micros
	LDI R24, 250
	RCALL delay_micros
	DEC R18
	CPI R18, 0			; more loops to do?
	BRNE loop_dms		;	continue!
	RET