			.text
			.global _start

_start:
			LDR R1,=NUMBERS //register that will be iterated upon
			LDR R2,[R1] //max
			LDR R3,=N //counter
			LDR R3,[R3]
			LDR R0,[R1]
			BL SUBROUTINE
			B END
			
SUBROUTINE:	PUSH {LR}
			BL LOOP
			
LOOP:		SUBS R3, R3, #1
			BEQ DONE
			ADD R1,R1,#4
			LDR R2,[R1]
			CMP R0,R2 
			BGE LOOP
			MOV R0, R2
			B LOOP

DONE:	
			POP {LR}
			BX LR

END:		B END

RESULT:		.word	0
N:			.word	7
NUMBERS:	.word	4, 5, 3, 6
			.word	1, 8, 2
