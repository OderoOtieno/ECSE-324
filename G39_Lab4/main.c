#include <stdio.h>
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"


void test_char(){
    int x,y;
    char c=0;
    
    for(y=0; y<=59 ; y++){
        for(x=0;x<=79;x++){
            VGA_write_char_ASM(x,y,c++);
        }
    }
}

void test_byte(){
    int x,y;
    char c = 0;

    for(y=0; y<=59 ; y++){
        for(x=0;x<=79; x+=3){
            VGA_write_byte_ASM(x,y,c++);
        }
    }
}

void test_pixel(){
    int x,y;
    unsigned short colour = 0;
    
    for(y=0;y<=239;y++){
        for(x=0;x<=319;x++){
            VGA_draw_point_ASM(x,y,colour++);
        }
    }
}


int main (){
	while(1){
		int switches = read_slider_switches_ASM();
		int PB = read_PB_data_ASM();
		switch(PB){
            case 1:
                if( switches == 0 ){ //if switch is off
					test_char();
					break;
                }
                else{
                    test_byte();
					break;
                }
            case 2:
                test_pixel();
				break;

            case 4:
                VGA_clear_charbuff_ASM();
				break;

            case 8:
                VGA_clear_pixelbuff_ASM();
				break;
        }

	}
    return 0;


}

