		ORG 0
		SETB P2.0
	  	MOV	P1, #0FFH
		MOV DPTR,#300H
INT	:	MOV	R3, #10 ;10의자리 10번
		MOV R2, #0 ; 10의자리수
RUN :	MOV R0, #10 ;1의자리 10번
		MOV R1, #0 ;1의자리수
		
REAL :	MOV R7, #50 ; 숫자증가 주기 설정을 위함
GO  :	JNB P2.0, INT ; P2.0 스위치 누를 시 0부터 다시시작
		CLR P3.3	;1의 자리수 위치 설정
		MOV A,R1	;1의 자리수 받아오기
		MOVC A,@A+DPTR ;LOOK UP TABLE
		MOV P1,A	;1의 자리수 출력
		ACALL DELAY ; 5ms 딜레이
		MOV P1, #0FFH ; 화면을 OFF
	
		JNB P2.0, INT ; P2.0 스위치 누를 시 0부터 다시 시작
		SETB P3.3	; 10의자리수 위치 설정
		MOV A,R2	; 10의 자리수 받아오기
		MOVC A,@A+DPTR ; LOOK UP TABLE
		MOV P1,A	; 10의 자리수 출력
		ACALL	DELAY ; 5ms 딜레이
		MOV P1, #0FFH ; 화면을 OFF
		DJNZ R7, GO ; 약 10ms 작업 50번 수행 -> 0.5sec
		INC R1		; 1의자리수 증가
		DJNZ R0, REAL ; 1 의자리 10번 출력
		INC	R2		; 10의자리수 증가
		DJNZ R3,RUN ; 10의 자리 10번 출력
		AJMP INT	; 99까지 출력 이후 0으로 복귀

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
