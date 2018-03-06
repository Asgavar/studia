import random

from l08z02 import get_occurences, is_composable


def all_letters_unique(word):
    word = word.replace(' ', '')
    letters = get_occurences(word)
    return all(c == 1 for c in letters.values())


def doesnotcontain(word, letters):
    # print(list(c for c in letters))
    # print(list(c for c in word))
    word = word[:-1]
    letters = letters[:-1]
    return all(c not in letters for c in word)


def alfabeton(slowo_startowe):
    with open('slowa.txt') as infile:
        words = infile.readlines()
    # najpierw eliminujemy slowa, ktore same w sobie sa antyalfabetoniczne
    words = set(filter(lambda w: all_letters_unique(w), words))
    alfabeton = slowo_startowe
    ile = -777
    while ile != 0:
        uglyword = random.choice(tuple(words))
        # '\n' na końcu wszstko psuł ;_;
        maybeaword = uglyword[:-1]
        maybealfabeton = alfabeton + maybeaword
        if all_letters_unique(maybealfabeton):
            alfabeton += ' '
            alfabeton += maybeaword
        words.discard(uglyword)
        # czyscimy zbior ze slowo zawierajacych litery z aktualnej postaci alfabetonu
        words = set(filter(lambda w: doesnotcontain(w, alfabeton), words))
        ile = len(words)
    return alfabeton

if __name__ == '__main__':
    print(alfabeton('gońbą'))
