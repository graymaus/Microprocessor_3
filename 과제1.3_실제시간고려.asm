		ORG 0
		SETB P2.0
	  	MOV	P1, #0FFH
		MOV DPTR,#300H
INT	:	MOV	R3, #10 ;10���ڸ� 10��
		MOV R2, #0 ; 10���ڸ���
RUN :	MOV R0, #10 ;1���ڸ� 10��
		MOV R1, #0 ;1���ڸ���
		
REAL :	MOV R7, #50 ; �������� �ֱ� ������ ����
GO  :	JNB P2.0, INT ; P2.0 ����ġ ���� �� 0���� �ٽý���
		CLR P3.3	;1�� �ڸ��� ��ġ ����
		MOV A,R1	;1�� �ڸ��� �޾ƿ���
		MOVC A,@A+DPTR ;LOOK UP TABLE
		MOV P1,A	;1�� �ڸ��� ���
		ACALL DELAY ; 5ms ������
		MOV P1, #0FFH ; ȭ���� OFF
	
		JNB P2.0, INT ; P2.0 ����ġ ���� �� 0���� �ٽ� ����
		SETB P3.3	; 10���ڸ��� ��ġ ����
		MOV A,R2	; 10�� �ڸ��� �޾ƿ���
		MOVC A,@A+DPTR ; LOOK UP TABLE
		MOV P1,A	; 10�� �ڸ��� ���
		ACALL	DELAY ; 5ms ������
		MOV P1, #0FFH ; ȭ���� OFF
		DJNZ R7, GO ; �� 10ms �۾� 50�� ���� -> 0.5sec
		INC R1		; 1���ڸ��� ����
		DJNZ R0, REAL ; 1 ���ڸ� 10�� ���
		INC	R2		; 10���ڸ��� ����
		DJNZ R3,RUN ; 10�� �ڸ� 10�� ���
		AJMP INT	; 99���� ��� ���� 0���� ����

DELAY : ;5ms DELAY
		MOV	R5, #10
AGAIN :	MOV	R4,	#125
HERE  :	NOP
		NOP
		DJNZ R4,HERE
		DJNZ R5,AGAIN
		RET
		ORG 300H
TABLE :
DB		192, 249, 164, 176, 153, 146, 130, 216, 128, 144
