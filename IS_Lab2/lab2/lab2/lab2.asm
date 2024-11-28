;
; lab2.asm
;
; Created: 2024-11-28 11:19:32
; Author : aq2560 Viktor Vallmark, al3706 Elsa Olsson
;

	;==============================================================================
	;    Definitions of registers, etc. ("constants")
	;==============================================================================
	.EQU RESET  = 0x0000
	.EQU PM_START = 0x0056
	.EQU NO_KEY = 0x0F
	.DEF TEMP = R16
	.DEF RVAL = R24

	;==============================================================================
	;    Start of program
	;==============================================================================
	.CSEG
	.ORG RESET
	RJMP init

	.ORG PM_START
	.INCLUDE "delay.inc"
	.INCLUDE "lcd.inc"
	;==============================================================================
	;    Basic initializations of stack pointer, I/O pins, etc.
	;==============================================================================

init:
	;    Set stack pointer to point at the end of RAM.
	LDI  TEMP, LOW(RAMEND)
	OUT  SPL, TEMP
	LDI  TEMP, HIGH(RAMEND)
	OUT  SPH, TEMP
	;    Initialize pins
	CALL init_pins
	CALL lcd_init
	;    Jump to main part of program
	RJMP main

	;==============================================================================
	; Initialize I/O pins
	;==============================================================================

init_pins:
	CBI DDRE, 6			;this sets port e6 to input, port b to output, port f to output
	LDI TEMP, 0xFF
	OUT DDRD, TEMP
	OUT DDRB, TEMP
	OUT DDRF, TEMP
	
	RET


	;==============================================================================
	; Read Keyboard
	;==============================================================================

read_keyboard:
	LDI R18, 0x00

scan_key:
	MOV  R19, R18
	LSL  R19
	LSL  R19
	LSL  R19
	LSL  R19
	OUT  PORTB, R19
	NOP				;12 NOPS needed
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
	SBIC PINE, 6
	RJMP return_key_val
	INC  R18
	CPI  R18, 12
	BRNE scan_key
	LDI  R18, NO_KEY

return_key_val:
	MOV RVAL, R18
	RET

	;==============================================================================
	; Main part of program
	;==============================================================================

main:
	;CALL read_keyboard
	;LSL RVAL
	;LSL RVAL
	;LSL RVAL
	;LSL RVAl
	
	;OUT  PORTF, RVAL
	;RJMP main; 2 cycles
	
	;LDI R24, 'H'
	;RCALL lcd_write_chr
	;LDI R24, 'E'
	;RCALL lcd_write_chr
	;LDI R24, 'L'
	;RCALL lcd_write_chr
	;LDI R24, 'L'
	;RCALL lcd_write_chr
	;LDI R24, 'O'
	;RCALL lcd_write_chr
	;LDI R24, '!'
	;RCALL lcd_write_chr

	LCD_WRITE_CHAR 'H'
	LCD_WRITE_CHAR 'E'
	LCD_WRITE_CHAR 'L'
	LCD_WRITE_CHAR 'L'
	LCD_WRITE_CHAR 'O'
	LCD_WRITE_CHAR '!'
loop:
	RJMP loop

