		.text
		.equ LED_BASE, 0xFF200000
		.global read_LEDs_ASM
		.global write_LEDs_ASM


		
read_LEDs_ASM:	LDR R1,=LED_BASE
				LDR R0, [R1]
				BX LR

				//.end    report challenge				
//R0 hasnt been overwritten from subroutine and contains the address that contains all switches clicked
write_LEDs_ASM:	LDR R1,=LED_BASE
				STR R0,[R1]
				BX LR

				.end
