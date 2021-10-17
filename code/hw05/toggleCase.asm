;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Toggle Case
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;;	string = "Assembly is interesting"; // given string
;;	Array[string.len()] answer; // array to store the result string
;;	i = 0;
;;
;;	while (string[i] != '\0') {
;;	    if (string[i] == " ") {
;;	        answer[i] = " ";
;;	    } else if (string[i] >= "A" && string[i] <= "Z") {
;;	        answer[i] = string[i].lowerCase();
;;	    } else {
;;	        answer[i] = string[i].upperCase();
;;	    }
;;	    i++;
;;	}


.orig x3000

AND R0, R0, #0 ;i = 0 string counter
AND R1, R1, #0 ;j = 0 answer counter

WHILE LD R2, STRING ;R2 = mem_addr of STRING[0]

ADD R2, R2, R0 ;R2 = mem_addr of STRING[i]
LDR R2, R2, #0 ;R2 = STRING[i]

NOT R2, R2
ADD R2, R2, #1 ;R2 = -R2


IF ADD R2, R2, #0 ;if R2 = 0 word, end loop
BRz ENDWHILE

LD R3, SPACE
ADD R3, R2, R3 ;if R2 = space, add space
BRz ELSE1

LD R3, Z
ADD R3, R2, R3 ;if Z - R2 >= 0, add R2 + 32
BRzp ELSE2
BR ELSE3

ELSE1
NOT R2, R2
ADD R2, R2, #1 ;R2 = -R2

LD R3, ANSWER
ADD R3, R3, R1 ;R3 = mem_addr of ANSWER[j]
STR R2, R3, #0 ;ANSWER[j] = R3
ADD R1, R1, #1 ;j++
BR ENDIF

ELSE2
NOT R2, R2
ADD R2, R2, #1 ;R2 = -R2

ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #2

LD R3, ANSWER
ADD R3, R3, R1 ;R3 = mem_addr of ANSWER[j]
STR R2, R3, #0 ;ANSWER[j] = R3
ADD R1, R1, #1 ;j++
BR ENDIF

ELSE3
NOT R2, R2
ADD R2, R2, #1 ;R2 = -R2

ADD R2, R2, #-16
ADD R2, R2, #-16

LD R3, ANSWER
ADD R3, R3, R1 ;R3 = mem_addr of ANSWER[j]
STR R2, R3, #0 ;ANSWER[j] = R3
ADD R1, R1, #1 ;j++
BR ENDIF


ENDIF NOP ;end if


ADD R0, R0, #1 ;i++


BR WHILE
ENDWHILE NOP ;end while

AND R2, R2, #0
LD R3, ANSWER
ADD R3, R3, R1 ;R3 = mem_addr of ANSWER[j]
STR R2, R3, #0 ;ANNSWER[j] = 0 word
ADD R1, R1, #1 ;j++

HALT


;; ASCII table: https://www.asciitable.com/


;; FILL OUT THESE ASCII CHARACTER VALUE FIRST TO USE IT IN YOUR CODE
SPACE	.fill x20
A		.fill x41
Z		.fill x5A
a       .fill x61
z       .fill x7A
BREAK	.fill x5D	;; this is the middle of uppercase and lowercase characters

STRING .fill x4000
ANSWER .fill x4100
.end

.orig x4000
.stringz "Assembly is INTERESTING"
.end

.orig x4100
.blkw 23
.end