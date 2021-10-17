;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Square
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; a = (argument 1);
;; ANSWER = 0;
;; for (int i = 0; i < a; i++) {
;;		ANSWER += a;
;; }
;; return ANSWER;

.orig x3000


AND R0, R0, #0;
LD R0, A ;R0 = A
NOT R0, R0
ADD R0, R0, #1 ;R0 = -A

AND R1, R1, #0
;ST R1, ANSWER ;ANSWER = 0

AND R2, R2, #0 ;i = 0


FOR1 ADD R3, R2, R0 ;start loop, stop when i - A >= 0
BRzp ENDFOR1

NOT R0, R0
ADD R0, R0, #1 ;R0 = A

ADD R1, R1, R0 ;R1 += A

NOT R0, R0
ADD R0, R0, #1 ;R0 = -A

ADD R2, R2, #1 ;i++

BR FOR1
ENDFOR1 NOP ;end for


ST R1, ANSWER ;ANSWER = R1



HALT


A .fill 9

ANSWER .blkw 1

.end
