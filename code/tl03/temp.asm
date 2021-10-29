;LDR R0, R5, #4 ;R0 = mem_addr of ARRAY[0]
;LDR R1, R5, #5 ;R1 = length

AND R2, R2, #0 ;i=0

AND R3, R3, #0
ADD R3, R3, R1
NOT R3, R3
ADD R3, R3, #1 ;R3 = -length

WHILE LDR R0, R5, #4 ;R0 = mem_addr of ARRAY[0]
	LDR R1, R5, #5 ;R1 = length
	NOT R1, R1
	ADD R1, R1, #1 ;R3 = -length
	ADD R1, R2, R1
	BRnz ENDWHILE ;if i - length <= 0

	;push secElem
	AND R1, R1, #0
	ADD R1, R2, R0
	ADD R1, R1, #1 ;secElem = mem_addr of ARRAY[i + 1]
	LDR R1, R1, #0 ;secElem = ARRAY[i + 1]
	ADD R6, R6, #-1
	STR R1, R6, #0

	;push firstElem
	AND R1, R1, #0
	ADD R1, R2, R0 ;firstElem = mem_addr of ARRAY[i]
	LDR R1, R2, #0 ;firstElem = ARRAY[i]
	ADD R6, R6, #-1
	STR R1, R6, #0

	JSR DIV
	LDR R3, R6, #0 ;R3 = DIV(firstElem, secElem)
	ADD R6, R6, #3 ;pop RV and 2 arg


	;push secElem
	AND R1, R1, #0
	ADD R1, R2, R0
	ADD R1, R1, #1 ;secElem = mem_addr of ARRAY[i + 1]
	LDR R1, R1, #0 ;secElem = ARRAY[i + 1]
	ADD R6, R6, #-1
	STR R1, R6, #0

	;push firstElem
	AND R1, R1, #0
	ADD R1, R2, R0 ;firstElem = mem_addr of ARRAY[i]
	LDR R1, R2, #0 ;firstElem = ARRAY[i]
	ADD R6, R6, #-1
	STR R1, R6, #0

	JSR MAX

	LDR R1, R6, #0 ;R1 = MAX(firstElem,secElem)
	ADD R6, R6, #3 ;pop RV and 2 arg
	
	AND R4, R4, #0 ;R4 = 0
	ADD R4, R2, R3 ;R4 = i + offset
	ADD R4, R0, R4 ;R4 = ARRAY[i + offset]

	STR R3, R4, #0;

	ADD R2, R2, #2

BR WHILE
ENDWHILE NOP