#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000
main:     JMP start

.org 0x0040
start:    SBI   DDRD,3  ;PORTD3 as out
          SBI   DDRD,4  ;PORTD4 as out
  
blink:    SBI   PORTD,3 ;ON red LED
          CBI   PORTD,4 ;OFF green LED
          LDI   R23,250 
          CALL  delay_ms
          CBI   PORTD,3 ;OFF red LED
          SBI   PORTD,4 ;ON green LED
          LDI   R23,250
          CALL  delay_ms
          RJMP  blink

; Delay about R23*1ms. Destroys R23, R24, and R25.
; One millisecond is about 16000 cycles at 16MHz.
delay_ms: LDI   R25, 0x0F ; high byte
          LDI   R24, 0x9E ; low byte
l1:       SBIW  R24, 1
          BRNE  l1
          SUBI  R23, 1
          BRNE  delay_ms
          ret