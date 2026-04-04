	ORG	0070h
	
SERIAL_RI:
	JNB	SM0,	SERIAL_RI_0_1
	MOV     A,      SBUF
        MOV     P1,     A
	MOV	C,	RB8
        MOV     P3.6,   C
        CLR     RI
	RETI

SERIAL_RI_0_1:
	MOV	A,	SBUF
	MOV	P1,	A
	CLR	RI
	RETI
