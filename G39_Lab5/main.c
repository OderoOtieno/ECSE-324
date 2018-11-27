#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"

int notesPressed[8] = {};



//Generates a sample signal given a freq and int
int genSample(float freq, int t){
	int index = (int)(((int)freq*t)%48000);
	float diff = ((freq*t)-(int)freq*t);

	if(diff==0){
		return (int)sine[index]; //get amplitude? or is it amplitude of 1
	}
	else{
		return (int)((1.0-diff)*sine[index]+ diff*sine[index+1]);
	}
}


int main() {
	float freq [] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};
	char val;
	int amplitude=1; //I just set 1 randomly
	int signal;

	//Timer configuration retrieved from lab 3
	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0 | TIM1 | TIM2 | TIM3;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);

	while(1) {
		/*
		int valid=read_ps2_data_ASM(&val);
		if(valid){
			switch(val){

				//note C
				case(0x1C):
					if(valid){
						notesDisplay[0]='C';
						notesPressed[0]=1;
					}
					else{
						notesDisplay
					}
					break;
				
				case(0x1B):
					if(valid){
						notesDisplay[1]='D';
						notesPressed[1]=1;
					}
					else{
						notesDisplay
					}
					break;


				case(0x23):
					if(valid){
						notesDisplay[2]='E';
						notesPressed[2]=1;
					}
					else{
						notesDisplay
					}
					break;


				case(0x2B):
					if(valid){
						notesDisplay[3]='F';
						notesPressed[3]=1;
					}
					else{
						notesDisplay
					}
					break;

				case(0x3B):
					if(valid){
						notesDisplay[4]='G';
						notesPressed[4]=1;
					}
					else{
						notesDisplay
					}
					break;

				case(0x42):
					if(valid){
						notesDisplay[5]='A';
						notesPressed[5]=1;
					}
					else{
						notesDisplay
					}
					break;

				case(0x4B):
					if(valid){
						notesDisplay[6]='B';
						notesPressed[6]=1;
					}
					else{
						notesDisplay
					}
					break;

				case(0x4C):
					if(valid){
						notesDisplay[0]='C';
						notesPressed[0]=1;
					}
					else{
						notesDisplay
					}
					break;
				default:
					valid=0;

			}
		

		signal = amplitude*genSignal(notesPressed,t);
}*/

	int a=0;
	while(a<48000){
		int signal = genSample(261.262,a);
		//write_audio_data_ASM(signal);//we get 240 iterations which returns "1"

 		audio_write_data_ASM(signal, signal);

		a++;
	}

	}


	return 0;
}


//Sum user inputed samples to generate signal
int genSignal(int *notePressed, float * frequencies, int t){
	int signal=0;
	int i;
	for (i=0;i<8;i++){
		if(notePressed[i]==1){ //if the key has been pressed
			signal+=genSample(frequencies[i], t);
		}
	}
	return signal;
}




