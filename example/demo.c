#include <stdio.h>
#include <gb/gb.h>
#include <gb/console.h>

// clear the screen
void cls (void) NONBANKED;

void main () {
    DISPLAY_ON;
    cls();
    gotoxy(14, 8);
    printf("O HAI!");
}