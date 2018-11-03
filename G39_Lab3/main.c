#include <stdio.h>

/*
LEDS COMPONENT

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"

int main(){
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
	}
	return 0;
}
*/



/* Hex display
#include "./drivers/inc/HEX_displays.h"

int main(){
	//HEX_flood_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
	//HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
	HEX_write_ASM(HEX0| HEX3 | HEX4, 9);
	return 0;
}
*/


/*
//Hex display, push button and switches
 #include "./drivers/inc/HEX_displays.h"
 #include "./drivers/inc/slider_switches.h"
 #include "./drivers/inc/pushbuttons.h"

 int main(){
 	while(1){
 		int num =read_slider_switches_ASM();
 		write_LEDs_ASM(num);
 		int disp = read_PB_data_ASM();
 		if(num==0x00000200){
 			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
 		}else{
 			HEX_clear_ASM(disp);
 			HEX_flood_ASM(HEX4 | HEX5);
 			HEX_write_ASM(disp,num);
 		}
 	}
 	return 0;
 }
*/


/*
//stop watchtimer
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"

int main() {

	HPS_TIM_config_t init;
	init.tim = TIM0;
	init.timeout = 10000;
	init.LD_en = 1;
	init.INT_en = 0;
	init.enable = 0;

	HPS_TIM_config_t configStart;
	configStart.tim = TIM0;
	configStart.timeout = 10000;
	configStart.LD_en = 1;
	configStart.INT_en = 0;
	configStart.enable = 1;

	HPS_TIM_config_t configStop;
	configStop.tim = TIM0;
	configStop.timeout = 10000;
	configStop.LD_en = 0;
	configStop.INT_en = 1;
	configStop.enable = 0;

	// polling timer
	HPS_TIM_config_t configFast;
	configFast.tim = TIM1;
	configFast.timeout = 2000;
	configFast.LD_en = 1;
	configFast.INT_en = 0;
	configFast.enable = 1;

	int millis0=0;
	int millis1=0;
	int secs0=0;
	int secs1=0;
	int mins0=0;
	int mins1=0;

	int pbs;

	HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);
	HPS_TIM_config_ASM(&init);
	HPS_TIM_config_ASM(&configFast);
	
	while(1) {
		

		if (HPS_TIM_read_INT_ASM(TIM1)) {
			HPS_TIM_clear_INT_ASM(TIM1);

			pbs = read_PB_edgecap_ASM() & 0x0000000F;
			if (pbs) {
				PB_clear_edgecap_ASM(PB0|PB1|PB2|PB3);

				if (pbs & 1) {
					HPS_TIM_config_ASM(&configStart);
				}
				else if (pbs & 2) {
					HPS_TIM_config_ASM(&configStop);
				}
				else if (pbs & 4) {
					millis0=0;
					millis1=0;
					secs0=0;
					secs1=0;
					mins0=0;
					mins1=0;
					HPS_TIM_config_ASM(&configStart);
				}
			}
		}

		if (HPS_TIM_read_INT_ASM(TIM0)) {
			HPS_TIM_clear_INT_ASM(TIM0);
			
			millis0++;
			if (millis0 == 10) {
				millis0 = 0;
				millis1++;
				if (millis1 == 10) {
					millis1 = 0;
					secs0++;
					if (secs0 == 10) {
						secs0 = 0;
						secs1++;
						if (secs1 == 6) {
							secs1 = 0;
							mins0++;
							if (mins0 == 10) {
								mins0 = 0;
								mins1++;
							}
						}
					}
				}
			}

			HEX_write_ASM(HEX0, millis0);
			HEX_write_ASM(HEX1, millis1);
			HEX_write_ASM(HEX2, secs0);
			HEX_write_ASM(HEX3, secs1);
			HEX_write_ASM(HEX4, mins0);
			HEX_write_ASM(HEX5, mins1);
		}
	}

	return 0;
}
*/

//Interrupt

#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"

int main() {

	int_setup(2, (int[]) {199, 73});

	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0;
	hps_tim.timeout = 10000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 0;
	hps_tim.enable = 0;

	HPS_TIM_config_t configStart;
	configStart.tim = TIM0;
	configStart.timeout = 10000;
	configStart.LD_en = 1;
	configStart.INT_en = 0;
	configStart.enable = 1;

	HPS_TIM_config_t configStop;
	configStop.tim = TIM0;
	configStop.timeout = 10000;
	configStop.LD_en = 0;
	configStop.INT_en = 1;
	configStop.enable = 0;

	int millis0=0;
	int millis1=0;
	int secs0=0;
	int secs1=0;
	int mins0=0;
	int mins1=0;

	HPS_TIM_config_ASM(&hps_tim);
	pb_int_flag = -1;
	enable_PB_INT_ASM(PB0|PB1|PB2);

	while (1) {

		if (pb_int_flag != -1) {
			if (pb_int_flag == 0)
				HPS_TIM_config_ASM(&configStart);
            
			else if (pb_int_flag == 1) 
				HPS_TIM_config_ASM(&configStop);
            
			else if (pb_int_flag == 2) { 
				millis0=0;
				millis1=0;
				secs0=0;				
				secs1=0;
				mins0=0;
				mins1=0;
				HPS_TIM_config_ASM(&configStop);
			}

			pb_int_flag = -1;
		}


		if (hps_tim0_int_flag) {
			hps_tim0_int_flag = 0;
			
			millis0++;
			if (millis0 == 10) {
				millis0 = 0;
				millis1++;
				if (millis1 == 10) {
					millis1 = 0;
					secs0++;
					if (secs0 == 10) {
						secs0 = 0;
						secs1++;
						if (secs1 == 6) {
							secs1 = 0;
							mins0++;
							if (mins0 == 10) {
								mins0 = 0;
								mins1++;
							}
						}
					}
				}
			}
		
			HEX_write_ASM(HEX0, millis0);
			HEX_write_ASM(HEX1, millis1);
			HEX_write_ASM(HEX2, secs0);
			HEX_write_ASM(HEX3, secs1);
			HEX_write_ASM(HEX4, mins0);
			HEX_write_ASM(HEX5, mins1);

		}
	}


	return 0;
}


