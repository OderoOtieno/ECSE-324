			.text
//			.global _start

//_start:
			//LDR R0, =ARRAY //Array of numbers to go through
			//LDR R1, =N //Number of elements in ARRAY
			//LDR R1, [R1]
			MOV R0,#2
			MOV R2, #4
			


PUSH:		STR R0, [SP,#-4]!
POP:		LDR R0, [SP],#4

END:		B END


ARRAY:		.word 1,2,3,4
N:			.word 4




