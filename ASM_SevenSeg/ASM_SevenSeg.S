#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000
main:     JMP start

.org 0x0040
start:    LDI   R16, 0xFF
          OUT   DDRD, R16   ;PortD (7-seg) and Digit 1,2 as out
          SBI   DDRB, 0   
          SBI   DDRB, 1   
loop:     CBI   PORTB, 0    ;Clear digits
          CBI   PORTB, 1    
          LDI   R16, 0x02   ;Load code for Digit 1
          OUT   PORTD, R16
          SBI   PORTB, 0    ;Activate Digit 1
          CBI   PORTB, 1
          LDI   R23, 5      ;Show for 5ms
          CALL  delay_ms
          CBI   PORTB, 0    ;Clear digits
          CBI   PORTB, 1
          LDI   R16, 0x00   ;Load code for Digit 1
          OUT   PORTD, R16  
          CBI   PORTB, 0    
          SBI   PORTB, 1    ;Activate Digit 2
          LDI   R23, 5      ;Show for 5ms
          call  delay_ms    
          RJMP  loop

; Delay about R23*1ms. Destroys R23, R24, and R25.
; One millisecond is about 16000 cycles at 16MHz.
delay_ms: LDI   R25, 0x0F ; high byte
          LDI   R24, 0x9E ; low byte
l1:       SBIW  R24, 1
          BRNE  l1
          SUBI  R23, 1
          BRNE  delay_ms
          ret