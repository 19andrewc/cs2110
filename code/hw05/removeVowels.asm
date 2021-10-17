;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Remove Vowels
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; STRING = (argument 1);
;; ANSWER = "";
;; for (int i = 0; i < a.length; i++) {
;;       if (string[i] == '\0'){
;;          break
;;        }

;;       if (string[i] == ’A’) {
;;           continue;
;;        } else if (string[i] == ’E’) {
;;            continue;
;;        } else if (string[i] == ’I’) {
;;            continue;
;;        } else if (string[i] == ’O’) {
;;            continue;
;;        } else if (string[i] == ’U’) {
;;            continue;
;;        } else if (string[i] == ’a’) {
;;            continue;
;;        } else if (string[i] == ’e’) {
;;            continue;
;;        } else if (string[i] == ’i’) {
;;            continue;
;;        } else if (string[i] == ’o’) {
;;            continue;
;;        } else if (string[i] == 'u') {
;;            continue;
;;        }
;;
;;        ANSWER += STRING[i];
;;	}
;;  ANSWER += '\0';
;;
;;  return ANSWER;
;; }

.orig x3000

AND R0, R0, #0 ;i = 0, string counter
AND R1, R1, #0 ;j = 0, answer counter

WHILE1 LD R2, STRING ;start loop

ADD R2, R0, R2 ;R2 = mem_addr of STRING[i]
LDR R2, R2, #0 ;R2 = STRING[i]

NOT R2, R2
ADD R2, R2, #1 ; R2 = -R2

; <======== if 0 word ========>
IF ADD R3, R2, #0 ;if 0 word
BRz ENDWHILE1

; <======== if A ========>
LD R3, A
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if E ========>
LD R3, E
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if I ========>
LD R3, I
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if O ========>
LD R3, O
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if U ========>
LD R3, U
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if a ========>
LD R3, LOWERA
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if e ========>
LD R3, LOWERE
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if i ========>
LD R3, LOWERI
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if o ========>
LD R3, LOWERO
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <======== if u ========>
LD R3, LOWERU
ADD R4, R3, R2 ;if 0 word, skip and don't add
BRz ENDIF

; <== if not a vowel or 0 word, load into answer ==>
LD R5, ANSWER
ADD R5, R5, R1 ; mem_addr of ANSWER[j]

NOT R2, R2
ADD R2, R2, #1

STR R2, R5, #0
ADD R1, R1, #1 ;j++

ENDIF NOP
ADD R0, R0, #1 ;i++


BR WHILE1
ENDWHILE1 NOP; end while

AND R2, R2, #0
LD R5, ANSWER
ADD R5, R5, R1 ;mem_addr of ANSWER[j]
STR R2, R5, #0 ;add 0 word to end of ANSWER

HALT

STRING .fill x4000
ANSWER .fill x4100



;;NOTE: For your convenience, you can make new labels for
;;the ASCII values of other vowels here! 2 have been done
;;here as an example.

LOWERA .fill x61    ;; a in ASCII
LOWERE .fill x65	;; e in ASCII
LOWERI .fill x69	;; i in ASCII
LOWERO .fill x6F	;; o in ASCII
LOWERU .fill x75	;; u in ASCII

A .fill x41     ;; A in ASCII
E .fill x45		;; E in ASCII
I .fill x49		;; I in ASCII
O .fill x4F		;; O in ASCII
U .fill x55		;; U in ASCII

.end

.orig x4000

.stringz "spongebob and SQUIDWARD"

.end
