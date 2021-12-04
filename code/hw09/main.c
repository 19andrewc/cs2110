#include "list.h"
#include "list.c"

#include <stdio.h>

int main(void) {
    char *someName = "Austin";
    union user_data someData;
    someData.instructor.salary = 20000;

    struct user someUser = create_user(someName, INSTRUCTOR, someData);

    printf()
}
