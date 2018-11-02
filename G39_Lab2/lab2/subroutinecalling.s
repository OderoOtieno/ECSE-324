			.text
			.global _start

_start:		
			LDR R1,=NUMBERS
			LDR R2,=N
			BL SUBROUTINE
			B END
			
SUBROUTINE:	PUSH {LR}
			LDR R0,[R1] //max
			LDR R2,[R2]
			B LOOP
			
LOOP:		SUBS R2, R2, #1
			BEQ DONE
			ADD R1,R1,#4
			LDR R3,[R1]
			CMP R0,R3 
			BGE LOOP
			MOV R0, R3
			B LOOP

DONE:	
			POP {LR}
			BX LR

END:		B END

RESULT:		.word	0
N:			.word	7
NUMBERS:	.word	4, 5, 3, 6
			.word	1, 8, 2
