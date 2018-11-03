	.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR

	.global hps_tim0_int_flag
	.global pb_int_flag

hps_tim0_int_flag:
	.word 0x0

pb_int_flag:
	.word 0x0

A9_PRIV_TIM_ISR:
	BX LR

	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:
	PUSH {R1, LR}

	MOV R0, #0x1
	BL HPS_TIM_clear_INT_ASM

	LDR R0, =hps_tim0_int_flag
	MOV R1, #1
	STR R1, [R0]

	POP {R1, LR}
	BX LR
	
HPS_TIM1_ISR:
	BX LR
	
HPS_TIM2_ISR:
	BX LR
	
HPS_TIM3_ISR:
	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR

	
FPGA_PB_KEYS_ISR:	
	PUSH {R1-R3, LR}
	BL read_PB_edgecap_ASM      // reading edgecap
	BL PB_clear_edgecap_ASM     // clearing edgecap

	LDR R1, =pb_int_flag        // the address of int flag


CHECK_KEY_0:
	MOVS R3, #0x1
	ANDS R3, R0
	BEQ CHECK_KEY_1
	MOVS R2, #0                 // int flag = 0
	STR R2, [R1]
	B END_KEY_ISR

CHECK_KEY_1:
	MOVS R3, #0x2
	ANDS R3, R0
	BEQ CHECK_KEY_2
	MOVS R2, #1                 // int flag = 1
	STR R2, [R1]
	B END_KEY_ISR

CHECK_KEY_2:
	MOVS R3, #0x4
	ANDS R3, R0
	BEQ CHECK_KEY_3 
	MOVS R2, #2                 // int flag = 2
	STR R2, [R1]
	B END_KEY_ISR

CHECK_KEY_3:
	MOVS R2, #3                 // int flag = 3
	STR R2, [R1]

END_KEY_ISR:
	POP {R1-R3, LR}             // restore state
	BX LR
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
	.end
