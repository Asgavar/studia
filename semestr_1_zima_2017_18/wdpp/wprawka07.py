#!/usr/bin/env python3.6

def wariant_1(lista, k):
    lista = sorted(set(lista), reverse=True)
    return lista[k-1]  # indeksowanie od 0


def wariant_2(lista, k):
    lista = list(set(lista))
    while len(lista) > k:
        lista = tylko_wieksze(lista)
    return min(lista)


def tylko_wieksze(lista):
    p = (len(lista)-1) // 2
    srodkowy = lista[p]
    wieksze = []
    for x in range(len(lista)):
        if lista[x] > srodkowy:
            wieksze.append(lista[x])
    return wieksze


if __name__ == '__main__':
    testowa1 = [9,  124, 6, -124412, 56034, 1, 124, 123, 124,  -9]
    testowa2 = [x for x in range(100_000)]
    print(wariant_1(testowa1, 3))
    print(wariant_1(testowa2, 3))
    print(wariant_2(testowa1, 3))
    print(wariant_2(testowa2, 3))
