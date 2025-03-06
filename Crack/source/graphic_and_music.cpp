#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <stdio.h>

#include "crack_file.h"

Errors graphic_image_and_music(const char *image_path, const char *music_path)
{
    sf::RenderWindow window(sf::VideoMode({1024, 1024}), "SFML works!");
    sf::Texture texture;
    if (!texture.loadFromFile(image_path))
    {
        return ERROR_OF_LOADING_IMAGE;
    }

    sf::Music music;

    if (!music.openFromFile(music_path))
    {
        return ERROR_OF_LOADING_MUSIC;
    }

    sf::Sprite sprite(texture);



    music.setLooping(true);
    music.play();

    while (window.isOpen())
    {
        while (const std::optional event = window.pollEvent())
        {
            if (event->is<sf::Event::Closed>())
            {
                window.close();
            }
        }

        window.clear();
        window.draw(sprite);
        window.display();
    }

    return NO_ERRORS;
}
