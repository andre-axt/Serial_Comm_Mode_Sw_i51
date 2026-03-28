	ORG     0000h
        SJMP    MAIN

MAIN:
        MOV     P2,     #0FFh
        MOV     IE,     #10011000b
        MOV     IP,     #00010000b
        MOV     PCON,   #80h
        MOV     TMOD,   #00100000b
        MOV     TH1,    #0FAh
	MOV	A,	P0
	MOV	R0,	A
        SETB    TR1
        JMP     $
	
