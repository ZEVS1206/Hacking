#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "crack_file.h"

static size_t get_size_of_file(FILE *file_pointer);


int main(int argc, char *argv[])
{
    Errors error = NO_ERRORS;
    if (argc != 2)
    {
        error = ERROR_OF_INPUT;
        fprintf(stderr, "Error: %d\n", error);
        return 1;
    }
    char file_name[100] = "";
    memcpy(file_name, argv[1], strlen(*argv));
    printf("file_name: %s\n", file_name);
    FILE *file_pointer = fopen(file_name, "rb+");
    if (file_pointer == NULL)
    {
        error = ERROR_OF_INPUT;
        fprintf(stderr, "Error: %d\n", error);
        return 1;
    }
    error = crack_com_file(file_pointer);
    fclose(file_pointer);
    if (error != NO_ERRORS)
    {
        fprintf(stderr, "Error: %d\n", error);
        return 1;
    }


    error = graphic_image_and_music("../source/image.png", "../source/music.mp3");
    if (error != NO_ERRORS)
    {
        fprintf(stderr, "Error: %d\n", error);
        return 1;
    }

    printf("Crack Ended!\n");
    return 0;
}

static size_t get_size_of_file(FILE *file_pointer)
{
    fseek(file_pointer, 0L, SEEK_END);
    size_t size_of_file = (size_t)ftell(file_pointer);
    fseek(file_pointer, 0L, SEEK_SET);
    return size_of_file;
}


Errors crack_com_file(FILE *file_pointer)
{
    if (file_pointer == NULL)
    {
        return ERROR_OF_INPUT;
    }
    size_t size_of_file = get_size_of_file(file_pointer);
    char *buffer = (char *) calloc (size_of_file, sizeof(char));
    size_t result_of_reading = fread(buffer, sizeof(char), size_of_file, file_pointer);
    if (result_of_reading != size_of_file)
    {
        return ERROR_OF_INPUT;
    }
    size_t index = 0;
    for (index = 0; index < size_of_file; index++)
    {
        if (buffer[index] == 51) //33 - ascii code of '!'
        {
            buffer[index] = 116; // 96 - ascii code of '`'
            buffer[index + 1] = 41;
            break;
        }
    }
    fseek(file_pointer, 0, SEEK_SET);
    size_t result_of_writing = fwrite(buffer, sizeof(char), size_of_file, file_pointer);
    if (result_of_writing != size_of_file)
    {
        return ERROR_OF_CRACK;
    }
    return NO_ERRORS;
}




