/**
 * @file tl04.c
 * @author Austin Peng
 * @brief Command-line argument & string parsing logic
 * @date 2021-12-01
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <string.h>
#include <stdio.h>
#include "tl04.h"

/*

The following macros and struct are defined in tl04.h. You will need to use these:

#define FAILURE 1
#define SUCCESS 0

struct ascii_image {
    int width;      // The number of columns in the ASCII image. Must be at least 1.
    int height;     // The number of rows in the ASCII image. Must be at least 1.
    char *name;     // The name of the ASCII image. This must be non-null, and must point to a deep copy that was allocated specifically for this struct.
    char *data;     // The image's data, which is a non-null, 1-dimensional char array of size width*height. Note: despite being a char*, this is not a string.
};

*/

/** @brief A debug function that prints an image's data.
 * 
 * This function is already provided for you. You can use this function to help debug your code.
 * @param image The image to display.
 */
void print_image(struct ascii_image *image)
{
    printf("Image name: %s\n", image->name);
    for (int i = 0; i < image->height * image->width; i++)
    {
        printf("%c", image->data[i]);
        if (i % image->width == image->width - 1)
            printf("\n");
    }
}

/**
 * @brief This function uses the provided height, width, and name, to make a new image with 
 * these parameters and fills the already allocated ascii_image's data with "." characters.
 *
 * The provided height and width must be at least 1, and the provided name must be non-NULL. 
 * If any of these conditions are not met, the function returns NULL without allocating anything.
 * Otherwise, it creates and returns a new struct ascii_image.
 * 
 * This function is provided for you. You can use it to help debug your code.
 *
 * @param height The height of the image. This is stored in the created ascii_image struct. 
 * @param width The width of the image. This is stored in the created ascii_image struct.
 * @param name The name of the image. Function creates a deep copy of the name for the new image.
 * @return Returns NULL if the height or width is less than 1, if the name is NULL, or if there was a malloc failure. Returns a valid ascii_image pointer otherwise.
 */
struct ascii_image *create_image(int height, int width, char *name)
{
    if (height < 1 || width < 1 || name == NULL)
        return NULL;
    struct ascii_image *image = malloc(sizeof(struct ascii_image));
    if (!image)
        return NULL;
    char *copy = malloc(strlen(name) + 1);
    if (!copy)
    {
        free(image);
        return NULL;
    }
    char *data = malloc(height * width);
    if (!data)
    {
        free(image);
        free(copy);
        return NULL;
    }
    image->height = height;
    image->width = width;
    strcpy(copy, name);
    image->name = copy;
    image->data = data;
    for (int i = 0; i < height * width; i++)
        image->data[i] = '.';
    return image;
}

/**
* @brief Determines whether or not a character is printable.
* A printable character is defined as one whose ASCII value is within [32, 126].
*
* @param image The character to check
* @return 0 (false) if the character is non-printable, a nonzero value (true) otherwise.
*/
int is_printable(char c)
{
    if (c < 32 || c > 126) {
        return 0;
    }
    return 1;
}

/**
 * @brief Write a character to an image using row and column coordinates.
 * 
 * If image is NULL or image->data is NULL or row is not within [0, image->height - 1], or column is not within [0, image->width - 1], then return FAILURE. 
 * Otherwise, write the character c to the requested coordinates in image->data, and return SUCCESS.
 * Since image->data is a 1D array that represents a 2D image, you should use a calculation similar to the OFFSET macro from Homework 8.
 *
 * Examples:
 *
 * Assume that 'img' is a pointer to a struct ascii_image with width=3, height=3, and its data looks like this:
 * 
 *      OOO
 *      OOO
 *      OOO
 * 
 * After calling set_character(img, 2, 1, 'C'), SUCCESS will be returned and the image will look like this:
 * 
 *      OOO
 *      OOO
 *      OCO
 * 
 * Then, after calling set_character(img, 1, 0, 'A'), SUCCESS will again be returned and the image will look like this:
 * 
 *      OOO
 *      AOO
 *      OCO
 * 
 * Calling set_character(img, 0, 3, 'B') or set_character(img, 4, 2, 'D') will return FAILURE and not modify the image at all.
 * set_character(NULL, 0, 0, 'X') will also return FAILURE. set_character(img, 0, 0, 'X') will return FAILURE if img->data is NULL.
 *
 * @param image A struct ascii_image that should be modified. See tl04.h for the definition of this struct.
 * @param row The row where the character will be drawn. Must be in [0, image->height - 1].
 * @param col The column where the character will be drawn. Must be in [0, image->width - 1].
 * @param c The character that will be drawn to the image. 
 * @return returns FAILURE if image is NULL or image->data is NULL, or if row or col is out-of-bounds, or if character is not printable; returns SUCCESS otherwise
 */
int set_character(struct ascii_image *image, int row, int col, char c)
{
    if (image == NULL) {
        return FAILURE;
    }

    if (image -> data == NULL) {
        return FAILURE;
    }

    if (row < 0 || row > image -> height - 1) {
        return FAILURE;
    }
    if (col < 0 || col > image -> width - 1) {
        return FAILURE;
    }

    if (!is_printable(c)) {
        return FAILURE;
    }

    int offset = row * (image -> width) + col;
    (image -> data)[offset] = c;


    // These are just to turn off compiler errors initially
    // Please delete once you have implemented the function
    // UNUSED_PARAM(image);
    // UNUSED_PARAM(row);
    // UNUSED_PARAM(col);
    // UNUSED_PARAM(c);
    return SUCCESS;

    //Implement checks for failure cases as detailed in the method description

    //Set the char in the image's data with the given row and col
}

/**
* @brief Draw a diagonal line between two specified points to the image inclusive of the given points. 
* If the provided image is NULL return FAILURE. (You may assume that if image is not NULL, then image->data is also not NULL.)
* Otherwise, use the two row/column pairs to draw a line between them. If any of the coordinates are less than 0, return FAILURE. 
* If the distance between the two points does not have equal height or width, then return FAILURE. If any pixel of the line is out-of-bounds, 
* simply do not draw it. You must not draw anything out-of-bounds. For this reason, it is HIGHLY RECOMMENDED to use set_character, 
* which refuses to draw anything if the provided coordinates are out-of-bounds. Also, draw_diagonal_line() should still return SUCCESS 
* even if some or all of the line is out-of-bounds or if the two given points are the same. 
* 
* Note: Your code should be able to work for any 2 valid points.
* (Meaning it can draw in any direction as long as the change in row and change in col are equal.) 
*
* Examples:
 * 
 * Assume that 'img' is a pointer to a struct ascii_image with width=7, height=5, and its data looks like this:
 * 
 *      .......
 *      .......
 *      .......
 *      .......
 *      .......
 * 
 * After calling draw_diagonal_line(img, 0, 0, 2, 2, 'X'), SUCCESS will be returned and the image will look like this:
 * 
 *      X......
 *      .X.....
 *      ..X....
 *      .......
 *      .......
 *      
 * Then, after calling draw_diagonal_line(img, 0, 0, 0, 0, 'B') and draw_diagonal_line(img, 3, 2, 1, 0, 'A'), the image looks like this:
 * 
 *      B......
 *      AX.....
 *      .AX....
 *      ..A....
 *      .......
 * @param image A struct ascii_image that should be modified. See tl04.h for the definition of this struct.
 * @param row1 The starting row of the line
 * @param col1 The starting col of the line
 * @param row2 The row of the endpoint of the line
 * @param col2 The col of the endpoint of the line
 * @param c The character to use when drawing the line.
 * @return Returns FAILURE if the image is NULL or image->data is NULL, or if any coordinate point is less than 0, or if the points do not make a straight line, or character is not printable. Otherwise, returns SUCCESS.
*/
int draw_diagonal_line(struct ascii_image *image, int row1, int col1, int row2, int col2, char c)
{
    if (image == NULL) {
        return FAILURE;
    }

    if (image -> data == NULL) {
        return FAILURE;
    }

    if (row1 < 0 || col1 < 0 || row2 < 0 || col2 < 0) {
        return FAILURE;
    }

    // posOrNegSlope = 0 means positive row slope
    // posOrNegSlope = 1 means negative row slope
    // int posOrNegSlope = 0;
   
    int posOrNegRow = 0;
    if (row2 - row1 < 0) {
        posOrNegRow = 1;
    }

    int posOrNegCol = 0;
    if (col2 - col1 < 0) {
        posOrNegCol = 1;
    }

    if ((abs(row2 - row1) - abs(col2 - col1)) != 0) {
        return FAILURE;
    }

    if (!is_printable(c)) {
        return FAILURE;
    }

    for (int i = 0; i <= abs(row2 - row1); i++) {
        if (posOrNegRow == 0 && posOrNegCol == 0) {
            set_character(image, row1 + i, col1 + i, c);
        } else if (posOrNegRow == 1 && posOrNegCol == 1) {
            set_character(image, row1 - i, col1 - i, c);
        } else if (posOrNegRow == 0 && posOrNegCol == 1) {
            set_character(image, row1 + i, col1 - i, c);
        } else if (posOrNegRow == 1 && posOrNegCol == 0) {
            set_character(image, row1 - i, col1 + i, c);
        }
    }


    // TODO: IMPLEMENT THIS FUNCTION! SEE .pdf FOR DETAILS

    // These are just to turn off compiler errors initially
    // Please delete once you have implemented the function
    // UNUSED_PARAM(image);
    // UNUSED_PARAM(row1);
    // UNUSED_PARAM(row2);
    // UNUSED_PARAM(col1);
    // UNUSED_PARAM(col2);
    // UNUSED_PARAM(c);

    /**Implement checks for failure cases as detailed in the method description**/

    /**Check to see if the change in row is equal to the change in col, else return FAILURE**/

    /**There will be four cases here, the first row can be less than the second row or the first second row can be the less than the first
     * and for each of the cases, there are two cases where the first col is greater than or less than the second. Think about how you would 
     * implement the drawing of these cases individually and implement them using set_character()
     * 
     * Hint: Remember to consider the case where both the change in col and row are equal to 0
    */

    return SUCCESS;
}

/**
 * @brief Using the provided image pointer, completely deallocate the data used by the ascii_image.
 * 
 * You must deallocate not only the ascii_image struct itself, but also the ascii_image's deep-copied name and its image data array.
 * Note that it is possible for image to be NULL, as well as image->name and image->data (assuming image is not NULL).
 * You should not need to handle these cases too differently, since free(NULL) is a harmless operation.
 * However, you MUST avoid using image->data or image->name if image is NULL, as this will cause a segfault.
 * You do not need to return anything. After calling destroy_image, the data that image points to must be deallocated, as well as the data that image->name and image->data previously pointed to.
 * 
 * @param image The image to be destroyed.
 */
void destroy_image(struct ascii_image *image)
{
    if (image == NULL) {
        return;
    }
    free(image -> data);
    free(image -> name);
    free(image);
    // UNUSED_PARAM(image);
}

/**
 * @brief Replaces the extension at the end of the name of the provided ascii_image.
 * 
 * If image is NULL, extension is NULL, or if there is a malloc/realloc failure, return FAILURE. image->name MUST remain unmodified. (You can assume that image->name is not NULL, as long as image is not NULL.)
 * Otherwise, modify image->name so that it points to an allocation with the original image name, with the extension replaced, and return SUCCESS.
 * There must be NO MEMORY LEAKS. If you allocate new space for the new name, make sure to deallocate the name's old space once you're done using it.
 * 
 * It is required to either use malloc, calloc, or realloc when implementing this function.
 * If you use realloc, make sure you remember how it works (remember that if successful, it copies the old allocation's data and frees it, and that if realloc fails, it does NOT free the old allocation).
 * You may use ANY of the functions from string.h in your code. Some of these functions will be extremely useful!
 
 * Examples:
 * 
 * Assume that 'img' is a pointer to a struct ascii_image, and assume that its name is the following string allocated on the heap: {'a', 'r', 't', '.', 'p', 'n', 'g', '\0'}, AKA "art.png".
 * After calling replace_extension(img, ".jpeg"), replace_extension should return SUCCESS (assuming no mallocs fail).
 * Additionally, img->name should point to a new or reduced allocation with the following string: {'a', 'r', 't', '.', 'j', 'p', 'e', 'g', '\0'}, AKA "art.jpeg".
 * Note that you should be replacing the LAST extension. Calling replace_extension(img, "") if img->name is "art.png.tar.gz", 
 * you should then turn the image's name into "art.png.tar". The last extension is the one after the last '.' character (again, in the above example it is '.gz').
 * 
 * @param image The image whose extension should be replaced.
 * @param extension The new extension to put into the image name. If replace_extension is successful, image->name should have the extension replaced.
 * @return Returns FAILURE if image is NULL, extension is NULL, or if there was a malloc/realloc failure. Otherwise, the image's extension is replaced and this function returns SUCCESS.
 */
int replace_extension(struct ascii_image *image, char *extension)
{
    if (image == NULL) {
        return FAILURE;
    }

    if (extension == NULL) {
        return FAILURE;
    }

    char *tempName = image -> name;

    int lenName = strlen(image -> name);
    int lenExtension = strlen(extension);

    if (((image -> name) = realloc(image -> name, lenName + lenExtension)) == NULL) {
        image -> name = tempName;
        return FAILURE;
    }

    for (int i = lenName - 1; i >= 0; i--) {
        if ((image -> name)[i] == '.') {
            strcpy(&(image -> name)[i], extension);
            return SUCCESS;
        }
    }


    // UNUSED_PARAM(image);
    // UNUSED_PARAM(extension);
    return SUCCESS;
}
