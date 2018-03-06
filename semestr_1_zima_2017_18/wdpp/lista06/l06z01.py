import duze_cyfry
import random
import sys
import turtle

bozydar = turtle.Turtle()
bozydar.speed('fastest')
bozydar.penup()
turtle.colormode(255)

def randomcolor():
    r = random.randint(0, 255)
    g = random.randint(0, 255)
    b = random.randint(0, 255)
    return (r, g, b)


def draw_square(color):
    bozydar.fillcolor(color)
    bozydar.begin_fill()
    for i in range(4):
        bozydar.forward(25)
        bozydar.left(90)
    bozydar.end_fill()
    bozydar.forward(25)


def draw_digit(d):
    pattern = duze_cyfry.dajCyfre(int(d))
    digit_color = randomcolor()
    line_no = 0
    for line in pattern:
        line_no += 1
        for sq in line:
            if sq == '#':
                draw_square(digit_color)
            elif sq == ' ':
                draw_square((255, 255, 255))
        bozydar.back(25*len(line))
        bozydar.right(90)
        if line_no != len(pattern):
            bozydar.forward(25)
        bozydar.left(90)
    bozydar.penup()
    bozydar.forward(5*25)
    bozydar.left(90)
    bozydar.forward(4*25)
    bozydar.right(90)
    bozydar.pendown()


if __name__ == '__main__':
    try:
        number = sys.argv[1]
    except:
        number = '1234567890'
    bozydar.goto(-400, 0)
    bozydar.pendown()
    for digit in number:
        draw_digit(digit)
    input()
