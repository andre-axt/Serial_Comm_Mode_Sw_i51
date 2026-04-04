	ORG	0059h

SERIAL_TI:
	CLR	TI
	RETI

SERIAL_TRM:
	MOV     R1,     P2
	JNB     SM0,    SERIAL_TRM_0_1
        MOV	C,	P3.7
	MOV     TB8,    C
	MOV     A,      P2
	MOV	SBUF,	A
        RET	
	
SERIAL_TRM_0_1:
	MOV	A,	P2
	MOV	SBUF,	A
	RET
		
