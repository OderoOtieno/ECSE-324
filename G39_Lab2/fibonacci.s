			.text
			.global _start

//_start:
			MOV R0,#0
			LDR R1,=N //Fibonacci amount
			LDR R1,[R1]
			LDR R2,=ARRAY
			LDR R2,[R2]
			BL FIBONACCI
			B END
			
FIBONACCI:	PUSH {LR,R1}
			CMP R1,#2
			MOVLT R0,#1
			SUBS R1,R1,#1
			//POPLT {LR,R1}
			BL FIBONACCI

			CMP R1,#2
			MOVLT R0,#1
			SUBS R1,R1,#1
			//POPLT {LR,R1}
			BL FIBONACCI

BASE:		MOV R0,#1
			


DONE:		B END

END:		B END

RESULT:		.word	0
N:			.word	3
ARRAY:		.word	0
