;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Selection Sort
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; In this file, you must implement the 'SORT' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'sort' label.

.orig x3000
HALT

;;Pseudocode (see PDF for explanation)
;;  arr: memory address of the first element in the array
;;  n: integer value of the number of elements in the array
;;
;;  sort(array, len, function compare) {
;;      i = 0;
;;      while (i < len - 1) {
;;          j = i;
;;          k = i + 1;
;;          while (k < len) {
;;              // update j if ARRAY[j] > ARRAY[k]
;;              if (compare(ARRAY[j], ARRAY[k]) > 0) {
;;                  j = k;
;;              }
;;              k++;
;;          }
;;          temp = ARRAY[i];
;;          ARRAY[i] = ARRAY[j];
;;          ARRAY[j] = temp;
;;          i++;
;;      }
;;  }

sort

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
        AND R0, R0, #0 ;i = 0

        ;LDR R1, R5, #5
        ;ADD R1, R1, #-1 ;R1 = len - 1

        ;NOT R1, R1
        ;ADD R1, R1, #1 ;R1 = -R1

WHILE1  LDR R1, R5, #5
        ADD R1, R1, #-1 ;R1 = len - 1
        NOT R1, R1
        ADD R1, R1, #1 ; R1 = -R1

        ADD R3, R0, R1 ; if i - (len - 1) < 0
        BRzp ENDWHILE1

        AND R1, R1, #0 ;j = 0
        ADD R1, R1, R0 ;j = i

        AND R2, R2, #0 ;k = 0
        ADD R2, R2, R0 ;k = i
        ADD R2, R2, #1 ;k = i + 1


WHILE2  LDR R3, R5, #5 ;R3 = len
        NOT R3, R3
        ADD R3, R3, #1 ;R3 = -len
        ADD R3, R2, R3 ;if k - len < 0
        BRzp ENDWHILE2

        ;push ARRAY[k] then ARRAY[j] bc compare(ARRAY[j], ARRAY[k])
        
        LDR R3, R5, #4 ;R3 = mem_addr of ARRAY[0]
        ADD R3, R3, R2 ;R3 = mem_addr of ARRAY[k]
        LDR R3, R3, #0 ;R3 = ARRAY[k]
        ADD R6, R6, #-1
        STR R3, R6, #0

        LDR R3, R5, #4 ;R3 = mem_addr of ARRAY[0]
        ADD R3, R3, R1 ;R3 = mem_addr of ARRAY[j]
        LDR R3, R3, #0 ;R3 = ARRAY[j]
        ADD R6, R6, #-1
        STR R3, R6, #0



        LDR R4, R5, #6 ;R4 = function compare
        JSRR R4
        LDR R3, R6, #0 ;R3 = RV
        ;LDR R3, R5, #3 ;R3 = RV
        ADD R6, R6, #3 ;pop RV and 2 args

IF      ADD R3, R3, #0 ;if R3 > 0
        BRnz ENDIF
        AND R1, R1, #0 ;j = 0
        ADD R1, R1, R2 ;j = k

ENDIF   NOP ;endif
        
        ADD R2, R2, #1 ;k++


        BR WHILE2
ENDWHILE2 NOP ;endwhile2

        LDR R3, R5, #4 ;R3 = mem_addr of ARRAY[0]
        ADD R3, R3, R0 ;R3 = mem_addr of ARRAY[i]
        LDR R4, R3, #0 ;R4 = ARRAY[i]
        STR R4, R5, #0 ;local_var = ARRAY[i]

        LDR R4, R5, #4 ;R4 = mem_addr of ARRAY[0]
        ADD R4, R4, R1 ;R4 = mem_addr of ARRAY[j]
        LDR R4, R4, #0 ;R4 = ARRAY[j]

        STR R4, R3, #0 ;ARRAY[i] = ARRAY[j]

        LDR R4, R5, #4 ;R3 = mem_addr of ARRAY[0]
        ADD R4, R4, R1 ;R4 = mem_addr of ARRAY[j]
        LDR R3, R5, #0 ;R3 = local_var
        STR R3, R4, #0 ;ARRAY[j] = temp

        ADD R0, R0, #1 ;i++

        BR WHILE1
ENDWHILE1 NOP ;endwhile1


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

;; USE FOR DEBUGGING IN COMPLX
;; load array at x4000 and put the length as 7

;; ARRAY
.orig x4000
    .fill 4
    .fill -9
    .fill 0
    .fill -2
    .fill 9
    .fill 3
    .fill -10
.end

;; The following subroutine is the compare function that is passed  
;; as the function address parameter into the sorting function. It   
;; will work perfectly fine as long as you follow the   
;; convention on the caller's side. 
;; DO NOT edit the code below; it will be used by the autograder.   
.orig x5000 
    ;;greater than  
CMPGT   
    .fill x1DBD
    .fill x7180
    .fill x7381
    .fill x6183
    .fill x6384
    .fill x927F
    .fill x1261
    .fill x1201
    .fill x0C03
    .fill x5020
    .fill x1021
    .fill x0E01
    .fill x5020
    .fill x7182
    .fill x6180
    .fill x6381
    .fill x1DA2
    .fill xC1C0
    .fill x9241
.end