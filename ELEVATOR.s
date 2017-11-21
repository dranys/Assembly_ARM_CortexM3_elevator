;====================================================================================================================
; PARAMETROS
;====================================================================================================================
; Directives para trabajar en  keil uVision
	PRESERVE8
	THUMB

;Vector table mapped to address 0 at reset
;link requires __vectors to be exported
	
	AREA RESET, DATA, READONLY
	EXPORT __Vectors

__Vectors

	DCD 0x20001000; stack pointer value when stack is empty
	DCD Reset_Handler; reset Vector

		ALIGN
;the program
;Linker requires Reset_Handler

	AREA MYCODE, CODE, READONLY

	ENTRY
	EXPORT Reset_Handler

Reset_Handler

;R0 estados de la FSM:
; GOING_UP 		0
; GOING_DOWN 	1
; WAITING 		2
; OPENING_DOOR	3
; CLOSING_DOOR 	4

	LDR R11, =0x1 ; piso inicial


; FINITE STATE MACHINE

WAITING
	LDR R0, =0x2 ; define estado actual
	BL CHECK_FLOOR; revisa si en el piso donde estamos se debe abrir el ascensor
	BL PISO_MAS_LEJANO2; calculamos el piso mas lejano en caso de que exista y sino se queda el ascensor estatico
	CMP R11, R10; 
	BLT GOING_UP; si el piso actual es mas pequeno que el primer piso solicitado
	; de arriba hacia abajo entocnes hay que subir
	B GOING_DOWN ; y sino hay que bajar




GOING_UP
	LDR R12, =0x1; subiendo
	LDR R0, =0x0; define estado actual
	BL CHECK_FLOOR ; check si habre puerta
	ADD R11, R11,#1; incremento el piso
	B PISO_MAS_LEJANO; 
GU_Cont
	CMP R11, R10; compara entre piso actual y piso  mas lejano
	BNE GOING_UP
	B WAITING;


GOING_DOWN
	LDR R12, =0x0; bajando
	LDR R0, =0x1 ; define estado actual
	BL CHECK_FLOOR ; check si habre puerta
	SUB R11, R11, #1; decremento el piso
	B PISO_MAS_LEJANO; 
GD_Cont
	CMP R11, R10; compara entre piso actual y piso  mas lejano
	BNE GOING_DOWN
	B WAITING;

OPENING_DOOR
	LDR R0, =0x3 ; define estado actual
	B CLOSING_DOOR ; 

CLOSING_DOOR
	LDR R0, =0x4 ; define estado actual
	B WAITING ; 

PISO_MAS_LEJANO
	CMP R12, #1;
	BNE PML1;

	MOV R10, #9
	CMP R9, #1
	BEQ GU_Cont

	MOV R10, #8
	CMP R8, #1
	BEQ GU_Cont

	MOV R10, #7
	CMP R7, #1
	BEQ GU_Cont

	MOV R10, #6
	CMP R6, #1
	BEQ GU_Cont

	MOV R10, #5
	CMP R5, #1
	BEQ GU_Cont

	MOV R10, #4
	CMP R4, #1
	BEQ GU_Cont

	MOV R10, #3
	CMP R3, #1
	BEQ GU_Cont

	MOV R10, #2
	CMP R2, #1
	BEQ GU_Cont
	B WAITING

PML1 

	MOV R10, #1
	CMP R1, #1
	BEQ GD_Cont

	MOV R10, #2
	CMP R2, #1
	BEQ GD_Cont

	MOV R10, #3
	CMP R3, #1
	BEQ GD_Cont

	MOV R10, #4
	CMP R4, #1
	BEQ GD_Cont

	MOV R10, #5
	CMP R5, #1
	BEQ GD_Cont

	MOV R10, #6
	CMP R6, #1
	BEQ GD_Cont

	MOV R10, #7
	CMP R7, #1
	BEQ GD_Cont

	MOV R10, #8
	CMP R8, #1
	BEQ GD_Cont

	B WAITING

PISO_MAS_LEJANO2; se calcula el piso mas lejano para mover el ascensor

	MOV R10, #9;
	CMP R9, #1;
	MOVEQ PC, LR;

	MOV R10, #8;
	CMP R8, #1;
	MOVEQ PC, LR;

	MOV R10, #7;
	CMP R7, #1;
	MOVEQ PC, LR;

	MOV R10, #6;
	CMP R6, #1;
	MOVEQ PC, LR;

	MOV R10, #5;
	CMP R5, #1;
	MOVEQ PC, LR;

	MOV R10, #4;
	CMP R4, #1;
	MOVEQ PC, LR;

	MOV R10, #3;
	CMP R3, #1;
	MOVEQ PC, LR;

	MOV R10, #2;
	CMP R2, #1;
	MOVEQ PC, LR;
	
	MOV R10, #0;
	B WAITING




CHECK_FLOOR  ; se verifica el estado de cada piso
	
	CMP R11, #1;
	BEQ VERIFICAR_P1;

	CMP R11, #2;
	BEQ VERIFICAR_P2;

	CMP R11, #3;
	BEQ VERIFICAR_P3;
	
	CMP R11, #4;
	BEQ VERIFICAR_P4;

	CMP R11, #5;
	BEQ VERIFICAR_P5;

	CMP R11, #6;
	BEQ VERIFICAR_P6;

	CMP R11, #7;
	BEQ VERIFICAR_P7;

	CMP R11, #8;
	BEQ VERIFICAR_P8;

	CMP R11, #9;
	BEQ VERIFICAR_P9;
VERIFICAR_P1
	CMP R1, #1;
	MOVEQ R1, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA
	
VERIFICAR_P2
	CMP R2, #1;
	MOVEQ R2, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P3
	CMP R3, #1;
	MOVEQ R3, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P4
	CMP R4, #1;
	MOVEQ R4, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P5
	CMP R5, #1;
	MOVEQ R5, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P6
	CMP R6, #1;
	MOVEQ R6, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P7
	CMP R7, #1;
	MOVEQ R7, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR;
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P8
	CMP R8, #1;
	MOVEQ R8, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA

VERIFICAR_P9
	CMP R9, #1;
	MOVEQ R9, #0; COLOCAMOS EN CERO EL REGISTRO PUES SE HA CUMPLIDO LA PETICION
	BEQ OPENING_DOOR;
	MOV PC, LR; RETORNAMOS A LA FUNCION LLAMADORA



	END 
