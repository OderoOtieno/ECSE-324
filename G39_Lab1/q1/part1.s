/*
			.text
//			.global _start

//_start:
			LDR R4, =RESULT
			LDR R2, [R4, #4]
			ADD R3,R4, #8
			LDR R0, [R3]
			
LOOP:		SUBS R2, R2, #1
			BEQ DONE
			ADD R3, R3, #4
			LDR R1, [R3]
			CMP R0, R1
			BGE LOOP
			MOV R0, R1
			B LOOP

DONE:		STR R0, [R4]

END:		B END

RESULT:		.word	0
N:			.word	7
NUMBERS:	.word	4, 5, 3, 6
			.word	1, 8, 2
*/


			.text
        .equ HEX_BASE_ONE, 0xFF200020
        .equ HEX_BASE_TWO, 0xFF200030
			.global _start



//Write to display
_start: //assume R0 and R1 have argument 1 and argument 2
				MOV R0,#0x3F
				MOV R1,#1

				CMP R1, #0
				BEQ IS_ZERO //move to 0 branch

				CMP R1, #1
				BEQ IS_ONE//move to 1 branch

				CMP R1, #2
				BEQ IS_TWO//move to 2 branch

				CMP R1, #3
				BEQ IS_THREE//move to 3 branch


				CMP R1, #4
				BEQ IS_FOUR//move to 4 branch

				CMP R1, #5
				BEQ IS_FIVE//move to 5 branch
				
				CMP R1, #6
				BEQ IS_SIX//move to 6 branch
				
				CMP R1, #7
				BEQ IS_SEVEN//move to 7 branch

				CMP R1, #8
				BEQ IS_EIGHT//move to 8 branch

				CMP R1, #9
				BEQ IS_NINE//move to 9 branch
				
				CMP R1, #0xA
				BEQ IS_TEN//move to A branch, Follwing we will implenment two sets of rules, i.e., input "10" as well as 'A' will both show "A"
				CMP R1, #0x41
				BEQ IS_TEN//move to 0 branch

				CMP R1, #0xB
				BEQ IS_ELEVEN
				CMP R1, #0x42
				BEQ IS_ELEVEN

				CMP R1, #0xC
				BEQ IS_TWELVE
				CMP R1, #0x43
				BEQ IS_TWELVE


        		CMP R1, #0xD
				BEQ IS_THIRTEEN
        		CMP R1, #0x44
				BEQ IS_THIRTEEN


        		CMP R1, #0xE
				BEQ IS_FOURTEEN
        		CMP R1, #0x45
				BEQ IS_FOURTEEN


        		CMP R1, #0xF
				BEQ IS_FIFTEEN
        		CMP R1, #0x46
				BEQ IS_FIFTEEN
 		

IS_ZERO: MOV R3,#0x3F
						B DISPLAY


IS_ONE: MOV R3,#0x06
						B DISPLAY


IS_TWO:MOV R3,#0x5B
						B DISPLAY


IS_THREE:MOV R3,#0x4F
						B DISPLAY


IS_FOUR:MOV R3,#0x66
						B DISPLAY


IS_FIVE:MOV R3,#0x6D
						B DISPLAY


IS_SIX:MOV R3,#0x7D
						B DISPLAY


IS_SEVEN:MOV R3,#0x07
						B DISPLAY


IS_EIGHT:MOV R3,#0x7F
						B DISPLAY


IS_NINE:MOV R3,#0x6F
						B DISPLAY


IS_TEN:MOV R3,#0x77
						B DISPLAY


IS_ELEVEN:MOV R3,#0x7C
						B DISPLAY


IS_TWELVE:MOV R3,#0x39
						B DISPLAY


IS_THIRTEEN:MOV R3,#0x5E
						B DISPLAY


IS_FOURTEEN:MOV R3,#0x79
						B DISPLAY


IS_FIFTEEN:MOV R3,#0x71
						B DISPLAY


DISPLAY:	  //R0 has the input value
                LDR R1, =HEX_BASE_ONE //R1 will have the base address of the display
                MOV R2,#0 //The counter for the displaY
				MOV R7,R3
                MOV R4,#0 // Will hold value of the current displays being lit


DISPLAY_LOOP:   CMP R2, #4
                LDREQ R1, =HEX_BASE_TWO
				MOVEQ R3,R7
				CMP R2,#6
				BEQ DONE
//to here

                AND R5,R0,#1 //checks R5 will hold the result if the LSB is 1
				ASR R0,R0,#1
                CMP R5,#0 //If the LSB is off jump to SHIFT_TO_NEXT_DISPLAY
                BEQ SHIFT_TO_NEXT_WRITE_DISPLAY

                //If the LSB is ON, write to the address to turn it ON
                LDR R6,[R1]
                ORR R6,R6,R3
				STR R6,[R1]




SHIFT_TO_NEXT_WRITE_DISPLAY:  LSL R3,#8
                        ADD R2, R2, #1
						B DISPLAY_LOOP




DONE: BX LR





