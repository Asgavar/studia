#!/usr/bin/env python3.6
# -*- coding: utf-8 -*-

from turtle import *

def draw_star():
    for i in range(10):
        forward(50)
        back(50)
        right(36)

if __name__ == '__main__':
    speed('fastest')
    for i in range(10):
        forward(200)
        draw_star()
        back(200)
        right(36)
    input()
