#!/usr/bin/env python3

import sys


def jest_podciagiem(slowo, slowa):
    slowo = slowo.lower()
    slowa = slowa.lower()
    slowo_p = 0
    slowa_p = 0
    slowo_koniec = len(slowo)
    slowa_koniec = len(slowa)
    while slowo_p != slowo_koniec and slowa_p != slowa_koniec:
        if slowo[slowo_p] == slowa[slowa_p]:
            slowo_p += 1
            slowa_p += 1
        else:
            slowa_p += 1
    return slowo_p == slowo_koniec


if __name__ == '__main__':
    with open('slowa.txt') as infile:
        words = infile.readlines()
    given_word = sys.argv[1]
    matches = []
    for word in words:
        if jest_podciagiem(given_word, word):
            matches.append(word)
    print('\n'.join(matches))
