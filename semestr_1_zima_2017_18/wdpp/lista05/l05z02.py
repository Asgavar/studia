#!/usr/bin/env python3.6

import random
import turtle


def draw_bar(height):
    turtle.left(90)
    turtle.forward(height)
    turtle.right(90)
    turtle.forward(25)
    turtle.right(90)
    turtle.forward(height)
    turtle.right(90)
    turtle.forward(25)
    turtle.backward(25)
    turtle.left(180)


if __name__ == '__main__':
    BAR_NUMBER = 35
    turtle.speed('fastest')
    turtle.penup()
    turtle.backward(700)
    turtle.pendown()
    for x in range(BAR_NUMBER):
        h = random.randrange(500)
        draw_bar(h)
        turtle.penup()
        turtle.forward(15)
        turtle.pendown()
    input()
