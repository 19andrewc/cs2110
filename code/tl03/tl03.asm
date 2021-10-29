;; Timed Lab 3
;; Student Name:

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA immediately.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;; // (checkpoint 1)
;; int MAX(int a, int b) {
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }
;; }
;;
;;
;;
;;
;; DIV(x, y) {
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }
;; }
;;
;;
;;
;; // (checkpoint 4)
;; void MAP(array, length) {
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
;; }


.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START MAX SUBROUTINE
MAX

;lay out stack frame
ADD R6, R6, #-4 ;push 4 wds (arg1, arg2, RV, RA, FP)
					;set rv later
STR R7, R6, #2 ;save RA
STR R5, R6, #1 ;save old FP
                	;set local var later
ADD R5, R6, #0 ;FP = SP
ADD R6, R6, #-5 ;push 5 words   
STR R0, R5, #-1 ;save R1
STR R1, R5, #-2 ;save R2
STR R2, R5, #-3 ;save R3
STR R3, R5, #-4 ;save R4
STR R4, R5, #-5 ;save R5


LDR R0, R5, #4 ;R0 = a
LDR R1, R5, #5 ;R1 = b

	NOT R1, R1
	ADD R1, R1, #1 ;R1 = -b
	ADD R1, R0, R1 ;R2 = a - b

	BRnz ELSE1 ;if a - b <= 0, return 1

	AND R1, R1, #0 ;R1 = 0
	STR R1, R5, #3 ;RV = 0
	BR ENDIF1

ELSE1 AND R1, R1, #0
	ADD R1, R1, #1 ;R1 = 1
	STR R1, R5, #3 ;RV = 1

ENDIF1 NOP ;endif

;break down stack frame
LDR R4, R5, #-5 ;restore R4
LDR R3, R5, #-4 ;restore R3
LDR R2, R5, #-3 ;restore R2
LDR R1, R5, #-2 ;restore R1
LDR R0, R5, #-1 ;restore R0
ADD R6, R5, #0 ;pop saved regs,
 			  ;and local vars
LDR R7, R5, #2 ;R7 = ret addr
LDR R5, R5, #1 ;FP = Old FP
ADD R6, R6, #3 ;pop 3 words

RET
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV

;lay out stack frame
ADD R6, R6, #-4 ;push 4 wds (arg1, arg2, RV, RA, FP)
					;set rv later
STR R7, R6, #2 ;save RA
STR R5, R6, #1 ;save old FP
                	;set local var later
ADD R5, R6, #0 ;FP = SP
ADD R6, R6, #-5 ;push 5 words   
STR R0, R5, #-1 ;save R1
STR R1, R5, #-2 ;save R2
STR R2, R5, #-3 ;save R3
STR R3, R5, #-4 ;save R4
STR R4, R5, #-5 ;save R5

LDR R0, R5, #4 ;R0 = x
LDR R1, R5, #5 ;R1 = y

	LDR R2, R5, #4 ;R2 = x
	NOT R2, R2
	ADD R2, R2, #1 ;R2 = -x
	ADD R2, R1, R2 ;R2 = y - x

	BRnz ELSE2 ;branch if y - x <= 0

	AND R0, R0, #0 ;R0 = 0
	STR R0, R5, #3 ;RV = 0

	BR ENDIF2

ELSE2
	;push y
	LDR	R0, R5, #5
	ADD R6, R6, #-1
	STR R0, R6, #0

	;push x-y
	LDR R0, R5, #4
	LDR	R1, R5, #5 ;R1 = y
	NOT R1, R1
	ADD R1, R1, #1 ;R1 = -y
	ADD R1, R0, R1 ;R1 = x - y
	ADD R6, R6, #-1
	STR R1, R6, #0

	JSR DIV
	LDR R0, R6, #0 ;R6 = RV = DIV(x-y, y)
	ADD R6, R6, #3 ;pop RV and 2 arg
	
	ADD R0, R0, #1 ;R0 = DIV(x-y,y) + 1
	STR R0, R5, #3 ;RV = DIV(x-y,y) + 1



ENDIF2 NOP ;endif


;break down stack frame
LDR R4, R5, #-5 ;restore R4
LDR R3, R5, #-4 ;restore R3
LDR R2, R5, #-3 ;restore R2
LDR R1, R5, #-2 ;restore R1
LDR R0, R5, #-1 ;restore R0
ADD R6, R5, #0 ;pop saved regs,
 			  ;and local vars
LDR R7, R5, #2 ;R7 = ret addr
LDR R5, R5, #1 ;FP = Old FP
ADD R6, R6, #3 ;pop 3 words



RET
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP




;lay out stack frame
ADD R6, R6, #-4 ;push 4 wds (arg1, arg2, RV, RA, FP)
					;set rv later
STR R7, R6, #2 ;save RA
STR R5, R6, #1 ;save old FP
                	;set local var later
ADD R5, R6, #0 ;FP = SP
ADD R6, R6, #-5 ;push 5 words   
STR R0, R5, #-1 ;save R1
STR R1, R5, #-2 ;save R2
STR R2, R5, #-3 ;save R3
STR R3, R5, #-4 ;save R4
STR R4, R5, #-5 ;save R5

AND R0, R0, #0 ;i = 0

WHILE LDR R1, R5, #4 ;R1 = mem_addr of ARRAY[0]
	LDR R2, R5, #5 ;R2 = length

	NOT R2, R2
	ADD R2, R2, #1 ;R2 = -length
	ADD R2, R0, R2 ;R2 = i - length
	BRzp ENDWHILE

	;push secElem
	LDR R1, R5, #4
	ADD R1, R1, R0
	ADD R1, R1, #1 ;R1 = mem_addr of ARRAY[i + 1]
	LDR R1, R1, #0 ;R1 = ARRAY[i + 1]
	ADD R6, R6, #-1
	STR R1, R6, #0

	;push firstElem
	LDR R1, R5, #4
	ADD R1, R1, R0 ;R1 = mem_addr of ARRAY[i]
	LDR R1, R1, #0 ;R1 = ARRAY[i]
	ADD R6, R6, #-1
	STR R1, R6, #0

	JSR MAX
	LDR R2, R6, #0 ;R2 = offset = MAX(firstElem, secElem)
	ADD R6, R6, #3 ;pop RV and 2 arg

	;push secElem
	LDR R1, R5, #4
	ADD R1, R1, R0
	ADD R1, R1, #1 ;R1 = mem_addr of ARRAY[i + 1]
	LDR R1, R1, #0 ;R1 = ARRAY[i + 1]
	ADD R6, R6, #-1
	STR R1, R6, #0

	;push firstElem
	LDR R1, R5, #4
	ADD R1, R1, R0 ;R1 = mem_addr of ARRAY[i]
	LDR R1, R1, #0 ;R1 = ARRAY[i]
	ADD R6, R6, #-1
	STR R1, R6, #0

	JSR DIV
	LDR R1, R6, #0 ;R1 = DIV(firstElem, secElem)
	ADD R6, R6, #3 ;pop RV and 2 arg

	AND R3, R3, #0 ;R3 = 0
	ADD R3, R0, R2 ; R3 = i + offset

	LDR R4, R5, #4 ;R4 = mem_adr of ARRAY[0]
	ADD R4, R4, R3 ;R4 = mem_adr of ARRAY[i + offset]

	STR R1, R4, #0 ;arr[i+offset] = div

	ADD R0, R0, #2 ;i += 2



BR WHILE
ENDWHILE NOP ;endwhile





;break down stack frame
LDR R4, R5, #-5 ;restore R4
LDR R3, R5, #-4 ;restore R3
LDR R2, R5, #-3 ;restore R2
LDR R1, R5, #-2 ;restore R1
LDR R0, R5, #-1 ;restore R0
ADD R6, R5, #0 ;pop saved regs,
 			  ;and local vars
LDR R7, R5, #2 ;R7 = ret addr
LDR R5, R5, #1 ;FP = Old FP
ADD R6, R6, #3 ;pop 3 words



RET
; END MAP SUBROUTINE


; LENGTH FOR TESTING

LENGTH .fill x12

; ARRAY FOR TESTING
ARRAY .fill x4000

.end

.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end
