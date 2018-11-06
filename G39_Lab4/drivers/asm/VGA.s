        .text
        .equ VGA_PIXEL_BUFFER, 0xC8000000
		.equ VGA_CHAR_BUFFER, 0xC9000000

		.global VGA_clear_charbuff_ASM
		.global VGA_clear_pixelbuff_ASM

		.global VGA_write_char_ASM
		.global VGA_write_byte_ASM

		.global VGA_draw_point_ASM

        
VGA_clear_pixelbuff_ASM:  PUSH {R0-R4}
							LDR R0,=VGA_PIXEL_BUFFER
							MOV R1, #0 //x
							MOV R2, #0 //y 

CLEAR_PIXEL_ROW:		CMP R1,#320
						ADD R1,R1,#1
						ADD R3,R1,#0 // clone of R1
						LSL R3,#1
						ADD R0,R3,R0
						BLT CLEAR_PIXEL_COLUMN //clear column by column
						BEQ DONE_PIXEL_CLEAR

CLEAR_PIXEL_COLUMN:

                        CMP R2,#240
			ADDLT R2,R2,#1
			MOVEQ R2,#0
			BEQ CLEAR_PIXEL_ROW
			ADD R4,R0,#0 //copy of R0
			LSL R2,#10
			ADD R4,R4,R2
			MOV R5,#0
			STR R5,[R4]
			B CLEAR_PIXEL_COLUMN
			
DONE_PIXEL_CLEAR: POP {R0-R4}
				BX LR








VGA_clear_charbuff_ASM:  PUSH {R0-R4}
                        
CLEAR_CHAR_ROW:         LDR R0,=VGA_CHAR_BUFFER
                        MOV R1, #0 //x
                        MOV R2, #0 //y 
                        CMP R1,#320

                        ADD R1,R1,#1
                        ADD R3,R1,#0 // clone of R1
                        LSL R3,#1
                        ADD R0,R3,R0
                        BLT CLEAR_CHAR_COLUMN //clear column by column
                        BEQ DONE_CHAR_CLEAR

CLEAR_CHAR_COLUMN:      CMP R2,#240
			ADDLT R2,R2,#1
			MOVEQ R2,#0
			BEQ CLEAR_CHAR_ROW
			ADD R4,R0,#0 //copy of R0
			LSL R2,#10
			ADD R4,R4,R2
			MOV R5,#0
			STR R5,[R4]
			B CLEAR_CHAR_COLUMN
			
DONE_CHAR_CLEAR: POP {R0-R4}
				BX LR












VGA_write_char_ASM: //R0 has x
                //R1 has y
                //R2 has char c 
                PUSH {R0-R3}

                //X
                CMP R0,#0
                BLT WRITE_CHAR_DONE
                CMP R0,#80
                BGE WRITE_CHAR_DONE

                //Y
                CMP R1,#0
                BLT WRITE_CHAR_DONE
                CMP R1,#60
                BGE WRITE_CHAR_DONE


                LDR R3,=VGA_CHAR_BUFFER
                LSL R1,#7
                ADD R3,R3,R1
                ADD R3,R3,R2

                STRB R2,[R3]


WRITE_CHAR_DONE:POP {R0-R3}
                BX LR      
                














VGA_write_byte_ASM://R0 has x
                //R1 has y
                //R2 has colour

                PUSH {R0-R9}

                //X
                CMP R0,#0
                BLT WRITE_BYTE_DONE
                CMP R0,#80
                BGE WRITE_BYTE_DONE


                //Y
                CMP R1,#0
                BLT WRITE_BYTE_DONE
                CMP R1,#60
                BGE WRITE_BYTE_DONE
                

                LDR R3,=VGA_PIXEL_BUFFER //address
                MOV R4,R3 //copy of address
                LSL R1,#7 //shift y by 7 bits
                LDR R5,R0,#1 //Copy of x with +1 for extra char

                //make the new address 1 with x and y
                ADD R3,R0,R3
                ADD R3,R1,R3

                //make the new address 2 with x+1 and y
                ADD R4,R5,R4
                ADD R4,R5,R4

                STR R2,[R6]
                LDRH R7,[R6]
                AND R8, R7,#0xF //second portion of bits
                ASR R7,R7,#4 //first portion

                MOV R9,R7
                BL GEN_CHAR
                STRB R9, [R3]

                MOV R9,R8
                BL GEN_CHAR
                STRB R9, [R4]

                B WRITE_BYTE_DONE



                

GEN_CHAR:       CMP R9, #0xA
                MOVEQ R9, #65

                CMP R9, #0xB
                MOVEQ R9, #66

                CMP R9, #0xC
                MOVEQ R9, #67

                CMP R9, #0xD
                MOVEQ R9, #68

                CMP R9, #0xE
                MOVEQ R9, #69

                CMP R9, #0xF
                MOVEQ R9, #70

                BX LR


WRITE_BYTE_DONE: POP {R0-R9}
                BX LR
    








VGA_draw_point_ASM:
                //R0 has x
                //R1 has y
                //R2 has short colour
                PUSH {R0-R3}

                //X
                CMP R0,#0
                BLT WRITE_CHAR_DONE
                CMP R0,#320
                BGE WRITE_CHAR_DONE

                //Y
                CMP R1,#0
                BLT WRITE_CHAR_DONE
                CMP R1,#240
                BGE WRITE_CHAR_DONE


                LDR R3,=VGA_PIXEL_BUFFER
                LSL R1,#7
                ADD R3,R3,R1
                ADD R3,R3,R2

                STRB R2,[R3]


WRITE_CHAR_DONE:POP {R0-R3}
                BX LR   