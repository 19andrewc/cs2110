#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// top left corner coordinates
// size of bee is 30x30
typedef struct bee {
	int row;
	int col;
} Bee;

void moveBee(Bee *b, int row, int col);

#endif
