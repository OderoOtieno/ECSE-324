        .text
        .equ VGA_PIXEL_BUFFER, 0xC8000000
		.equ VGA_CHAR_BUFFER, 0xC9000000

		.global VGA_clear_charbuff_ASM
		.global VGA_clear_pixelbuff_ASM

		.global VGA_write_char_ASM
		.global VGA_write_byte_ASM

		.global VGA_draw_point_ASM

        
VGA_clear_pixelbuff_ASM:  PUSH {R0-R7,LR}
						LDR R0,=VGA_PIXEL_BUFFER
                        MOV R1, #0 //x
                        MOV R2, #0 //y       

CLEAR_PIXEL_ROW:		CMP R1,#320
                        ADD R3,R1,#0 // clone of R1
                        LSL R3,#1
						ADD R7,R0,#0
                        ADD R7,R3,R7
                        BLT CLEAR_PIXEL_COLUMN //clear column by column
                        BEQ DONE_PIXEL_CLEAR

CLEAR_PIXEL_COLUMN:

			CMP R2,#240
			MOVEQ R2,#0
			ADDEQ R1,R1,#1
			BEQ CLEAR_PIXEL_ROW
			ADD R4,R7,#0 //copy of R0
			ADD R5,R2,#0
			LSL R5,#10
			ADD R4,R4,R5
			MOV R6,#0x0
			STRH R6,[R4]
			ADDLT R2,R2,#1
			B CLEAR_PIXEL_COLUMN
			
DONE_PIXEL_CLEAR: POP {R0-R7,LR}
				BX LR








VGA_clear_charbuff_ASM: PUSH {R0-R7,LR}
						LDR R0,=VGA_CHAR_BUFFER
                        MOV R1, #0 //x
                        MOV R2, #0 //y       
CLEAR_CHAR_ROW:   
                        CMP R1,#80
                        ADD R3,R1,#0 // clone of R1
                        //LSL R3,#1
						ADD R7,R0,#0
                        ADD R7,R3,R7
                        BLT CLEAR_CHAR_COLUMN //clear column by column
                        BEQ DONE_CHAR_CLEAR

CLEAR_CHAR_COLUMN:      CMP R2,#60
			MOVEQ R2,#0
			ADDEQ R1,R1,#1
			BEQ CLEAR_CHAR_ROW
			ADD R4,R7,#0 //copy of R0
			ADD R5,R2,#0
			LSL R5,#7
			ADD R4,R4,R5
			MOV R6,#0x0
			STRB R6,[R4]
			ADDLT R2,R2,#1
			B CLEAR_CHAR_COLUMN
			
DONE_CHAR_CLEAR: POP {R0-R7,LR}
				BX LR




VGA_write_char_ASM: //R0 has x
                //R1 has y
                //R2 has char c 
                PUSH {R0-R3,LR}

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
                ADD R3,R3,R0
                ADD R3,R3,R1

                STRB R2,[R3]


WRITE_CHAR_DONE:POP {R0-R3,LR}
                BX LR      
                






VGA_write_byte_ASM://R0 has x
                  //R1 has y
                //R2 has byte

				PUSH {R0-R9,LR}

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
                

                LDR R3,=VGA_CHAR_BUFFER //address
                MOV R4,R3 //copy of address
                LSL R1,#7 //shift y by 7 bits
                ADD R5,R0,#1 //Copy of x with +1 for extra char

                //make the new address 1 with x and y
                ADD R3,R0,R3
                ADD R3,R1,R3

                //make the new address 2 with x+1 and y
                ADD R4,R5,R4 //add the new X
                ADD R4,R1,R4 //add the new Y
				
				MOV R6,#0
                STR R2,[R6]
                LDRH R7,[R6] //load half word content into R7
                AND R8, R7,#0xF //second byte to display
                ASR R7,R7,#4 //First byte to display

                MOV R9,R7
                BL GEN_CHAR
                STRB R9, [R3]

                MOV R9,R8
                BL GEN_CHAR
                STRB R9, [R4]

                B WRITE_BYTE_DONE


GEN_CHAR:       
                CMP R9, #0x0
				MOVEQ R9, #48

                CMP R9, #0x1
                MOVEQ R9, #49

                 CMP R9, #0x2
                MOVEQ R9, #50

                CMP R9, #0x3
                MOVEQ R9, #51

                 CMP R9, #0x4
                MOVEQ R9, #52

                CMP R9, #0x5
                MOVEQ R9, #53

                 CMP R9, #0x6
                MOVEQ R9, #54

                CMP R9, #0x7
                MOVEQ R9, #55

                CMP R9, #0x8
                MOVEQ R9, #56

                CMP R9, #0x9
                MOVEQ R9, #57

                CMP R9, #0xA
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
				
				CMP R9, #0x0
				MOVEQ R9, #48

                BX LR


WRITE_BYTE_DONE: POP {R0-R9,LR}
                BX LR
    








VGA_draw_point_ASM:
                //R0 has x
                //R1 has y
                //R2 has char c 
                PUSH {R0-R3,LR}

                //X
                CMP R0,#0
                BLT WRITE_CHAR_DONE
                CMP R0,#320
                BGE WRITE_CHAR_DONE
				LSL R0,#1
                //Y
                CMP R1,#0
                BLT WRITE_CHAR_DONE
                CMP R1,#240
                BGE WRITE_CHAR_DONE


                LDR R3,=VGA_PIXEL_BUFFER
                LSL R1,#10
                ADD R3,R3,R0
                ADD R3,R3,R1
				
                STRH R2,[R3]


WRITE_DRAW_DONE:POP {R0-R3,LR}
                BX LR    
