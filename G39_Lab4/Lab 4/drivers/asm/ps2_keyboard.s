			.text
			.equ PS2_base, 0xFF200100
			.global read_PS2_data_ASM

read_PS2_data_ASM:
			LDR R1, =PS2_base 
			LDR R2, [R1] 
			AND R3, R2, #0x8000 

			CMP R3, #0x8000
			MOVEQ R4,R2
			STREQB R4,[R0]
			MOVEQ R0,#1
			
			BEQ END
			
			
			MOV R0, #0
			BEQ END			

END:		BX LR
