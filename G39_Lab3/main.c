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

