#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000 //donde comienza el programa
main:    RJMP start

.org 0x0040
start:    LDI   R16, 0xFF
          OUT   DDRD, R16   
blink:    LDI   R16, 0x56  ;Load code for Digit 1
          OUT   PORTD, R16
          LDI   R23,200
          CALL  delay
          LDI   R16, 0xA5  ;Load code for Digit 1
          OUT   PORTD, R16
          LDI   R23,100
          CALL  delay
          LDI   R16, 0x69  ;Load code for Digit 1
          OUT   PORTD, R16
          LDI   R23,150
          CALL  delay
          RJMP blink




; Delay about R23*1ms. Destroys R23, R24, and R25.
; One millisecond is about 16000 cycles at 16MHz.
delay:    LDI   R22,100
delay_ms: LDI   R25, 0x0F ; high byte
          LDI   R24, 0x9E ; low byte
l1:       SBIW  R24, 1
          BRNE  l1
          SUBI  R22, 1
          BRNE  delay_ms
          SUBI  R23, 1
          BRNE  delay
          ret