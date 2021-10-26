// file name: helloworld.c
#include <stdio.h>

int main(int argc, char *argv[]) {
	printf("Hello, World!\n\n");
	
	for (int i = 0; i < argc; i++) {
		printf("Argument %d: '%s'\n", i, argv[i]);
	}
	printf("You have %d arguments.\n", argc);
}