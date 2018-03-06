#!/usr/bin/env python3

def silnia(n):
    ret = 1
    for i in range(1, n+1):  # domyslnie iteruje od 0
        ret *= i
    return ret

def cyfryzuj(n):
    # FIXME: corner case ze 112/113/114
    if n == 1:
        return "cyfrę"
    elif 2 <= n <= 4:
        return "cyfry"
    elif 5 <= n <= 21:
        return "cyfr"
    elif n in (112, 113, 114):
        return "cyfr"
    else:
        return "cyfry" if str(n)[-1] in ('2', '3', '4') else "cyfr"

for i in range(4, 101):
    # alternatywnie moznaby obliczyc logarytm przy podst. 10 zaokraglony w dol + 1
    dlugosc = len(str(silnia(i)))
    print("{0}! ma {1} {2}".format(i, dlugosc, cyfryzuj(dlugosc)))
