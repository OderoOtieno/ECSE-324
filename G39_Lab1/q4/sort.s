			.text
	//		.global _start

//_start:		
			LDR R4, =N		
			LDR R0, [R4]		
			
			MOV R1, #0		
			MOV R10, #1
		

WHILELOOP:	CMP R1, R10 						
			BEQ END			
			MOV R1, #1			
			MOV R5, #1			
			ADD R2, R4, #0		
			ADD R3, R4, #4	

			B FORLOOP						

FORLOOP:	CMP R5, R0					
			BGE WHILELOOP		
			ADD R5, R5, #1		

			ADD R2, #4			
			ADD R3, #4			

			LDR R6, [R2]		
			LDR R7, [R3]		

			CMP R6, R7			
			BLE	FORLOOP		
								
		 	MOV R8, R6			
			MOV R6, R7			
			MOV R7, R8			
			STR R6, [R2]		
			STR R7, [R3]		
			MOV R1, #0			
			
			B FORLOOP

END:	 	B END

N:			.word	4			
NUMBERS:	.word	5, 4, 1, 3	
