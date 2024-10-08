	AREA RESET, DATA, READONLY
	DCD          0    ;initial_sp
	DCD          Main;reset_vector

	AREA STACK_POINTER_AREA, DATA, READWRITE
STACK_POINTER SPACE  24 ; WE NEED 6 WORD SPACE FOR OUR STACK POINTER
	; AND EACH WORD IS 4 BYTE, SO WE NEED 6 * 4 = 24 BYTE.

	AREA    MyCode, CODE, READONLY
	ENTRY
Main PROC
	
	; FIRST WE INITIALIZE STACK_POINTER
	LDR SP, =STACK_POINTER
	ADD SP, #24 ; THIS LINE IS LOCATED BECAUSE OUR STACK IS DESCENDING
	; SO WE NEED TO SET THE SP TO TOP OF THE STACK. AND FOR THIS WE ADD
	; THE GIVEN ADDRESS WITH THE SIZE OF THE STACK;
	
	MOV R0, #429; A RANDOM NUMBER
	MOV R1, #0  ; NUMBER OF 1 BITS
	MOV R2, #0  ; NUMBER OF 0 BITS
	MOV R3, #0  ; NUMBER OF TOTAL BITS THAT WE CHECKED
	
	PUSH {R0}  ; THIS FOR STORING THE RANDOM NUMBER
	; AFTER LOOP
LOOP
	CMP R3, #32
	BGE END_OF_LOOP ; CHECKING IF WE HAVE CHECKED ALL BITS
	AND R4, R0, #1  ;R4 = R0[0] : FINDING LSB AND STORING IT IN R4
	CMP R4, #1 ; COMPARING LSB WITH ONE
	ADDEQ R1, #1 ; R1 = R1 + 1 : ADDING NUMBER OF ONES IN NUMBER IF LSB IS ONE
	ADDNE R2, #1 ; R2 = R2 + 1 : ADDING NUMBER OF ZEROS IN NUMBER IF LSB IS ZERO
	LSR R0, #1   ; R0 = R0 >> 1: SHIFTING THE RANDOM NUMBER ONE BIT TO RIGHT
	ADD R3, #1   ; R3 = R3 + 1 : INCREASING NUMBER OF CHECKED BITS
	B LOOP ; BACK TO THE BEGINING OF LOOP
END_OF_LOOP
	
	POP {R0} ; THIS IS FOR RELOADING THE RANDOM NUMBER
	
	; NOW HERE WE HAVE NIMBER OFE ONES AND ZEROS
	BL MySubRoutine ; GOING TO THE MyFunction
	;END OF PROGRAM
	B HERE
	
	; START OF SUBROUTINE
MySubRoutine
	PUSH {R1, R2, LR}
	; FOR MUL INSTRUCTION, WE CAN'T USE ANY (IMMEDIATE)NUMBER LIKE #3
	; SO WE WRITE OUR NUMBER (HERE OUR NUMBER IS 3) IN A REGISTER (HERE R2)
	; AND THEN WE USE THIS REGISTER
	MOV R2, #3  ; R2 = 3
	MUL R2, R1  ; R2 = R2 * R1      OR      R2 = R1 * 3
	; FOR SUB INSTRUCTION, WE ONLY CAN USE (IMMEDIATE) NUMBER LIKE #100
	; IN THE 3RD PART. FOR USING A NUMBER IN 2ND PART, FIRST WE SHOULD 
	;WRITE THE NUMBER IN A REGISTER.
	MOV R3, #100 ; R3 = 100
	SUB R3, R2 ; R3 = R3 - R2       OR      R3 = 100 - R2
	POP {R1, R2, LR}
	MOV PC, LR ; return
	; END OF SUBROUTINE
HERE
    B    HERE        ;stay here forever
	ENDP
	END