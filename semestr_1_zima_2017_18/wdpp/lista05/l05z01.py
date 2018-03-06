#!/usr/bin/env python3.6

import math


def collatz(n):
    if n % 2 == 0:
        return int(n / 2)
    else:
        return 3 * n + 1


def energia(n):
    pos = 0
    while True:
        if n == 1:
            return pos
        n = collatz(n)
        pos += 1


def analizaCollatza(a, b):
    energie = sorted([energia(x) for x in range(a, b+1)])
    srednia = sum(energie) / len(energie)
    if len(energie) % 2 == 0:
        mediana = energie[int(len(energie) / 2)]
    else:
        left = energie[int(math.floor(len(energie) / 2))]
        right = energie[int(math.ceil(len(energie) / 2))]
        mediana = (left + right) / 2
    mini = min(energie)
    maks = max(energie)
    print(f'srednia: {srednia}')
    print(f'mediana: {mediana}')
    print(f'minimalna: {mini}')
    print(f'maksymalna: {maks}')


if __name__ == '__main__':
    analizaCollatza(2, 10000)
