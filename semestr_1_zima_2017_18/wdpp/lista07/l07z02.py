#!/usr/bin/env python3.6

import turtle

START_X = -500
START_Y = 450
PIXEL_SIZE = 15
turtle.tracer(0, 1)
turtle.colormode(255)
turtle.penup()
turtle.setpos(x=START_X, y=START_Y)
turtle.pendown()
turtle.speed('fastest')
rgb_pattern = r'\((\d*),(\d*),(\d*)\)'


def draw_pixel(rgb):
    turtle.fillcolor(rgb)
    turtle.begin_fill()
    for x in range(4):
        turtle.forward(PIXEL_SIZE)
        turtle.right(90)
    turtle.end_fill()


def move_to_next_pixel():
    turtle.forward(PIXEL_SIZE)


def move_to_next_line():
    current_y = turtle.position()[1]
    turtle.sety(current_y - PIXEL_SIZE)
    turtle.setx(START_X)


if __name__ == '__main__':
    infilepath = 'l07z02.in'
    pixels = []  # lista list z krotkami
    with open(infilepath) as infile:
        for line in infile.readlines():
            to_append = []  # docelowo lista krotek w formacie (r,g,b)
            for pixel in line.split():
                pixel = pixel.split(',')
                to_append.append((int(pixel[0][1:]), int(pixel[1]), int(pixel[2][:-1])))  # noqa: E501
            pixels.append(to_append)
    for line in pixels:
        for pixel in line:
            draw_pixel(pixel)
            move_to_next_pixel()
        move_to_next_line()
    input()
