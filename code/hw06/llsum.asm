;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Linked List Sum
;;=============================================================
;; Name: Austin Peng
;;============================================================

;; In this file, you must implement the 'llsum' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseCopy' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of llsum: Node head
;;
;; llsum(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return 0;
;;     }
;;     Node next = head.next;
;;     sum = head.data + llsum(next);
;;     return sum;
;; }

llsum

;build up stack frame
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
		AND R0, R0, #0 ;R0 = 0
		STR R0, R5, #0 ;sum = R0

IF		LDR R0, R5, #4 ;R0 = node
		ADD R0, R0, #0
		BRnp ENDIF ;branch if node is 0
		STR R0, R5, #3 ;RV = 0
		BR RETURN

ENDIF 	NOP ;endif

		LDR R0, R5, #4 ;R0 = node
		LDR R1, R0, #0 ;R1 = mem_addr of node.next
		LDR R2, R0, #1 ;R2 = current node.data

		;push mem_addr of node.next
		ADD R6, R6, #-1
		STR R1, R6, #0
		JSR llsum

		;pop rv and 1 arg
		LDR R3, R6, #0 ;R0 => R6 = RV = llsum(node.next)
		ADD R6, R6, #2 ;pop RV and 1 arg
		ADD R3, R3, R2 ;node.data + llsum(node.next)
		STR R3, R5, #3 ;RV = node.data + llsum(node.next)

RETURN

;break down stack frame
LDR R4, R5, -5 ;restore R4
LDR R3, R5, -4 ;restore R3
LDR R2, R5, -3 ;restore R2
LDR R1, R5, -2 ;restore R1
LDR R0, R5, -1 ;restore R0
ADD R6, R5, 0 ;pop saved regs,
 			  ;and local vars
LDR R7, R5, 2 ;R7 = ret addr
LDR R5, R5, 1 ;FP = Old FP
ADD R6, R6, 3 ;pop 3 words

RET

;; used by the autograder
STACK .fill xF000
.end

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end
