	ORG	0051h

SERIAL_TI:
	CLR	TI
	RETI

SERIAL_TRM:
	JNB     SM0,    SERIAL_TRM_0_1
        MOV     A,      P2
        MOV     TB8,    P3.7
        RET	
	
SERIAL_TRM_0_1:
	MOV	A,	P2
	MOV	SBUF,	A
	RET
		
