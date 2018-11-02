		.text
		.global read_PB_data_ASM
        .global PB_data_is_pressed_ASM

        .global read_PB_edgecap_ASM
        .global PB_edgecap_is_pressed_ASM
        .global PB_clear_edgecap_ASM

        .global enable_PB_INT_ASM
        .global disable_PB_INT_ASM

        .equ button_base_data, 0xFF200050
        .equ button_base_interruptmask, 0xFF200058
        .equ button_base_edgecapture, 0xFF20005C

//access the push button data registers
read_PB_data_ASM: 
                  LDR R0,=button_base_data
                  LDR R0,[R0]
                  BX LR  



PB_data_is_pressed_ASM: PUSH {R1}
					  LDR R0,=button_base_data
					   LDR R1,=button_base_edgecapture
						MOV R0,R1
						POP {R1}
						BX LR
					
						


read_PB_edgecap_ASM:
PB_edgecap_is_pressed_ASM:
PB_clear_edgecap_ASM:


enable_PB_INT_ASM:
disable_PB_INT_ASM:

