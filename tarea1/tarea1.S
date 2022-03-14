#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000 //donde comienza el programa
main:    RJMP start

.org 0x0040
start:    LDI R29,0x01 
          LDI R28,0X10 
          LDI R16,0x10 //cargo 0110 en Y y 16 porque voy llenar el vector al contrario
vector:   SUBI R16,1 //llenando el vector
          ST -Y, R16
          BRNE vector
          LDI R18,0XFF
          OUT DDRD, R18 //puerto d como salida
nuevo:    LDI R29,0x01 
          LDI R28,0X00
          LDI R19,0X10
mostrar:  LD R17, Y+ //2  aqui muestro los valores en los led
          OUT PORTD,R17 // 1
          LDI R23,250 //1
          CALL delay_ms // 4 
          DEC R19 //  1
          BRNE mostrar // 1 or 2
          RJMP nuevo //
          
delay_ms: LDI R25,0x3E // 1 //delay 1 segundo
          LDI R24,0X7F // 1
l1:       SBIW R24,1 // 2
          BRNE l1 // 1 or 2
          SUBI R23,1 // 1
          BRNE delay_ms // 1 or 2
          ret //4 