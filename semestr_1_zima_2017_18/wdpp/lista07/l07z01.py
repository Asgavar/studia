import random
import turtle

import duze_cyfry

bozydar = turtle.Turtle()

COLORS = {
    -1: 'white',
    0: 'red',
    1: 'green',
    2: 'blue',
    3: 'yellow',
    4: 'black',
    5: 'orange'
}

PIXEL_SIZE = 25

pixel_placement = [  # zakladamy ekran 1000 na 1000 pikseli
    [-1 for x in range(1_000)] for y in range(1_000)  # -1 oznacza kolor bialy
]

# def map_coordinate(x_or_y):
    # return 500 - x_or_y

# przyjmujemy, ze istnieja tylko 4 mozliwe katy ruchu
def registered_forward(animal, color, dist):
    x = int(bozydar.pos()[0])
    y = int(bozydar.pos()[1])
    angle = bozydar.heading()
    for i in range(dist//PIXEL_SIZE):
        if angle == 0.0:
            pixel_placement[x+i][y] = color
            animal.forward(PIXEL_SIZE)
        elif angle == 90.0:
            pixel_placement[x][y+i] = color
            animal.forward(PIXEL_SIZE)
        elif angle == 180.0:
            pixel_placement[x-i][y] = color
            animal.forward(PIXEL_SIZE)
        elif angle == 270.0:
            pixel_placement[x][y-i] = color
            animal.forward(PIXEL_SIZE)


def draw_square(color):
    bozydar.fillcolor(COLORS[color])
    bozydar.begin_fill()
    for i in range(4):
        registered_forward(bozydar, color, PIXEL_SIZE)
        bozydar.left(90)
    bozydar.end_fill()
    registered_forward(bozydar, color, 25)


def draw_digit(d):
    pattern = duze_cyfry.dajCyfre(int(d))
    digit_color = random.randint(0, 5)
    while is_colliding(d, digit_color, int(bozydar.pos()[0]), int(bozydar.pos()[1])):
        digit_color = random.randint(0, 5)
    line_no = 0
    for line in pattern:
        line_no += 1
        for sq in line:
            if sq == '#':
                draw_square(digit_color)
            elif sq == ' ':
                draw_square(-1)  # puste pole
        bozydar.back(25*len(line))
        bozydar.right(90)
        if line_no != len(pattern):
            registered_forward(bozydar, digit_color, PIXEL_SIZE)
        bozydar.left(90)
    bozydar.penup()
    bozydar.forward(5*25)
    bozydar.left(90)
    bozydar.forward(4*25)
    bozydar.right(90)
    bozydar.pendown()


def is_colliding(digit, color, start_x, start_y):
    pattern = duze_cyfry.dajCyfre(int(digit))
    x = start_x
    y = start_y
    for line in pattern:
        for pixel in line:
            if pixel_placement[x][y] == color:
                return True
            x += 1
        x = start_x
        y += 1
    return False


if __name__ == '__main__':
    bozydar._tracer(1, 0)
    for i in range(20):
        bozydar.penup()
        bozydar.goto(random.randrange(500), random.randrange(500))
        digit_to_draw = random.randint(0, 9)
        draw_digit(digit_to_draw)
    input()
