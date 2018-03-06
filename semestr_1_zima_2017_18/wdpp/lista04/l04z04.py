#!/usr/bin/env python3

import random


def randperm(n):
    obsadzenia = {}
    ret = [i for i in range(n)]
    for x in range(n):
        pozycja = random.randint(0, n-1)
        while pozycja in obsadzenia:
            pozycja = random.randint(0, n-1)
        obsadzenia[pozycja] = x
    # print(obsadzenia)
    for k, v in obsadzenia.items():  # pozycja to klucz, wartosc to... wartosc
        ret[k] = v
    return ret


if __name__ == '__main__':
    # x = randperm(10 ** 6)
    for x in range(10):
        print(randperm(10))
