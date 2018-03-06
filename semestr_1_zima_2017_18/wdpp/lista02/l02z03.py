# Program zaklada, ze n jest nieparzyste

import math

def kolko(offset, n):
    srodek = n // 2  # (x,y) srodka i promien w jednym
    punkty = []
    for x in range(n):
        sublista = []
        for y in range(n):
            if math.floor(math.sqrt((srodek-x)**2 + (srodek-y)**2)) <= srodek:
                sublista.append('#')
            else:
                sublista.append(' ')
        punkty.append(sublista)
    for x in range(n):
        print(' ' * offset, end='')
        for y in range(n):
            print(punkty[x][y], end='')
        print()

kolko(9, 13)
kolko(6, 19)
kolko(0, 31)
