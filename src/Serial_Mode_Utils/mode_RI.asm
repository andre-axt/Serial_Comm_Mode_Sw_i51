	ORG	0080h
	
SERIAL_RI:
	JNB	SM0,	SERIAL_RI_0_1
	MOV     A,      SBUF
        MOV     P1,     A
	MOV	A,	RB8
        MOV     P3.6,   A
        CLR     RI
	RETI

SERIAL_RI_0_1:
	MOV	A,	SBUF
	MOV	P1,	A
	CLR	RI
	RETI
