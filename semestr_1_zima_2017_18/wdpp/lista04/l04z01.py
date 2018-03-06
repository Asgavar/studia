import turtle


def square(n, color):
    turtle.fillcolor(color)
    turtle.begin_fill()
    for i in range(4):
        turtle.forward(n)
        turtle.right(90)
    turtle.end_fill()
    turtle.forward(n)  # ulatwia laczenie kwadratow


def square_count(highest_length):
    "Zwraca liczbe kwadratow, z ktorych bedzie sie skladac spirala."
    ret = 2
    current = 2
    # przy kazdym przejsciu jeden kwadrat jest 'nadpisywany'
    while current <= highest_length + 1:
        ret += current
        current += 1
    return ret


def mix(a, color1, color2):
    """
    Przejscie miedzy color1 a color2.
    0<= a <=1
    """
    r1, g1, b1 = color1
    r2, g2, b2 = color2
    return (
        int(a * r2 + (1-a) * r1),
        int(a * g2 + (1-a) * g1),
        int(a * b2 + (1-a) * b1)
    )


if __name__ == '__main__':
    SQUARE_SIDE = 25
    col_from = (255, 255, 0)  # zolty
    col_to = (228, 0, 224)  # fioletowy
    step = 1 / square_count(18)
    turtle.colormode(255)  # inaczej zwraca blad 'bad color sequence'
    turtle.speed('fastest')
    col = 0
    curr_length = 2
    while curr_length <= 19:
        for x in range(curr_length):
            col += step
            square(SQUARE_SIDE, mix(col, col_from, col_to))
        turtle.right(90)
        curr_length += 1
    input()
