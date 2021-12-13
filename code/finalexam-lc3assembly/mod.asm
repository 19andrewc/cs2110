;;=======================================
;; CS 2110 - Fall 2021
;; Final Exam - Modulo
;;=======================================
;; Name: Austin Peng
;;=======================================

;; In this file, you must implement the 'mod' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'mod' label.


.orig x3000
HALT

mod
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of mod: integer a, positive integer b
;;
;; Pseudocode:
;; 
;; mod(a, b) {
;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
;;
;;     if (a < b) {
;;         return a;
;;     }
;;
;;     return mod(a - b, b);
;; }
;;
    
    ;stack buildup
    ADD R6, R6, -4      ;push 4 wds
                        ;set rv later
    STR R7, R6, 2       ;save RA
    STR R5, R6, 1       ;save old FP
                        ;set local var later
    ADD R5, R6, 0       ;FP = SP
    ADD R6, R6, -5      ;push 5 words   
    STR R0, R5, -1      ;save SR1
    STR R1, R5, -2      ;save SR2
    STR R2, R5, -3      ;save SR3
    STR R3, R5, -4      ;save SR4
    STR R4, R5, -5      ;save SR5
    


;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
;;
    LDR R0, R5, #4 ; R0 = a
    LDR R1, R5, #5 ; R1 = b

    ADD R0, R0, #0 ; if R0 < 0 continue
    BRzp ELSE1

    ; push b
    LDR R1, R5, #5 ; R1 = b
    ADD R6, R6, #-1 ; update SP
    STR R1, R6, #0 ;push b

    ; push a + b
    ADD R0, R0, R1 ;R0 = a + b
    ADD R6, R6, #-1 ; update SP
    STR R0, R6, #0 ;push a + b

    JSR mod

    LDR R0, R6, #0; R0 = RV
    ADD R6, R6, 3; uhhh this line sus
    STR R0, R5, #3; store answer into RV

    ;stack breakdown
    LDR R4, R5, -5      ; restore R4
    LDR R3, R5, -4      ; restore R3
    LDR R2, R5, -3      ; restore R2
    LDR R1, R5, -2      ; restore R1
    LDR R0, R5, -1      ; restore R0
    ADD R6, R5, 0       ; pop saved regs,
                        ; and local vars
    LDR R7, R5, 2       ; R7 = ret addr
    LDR R5, R5, 1       ; FP = Old FP
    ADD R6, R6, 3       ; pop 3 words

    RET


ELSE1

;;     if (a < b) {
;;         return a;
;;     }

    LDR R0, R5, #4 ; R0 = a
    LDR R1, R5, #5 ; R1 = b
    NOT R1, R1
    ADD R1, R1, #1 ; R1 = -b

    ADD R0, R0, R1 ;R0 = a - b ; if a - b < 0
    BRzp ELSE2

    LDR R0, R5, #4 ; R0 = a
    STR R0, R5, #3; store answer into RV

    ;stack breakdown
    LDR R4, R5, -5      ; restore R4
    LDR R3, R5, -4      ; restore R3
    LDR R2, R5, -3      ; restore R2
    LDR R1, R5, -2      ; restore R1
    LDR R0, R5, -1      ; restore R0
    ADD R6, R5, 0       ; pop saved regs,
                        ; and local vars
    LDR R7, R5, 2       ; R7 = ret addr
    LDR R5, R5, 1       ; FP = Old FP
    ADD R6, R6, 3       ; pop 3 words
    RET


ELSE2

;;return mod(a - b, b);
    LDR R0, R5, #4 ; R0 = a
    LDR R1, R5, #5 ; R1 = b

    ; push b
    LDR R1, R5, #5 ; R1 = b
    ADD R6, R6, #-1 ; update SP
    STR R1, R6, #0 ;push b

    ; push a - b
    NOT R1, R1
    ADD R1, R1, #1 ;R1 = -b

    ADD R0, R0, R1 ;R0 = a - b
    ADD R6, R6, #-1 ; update SP
    STR R0, R6, #0 ;push a - b


    JSR mod

    LDR R0, R6, #0; R0 = RV
    ADD R6, R6, 3; uhhh this line sus
    STR R0, R5, #3; store answer into RV
    

    ;stack breakdown
    LDR R4, R5, -5      ; restore R4
    LDR R3, R5, -4      ; restore R3
    LDR R2, R5, -3      ; restore R2
    LDR R1, R5, -2      ; restore R1
    LDR R0, R5, -1      ; restore R0
    ADD R6, R5, 0       ; pop saved regs,
                        ; and local vars
    LDR R7, R5, 2       ; R7 = ret addr
    LDR R5, R5, 1       ; FP = Old FP
    ADD R6, R6, 3       ; pop 3 words

RET

;; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end