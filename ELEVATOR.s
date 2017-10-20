;====================================================================================================================
; PARAMETROS
;====================================================================================================================


;R0 estados de la FSM:
; GOING_UP 		0
; GOING_DOWN 	1
; WAITING 		2
; OPENING_DOOR	3
; CLOSING_DOOR 	4

LDR R2, =0x0 ; registro de temporizador
; FINITE STATE MACHINE

GOING_UP
	LDR R0, =0x0; define estado actual
	B TIMER ; iniciar temporizador

GOING_DOWN
	LDR R0, =0x1 ; define estado actual
	B TIMER ; iniciar temporizador

WAITING
	LDR R0, =0x2 ; define estado actual
	B TIMER ; iniciar temporizador

OPENING_DOOR
	LDR R0, =0x3 ; define estado actual
	B TIMER ; iniciar temporizador

CLOSING_DOOR
	LDR R0, =0x4 ; define estado actual
	B TIMER ; iniciar temporizador


COMPLETED
 	B COMPLETED

TIMER
	ADD R2, R2, #1 ; suma uno al contador
	CMP R2, R3 ; valor límite de tiempo (5 s)
	BNE TIMER ; realiza el salto pues no se ha llegado al valor límite de tiempo
	LDR R2, =0x0 ; reinicia el contador

NEXT_STATE
	CMP R1, #0 ; estado actual: GOING_UP
	BEQ GOING_UP ; ir a ##

	CMP R1, #1 ; estado actual: GOING_DOWN
	BEQ GOING_DOWN ; ir a ##

	CMP R1, #2 ; estado actual: OPENING_DOOR
	BEQ OPENING_DOOR ; ir a ##

	CMP R1, #3 ; estado actual: CLOSING_DOOR
	BEQ CLOSING_DOOR ; ir a ##

	CMP R1, #4 ; estado actual: WAITING
	BEQ WAITING ; ir a ##

END ; End of the progra