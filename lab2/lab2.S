#define __SFR_OFFSET 0
#include "avr/io.h"

.global main

.org 0x0000 //donde comienza el programa
main:    RJMP start

.org 0x0040
start:    LDI   R16, 0xef //pin 4 del puerto de como entrada resto como salida
          OUT   DDRD, R16 
          LDI   R16, 0xff //todo el puerto b como salida
          OUT   DDRB, R16

          LDI   R16, 0x00
          OUT   TCCR0A, R16  ;Disable comparators, set WGM01-00 to zero
          LDI   R16, 0x03
          OUT   TCCR0B, R16  ;Pick /64 pre-scaler, set WGM02 to zero (mode 0)

          //se mapea con su respectivo numero
          LDI R16, 0x01   //0
          STS 0x0100, R16 
          LDI R16, 0x8F    //1
          STS 0x0101, R16
          LDI R16, 0x22   //2
          STS 0x0102, R16
          LDI R16, 0x06    //3
          STS 0x0103, R16
          LDI R16, 0x8C   //4
          STS 0x0104, R16
          LDI R16, 0x44   //5
          STS 0x0105, R16
          LDI R16, 0x40   //6
          STS 0x0106 , R16
          LDI R16, 0x0F    //7
          STS 0x0107, R16
          LDI R16, 0x00   //8
          STS 0x0108, R16
          LDI R16, 0x04   //9
          STS 0x0109, R16
          LDI R16, 0x08   //A
          STS 0x010A, R16
          LDI R16, 0xC0    //B
          STS 0x010B, R16
          LDI R16, 0x61   //C
          STS 0x010C, R16
          LDI R16, 0x82  //D
          STS 0x010D, R16
          LDI R16, 0x60   //E
          STS 0x010E, R16
          LDI R16, 0x68   //F
          STS 0x010F, R16
          //estas variables se modificaran para mostrar los diferentes numeros
          LDI XH, 0x01
          LDI XL, 0x00
          LDI YH, 0x01
          LDI YL, 0x00
loop:     SBIS PIND , 4 //si se presiona
          call inc //incremento
          LDI R20, 50
          CALL delay_ms //para solucionar el rebote
          //display 
          CBI PORTB, 0
          CBI PORTB, 1
          LD R16, X
          OUT PORTD, R16
          SBI PORTB, 0
          CBI PORTB, 1
          LDI R20, 5
          CALL delay_ms
          CBI PORTB, 0
          CBI PORTB, 1
          LD R17, Y
          OUT PORTD, R17
          CBI PORTB, 0
          SBI PORTB, 1
          LDI R20, 5
          CALL delay_ms
          RJMP loop

inc:      SBIS PIND , 4
          RJMP inc //no avanza si sigue presionado
          CPI YL, 0x0F
          BREQ reset //hace reset si ya esta en f el segundo digito
          INC YL //sino es f incremente 1 el segundo digito
          ret
reset:    CPI XL, 0x0F
          BREQ resetff //hace reset de los dos digitos si el primer digito tambien esta en f
          INC XL      //si solo era el segundo digito que estaba en f pone en 0 este y aumenta en 1 el primer digito
          LDI YH, 0x01
          LDI YL, 0x00
          ret
resetff:  LDI XH, 0x01 //ambos digitos en 1
          LDI XL, 0x00
          LDI YH, 0x01
          LDI YL, 0x00
          ret

; Delay about R20*1ms. Destroys R20, R16
delay_ms: LDI   R16, 6
          OUT   TCNT0,R16     ;Count 250 events
li:       SBIS  TIFR0,0       ;Check for timer reset
          RJMP  li
          CBI   TIFR0,0
          DEC   R20
          BRNE  delay_ms
          ret