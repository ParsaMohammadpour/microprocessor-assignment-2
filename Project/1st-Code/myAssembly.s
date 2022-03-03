	AREA RESET, DATA, READONLY
	DCD          0      ;initial_sp
	DCD          Example;reset_vector

	AREA    MyCode, CODE, READONLY  
Example PROC
	MOV R1, #0 ; R1 IS SUM
    MOV R0, #1 ; R0 IS i
LOOP
	CMP R0, #8
	BGT END_OF_LOOP ; END OF FINDING SUM
	ADD R1, R1, R0  ; SUM = SUM + 1
	ADD R0, #1      ; i = i + 1
	B LOOP
END_OF_LOOP
	;R1 IS OUR SUM NOW
HERE
    B    HERE        ;stay here forever
	ENDP
	END