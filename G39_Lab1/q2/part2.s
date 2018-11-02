			.text
			//.global _start

//_start:
			LDR R4, =MAXRESULT
			LDR R2, [R4, #4]
			ADD R3,R4, #8
			LDR R0, [R3]
			LDR R5, =MINRESULT

			
LOOP1:		SUBS R2, R2, #1
			BEQ STORE
			ADD R3, R3, #4
			LDR R1, [R3]
			CMP R0, R1
			BGE LOOP1
			MOV R0, R1
			B LOOP1

STORE: 		STR R0, [R4]
			LDR R0, [R4]

			LDR R2, [R4, #4]
			ADD R3,R4, #8
			LDR R0, [R3]
			B LOOP2

LOOP2:		SUBS R2, R2, #1
			BEQ DONE
			ADD R3, R3, #4
			LDR R1, [R3]
			CMP R0, R1
			BLE LOOP2
			MOV R0, R1
			B LOOP2

DONE:		LDR R4,[R4]
			SUBS R4,R4,R0
			ASR R4,R4,#2

END:		B END

MAXRESULT:		.word	0
N:				.word	7
NUMBERS:	.word	4, 5, 3, 10
				.word	1, 8, 2
MINRESULT:		.word	0
