#!/usr/bin/env python3.6

import itertools


def punkt_a(lista, ile, wynik):
    """
    Schodzi w dół do momentu dojścia do zbioru pustego, po drodze dodając do
    wyniku sumę wszystkich podzbiorów o długości równej ile.
    """
    if ile == 0:
        wynik.add(0)
        return wynik
    doklejka = [
        sum(podzbior) for podzbior in itertools.combinations(lista, ile)
    ]
    wynik = wynik.union(set(doklejka))
    return punkt_a(lista, ile - 1, wynik)


def punkt_b(od, do, ile):
    # rekurencja czy jej brak?
    return [x for x in itertools.combinations_with_replacement(range(od, do), ile) if czy_niemalejacy(x)]


def czy_niemalejacy(ciag):
    schowek = ciag[0]
    for el in ciag:
        if el < schowek:
            return False
        schowek = el
    return True


if __name__ == '__main__':
    print(punkt_a([1, 2, 3, 100], 4, set()))
    print(punkt_b(0, 5, 2))
    print(punkt_b(1, 5, 3))
    print(punkt_b(1, 5, 10))
