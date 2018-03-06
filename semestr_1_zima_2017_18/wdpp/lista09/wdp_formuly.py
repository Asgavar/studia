#!/usr/bin/env python3.6

"""
Mimo, że program uważa True i False za zmienne, eval zinterpretuje
je jako stałe, więc w zasadzie stałych można było używać od początku.
"""

def ciagi_binarne(N):
    if N == 0:
      return [ [] ]
    return [ [b] + c for b in [True, False] for c in ciagi_binarne(N-1)]


def wartosciowania(zmienne):
    cb = ciagi_binarne(len(zmienne))
    # print(zmienne)
    zwrot = [dict(zip(zmienne, ciag)) for ciag in cb]
    print(zwrot)
    return zwrot


def wartosc_formuly(F, wart):
    F = F.replace('*', ' and ')
    F = F.replace('+', ' or ')
    F = F.replace('-', ' not ')
    return eval(F, wart)


def wydobadz_zmienne(z_formuly):
    zmienne = z_formuly
    do_wyciecia = '+*()-'
    for rzecz in do_wyciecia:
        zmienne = zmienne.replace(rzecz, '')
    zmienne = zmienne.split()
    zmienne = set(zmienne)
    return zmienne

def spelnialna(F):
    zmienne = wydobadz_zmienne(F)
    for wart in wartosciowania(zmienne):
      if wartosc_formuly(F, wart) == True:
        return True
    return False

def czy_tautologia(formula):
    zmienne = wydobadz_zmienne(formula)
    for wart in wartosciowania(zmienne):
        if not wartosc_formuly(formula, wart):
            return False
    return True

if __name__ == '__main__':
    print (spelnialna('(-p) * (-q) * r'))
    print(czy_tautologia('p + (-p)'))
    print(czy_tautologia('pies + (-qurczak)'))
    print(czy_tautologia('pies + (-pies)'))
    print(czy_tautologia('pies + (-pies) + True'))
    print(czy_tautologia('False'))
