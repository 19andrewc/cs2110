#include "main.h"

#include <stdio.h>
#include <stdlib.h>

#include "gba.h"

#include "images/start.h"
#include "images/end.h"
#include "images/bee.h"
#include "images/honeycomb.h"

Bee b;

enum gba_state {
  START,
  START_TEXT,
  PLAY_INIT,
  PLAY,
  WIN_BG,
  WIN_TEXT,
  LOSE_BG,
  LOSE_TEXT,
  RESTART
};

int main(void) {
  REG_DISPCNT = MODE3 | BG2_ENABLE;

  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;

  // Load initial application state
  enum gba_state state = START;

  char title[] = "PRESS ENTER TO PLAY";
  char buffer[30];
  int speed = 3;

  int honeycombRow = 130;
  int honeycombCol = 210;

  int timer = 0;

  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons
    

    switch (state) {
      case START:
        drawFullScreenImageDMA(start);
        timer = 0;
        
        state = START_TEXT;
        break;
      case START_TEXT:
        drawString(60, 65, title, BLACK);
        if (KEY_DOWN(BUTTON_START, currentButtons)) {
          state = PLAY_INIT;
        }
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = RESTART;
        }
        break;
      case PLAY_INIT:
        waitForVBlank();
        fillScreenDMA(BLACK);
        Bee *bptr, b;
        bptr = &b; 
        (*bptr).row = 0;
        (*bptr).col = 0;
        drawImageDMA((*bptr).row, (*bptr).col, 30, 30, bee);
        drawImageDMA(honeycombRow, honeycombCol, 30, 30, honeycomb);
        state = PLAY;
        break;
      case PLAY:
        waitForVBlank();
        drawRectDMA(5, 160, 80, 25, BLACK);
        drawImageDMA((*bptr).row, (*bptr).col, 30, 30, bee);
        sprintf(buffer, "TIME: %d", timer / 60);
        drawString(5, 160, buffer, WHITE);


        if (KEY_DOWN(BUTTON_UP, currentButtons)) {
          moveBee(bptr, -speed, 0);
        }
        if (KEY_DOWN(BUTTON_DOWN, currentButtons)) {
          moveBee(bptr, speed, 0);
        }
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons)) {
          moveBee(bptr, 0, speed);
        }
        if (KEY_DOWN(BUTTON_LEFT, currentButtons)) {
          moveBee(bptr, 0, -speed);
        }
        int topLeftX = (*bptr).col;
        int topLeftY = (*bptr).row;

        int reachedHoneycomb = 0;

        // top right // top left // bottom right // bottom left anywhere inside honeycomb
        if (topLeftX + 30 >= honeycombCol && topLeftX + 30 <= honeycombCol + 30 && topLeftY >= honeycombRow && topLeftY <= honeycombRow + 30) {
          reachedHoneycomb = 1;
        } else if (topLeftX + 30 >= honeycombCol && topLeftX + 30 <= honeycombCol + 30 && topLeftY + 30 >= honeycombRow && topLeftY + 30 <= honeycombRow + 30) {
          reachedHoneycomb = 1;
        } else if (topLeftX >= honeycombCol && topLeftX <= honeycombCol + 30 && topLeftY >= honeycombRow && topLeftY <= honeycombRow + 30) {
          reachedHoneycomb = 1;
        } else if (topLeftX >= honeycombCol && topLeftX <= honeycombCol + 30 && topLeftY + 30 >= honeycombRow && topLeftY + 30 <= honeycombRow + 30) {
          reachedHoneycomb = 1;
        }
        if (timer == 600) {
          state = LOSE_BG;
        }

        if (reachedHoneycomb) {
          fillScreenDMA(BLACK);
          drawImageDMA((*bptr).row, (*bptr).col, 30, 30, bee);
          state = WIN_BG;
        }

        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = RESTART;
        }

        timer++;
        break;
      case WIN_BG:
        waitForVBlank();
        drawFullScreenImageDMA(end);
        state = WIN_TEXT;
        break;
      case WIN_TEXT:
        waitForVBlank();
        drawString(60, 65, "YOU WIN", BLACK);
        sprintf(buffer, "TIME TAKEN: %d", timer / 60);
        drawString(5, 140, buffer, BLACK);

        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = RESTART;
        }
        break;
      case LOSE_BG:
        fillScreenDMA(CYAN);
        
        state = LOSE_TEXT;
        break;
      case LOSE_TEXT:
        drawString(60, 65, "YOU LOSE", BLACK);
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = RESTART;
        }
        break;
      case RESTART:
        state = START;
        break;
    }
    waitForVBlank();
    previousButtons = currentButtons; // Store the current state of the buttons
  }

  UNUSED(previousButtons); // You can remove this once previousButtons is used

  return 0;
}

void moveBee(Bee *b, int row, int col) {
  drawRectDMA((*b).row, (*b).col, 30, 30, BLACK);
  // fillScreenDMA(BLACK);
  if ((((*b).row + row) >= 0) && ((*b).row + row) <= (HEIGHT - 30)) {
    (*b).row += row;
  }
  if ((((*b).col + col) >= 0) && ((*b).col + col) <= (WIDTH - 30)) {
    (*b).col += col;
  }
  drawImageDMA((*b).row, (*b).col, 30, 30, bee);
}
