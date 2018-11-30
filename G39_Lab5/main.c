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

//holds frequencies corresponding to each note value 
int notes_to_play [8] = {};
int * note_pointer = &notes_to_play;

//holds the keys pressed for a toggle play note style instead of holding
int keysPressed [8] = {};
int * keys_pointer = &keysPressed;

//Generates a sample signal given a freq and int
int genSample(float freq, int *t){
	int time = *t;
	int index = (int)(((int)freq*time)%48000);
	float diff = ((freq*time)-(int)freq*time);
	
	if(diff==0){
		return (int)sine[index]; //get amplitude? or is it amplitude of 1
	}
	else{
		return (int)((1.0-diff)*sine[index]+ diff*sine[index+1]);
	}
}

/* TEST for audio
	int a=0;
	while(a<48000){
		int signal = genSample(261.262,a);
		//write_audio_data_ASM(signal);//we get 240 iterations which returns "1"

 		audio_write_data_ASM(signal, signal);

		a++;
	}
*/



//Sum user inputed samples to generate signal
float genSignal(int *keysPressed,int *notes_to_play, int * t){
	float signal=0;
	int i;
	for (i=0;i<8;i++){
		if(keysPressed[i]==1){ //if the key has been pressed
			signal+=genSample(notes_to_play[i], t);
		}
	}
	return signal;
}

int main() {
	float frequencies [] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};
	
	//value of key pressed
	char val;
	char * val_pointer = &val;

	//Amplitude is the volume of the signal
	int amplitude=1;
	
	double signal;
	int time=0;
	int * time_pointer = &time;

	//Timer configuration retrieved from lab 3
	int_setup(1, (int []){199});
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0; // | TIM1 | TIM2 | TIM3; Only need the microsecond component
	hps_tim.timeout = 20; //approximate period of 48000 Hz (Reminder tau= 1/F)
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);

	


	//while loop that will check all buttons and declare them 
	while(1){

		int valid = read_ps2_data_ASM(val_pointer);

		if(valid){
			switch (val){
				//Pressed A and achieve Frequency of 130.813 Hz
				case 0x1C:
					//if it has already been pressed toggle off
					if(keysPressed[0]){
						notes_to_play[0]=0;
						keysPressed[0]=0;
					}
					else{
						keysPressed[0]=1;
						notes_to_play[0]=frequencies[0];
					}
					break;

				//Pressed S and achieve Frequency of 146.832 Hz
				case 0x1B:
					if(keysPressed[1]){
						notes_to_play[1]=0;
						keysPressed[1]=0;
					}
					else{
						keysPressed[1]=1;
						notes_to_play[1]=frequencies[1];
					}
					break;

				//Pressed D and achieve Frequency of 164.814 Hz
				case 0x23:
					if(keysPressed[2]){
						notes_to_play[2]=0;
						keysPressed[2]=0;
					}
					else{
						keysPressed[2]=1;
						notes_to_play[2]=frequencies[2];
					}
					break;

				//Pressed F and achieve Frequency of 174.614 Hz
				case 0x2B:
					if(keysPressed[3]){
						notes_to_play[3]=0;
						keysPressed[3]=0;
					}
					else{
						keysPressed[3]=1;
						notes_to_play[3]=frequencies[3];
					}
					break;


				//Pressed J and achieve Frequency of 195.998 Hz
				case 0x3B:
					if(keysPressed[4]){
						notes_to_play[4]=0;
						keysPressed[4]=0;
					}
					else{
						keysPressed[4]=1;
						notes_to_play[4]=frequencies[4];
					}
					break;


				//Pressed K and achieve Frequency of 220.000 Hz
				case 0x42:
					if(keysPressed[5]){
						notes_to_play[5]=0;
						keysPressed[5]=0;
					}
					else{
						keysPressed[5]=1;
						notes_to_play [5]=frequencies[5];
					}
					break;


				//Pressed L and achieve Frequency of 246.942 Hz
				case 0x4B:
					if(keysPressed[6]){
						notes_to_play[6]=0;
						keysPressed[6]=0;
					}
					else{
						keysPressed[6]=1;
						notes_to_play[6]=frequencies[6];
					}
					break;


				
				//Pressed ; and achieve Frequency of 261.626 Hz
				case 0x4C:
					if(keysPressed[7]){
						notes_to_play[7]=0;
						keysPressed[7]=0;
					}
					else{
						keysPressed[7]=1;
						notes_to_play[7]=frequencies[7];
					}
					break;

			
				//Volume up, press Q
				case 0x15:
					if(amplitude>100){
						break;
					}
					else{
						amplitude+=1;
					}
					break;

				//Volume down, press E
				case 0x24:
					if(amplitude==0){
						break;
					}
					else{
						amplitude-=1;
					}
					break;

				default:
					break;

			}
		}
		

		signal = amplitude*genSignal(keys_pointer,note_pointer,time_pointer);//t will be current timer

		if(hps_tim0_int_flag){ //pulled from lab 3, checks the interrupt from timer after timeout
			hps_tim0_int_flag=0; //reset the timeout
			audio_write_data_ASM(signal, signal);
			
			//keeps time iterating and below 48000 for multiplying in the genSample function
			if(time%48000 == 0){
				time=0;
			}
			time+=1;
		}
	}
	return 0;
	
}








