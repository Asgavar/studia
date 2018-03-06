#!/usr/bin/env python3.6

import math
import turtle

zolwik = turtle.Turtle()
zolwik.speed('fastest')
colors = ['#9C27B0', '#F44336', '#00BCD4']


def draw_circle(radius, col_number):
    color = colors[col_number % 3]
    angle = 0
    zolwik.fillcolor(color)
    zolwik.penup()
    zolwik.setx(radius * math.cos(0))
    zolwik.sety(radius * math.sin(0))
    zolwik.pendown()
    zolwik.begin_fill()
    while angle != 360:
        angle_rad = math.radians(angle)
        x = radius * math.cos(angle_rad)
        y = radius * math.sin(angle_rad)
        zolwik.setx(x)
        zolwik.sety(y)
        angle += 1
    zolwik.end_fill()


if __name__ == '__main__':
    START_RADIUS = 300
    for i in range(15):
        draw_circle(START_RADIUS - 20*i, i)
    input()
