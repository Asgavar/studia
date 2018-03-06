import math
import string
from decimal import Decimal

def first_100_pi_digits():
    # Leibniz
    positives = sum((1/den for den in range(1, 10**4, 4)))
    negatives = sum((1/den for den in range(3, 10**4, 4)))
    pi = 4 * (positives - negatives)
    print(pi)
    # Ramanujan
    const = Decimal(str(2 * (2**1/2) / 9801))
    pi = Decimal('0.0')
    for k in range(0, 10**3):
        to_add = Decimal(str((math.factorial(4*k)) * (1103 + (26390*k))))
        denom = Decimal(((math.factorial(k) ** 4) * 396**(4*k)))
        to_add /= denom
        pi += to_add
    pi *= const
    pi = pi ** (-1)
    print(pi)
    pi = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
    return [c for c in str(pi) if c != '.']


def wordlength(word):
    alphabet = string.ascii_letters
    alphabet += 'ąćęłńóśżź'
    word = ''.join([c for c in word if c in alphabet])
    return len(word) if len(word) != 10 else 0


if __name__ == '__main__':
    with open('/home/asgavar/Dropbox/studia/wdpp/lista10/pan-tadeusz.txt') as infile:
        tekst = infile.read().split()
    pi = first_100_pi_digits()
    pi = [int(d) for d in pi]
    print(pi)
    maks_fragment = ''
    maks_dlugosc = 0
    wskaznik = 0
    fragment = ''
    for wyraz in tekst:
        if wordlength(wyraz) == pi[wskaznik]:
            fragment += wyraz
            fragment += ' '
            wskaznik += 1
        else:
            if wskaznik > maks_dlugosc:
                maks_fragment = fragment
                maks_dlugosc = wskaznik
            wskaznik = 0
            fragment = ''
    print(f'Najdłuższy fragment: {maks_dlugosc}')
    print(maks_fragment)
