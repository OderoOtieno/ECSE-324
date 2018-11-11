//testing        
	.text

	.global write_audio_data_ASM
	.equ Control,	0xFF203040
	.equ Fifospace,	0xFF203044
	.equ Leftdata,	0xFF203048
	.equ Rightdata,	0xFF20304C//Typo in the paper. Corrected.


write_audio_data_ASM:

					 LDR R2, =Fifospace
					 LDR R3, [R2]       //load the value from Fifospace 
		 			 LSR R3, R3, #16
         			 MOV R4, R3   //R4 holds the value of the WSRC and WSLC

					 LDRB R5, [R4]		    // Half word: stores value of WSRC

		 			 LSR R4, R4, #8		//R4 holds the value of WSLC

		 			 LDRB R6, [R4]         //R6 stores value of WSLC 

		 			 CMP R5,#0              //check the avalibility of WSRC (whether have space
         			 BEQ No_Space           
                     CMP R6,#0              //check the avalibility of WSLC (whether have space
         			 BEQ No_Space           


		 			 LDR R7,=Leftdata		//get the address of Leftdata
         			 LDR R8,=Rightdata		//get the address of Rightdata
         			 STR R0,[R7]			//store the value 
         			 STR R0,[R8]			//store the value
         			 MOV R0, #1				//return 1 
		 			 B END
		 
No_Space:
					 MOV R0, #0				//return 0 
END:				 BX LR
