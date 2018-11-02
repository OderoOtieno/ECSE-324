			.text
//			.global _start


//_start:		LDR R4, =RESULT		
			
			LDR R2, [R4, #4]
			MOV R3, #0
			MOV R5, #0	
			MOV R6, #0
			LDR R7, [R4, #4]					
			ADD R3, R4, #8		
			

SUMLOOP:	SUBS R2, R2, #1		
			BLT DONE			 
			LDR R1, [R3]				
			ADD R3, R3, #4 
			ADD R5, R5, R1		
			B SUMLOOP 			

DONE: 		ADD R0, R5, #0		

DIVSHIFT: 	SUBS R7, R7, #1		
			CMP R7, #1			
			BEQ AVG	
			ADD R6, R6, #1			
			ASR R0, #1				
			B DIVSHIFT

AVG:		ASR R5, R5, R6		
			ADD R3, R4, #8		
			LDR R7, [R4, #4]

SUBLOOP:	SUBS R7, R7, #1	
			BLT END				
			LDR R1, [R3]		
			SUB R1, R1, R5		
			STR R1, [R3]		
			ADD R3, R3, #4 		

			B SUBLOOP 			

END:		B END 				

RESULT:		.word	0			
N:			.word	4			
NUMBERS:	.word	5, 4, 1, 6, 10, 12, 14, 15	
