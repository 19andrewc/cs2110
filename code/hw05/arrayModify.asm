;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Array Modify
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    i = 0; // first index 
;;    len = Len(ARR_X);
;;
;;    while (i < len) {
;;        if (i % 2 == 0) {
;;            //if we are at an even index, subtract 10 and save it to the array at that index 
;;    	    ARR_Y[i] = ARR_X[i] - 10;
;;        } else {
;;            //if we are at odd index, multiply by 2 and save it to the array at that index 
;;    	    ARR_Y[i] = ARR_X[i] * 2;
;;        }
;;        	i++;
;;    }

.orig x3000



AND R0, R0, #0 ;i = 0

AND R1, R1, #0 ;R1 = 0
LD R1, LENGTH ;R1 = LENGTH
NOT R1, R1
ADD R1, R1, #-1 ;R1 = -LENGTH


WHILE1 ADD R3, R1, R0, ;start while, end when i - len >= 0
BRzp ENDWHILE1

AND R3, R0, x0001 ;get least significant bit of i

IF ADD R3, R3, #0
BRnp ELSE1 ;if R3 != 0, i % 2 != 0

AND R2, R2, #0 ;R1 = 0
LD R2, ARR_X ;R2 = mem_addr of ARR_X[0]
ADD R2, R2, R0 ;R2 = mem_addr of ARR_X[i]
LDR R2, R2, #0 ;R2 = ARR_X[i]
ADD R2, R2, #-10 ;R2 = ARR_X[i] - 10

LD R3, ARR_Y ;R3 = mem_addr of ARR_Y[0]
ADD R3, R3, R0 ;R3 = mem_addr of ARR_Y[i]
STR R2, R3, #0 ;ARR_Y[i] = R2

BR ENDIF
ELSE1

AND R2, R2, #0 ;R1 = 0
LD R2, ARR_X ;R2 = mem_addr of ARR_X[0]
ADD R2, R2, R0 ;R2 = mem_addr of ARR_X[i]
LDR R2, R2, #0 ;R2 = ARR_X[i]
ADD R2, R2, R2 ;R2 = ARR_X[i] + ARR_X[i]

LD R3, ARR_Y ;R3 = mem_addr of ARR_Y[0]
ADD R3, R3, R0 ;R3 = mem_addr of ARR_Y[i]
STR R2, R3, #0 ;ARR_Y[i] = R2

ENDIF NOP ;end if

ADD R0, R0, #1 ;i++


BR WHILE1
ENDWHILE1 NOP ;end while



HALT

ARR_X       .fill x4000
ARR_Y       .fill x4100
LENGTH      .fill 4
.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.end

.orig x4100
.blkw 4
.end
