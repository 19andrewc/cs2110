;;=======================================
;; CS 2110 - Fall 2021
;; HW6 - Collatz Conjecture
;;=======================================
;; Name: Austin Peng
;;=======================================

;; In this file, you must implement the 'collatz' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'collatz' label.


.orig x3000
HALT

collatz
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of collatz: postive integer n
;;
;; Pseudocode:
;; collatz(int n) {
;;     if (n == 1) {
;;         return 0;
;;     }
;;     if (n % 2 == 0) {
;;         return collatz(n/2) + 1;
;;     } else {
;;         return collatz(3 * n + 1) + 1;
;;     }
;; }

;lay out stack frame
ADD R6, R6, #-4 ;push 4 wds
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


;subroutine here
		LDR R0, R5, #4 ;R0 = n
		ADD R0, R0, #-1
		BRnp ELSE1

		STR R0, R5, 3 ;RV = 0
		BR ENDIF

ELSE1 	LDR R0, R5, #4 ;R0 = n
		AND R0, R0, x0001 ;get least significant bit of n
		ADD R0, R0, #0 ;if 1 -> odd, 0 -> even
		BRnp ELSE2

		;push n
		LDR	R0, R5, #4 ;R0 = n
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR divideBy2
		LDR R0, R6, #0 ;R6 = RV = divideBy2(n)
		ADD R6, R6, #2 ;pop RV and 1 arg

		;push n/2
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR collatz
		LDR R0, R6, #0 ;R0 => R6 = RV = collatz(n / 2)
		ADD R6, R6, #2 ;pop RV and 1 arg
		ADD R0, R0, #1 ;collatz(n / 2) + 1
		STR R0, R5, #3 ;RV = collatz(n / 2) + 1

		BR ENDIF

ELSE2	LDR	R0, R5, #4 ;R0 = n
		ADD R1, R0, R0 ;R1 = 2 * n
		ADD R1, R0, R1 ;R1 = 3 * n
		ADD R1, R1, #1 ;R1 = 3 * n + 1
		
		;push 3 * n + 1
		ADD R6, R6, #-1
		STR R1, R6, #0

		JSR collatz
		LDR R0, R6, #0 ;R0 => R6 = RV = collatz(3 * n + 1)
		ADD R6, R6, #2 ;pop RV and 1 arg
		ADD R0, R0, #1 ;R0 = collatz(3 * n + 1) + 1
		STR R0, R5, #3 ;RV = collatz(3 * n + 1) + 1

ENDIF NOP ;end if


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

;; The following is a subroutine that takes a single number n and returns n/2.
;; You may call this subroutine to help you with 'collatz'.

;; DO NOT CHANGE THIS SUBROUTINE IN ANY WAY
divideBy2
.fill x1DBC
.fill x7F82
.fill x7B81
.fill x1BA0
.fill x1DBB
.fill x7184
.fill x7383
.fill x7582
.fill x7781
.fill x7980
.fill x6144
.fill x5260
.fill x1020
.fill x0C03
.fill x103E
.fill x1261
.fill x0FFB
.fill x7343
.fill x6980
.fill x6781
.fill x6582
.fill x6383
.fill x6184
.fill x1D60
.fill x6B81
.fill x6F82
.fill x1DA3
.fill xC1C0


; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end