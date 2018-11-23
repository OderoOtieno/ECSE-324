#include <stdio.h>
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"

/*
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
        if(PB==1){
                if( switches == 0 ){ //if switch is off
					test_char();
                }
                else{
                    test_byte();
                }
        }
        else if (PB==2){
            test_pixel();
			
        }
        else if(PB==4){
            VGA_clear_charbuff_ASM();
			
        }

        else if(PB==8){
                VGA_clear_pixelbuff_ASM();
        }
        

	}
    return 0;

}

*/

int main(){
	int x=0;
	int y=0;
	int x_max = 80;
	int y_max = 60;	
	char data;
	char *dataPointer=&data;	

    while(1){
		int read_data = read_PS2_data_ASM(dataPointer);
		if(read_data){
			VGA_write_byte_ASM(x,y,*dataPointer);
			x= x+3; //skip 2 bytes and a space to input a new set
					//of 2 bytes
				if(x>=x_max){
					x=0;
					y=y+1;
				}
				if(y>=y_max){
				//clean display and start from y=0 the top again
					VGA_clear_charbuff_ASM();
					y=0;
				}
		}

			
        

    }

}
