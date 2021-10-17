.MODEL SMALL
.STACK 1000
.DATA
	S1 DB 13,10,"Select one function to proceed(1-TIMER, 2-ALARM, 3-WORLD CLOCK, 4-STOPWATCH): $"
	S2 DB 13,10,"DO YOU WANNA COUNTINUE?(1-YES, OTHERS-NO): $"
	INVALID	DB 13,10,"Invalid input. Please enter again.$"

	MEGACHOICE DB 0
	OPTION DB 0

;TIMER
	
	;SOUND FREQUENCY
	TIMERNOTES DW 7 DUP(4530)

	TIMER1 	DB 13,10,"Enter the timer time in (HH:MM:SS)format: $"
	TIMER2	DB 13,10,"Time has reached.$"
	TIMER3 	DB 13,10,"Select(1-Snooze, 2-Repeat, Others-Stop) $"
	TIMERCURRTIME DB 13,10,"Current time: $"

	;System variable
	HOUR DB 2 DUP(0)
	MINS DB 2 DUP(0)
	DAY DB 2 DUP(0)
	MONTH DB 2 DUP(0)

	ONE DB 1
	TEN DB 10
	HUNDRED DB 100
	THOUSAND DW 1000
	FIV DB 5

	;USER INPUT VARIABLE
	TIMERTIME DB 6 DUP(0)
	REPEATTIMER DB 6 DUP(0)
	

;ALARM
	ALARMNOTES DW 7 DUP(4530)
	ALARM1 DB 13,10,"Enter the date and time to be set in the reminder in (DD:MM)(HH:MM)format: $"
	ALARM2 DB 13,10,"Reminder is set successfully!$"
	ALARM3 DB 13,10,"Press any key to stop the sound!$"
	ALARM4 DB 13,10,"Sound has been stopped!$"

	ALARM5 DB 13,10,"Here is your reminder$"
	ALARM6 DB 13,10,"Today's date and time$"
	ALARM7 DB 13,10,"DATE: $"
	ALARM8 DB 13,10,"TIME: $"
	ALARM9 DB 13,10,"EVENT: $"

	ALARM10 DB 13,10,"Another alarm?(1-yes,others-no): $"

	COLOR DB 1FH,2FH,3FH,4FH,5FH,6FH,7FH

	EHR DB 2 DUP(0)
	EMIN DB 2 DUP(0)
	EDAY DB 2 DUP(0)
	EMONTH DB 2 DUP(0)

	EVENT DB 80 DUP('$')

;WORLD CLOCK
	SYSTEMDAY DB ?
	SYSTEMMONTH DB ?
	SYSTEMYEAR DW ?
	
	YEAR1 DB ?
	YEAR2 DB ?
	YEAR3 DB ?
	YEAR4 DB ?
	MONTH1 DB ?
	MONTH2 DB ?
	DAY1 DB ?
	DAY2 DB ?
	
	WCHR DB  ?
	WCHR1 DB ?
	WCHR2 DB ?
	WCMIN DB ?
	WCMIN1 DB ?
	WCMIN2 DB ?
	WCSEC DB ?
	WCSEC1 DB ?
	WCSEC2 DB ?
	WCGMT DB 8,12,15,2,6  
	COUNTRY DB 0AH,0DH,"GREENWICH(GMT+0):"
			DB 0AH,0DH,"NEW YORK(GMT-4):"
			DB 0AH,0DH,"LOS ANGELES(GMT-7):"
			DB 0AH,0DH,"SYDNEY(GMT+10):"
			DB 0AH,0DH,"PARIS(GMT+2)$:"
    	PER DB 60
	WSYM DB "/$"
	SYM1 DB ":$"
	SPACE DB "	$"
	CURSOR DB 3
	MALAYSIA DB "MALAYSIA(GMT+8):$"
	WORLD DB 0AH,0DH,"PRESS 1 TO DISPLAY WORLD CLOCK$"
	PRESS DB 0AH,0DH,"PRESS ANY KEY TO CONTINUE$"

;STOPWATCH
	
	RHR DB 0
	IHR DB ?
	HR DB ?
	HR1 DB 0
	HR2 DB 0
    	IMIN DB ?
    	RMIN DB 0
	MIN DB ?
	MIN1 DB 0
	MIN2 DB 0
	RSEC DB 0
	SEC DB ?
	ISEC DB ?
	SEC1 DB 0
	SEC2 DB 0
	IMSEC DB ?
	RMSEC DB 0
	MSEC DB ?
	MSEC1 DB 0
	MSEC2 DB 0
	NEWH DB ?
	NEWMS DB ?
	NEWS DB ?
	NEWM DB ?
    LAPMIN DB 5 DUP(0)
    LAPSEC DB 5 DUP(0)
    LAPMSEC DB 5 DUP(0)
    LAPMIN1 DB 5 DUP(0)
    LAPMIN2 DB 5 DUP (0)
    LAPSEC1 DB 5 DUP (0)
    LAPSEC2 DB 5 DUP (0)
    LAPMSEC1 DB 5 DUP (0)
    LAPMSEC2 DB 5 DUP (0)
    LAPC DB 0AH,0DH,"1"
         DB 0AH,0DH,"2"
         DB 0AH,0DH,"3"
         DB 0AH,0DH,"4"
         DB 0AH,0DH,"5$"
	SYM2 DB ".$"
	SECTOTAL DW ?
	MSECTOTAL DB ?
	MSECTOTAL1 DB ?
	MSECTOTAL2 DB ?
	AVRTIME1 DB 0
	AVRTIME2 DB 0
	AVR1 DB ?
	AVR2 DB ?
	AVR3 DB ?
	AVR4 DB ?
	AVR5 DB ?	
	AVR6 DB ?
	SWATCH1 DB 0AH,0DH,"1.START/STOP$"
   	SWATCH2 DB 0AH,0DH,"2.EXIT$"
	SWATCH3 DB 0AH,0DH,"3.RESET$"
	SWATCH4 DB 0AH,0DH,"PRESS SPACE FOR LAP$"
	SWATCH5 DB 0AH,0DH,"4.RESUME$"
	INPUT DB ?
	INPUT1 DB ?
	CURSOR1 DB 6
	CURSOR2 DB 5
	AVERAGETIME DB 0AH,0DH,"AVERAGE TIME:$"
	LAPCOUNT DB 0
    LAPCOUNT1 DW 0

	NL DB 13,10,"$"

.CODE

MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX

MEGAFUNCTION:
	MOV AH,09H
	LEA DX,S1
	INT 21H

	MOV AH,01H
	INT 21H

	MOV MEGACHOICE,AL
	CMP MEGACHOICE,31H
	JE MEGATIMER

	CMP MEGACHOICE,32H
	JE MEGAALARM1

	CMP MEGACHOICE,34H
	JE MEGASWATCH1

	CMP MEGACHOICE,33H
	JE MEGAWORLDCLOCK1

INVALIDMSG:
	MOV AH,09H
	LEA DX,INVALID
	INT 21H

	JMP MEGAFUNCTION

MEGATIMER:

;Get Current Time
TIMERDISPLAYTIME:
	MOV AH,2CH
	INT 21H

	MOV AX,0
	MOV AL,CL ; DH-SECONDS, CL-MINS, CH-HOUR

	DIV TEN
	MOV MINS[0],AL
	MOV MINS[1],AH
	
	ADD MINS[0],30H
	ADD MINS[1],30H

	MOV AX,0
	MOV AL,CH
	
	DIV TEN
	MOV HOUR[0],AL
	MOV HOUR[1],AH
	
	ADD HOUR[0],30H
	ADD HOUR[1],30H
	
	MOV AH,09H
	LEA DX,TIMERCURRTIME
	INT 21H

	MOV AH,02H
	MOV DL,HOUR[0]		;PRINT HOUR
	INT 21H
	
	MOV AH,02H
	MOV DL,HOUR[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,02H
	MOV DL,MINS[0]		;PRINT MINUTES
	INT 21H
	
	JMP JUMPPUR

MEGAALARM1:
	JMP MEGAALARM2
MEGASWATCH1:
	JMP MEGASWATCH2

JUMPPUR:	
	MOV AH,02H
	MOV DL,MINS[1]
	INT 21H

	JMP TIMERINPUT

;FOR JUMPING OUT OF RANGE PURPOSE
MEGAWORLDCLOCK1:
	JMP MEGAWORLDCLOCK2

MEGAFUNCTION24:
	JMP MEGAFUNCTION

;RECEIVE USER TIMER INPUT
TIMERINPUT:
	MOV AH,09H
	LEA DX,TIMER1
	INT 21H
;-HOUR	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[0],AL
	MOV REPEATTIMER[0],AL
	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[1],AL
	MOV REPEATTIMER[1],AL

	MOV AH,02H
	MOV DL,":"
	INT 21H

;-MINUTES	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[2],AL
	MOV REPEATTIMER[2],AL
	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[3],AL
	MOV REPEATTIMER[3],AL
	
	MOV AH,02H
	MOV DL,":"
	INT 21H

;-SECONDS	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[4],AL
	MOV REPEATTIMER[4],AL
	
	MOV AH,01H
	INT 21H
	
	MOV TIMERTIME[5],AL
	MOV REPEATTIMER[5],AL

;-CHECK VALIDITY
	CMP TIMERTIME[0],33H
	JAE TIMERINVALIDMSG
	CMP TIMERTIME[0],2FH
	JBE TIMERINVALIDMSG

	CMP TIMERTIME[1],2FH
	JBE TIMERINVALIDMSG
	
	CMP TIMERTIME[2],36H
	JAE TIMERINVALIDMSG
	CMP TIMERTIME[2],2FH
	JBE TIMERINVALIDMSG
	
	CMP TIMERTIME[3],2FH
	JBE TIMERINVALIDMSG
	
	CMP TIMERTIME[4],36H
	JAE TIMERINVALIDMSG
	CMP TIMERTIME[4],2FH
	JBE TIMERINVALIDMSG
	
	CMP TIMERTIME[5],2FH
	JBE TIMERINVALIDMSG

;--IF VALID INPUT	
	JMP TIMER

MEGAALARM2:
	JMP MEGAALARM3
MEGAWORLDCLOCK2:
	JMP MEGAWORLDCLOCK3
MEGASWATCH2:
	JMP MEGASWATCH3
MEGAFUNCTION23:
	JMP MEGAFUNCTION24
	
TIMERINVALIDMSG:
	MOV AH,09H
	LEA DX,INVALID
	INT 21H
	
	JMP TIMERINPUT

;-TIMER

TIMERORREPEAT:
	MOV SI,0
	MOV CX,6

MOVETIME:
	MOV AL,REPEATTIMER[SI]
	MOV TIMERTIME[SI],AL
	INC SI
	DEC CX
	CMP CX,0
	JE TIMER
	JMP MOVETIME

TIMER:
	MOV BL,30H
	
GETTIME:
	MOV AH,2CH
	INT 21H
	MOV BH,DH  ; DH has current second

GETSEC:      
	MOV AH,2CH
	INT 21H
	CMP BH,DH
	JNE LOOPSEC1
	JMP GETSEC

GETSNOOZETIMER3:
	JMP TIMER
TIMERORREPEAT4:
	JMP TIMERORREPEAT
MEGAALARM3:
	JMP MEGAALARM4
	
LOOPSEC1:
;-CLEAR SCREEN
	MOV AX,0600H
	MOV BH,07H	;FIRST DIGIT IS BACKGROUND COLOR, SEC DIGIT IS WORDS COLOR
	MOV CX,0000H
	MOV DX,184FH
	INT 10H
;SET CURSOR TO CENTER	
	MOV AH,02H
	MOV BH,00			
	MOV DX,0C27H
	INT 10H
	
	MOV AH,02H
	MOV DL,TIMERTIME[0]
	INT 21H
	
	MOV AH,02H
	MOV DL,TIMERTIME[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,02H
	MOV DL,TIMERTIME[2]
	INT 21H
	
	MOV AH,02H
	MOV DL,TIMERTIME[3]
	INT 21H
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,02H
	MOV DL,TIMERTIME[4]
	INT 21H
	
	MOV AH,02H
	MOV DL,TIMERTIME[5]
	INT 21H
		
	CMP BL,TIMERTIME[5]
	JE  LOOPSECOND2
	SUB TIMERTIME[5],1H
	JMP GETTIME

GETSNOOZETIMER2:
	JMP GETSNOOZETIMER3
TIMERORREPEAT3:
	JMP TIMERORREPEAT4

MEGAALARM4:
	JMP MEGAALARM5
MEGASWATCH3:
	JMP MEGASWATCH4
MEGAWORLDCLOCK3:
	JMP MEGAWORLDCLOCK4
MEGAFUNCTION22:
	JMP MEGAFUNCTION23
	
LOOPSECOND2:
	CMP BL,TIMERTIME[4]
	JE  LOOPMIN1
	SUB TIMERTIME[4],1H
	ADD TIMERTIME[5],9H
	JMP GETTIME
 
LOOPMIN1:
	CMP BL,TIMERTIME[3]
	JE  LOOPMIN2
	SUB TIMERTIME[3],1H
	ADD TIMERTIME[4],5H
	ADD TIMERTIME[5],9H
	JMP GETTIME

LOOPMIN2:
	CMP BL,TIMERTIME[2]
	JE  LOOPHR1
	SUB TIMERTIME[2],1H
	ADD TIMERTIME[3],9H
	ADD TIMERTIME[4],5H
	ADD TIMERTIME[5],9H
	JMP GETTIME

LOOPHR1:
	CMP BL,TIMERTIME[1]
	JE  LOOPHR2
	SUB TIMERTIME[1],1H
	ADD TIMERTIME[2],5H
	ADD TIMERTIME[3],9H
	ADD TIMERTIME[4],5H
	ADD TIMERTIME[5],9H
	JMP GETTIME

LOOPHR2:
	CMP BL,TIMERTIME[0]
	JE  TIMERRINGTONE
	SUB TIMERTIME[0],1H
	ADD TIMERTIME[1],9H
	ADD TIMERTIME[2],5H
	ADD TIMERTIME[3],9H
	ADD TIMERTIME[4],5H
	ADD TIMERTIME[5],9H
	JMP GETTIME

GETSNOOZETIMER1:
	JMP GETSNOOZETIMER2
TIMERORREPEAT2:
	JMP TIMERORREPEAT3
MEGAALARM5:
	JMP MEGAALARM6

TIMERRINGTONE:
	MOV SI,0
TIMERSOUND:	
;-CLEAR SCREEN
	MOV AX,0600H
	MOV BH,07H	;FIRST DIGIT IS BACKGROUND COLOR, SEC DIGIT IS WORDS COLOR
	MOV CX,0000H
	MOV DX,184FH
	INT 10H

;SET CURSOR TO CENTER	
	MOV AH,02H
	MOV BH,00			
	MOV DX,0C27H
	INT 10H
	
;PRINT STRING
	MOV AH,09H
	LEA DX,TIMER2
	INT 21H
	
	MOV AL,182		; setting up speaker by sending the value 182
	OUT 43H,AL		;port 43h
	MOV AX,TIMERNOTES[SI]	;frequency number(in dec)
	
	OUT 42H,AL
	MOV AL,AH
	OUT 42H,AL
	IN AL,61H
	
	OR AL,00000011B
	OUT 61H,AL
	MOV CX,10	;control duration of sound
	JMP TIMERSTOP1

GETSNOOZETIMER:
	JMP GETSNOOZETIMER1
TIMERORREPEAT1:
	JMP TIMERORREPEAT2

MEGAALARM6:
	JMP MEGAALARM
MEGAWORLDCLOCK4:
	JMP MEGAWORLDCLOCK5
MEGASWATCH4:
	JMP MEGASWATCH5
MEGAFUNCTION21:
	JMP MEGAFUNCTION22
	
TIMERSTOP1:
	MOV BX,65535	; produce one sound

TIMERSTOP2:
	DEC BX
	JNE TIMERSTOP2	;continue jmp when BX is not zero
	DEC CX
	JNE TIMERSTOP1
		
	INC SI
	CMP SI,7
	JNE TIMERSOUND

;-CLEAR SCREEN
	MOV AX,0600H
	MOV BH,07H
	MOV CX,0000H
	MOV DX,184FH
	INT 10H

;SET CURSOR TO CENTER	
	MOV AH,02H
	MOV BH,00			
	MOV DX,0C15H
	INT 10H
	
	MOV AH,09H
	LEA DX,TIMER2
	INT 21H

	MOV AH,09H
	LEA DX,TIMER3
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV OPTION,AL
		
	IN AL,61H
	
	AND AL,11111100B
	OUT 61H,AL

SNOOZEORREPEAT:
	CMP OPTION,31H
	JE SNOOZETIMER
	CMP OPTION,32H
	JE TIMERORREPEAT1 
	JMP CONTINUEOREND

SNOOZETIMER:
	MOV TIMERTIME[3],32H
	JMP GETSNOOZETIMER

MEGAWORLDCLOCK5:
	JMP MEGAWORLDCLOCK6
MEGASWATCH5:
	JMP MEGASWATCH6

MEGAALARM:

;GET CURRENT SYSTEM DATE AND TIME
DISPLAYTIMEANDDATE:
	MOV AH,2AH 
	INT 21H

	MOV AX,0
	MOV AL,DL ; DH = month DL = day CX = YEAR

	DIV TEN
	MOV DAY[0],AL
	MOV DAY[1],AH

	ADD DAY[0],30H
	ADD DAY[1],30H

	MOV AX,0
	MOV AL,DH ; DH = month DL = day CX = YEAR

	DIV TEN
	MOV MONTH[0],AL
	MOV MONTH[1],AH

	ADD MONTH[0],30H
	ADD MONTH[1],30H

	MOV AH,2CH  ; GET CURRENT TIME IN DECIMAL
	INT 21H
	
	MOV AX,0
	MOV AL,CL  ; DH-SECONDS, CL-MINS, CH-HOUR
		
	DIV TEN
	MOV MINS[0],AL
	MOV MINS[1],AH

	ADD MINS[0],30H
	ADD MINS[1],30H

	MOV AX,0
	MOV AL,CH
	
	DIV TEN
	MOV HOUR[0],AL
	MOV HOUR[1],AH
	
	ADD HOUR[0],30H
	ADD HOUR[1],30H

	MOV AH,09H
	LEA DX,ALARM6
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,ALARM7
	INT 21H
	
	MOV AH,02H
	MOV DL,DAY[0]
	INT 21H
	
	MOV AH,02H
	MOV DL,DAY[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,"/"
	INT 21H
	
	MOV AH,02H
	MOV DL,MONTH[0]
	INT 21H
	
	MOV AH,02H
	MOV DL,MONTH[1]
	INT 21H

	MOV AH,09H
	LEA DX,ALARM8
	INT 21H

	MOV AH,02H
	MOV DL,HOUR[0]		;PRINT HOUR
	INT 21H
	
	MOV AH,02H
	MOV DL,HOUR[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,02H
	MOV DL,MINS[0]		;PRINT MINUTES
	INT 21H
	
	MOV AH,02H
	MOV DL,MINS[1]
	INT 21H

	JMP START

NEWALARM5:
	JMP DISPLAYTIMEANDDATE
MEGAFUNCTION20:
	JMP MEGAFUNCTION21
MEGAWORLDCLOCK6:
	JMP MEGAWORLDCLOCK7
MEGASWATCH6:
	JMP MEGASWATCH7

START:
	MOV AH,09H
	LEA DX,ALARM1
	INT 21H

	MOV AH,09H
	LEA DX,ALARM7
	INT 21H

	MOV AH,01H
	INT 21H
	MOV EDAY[0],AL
	
	MOV AH,01H
	INT 21H
	MOV EDAY[1],AL
	
	MOV AH,02H
	MOV DL,"/"
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV EMONTH[0],AL
	
	MOV AH,01H
	INT 21H
	MOV EMONTH[1],AL

	MOV AH,09H
	LEA DX,ALARM8
	INT 21H

	MOV AH,01H
	INT 21H
	MOV EHR[0],AL
	
	MOV AH,01H
	INT 21H
	MOV EHR[1],AL
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV EMIN[0],AL
	
	MOV AH,01H
	INT 21H
	MOV EMIN[1],AL

	MOV AH,09H
	LEA DX,ALARM9
	INT 21H

	MOV SI,OFFSET EVENT

EVENTINPUT:
	MOV AH,01H
	INT 21H

	CMP AL,13
	JE ALARMCHECKVALIDITY
	MOV [SI],AL
	INC SI
	JMP EVENTINPUT


NEWALARM4:
	JMP NEWALARM5
MEGAFUNCTION19:
	JMP MEGAFUNCTION20

ALARMCHECKVALIDITY:
;CHECK VALIDITY
	CMP EDAY[0],34H
	JAE ALARMINVALIDMSG
	CMP EDAY[0],2FH
	JBE ALARMINVALIDMSG

	CMP EDAY[1],2FH
	JBE ALARMINVALIDMSG

	CMP EMONTH[0],32H
	JAE ALARMINVALIDMSG
	CMP EMONTH[0],2FH
	JBE ALARMINVALIDMSG

	CMP EMONTH[1],2FH
	JBE ALARMINVALIDMSG

	CMP EHR[0],33H
	JAE ALARMINVALIDMSG
	CMP EHR[0],2FH
	JBE ALARMINVALIDMSG

	CMP EHR[1],2FH
	JBE ALARMINVALIDMSG
	
	CMP EMIN[0],36H
	JAE ALARMINVALIDMSG
	CMP EMIN[0],2FH
	JBE ALARMINVALIDMSG

	CMP EMIN[1],2FH
	JBE ALARMINVALIDMSG

;IF VALID INPUT
	JMP REMINDERISSET

MEGAWORLDCLOCK7:
	JMP MEGAWORLDCLOCK8
MEGASWATCH7:
	JMP MEGASWATCH8

ALARMINVALIDMSG:
	MOV AH,09H
	LEA DX,INVALID
	INT 21H

	JMP START

REMINDERISSET:
	MOV AH,09H
	LEA DX,ALARM2
	INT 21H

MTCHMNTH1:
	MOV AH,2AH
	INT 21H
	
	MOV AX,0
	MOV AL,DH

	DIV TEN
	ADD AL,30H
	CMP EMONTH[0],AL
	JE MTCHMNTH2
	JMP MTCHMNTH1

NEWALARM3:
	JMP NEWALARM4
MEGAFUNCTION18:
	JMP MEGAFUNCTION19

MTCHMNTH2:
	ADD AH,30H
	CMP EMONTH[1],AH
	JE MTCHDAY1
	JMP MTCHMNTH1

MTCHDAY1:
	MOV AX,0
	MOV AL,DL

	DIV TEN
	ADD AL,30H
	CMP EDAY[0],AL
	JE MTCHDAY2
	JMP MTCHMNTH1

MTCHDAY2:
	ADD AH,30H
	CMP EDAY[1],AH
	JE MTCHHR1
	JMP MTCHMNTH1

MTCHHR1:
	MOV AH,2CH  ; GET CURRENT TIME IN DECIMAL
	INT 21H
	
	MOV AX,0	
	MOV AL,CH	;CH-HOUR
	
	DIV TEN
	ADD AL,30H
	CMP EHR[0],AL
	JE  MTCHHR2
	JMP MTCHHR1

MTCHHR2:	
	ADD AH,30H
	CMP EHR[1],AH
	JE  MTCHMIN1
	JMP MTCHHR1

NEWALARM2:
	JMP NEWALARM3
MEGAFUNCTION17:
	JMP MEGAFUNCTION18
MEGAWORLDCLOCK8:
	JMP MEGAWORLDCLOCK9
MEGASWATCH8:
	JMP MEGASWATCH9

MTCHMIN1:	
	MOV AX,0
	MOV AL,CL
	DIV TEN	
	ADD AL,30H
	CMP EMIN[0],AL
	JE MTCHMIN2
	JMP MTCHHR1

MTCHMIN2:
	ADD AH,30H
	CMP EMIN[1],AH
	JE ALARM
	JMP MTCHHR1

ALARM:	
	MOV SI,0
SOUND:	
	;-CLEAR SCREEN				;REQUEST FOR SCREEN CLEANING, 
	MOV AX,0600H				; AH-06H->SCROLL UP REQUEST, AL-00H->FULL SCREEN SCROLL
	MOV BH,COLOR[SI]			;FIRST DIGIT-BACKGROUND COLOR, SEC DIGIT-WORDS COLOR
	MOV CX,0000H				;FROM WHR, CH-ROW,CL-COLUMN
	MOV DX,184FH				;TO WHR
	INT 10H					;CALL INT SERVICE

;SET CURSOR TO CENTER	
	MOV AH,02H				;REQUEST FOR SETTING
	MOV BH,00				;SET PAGE AS 0
	MOV DX,0C27H				;SET ROW AS 0C,COLUMN AS 27
	INT 10H
	
;PRINT REMINDER
	MOV AH,09H
	LEA DX,ALARM5
	INT 21H
	JMP EVENTDATEANDTIME

NEWALARM1:
	JMP NEWALARM2
MEGAFUNCTION16:
	JMP MEGAFUNCTION17

EVENTDATEANDTIME:
	MOV AH,09H
	LEA DX,ALARM7
	INT 21H
	
	MOV AH,02H
	MOV DL,EDAY[0]		;PRINT DAY
	INT 21H
	
	MOV AH,02H
	MOV DL,EDAY[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,"/"
	INT 21H
	
	MOV AH,02H
	MOV DL,EMONTH[0]	;PRINT MONTH
	INT 21H
	
	MOV AH,02H
	MOV DL,EMONTH[1]
	INT 21H

	MOV AH,09H
	LEA DX,ALARM8
	INT 21H

	MOV AH,02H
	MOV DL,EHR[0]		;PRINT HOUR
	INT 21H
	
	MOV AH,02H
	MOV DL,EHR[1]
	INT 21H
	
	MOV AH,02H
	MOV DL,":"
	INT 21H
	
	MOV AH,02H
	MOV DL,EMIN[0]		;PRINT MINUTES
	INT 21H
	
	MOV AH,02H
	MOV DL,EMIN[1]
	INT 21H
	
	MOV AH,09H
	LEA DX,ALARM9
	INT 21H
	JMP PRINTEVENT

JMPBACKTOSOUND:
	JMP SOUND
MEGAWORLDCLOCK9:
	JMP MEGAWORLDCLOCK
MEGASWATCH9:
	JMP MEGASWATCH10

PRINTEVENT:
	MOV DX,OFFSET EVENT
	MOV AH,09H
	INT 21H

	MOV AL,182		; set up speaker by sending the value 182
	OUT 43H,AL		; to port 43h
	MOV AX,ALARMNOTES[SI]	;frequency number(in dec)
	
	OUT 42H,AL
	MOV AL,AH
	OUT 42H,AL
	IN AL,61H
	
	OR AL,00000011B
	OUT 61H,AL
	MOV CX,10		;control duration of sound
	JMP STOP1

NEWALARM:
	JMP NEWALARM1
	
STOP1:
	MOV BX,65535	; produce one sound
	JMP STOP2

STOP2:
	DEC BX
	JNE STOP2		; continue jmp when BX is not zero
	DEC CX
	JNE STOP1
		
	INC SI
	CMP SI,7
	JNE JMPBACKTOSOUND
	JMP CLEARSCREEN

MEGAFUNCTION15:
	JMP MEGAFUNCTION16
	
CLEARSCREEN:
	MOV AX,0600H
	MOV BH,07H			;FIRST DIGIT-BACKGROUND COLOR, SEC DIGIT-WORDS COLOR
	MOV CX,0000H
	MOV DX,184FH
	INT 10H

;SET CURSOR TO CENTER	
	MOV AH,02H
	MOV BH,00			
	MOV DX,0C15H
	INT 10H
	
	MOV AH,09H
	LEA DX,ALARM3
	INT 21H
	
	MOV AH,01H
	INT 21H
	
	IN AL,61H
	
	AND AL,11111100B
	OUT 61H,AL
	
;-CLEAR SCREEN
	MOV AX,0600H
	MOV BH,07H			;FIRST DIGIT-BACKGROUND COLOR, SEC DIGIT-WORDS COLOR
	MOV CX,0000H
	MOV DX,184FH
	INT 10H
;SET CURSOR TO CENTER	
	MOV AH,02H
	MOV BH,00			
	MOV DX,0C20H
	INT 10H
	
	MOV AH,09H
	LEA DX,ALARM4
	INT 21H

ANOTHERALARM:
	MOV AH,09H
	LEA DX,ALARM10
	INT 21H

	MOV AH,01H
	INT 21H
	MOV OPTION,AL

	CMP OPTION,31H
	JE NEWALARM
	
	JMP CONTINUEOREND

MEGASWATCH10:
	JMP MEGASWATCH11

MEGAWORLDCLOCK:	
	MOV AH,06H
	MOV BH,07H
	MOV CX,0000H
	MOV DX,184FH
	INT 10H
	
	MOV AH,02H
   	MOV BH,00
    	MOV DH,00
	MOV DL,00
    	INT 10H
	
	MOV AH,09H
	LEA DX,MALAYSIA
	INT 21H
	
	MOV AH,02H
    	MOV BH,00
   	MOV DH,00
	MOV DL,20
    	INT 10H
	JMP DATE

MEGAFUNCTION14:
	JMP MEGAFUNCTION15
	
DATE:
	MOV AH,2AH;DATE
	INT 21H
	
	MOV AX,CX
	MOV SYSTEMDAY,DL
	MOV SYSTEMMONTH,DH
	
	MOV DX,0
	DIV THOUSAND
	MOV YEAR1,AL
	MOV DX,AX
	DIV HUNDRED
	MOV YEAR2,AL
	MOV AX,DX
	DIV TEN
	MOV YEAR3,AH
	MOV YEAR4,AL
	
	MOV AH,02H
	MOV DL,YEAR1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR2
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR3
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR4
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,WSYM
	INT 21H
	
	MOV AX,0
	MOV AL,SYSTEMMONTH
	DIV TEN
	MOV MONTH1,AL
	MOV MONTH2,AH
		
	MOV AH,02H
	MOV DL,MONTH1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,MONTH2
	ADD DL,30H
	INT 21H
	
	MOV AX,0
	MOV AL,SYSTEMDAY
	DIV TEN
	MOV DAY1,AL
	MOV DAY2,AH
	
	MOV AH,09H
	LEA DX,WSYM
	INT 21H
	
	MOV AH,02H
	MOV DL,DAY1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,DAY2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,SPACE
	INT 21H

	JMP TIME

MEGASWATCH11:
	JMP MEGASWATCH12
MEGAFUNCTION13:
	JMP MEGAFUNCTION14
	
TIME:
	MOV AH,2CH
	INT 21H
	
	MOV WCHR,CH
	MOV WCMIN,CL
	MOV WCSEC,DH
	
	MOV AX,0
	MOV AL,WCSEC
	DIV TEN
	
	MOV WCSEC1,AL
	MOV WCSEC2,AH
	
	MOV AX,0
	MOV AL,WCMIN
	DIV TEN
	
	MOV WCMIN1,AL
	MOV WCMIN2,AH
	
	MOV AX,0
	MOV AL,WCHR
	DIV TEN
	
	MOV WCHR1,AL
	MOV WCHR2,AH
	
	MOV AH,02H
	MOV DL,WCHR1
	ADD DL,30H
	INT 21H

	MOV AH,02H
	MOV DL,WCHR2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
    	LEA DX,SYM1
    	INT 21H
	
	MOV AH,02H
	MOV DL,WCMIN1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,WCMIN2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
    	LEA DX,SYM1
    	INT 21H
	
	MOV AH,02H
	MOV DL,WCSEC1
	ADD DL,30H
	INT 21H
		
    	MOV AH,02H
	MOV DL,WCSEC2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,WORLD
	INT 21H
	
	MOV AH,09H
	LEA DX,NL
	INT 21H
	
	MOV AH,01H
	INT 21H
	SUB AL,30H
	CMP AL,1
	JE COUNTRYDT
	CMP AL,2
	JE FIN1
	JNE WORLDCLOCKERROR1

MEGAFUNCTION12:
	JMP MEGAFUNCTION13
MEGASWATCH12:
	JMP MEGASWATCH13
	
FIN1:
	JMP FIN
	       
WORLDCLOCKERROR1:
	JMP WORLDCLOCKERROR
	
COUNTRYDT:
	MOV AH,09H
	LEA DX,COUNTRY
	INT 21H
            
        MOV SI,0
	MOV CX,5
			
L1:		
	CALCULATION:
		MOV AH,2CH
		INT 21H
			                                                      
		MOV WCHR,CH
			
		MOV AH,2AH
		INT 21H
		MOV SYSTEMDAY,DL
			
			
		MOV AL,WCHR
		CMP SI,3
		JE CAL2
		JNE CAL1
				
CAL1:
	SUB AL,WCGMT[SI]
	MOV WCHR,AL
	CMP AL,0
	JLE SUBDAY
	JMP DISPLAY
				    
CAL2:
	ADD AL,WCGMT[SI]
	MOV WCHR,AL
	CMP AL,24
	JGE PLUSDAY
	JMP DISPLAY
	                
	                
SUBDAY:
	ADD AL,24
	MOV WCHR,AL
        DEC SYSTEMDAY
	JMP DISPLAY
	                    
PLUSDAY:
	SUB AL,24
	MOV WCHR,AL
	INC SYSTEMDAY

DISPLAY:
	MOV AH,02H
    	MOV BH,00
	MOV DH,CURSOR
	MOV DL,20
    	INT 10H
    
	MOV AH,02H
	MOV DL,YEAR1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR2
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR3
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,YEAR4
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,WSYM
	INT 21H
	
		
	MOV AH,02H
	MOV DL,MONTH1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,MONTH2
	ADD DL,30H
	INT 21H
	
	MOV AX,0
	MOV AL,SYSTEMDAY
	DIV TEN
	MOV DAY1,AL
	MOV DAY2,AH
	
	MOV AH,09H
	LEA DX,WSYM
	INT 21H
	
	
	MOV AH,02H
	MOV DL,DAY1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,DAY2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,SPACE
	INT 21H
	
	MOV AX,0
	MOV AL,WCHR
	DIV TEN
	
	MOV WCHR1,AL
	MOV WCHR2,AH	
	
	MOV AH,02H
	MOV DL,WCHR1
	ADD DL,30H
	INT 21H

	MOV AH,02H
	MOV DL,WCHR2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
    	LEA DX,SYM1
   	INT 21H
	
	MOV AH,02H
	MOV DL,WCMIN1
	ADD DL,30H
	INT 21H
	
	MOV AH,02H
	MOV DL,WCMIN2
	ADD DL,30H
	INT 21H
	
	MOV AH,09H
    	LEA DX,SYM1
   	INT 21H
	
	MOV AH,02H
	MOV DL,WCSEC1
	ADD DL,30H
	INT 21H
		
    	MOV AH,02H
	MOV DL,WCSEC2
	ADD DL,30H
	INT 21H
	
	INC SI

	CMP SI,5
	JE FIN	             
	
	JNE JMPL1

MEGASWATCH13:
	JMP MEGASWATCH
MEGAFUNCTION11:
	JMP MEGAFUNCTION12
			
JMPL1:
	INC CURSOR
	JMP L1
				
WORLDCLOCKERROR:
	MOV AH,09H
	LEA DX,INVALID
	INT 21H
	    
	MOV AH,09H
	LEA DX,PRESS
	INT 21H
	    
	MOV AH,01H
	INT 21H
	CMP AL,00H
	    
	JMP MEGAWORLDCLOCK
	
FIN:
	MOV AH,09H
	LEA DX,NL
	INT 21H
    
	MOV AH,09H
	LEA DX,PRESS
	INT 21H
	    
	MOV AH,01H
	INT 21H
	CMP AL,00H

	JMP CONTINUEOREND

MEGASWATCH:
	UI:	
	MOV AH,2CH	;GET CURRENT SYSTEMTIME
	INT 21H
	
	MOV IHR,CH
	MOV IMIN,CL
	MOV ISEC,DH
	MOV IMSEC,DL
	
SWATCHSTOP1:
	MOV AX,0600H
	MOV BH,07H
	MOV CX,0000H
	MOV DX,184FH
	INT 10H
	
;SET CURSOR
	MOV AH,02H
	MOV BH,00
	MOV DX,0000H
	INT 10H 
	
	MOV AH,02H
    	MOV DL,MIN1
    	ADD DL,30H
    	INT 21H
    
    	MOV AH,02H
    	MOV DL,MIN2
    	ADD DL,30H
    	INT 21H
    
    	MOV AH,09H
    	LEA DX,SYM1
    	INT 21H
    
    	MOV AH,02H
    	MOV DL,SEC1
    	ADD DL,30H
    	INT 21H
    
    	MOV AH,02H
    	MOV DL,SEC2
    	ADD DL,30H
    	INT 21H
    
   	MOV AH,09H
    	LEA DX,SYM2
    	INT 21H
    
    	MOV AH,02H
    	MOV DL,MSEC1
    	ADD DL,30H
    	INT 21H
    
    	MOV AH,02H
    	MOV DL,MSEC2
    	ADD DL,30H
    	INT 21H
    
    	MOV AH,09H
   	LEA DX,SWATCH1
   	INT 21H
    
    	MOV AH,09H
    	LEA DX,SWATCH2
   	INT 21H
	
	MOV AH,09H
	LEA DX,SWATCH3
	INT 21H
	
	MOV AH,09H
	LEA DX,SWATCH5
	INT 21H
    
	MOV AH,09H
	LEA DX,NL
	INT 21H
	
    	MOV AH,01H
    	INT 21H
    	SUB AL,30H
    	MOV INPUT1,AL
    	CMP INPUT1,1
   	JE SWATCHSTART
   	CMP INPUT1,2
    	JE JMPEXIT
	CMP INPUT1,3
    	JE RESET2
    	CMP INPUT1,4
    	JE RESUME1
    	JNE JMPERROR

	RESUME1:
		JMP RESUME
	
	RESET2:
		JMP RESET
	
	JMPEXIT:
		JMP FIN
			
	JMPERROR:
		JMP ERROR
			
	ERROR:
		MOV AH,09H
		LEA DX,SWATCH3
		INT 21H
	    
		MOV AH,09H
		LEA DX,PRESS
		INT 21H
	    
		MOV AH,01H
		INT 21H
		CMP AL,00H
	    
		JMP UI
	
	SWATCHSTART:
	       MOV AH,2CH
	       INT 21H
	       
	       MOV HR,CH
	       MOV MIN,CL
	       MOV SEC,DH
	       MOV MSEC,DL
	       
	       MOV DL,IMSEC
	       CMP MSEC,DL
	       JG IFGREATER
	       JL IFLOWER     
	       
	IFGREATER:
		MOV AX,0
	        MOV AL,IMSEC              
	        SUB DL,AL
	        MOV MSEC,DL
	                 
	       	MOV AX,0
	        MOV AL,ISEC
	        SUB DH,AL
	        MOV SEC,DH
	                 
	        MOV AX,0
	        MOV AL,IMIN
	        SUB CL,AL
	        MOV MIN,CL
	                 
	        MOV AX,0
	        MOV AL,IHR
	        SUB CH,AL
	        MOV HR,CH
	                 
	        JMP DISPLAYTIME

MEGAFUNCTION10:
	JMP MEGAFUNCTION11
	                 
;CHECKCALC
	       IFLOWER: 
	                MOV AX,0
	                MOV AL,SEC
	                SUB AL,1
	                SUB AL,ISEC
	                MOV SEC,AL
	                
	                MOV AL,MSEC
	                ADD AL,HUNDRED
	                SUB AL,IMSEC
	                MOV MSEC,AL
	                
	                MOV AX,0
	                MOV AL,IMIN
	                SUB CL,AL
	                MOV MIN,CL
	                 
	                MOV AX,0
	                MOV AL,IHR
	                SUB CH,AL
	                MOV HR,CH
	                JMP DISPLAYTIME
	              
		RUNNING:
             	;CALCULATION
             		MOV AH,2CH
             		INT 21H
             
             		MOV NEWH,CH
             		MOV NEWM,CL
             		MOV NEWS,DH
            		MOV NEWMS,DL
                      
             		MOV AX,0
             		MOV AL,NEWMS
             
             		CMP AL,IMSEC
             		JL BORROWS
             		JGE SUBMS
             
             	BORROWS:
                    	MOV AX,0
                    	MOV AL,NEWS
                    	SUB AL,1
                    	MOV NEWS,AL
                    
                    	MOV AL,NEWMS
                    	ADD AL,HUNDRED
                    	MOV NEWMS,AL
                        
             
             SUBMS:
                    MOV AX,0
                    MOV AL,NEWMS
                    SUB AL,IMSEC
                    MOV MSEC,AL
                    
                    MOV AL,NEWS
                    CMP AL,ISEC
                    JGE SUBS
                    JL BORROWM
                    
              BORROWM:
                    MOV AX,0
                    MOV AL,NEWM
                    SUB AL,1
                    MOV NEWM,AL
                    
                    MOV AL,NEWS
                    ADD AL,PER
                    MOV NEWS,AL
                    
              SUBS:
                    MOV AX,0
                    MOV AL,NEWS
                    SUB AL,ISEC
                    MOV SEC,AL
                    
                    MOV AL,NEWM
                    CMP AL,IMIN
                    JGE SUBM
                    JL BORROWH
                    
               BORROWH:
                    MOV AX,0
                    MOV AL,NEWH
                    SUB AL,1
                    MOV NEWH,AL
                    
                    MOV AL,NEWM
                    ADD AL,PER
                    MOV NEWM,AL
                    
              SUBM:
                    MOV AX,0
                    MOV AL,NEWM
                    SUB AL,IMIN
                    MOV MIN,AL
                    
                    MOV AL,NEWH
                    CMP AL,IHR
                    JMP DISPLAYTIME

MEGAFUNCTION9:
	JMP MEGAFUNCTION10

    INCLAP:
            INC LAPCOUNT
            INC LAPCOUNT1         
                     
		LAP:
		    CMP LAPCOUNT,1
		    JE FIRST1
		    CMP LAPCOUNT,2
		    JE SECOND1
		    CMP LAPCOUNT,3
		    JE THIRD1
		    CMP LAPCOUNT,4
		    JE FOURTH1
		    CMP LAPCOUNT,5
		    JE FIFTH1
		    
		    FIRST1:
		            JMP FIRST
		    SECOND1:
		            JMP SECOND
		    THIRD1:
		            JMP THIRD
		    FOURTH1:
		            JMP FOURTH
		    FIFTH1:
		            JMP FIFTH        
		          
		
		FIFTH:
		      MOV AX,0      
		      MOV AL,MSEC
		      MOV BL,SEC
		      MOV DL,MIN
		      
		      MOV AL,LAPMSEC[0]
		      ADD AL,LAPMSEC[1]
		      ADD AL,LAPMSEC[2]
		      ADD AL,LAPMSEC[3]
		      MOV LAPMSEC[4],AL
		      MOV AL,MSEC
		      MOV SI,0
		      
		      CMP AL,LAPMSEC[4]
		      JGE MINUS4
		      JL B4
		      
		      B4:
		        CMP SI,1
		        JE MINUS4
		        DEC BL
		        ADD AL,100
		        INC SI
		        CMP AL,LAPMSEC[4]
		        JGE MINUS4
		        JL B4
		        
		        
		       MINUS4:
		        SUB AL,LAPMSEC[4]
		        MOV LAPMSEC[4],AL
		        
		           
		        D3:
		        MOV AL,LAPMSEC[4]
		        MOV AH,0
		        DIV TEN
		        MOV LAPMSEC1[4],AL
		        MOV LAPMSEC2[4],AH
		        
		        MOV AX,0
		        MOV AL,BL
		        MOV AH,LAPSEC[0]
		        ADD AH,LAPSEC[1]
		        ADD AH,LAPSEC[2]
		        ADD AH,LAPSEC[3]
		        CMP AL,AH
		          
		        H4:
		        SUB AL,AH
		        
		        
             F4:
                MOV AH,0
		        MOV LAPSEC[4],AL    
		        DIV TEN
		        MOV LAPSEC1[4],AL
		        MOV LAPSEC2[4],AH
		        
		        MOV AX,0
                MOV AL,LAPMIN[0]
                ADD AL,LAPMIN[1]
                ADD AL,LAPMIN[2]
                ADD AL,LAPMIN[3]
                MOV LAPMIN[4],AL
                
                MOV AL,DL
                SUB AL,LAPMIN[4]
                DIV TEN
                MOV LAPMIN1[4],AL
                MOV LAPMIN2[4],AH
		      
		      JMP DISPLAYLAP

MEGAFUNCTION8:
	JMP MEGAFUNCTION9
		      
		FOURTH:
		      MOV AX,0
		      MOV AL,MSEC
		      MOV BL,SEC
		      MOV DL,MIN
		      
		      MOV AL,LAPMSEC[0]
		      ADD AL,LAPMSEC[1]
		      ADD AL,LAPMSEC[2]
		      MOV LAPMSEC[3],AL
		      MOV AL,MSEC
		      MOV CL,LAPMSEC[3]
		      
		      CMP AL,LAPMSEC[3]
		      JGE MINUS3
		      JL B3
		      
		      B3:
		        CMP SI,1
		        JE MINUS3
		        DEC BL
		        ADD AL,100
		        CMP AL,LAPMSEC[3]
		        INC SI
		        JGE MINUS3
		        JL B3
		        
		        
		      MINUS3:
		        SUB AL,LAPMSEC[3]
				MOV AH,0
		        MOV LAPMSEC[3],AL
		        
		        CMP LAPMSEC[3],100
		        JGE C2
		        JL D2
		        
		        C2:
		          SUB LAPMSEC[3],100
		          INC BL
		           
		        D2:
		        MOV AH,0
		        MOV LAPMSEC[3],AL
		        DIV TEN
		        MOV LAPMSEC1[3],AL
		        MOV LAPMSEC2[3],AH
		        
		        MOV AX,0
                MOV AL,BL
                MOV AH,LAPSEC[0]
                ADD AH,LAPSEC[1]
                ADD AH,LAPSEC[2]
                MOV LAPSEC[3],AH
                
                CMP AL,0                
                JGE E3
                JL F3 
                
                F3:
                    DEC DL
                    ADD AL,60
             
                E3:
                SUB AL,LAPSEC[3]
                MOV AH,0
                DIV TEN
                MOV LAPSEC1[3],AL
                MOV LAPSEC2[3],AH
             
                MOV AX,0
                MOV AL,LAPMIN[0]
                ADD AL,LAPMIN[1]
                ADD AL,LAPMIN[2]
                MOV LAPMIN[3],AL
                MOV AL,DL
                SUB AL,LAPMIN[3]
                DIV TEN
                MOV LAPMIN1[3],AL
                MOV LAPMIN2[3],AH
		     
		      
		      JMP DISPLAYLAP

		THIRD:
		    MOV AX,0
		    MOV AL,MSEC
            MOV BL,SEC
            MOV DL,MIN
		    
		    MOV AL,LAPMSEC[0]
		    ADD AL,LAPMSEC[1]
		    MOV LAPMSEC[2],AL
		    MOV AL,MSEC
		    
		    CMP AL,LAPMSEC[2]
		    JGE MINUS2
		    JL B2
		    
		    B2:
		        DEC BL
		        ADD AL,100
		        
		      
		     MINUS2:
		        SUB AL,LAPMSEC[2]
		        MOV LAPMSEC[2],AL		        
		           
		        D1:
		        MOV AH,0
		        MOV AL,LAPMSEC[2]
		        DIV TEN
		        MOV LAPMSEC1[2],AL
		        MOV LAPMSEC2[2],AH
		        
		        MOV AX,0
                MOV AL,BL
                MOV AH,LAPSEC[0]
                ADD AH,LAPSEC[1]
                CMP AL,AH
                JGE F2
                JL E2
                
                E2:
                DEC DL
                ADD AH,60
                
                F2:
                SUB AL,AH
                
                MOV AH,0
                MOV LAPSEC[2],AL
                
                 
             
                MOV AH,0
                MOV AL,LAPSEC[2]
                DIV TEN
                MOV LAPSEC1[2],AL
                MOV LAPSEC2[2],AH
             
                MOV AX,0
                MOV AL,LAPMIN[0]
                ADD AL,LAPMIN[1]
                MOV LAPMIN[2],AL
                MOV AL,DL
                SUB AL,LAPMIN[2]
                DIV TEN
                MOV LAPMIN1[2],AL
                MOV LAPMIN2[2],AH
		    
		    JMP DISPLAYLAP 

MEGAFUNCTION7:
	JMP MEGAFUNCTION8
		     
        SECOND:     
             MOV AX,0
             MOV AL,MSEC
             MOV BL,SEC
             MOV DL,MIN
             CMP AL,LAPMSEC[0]
             JGE MINUS1
             JL B1
             
             B1:
                DEC BL
                ADD AL,100
                CMP AL,LAPMSEC[0]
             
             MINUS1:
             SUB AL,LAPMSEC[0]
			 MOV AH,0
             MOV LAPMSEC[1],AL
             DIV TEN
             MOV LAPMSEC1[1],AL
             MOV LAPMSEC2[1],AH
             
             MOV AX,0
             MOV AL,BL
             SUB AL,LAPSEC[0]
             MOV LAPSEC[1],AL
             
             
             MOV AH,0
             MOV AL,LAPSEC[1]
             DIV TEN
             MOV LAPSEC1[1],AL
             MOV LAPSEC2[1],AH
             
             MOV AX,0
             MOV AL,DL
             SUB AL,LAPMIN[0]
             MOV LAPMIN[1],AL
             DIV TEN
             MOV LAPMIN1[1],AL
             MOV LAPMIN2[1],AH
             
             JMP DISPLAYLAP

			 
	FIRST:	 
			 MOV AX,0
             MOV AL,MSEC
             MOV LAPMSEC[0],AL
             DIV TEN
             MOV LAPMSEC1[0],AL
             MOV LAPMSEC2[0],AH
		     
		     MOV AX,0
             MOV AL,SEC
             MOV LAPSEC[0],AL
             DIV TEN
             MOV LAPSEC1[0],AL
             MOV LAPSEC2[0],AH
		     
		     MOV AX,0
             MOV AL,MIN
             MOV LAPMIN[0],AL
             DIV TEN
             MOV LAPMIN1[0],AL
             MOV LAPMIN2[0],AH
	                
	         JMP DISPLAYLAP
	                

MEGAFUNCTION6:
	JMP MEGAFUNCTION7
	                

	
	RESET:  
	        MOV IHR,0
	        MOV HR,0
	        MOV HR1,0
	        MOV HR2,0
	        MOV NEWH,0    
	        
	        MOV IMIN,0
	        MOV MIN,0
	        MOV MIN1,0
	        MOV MIN2,0
	        MOV NEWM,0
	        
	        MOV ISEC,0
	        MOV SEC,0
	        MOV SEC1,0
	        MOV SEC2,0
	        MOV NEWS,0
	        
	        MOV MSEC,0
	        MOV IMSEC,0
	        MOV MSEC1,0
	        MOV MSEC2,0
	        MOV NEWMS,0
	        
	        MOV LAPCOUNT,0
	        
	        MOV SECTOTAL,0
	        MOV MSECTOTAL,0
	        MOV MSECTOTAL1,0
	        MOV MSECTOTAL2,0
	        
	        MOV AVRTIME1,0
	        MOV AVRTIME2,0
	        MOV AVR1,0
	        MOV AVR2,0
	        MOV AVR3,0
	        MOV AVR4,0
	        MOV AVR5,0
	        MOV AVR6,0
			
		MOV RHR,0
		MOV RMIN,0
		MOV RSEC,0
		MOV RMSEC,03 
	        
	        
	        JMP UI	
	
	SWATCHSTOP:
	     JMP SWATCHSTOP1

	RESUME:
	       MOV AH,2CH
	       INT 21H
	       MOV IHR,CH
	       MOV IMIN,CL
	       MOV ISEC,DH
	       MOV IMSEC,DL
	       
          
        MOV AL,HR
        MOV BL,MIN
        MOV CL,SEC
        MOV DL,MSEC
          
	ADD AL,RHR
	ADD BL,RMIN
	ADD CL,RSEC
	ADD DL,RMSEC
		  
        MOV RHR,AL
        MOV RMIN,BL
        MOV RSEC,CL
        MOV RMSEC,DL  
	     
	JMP RUNNING

MEGAFUNCTION5:
	JMP MEGAFUNCTION6
	      
	       
	DISPLAYTIME:	
		MOV AX,0600H
		MOV BH,07H
		MOV CX,0000H
		MOV DX,004FH;NEED TO CHANGE TO REMAIN THE UI
		INT 10H
	
		;SET CURSOR
		MOV AH,02H
		MOV BH,00
		MOV DX,0000H
		INT 10H
	
		MOV AX,0                           
		MOV AL,MIN
		ADD AL,RMIN
		DIV TEN
		MOV MIN1,AL
		MOV MIN2,AH
	
		MOV AH,02H
		MOV DL,MIN1
		ADD DL,30H
		INT 21H
    
		MOV AH,02H
		MOV DL,MIN2
		ADD DL,30H
		INT 21H
    
		MOV AH,09H
		LEA DX,SYM1
		INT 21H
    
		MOV AX,0
		MOV AL,SEC
		ADD AL,RSEC
		CMP AL,PER
		JNE S
    
		MOV AL,SEC
		SUB AL,PER
		INC MIN

		JMP S

	
MEGAFUNCTION4:
	JMP MEGAFUNCTION5
    
		S:
			DIV TEN
			MOV SEC1,AL
			MOV SEC2,AH
		
			MOV AH,02H
			MOV DL,SEC1
			ADD DL,30H
			INT 21H
    
			MOV AH,02H
			MOV DL,SEC2                         
			ADD DL,30H
			INT 21H
    
			MOV AH,09H
			LEA DX,SYM2
			INT 21H
    
			MOV AX,0
			MOV AL,MSEC
    
 
			DIV TEN
			MOV MSEC1,AL
			MOV MSEC2,AH
    
			MOV AH,02H
			MOV DL,MSEC1
			ADD DL,30H
			INT 21H
    
			MOV AH,02H
			MOV DL,MSEC2
			ADD DL,30H
			INT 21H
    
			MOV AH,09H
			LEA DX,SWATCH1
			INT 21H
    
			MOV AH,09H
			LEA DX,SWATCH2
			INT 21H
    
			MOV AH,09H
			LEA DX,SWATCH3
			INT 21H
    
			MOV AH,09H
			LEA DX,SWATCH4
			INT 21H
    
	
			MOV AH,01H
			INT 16H
			JZ RUNNING1
			MOV AH,00H
			INT 16H
			MOV INPUT,AL
			CMP INPUT,20H
			JE LAP1
			CMP INPUT,33H
			JE RESET1
			CMP INPUT,31H
			JE SWATCHSTOP2
	
		LAP1:
			JMP INCLAP
		RESET1:
			JMP RESET
		SWATCHSTOP2:
			JMP SWATCHSTOP
    
		RUNNING1:
		JMP RUNNING
		  
	DISPLAYLAP:
	            MOV DX,0
	            MOV AX,0
	            
	            MOV AH,06H
                MOV BH,07H
                MOV CX,0A27H
                MOV DX,184FH
                INT 10H
                
				
                MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR2
                MOV DL,00
                INT 10H
                
	             
                MOV AH,09H
                LEA DX,LAPC
                INT 21H
		JMP L11

MEGAFUNCTION3:
	JMP MEGAFUNCTION4
                
               L11:
               
                MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR1
                MOV DL,16
                INT 10H
                
                MOV AH,02H
	            MOV DL,LAPMIN1[0]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMIN2[0]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM1
                INT 21H
	                    
	            MOV AH,02H
	            MOV DL,LAPSEC1[0]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPSEC2[0]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM2
                INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC1[0]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC2[0]
	            ADD DL,30H
	            INT 21H
	            
	            INC CURSOR1
	            MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR1
                MOV DL,16
                INT 10H
                
                MOV AH,02H
	            MOV DL,LAPMIN1[1]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMIN2[1]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM1
                INT 21H
	                    
	            MOV AH,02H
	            MOV DL,LAPSEC1[1]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPSEC2[1]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM2
                INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC1[1]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC2[1]
	            ADD DL,30H
	            INT 21H
	            
	            INC CURSOR1
	            MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR1
                MOV DL,16
                INT 10H
                
                MOV AH,02H
	            MOV DL,LAPMIN1[2]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMIN2[2]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM1
                INT 21H
	                    
	            MOV AH,02H
	            MOV DL,LAPSEC1[2]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPSEC2[2]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM2
                INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC1[2]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC2[2]
	            ADD DL,30H
	            INT 21H
	            
	            INC CURSOR1
	            MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR1
                MOV DL,16
                INT 10H
                
                MOV AH,02H
	            MOV DL,LAPMIN1[3]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMIN2[3]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM1
                INT 21H
	                    
	            MOV AH,02H
	            MOV DL,LAPSEC1[3]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPSEC2[3]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM2
                INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC1[3]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC2[3]
	            ADD DL,30H
	            INT 21H
	            
	            INC CURSOR1
	            MOV AH,02H
                MOV BH,00
                MOV DH,CURSOR1
                MOV DL,16
                INT 10H
                
                MOV AH,02H
	            MOV DL,LAPMIN1[4]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMIN2[4]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM1
                INT 21H
	                    
	            MOV AH,02H
	            MOV DL,LAPSEC1[4]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPSEC2[4]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,09H
                LEA DX,SYM2
                INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC1[4]
	            ADD DL,30H
	            INT 21H
	            
	            MOV AH,02H
	            MOV DL,LAPMSEC2[4]
	            ADD DL,30H
	            INT 21H
		    JMP AVERAGE

MEGAFUNCTION2:
	JMP MEGAFUNCTION3
                
	
	AVERAGE:
	        MOV AX,0
			MOV AL,MIN
			ADD AL,RMIN
	        MUL PER
	        MOV BX,AX
	        MOV AL,SEC
			ADD AL,RSEC
	        MUL ONE
	        ADD BX,AX
	        MOV SECTOTAL,BX
	        
	        MOV AX,0
	        MOV AX,SECTOTAL
	        DIV LAPCOUNT
	        MOV AVRTIME1,AL
	        MOV AVRTIME2,AH
	        CMP AVRTIME1,10
	        
	        MOV AX,0
	        MOV AL,AVRTIME1
	        DIV TEN
	        MOV AVR3,AL
	        MOV AVR4,AH
	      L12:  
	        CMP AVR3,6
	        JL CALCMSEC
	       
	        MOV AL,AVR3
	        SUB AL,6
	        MOV AVR3,AL
	        INC AVR2
	        
	        LOOP L12
	        
	        CALCMSEC:
	        MOV AX,0           
	        MOV AL,MSEC
	        MUL ONE
	        DIV LAPCOUNT
	        MOV MSECTOTAL1,AL
	        MOV MSECTOTAL2,AH
	        CMP AL,10
	        JGE DIVTEN
	        
	        CMP AH,2
	        JGE INCAVR6
	        
	        INCAVR6:
	        INC AVR6
	        
	        MOV AVR5,AL
	        MOV AVR6,AH
	        JMP DISPLAYAVERAGE
	        
	        DIVTEN:
	                MOV AL,MSECTOTAL1
	                MUL ONE
	                DIV TEN
	                MOV AVR5,AL
	                MOV AVR6,AH
			
	DISPLAYAVERAGE:
		MOV AH,09H
	        LEA DX,NL
	        INT 21H
	            
	        MOV AH,09H
	        LEA DX,AVERAGETIME
	        INT 21H
	            
	        MOV AH,09H
	        LEA DX,SPACE
	        INT 21H
	            
	        MOV AH,02H
	        MOV DL,AVR1
	        ADD DL,30H
	        INT 21H

		JMP JUMPPUR1

MEGAFUNCTION1:
	JMP MEGAFUNCTION2

JUMPPUR1:  
	MOV AH,02H
	MOV DL,AVR2
	ADD DL,30H
	INT 21H
	            
	MOV AH,09H
        LEA DX,SYM1
        INT 21H
	                    
	MOV AH,02H
	MOV DL,AVR3
	ADD DL,30H
	INT 21H
	            
	MOV AH,02H
	MOV DL,AVR4
	ADD DL,30H
	INT 21H
	            
	MOV AH,09H
        LEA DX,SYM2
        INT 21H
	            
	MOV AH,02H
	MOV DL,AVR5
	ADD DL,30H
	INT 21H
	            
	MOV AH,02H
	MOV DL,AVR6
	ADD DL,30H
	INT 21H
	MOV CURSOR1,6
				
	CMP LAPCOUNT,5
	JE CONTINUEOREND
        JMP RUNNING
		
CONTINUEOREND:
	MOV AH,09H
	LEA DX,S2
	INT 21H

	MOV AH,01H
	INT 21H

	MOV OPTION,AL

	CMP OPTION,31H
	JE MEGAFUNCTION1
	
EXIT:	
	MOV AH,4CH
	INT 21H

	
MAIN ENDP
END MAIN

	