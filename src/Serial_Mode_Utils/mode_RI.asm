	ORG	005Fh
	
SERIAL_RI:
	JNB	SM0,	SERIAL_RI_0_1
	MOV     A,      SBUF
        MOV     P1,     A
        MOV     P3.6,   RB8
        CLR     RI
	RETI

SERIAL_RI_0_1:
	MOV	A,	SBUF
	MOV	P1,	A
	CLR	RI
	RETI
