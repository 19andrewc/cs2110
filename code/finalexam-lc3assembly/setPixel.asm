;;=============================================================
;; CS 2110 - Fall 2021
;; Final Exam - Set Pixel
;;=============================================================
;; Name: Austin Peng
;;=============================================================

;; Pseudocode (see PDF for additional information)
;; 
;; offset = 0;
;; for (i = 0; i < ROW; i++) {
;;		offset += WIDTH;
;; }
;; offset += COL;
;; VIDEOBUFFER[offset] = COLOR

.orig x3000

    AND R0, R0, #0 ;i = 0
    AND R1, R1, #0 ;offset = 0

    LD R2, ROW ;R2 = ROW
    NOT R2, R2
    ADD R2, R2, #1 ;R2 = -ROW

    AND R4, R4, #0 ;temp var

WHILE ADD R4, R0, R2 ;if i - row < 0 ; else BR
    BRzp ENDWHILE

    LD R3, WIDTH ;R3 = WIDTH
    ADD R1, R1, R3 ;offset = offset + WIDTH

    ADD R0, R0, #1 ;i++
    BR WHILE

ENDWHILE NOP

    LD R3, COL ;R3 = COL
    ADD R1, R1, R3 ;offset = offset + COL


    LD R3, VIDEOBUFFER ;R3 = addr of VIDEOBUFFER[0]
    ADD R3, R3, R1 ;R3 = addr of VIDEOBUFFER[offset]

    LD R4, COLOR ;R4 = COLOR
    STR R4, R3, #0 ;VIDEOBUFFER[offset] = COLOR


HALT

COLOR .fill xFFFF
ROW .fill 1
COL .fill 1

HEIGHT .fill 2
WIDTH .fill 2

VIDEOBUFFER .fill x4000

.end

.orig x4000
    .fill 2
    .fill 1
    .fill 1
    .fill 0
.end