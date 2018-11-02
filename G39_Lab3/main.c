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

/*
#include "./drivers/inc/HEX_displays.h"

int main(){
	//HEX_flood_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
	//HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
	HEX_write_ASM(HEX0| HEX3 | HEX4, 9);
	return 0;
}
*/

// #include "./drivers/inc/HEX_displays.h"
// #include "./drivers/inc/slider_switches.h"
// #include "./drivers/inc/pushbuttons.h"

// int main(){
// 	while(1){
// 		int num =read_slider_switches_ASM();
// 		write_LEDs_ASM(num);
// 		int disp = read_PB_data_ASM();
// 		if(num==0x00000200){
// 			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
// 		}else{
// 			HEX_clear_ASM(disp);
// 			HEX_flood_ASM(HEX4 | HEX5);
// 			HEX_write_ASM(disp,num);
// 		}
// 	}
// 	return 0;
// }

/*HPS timer driver*/
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"

int main()
{
	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0 | TIM1 | TIM2 | TIM3;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);

	while (1)
	{
		if (HPS_TIM_read_INT_ASM(TIM0))
		{
			HPS_TIM_clear_INT_ASM(TIM0);
			if (++count0 == 16)
			{
				count0 = 0;
			}
			HEX_write_ASM(HEX0, count0);
		}

		if (HPS_TIM_read_INT_ASM(TIM1))
		{
			HPS_TIM_clear_INT_ASM(TIM1);
			if (++count1 == 16)
			{
				count1 = 0;
			}
			HEX_write_ASM(HEX1, count1);
		}

		if (HPS_TIM_read_INT_ASM(TIM2))
		{
			HPS_TIM_clear_INT_ASM(TIM2);
			if (++count2 == 16)
			{
				count2 = 0;
			}
			HEX_write_ASM(HEX2, count2);
		}

		if (HPS_TIM_read_INT_ASM(TIM3))
		{
			HPS_TIM_clear_INT_ASM(TIM3);
			if (++count3 == 16)
			{
				count3 = 0;
			}
			HEX_write_ASM(HEX3, count3);
		}
	}

	return 0;
}