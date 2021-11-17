/**
 * @file main.c
 * @author Austin Peng
 * @brief testing and debugging functions written in my_string.c and hw7.c
 * @date 2021-11-17
 */

// You may add and remove includes as necessary to help facilitate your testing
#include <stdio.h>
// #include "hw7.h"
#include <string.h>
#include "my_string.h"
#include <stddef.h>

#define FOO(x) -1*(x)

char *my_strcat(char *dest, const char *src);
char *my_strncat(char *dest, const char *src, size_t n);
void functa(int a, int *b, int *c);
void replaceCharWithString(char *originalString, char charToReplace, char *stringReplace, char *result);

/** main
 *
 * @brief used for testing and debugging functions written in my_string.c and hw7.c
 *
 * @param void
 * @return 0 on success
 */
int main(void)
{
  // printf("%d\n", FOO(5));
  //   return 0;


  // char src[] = "efghijkl";
  // char dest[20] = "abcd";
  // my_strcat(dest, src);
  // printf("strcat concatenated string: %s\n\n", dest);

  // // dest[0] = 'a';
  // // dest[1] = 'b';
  // // dest[2] = 'c';
  // // dest[3] = 'd';
  // dest[4] = '\0';
  // printf("reset string: %s\n\n", dest);

  // my_strncat(dest, src, 3);
  // printf("strncat 5 concatenated string: %s\n\n", dest);
//   int *x = getNthElement(6);
//   printf("%d\n", *x);
//   return 0;

  char result[50] = "";
  // char originalString[50] = "hi";
  // char charToReplace = 'i';
  // char *stringReplace = "ello";

  // replaceCharWithString(originalString, charToReplace, stringReplace, result);
  replaceCharWithString("beautiful", 'u', "uwu", result);

  // int a = 12;
  // int b = 9;
  // int c = 36;
  // functa(a, &b, &c);
  // printf("a: %d\n", a);
  // printf("b: %d\n", b);
  // printf("c: %d\n", c);
}

void replaceCharWithString(char *originalString, char charToReplace, char *stringReplace, char *result) {
    int ogCount = 0;
    int resultCount = 0;
    int stringReplaceCount = 0;
    while (originalString[ogCount] != '\0') {
        if (originalString[ogCount] == charToReplace) {
          while (stringReplace[stringReplaceCount] != '\0') {
            result[resultCount] = stringReplace[stringReplaceCount];
            resultCount++;
            stringReplaceCount++;
          }
          stringReplaceCount = 0;
        } else {
          result[resultCount] = originalString[ogCount];
          resultCount++;
        }
        ogCount++;
    }
    printf("%s\n", result);
}

void functa(int a, int *b, int *c) {
  a++;
  c = b;
  *b = a + 7;
  printf("asdfas: %d\n", *b);
  (*c)++;
}



char *my_strcat(char *dest, const char *src) {
  int i = 0;
  int j = 0;
  while (dest[i] != '\0') {
    i++;
  }

  while (src[j] != '\0') {
    dest[i + j] = src[j];
    j++;
  }
  dest[i + j] = '\0';

  return dest;
}

char *my_strncat(char *dest, const char *src, size_t n) {
  int i = 0;
  int j = 0;
  while (dest[i] != '\0') {
    i++;
  }

  while (src[j] != '\0' && j < n) {
    dest[i + j] = src[j];
    j++;
  }
  dest[i + j] = '\0';

  return dest;
}