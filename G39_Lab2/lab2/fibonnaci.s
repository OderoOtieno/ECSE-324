			.text
			.global _start

_start:
			LDR R4, =RESULT
			LDR R0, [R4, #4] 	// arg1 is n
			PUSH {LR}           // Save LR
			BL FIB
			POP {LR}            // Restore LR
			STR R0, [R4]        // Store the result in memory
			B END



FIB: 		PUSH {R4-R12}       // Save the state
			CMP R0, #2          // Check if n >= 2
			BGE CONTINUE
			MOV R0, #1          // No, return one only
			B CLEAN

CONTINUE: 	SUBS R0, R0, #1 	// Yes, get n-1
			MOV R4, R0          // Save the value of n-1
			PUSH {LR}           // Save LR
			BL FIB              // fib(n-1)
			POP {LR}            // Restore LR
			MOV R5, R0          // save the value of fib(n-1)
			SUBS R0, R4, #1     // get n-2
			PUSH {LR} 
			BL FIB              // fib(n-2)
			POP {LR}
			ADD R0, R5, R0      // put in R0 fib(n-1) + fib(n-2)
			B CLEAN

CLEAN:		POP {R4-R12}        // Restore the state
			BX LR



END: 		B END



RESULT: 	.word	0
N: 			.word 	6
