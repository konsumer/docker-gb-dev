#include <gb/gb.h>
#include <gb/drawing.h>
#include <gb/bgb_emu.h>

void main () {
    gotogxy(7, 8);
    gprintf("O HAI!");
    BGB_MESSAGE("O HAI!");
}