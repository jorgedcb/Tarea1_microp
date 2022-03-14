#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000
main:     RJMP start

.org 0x0040
start:    SBI   DDRD, 3
          CBI   DDRD, 5
loop:     SBIC  PIND, 5
          RJMP  off
          SBI   PORTD, 3 //LED ON
          RJMP  loop
off:      CBI   PORTD, 3 //LED OFF
          RJMP  loop          