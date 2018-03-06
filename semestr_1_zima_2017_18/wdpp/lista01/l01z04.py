#!/usr/bin/env python3

from losowanie_fragmentow import losuj_fragment

def losuj_haslo(n):
    dlugosc = 0
    haslo = ""
    while dlugosc != n:
        fragment = losuj_fragment()
        potencjalna_dlugosc = dlugosc + len(fragment)
        # zeby uniknac zablokowania sie (nie ma slow o dlugosci 1)
        if potencjalna_dlugosc <= n and potencjalna_dlugosc != n-1:
            dlugosc += len(fragment)
            haslo += fragment
    return haslo

print("10 wywolan dla n=8:")
print("-"*19)
for i in range(10):
    print(losuj_haslo(8))

print()

print("10 wywolan dla n=12:")
print("-"*20)
for i in range(10):
    print(losuj_haslo(12))
