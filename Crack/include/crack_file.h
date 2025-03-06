#ifndef CRACK_FILE_H
#define CRACK_FILE_H

enum Errors
{
    NO_ERRORS              = 0,
    ERROR_OF_INPUT         = 1,
    ERROR_OF_CRACK         = 2,
    ERROR_OF_LOADING_IMAGE = 3,
    ERROR_OF_LOADING_MUSIC = 4
};

Errors crack_com_file(FILE *file_pointer);
Errors graphic_image_and_music(const char *image_path, const char *music_path);

#endif
