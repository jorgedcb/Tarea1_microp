.nolist
.include "m328pdef.inc"
.list

.cseg
.org 0x0000
reset:	   JMP main

.org 0x0040
main:
	LDI R16, 0x96
	LDI R17, 0x00
	LDI R18, 0x00
	LDI R19, 0x00
	LDI R20, 0x0
loop:
	CPI R20, 0x0A
	BREQ result  //se salta si
	ADD R18,R16
 	ADC R19,R17
	INC R20
	RJMP loop
result:
	STS 0x0100, R19
	STS 0x0101, R18
break
