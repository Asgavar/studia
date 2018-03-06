#!/usr/bin/env python3.6

import itertools
import sys

from l08z02 import get_occurences, is_composable


def word_without(longer, shorter):
    ret = longer
    for letter in shorter:
        ret = ret.replace(letter, '', 1)
    return ret


if __name__ == '__main__':
    with open('slowa.txt') as slowatxt:
        words_list = slowatxt.readlines()
    words_list = list(map(lambda w: w[:-1], words_list))
    words_set = set(words_list)
    famous_person_name = sys.argv[1] + sys.argv[2]
    famous_person_name = famous_person_name.lower()
    fam_letters = get_occurences(famous_person_name)
    suspects = []
    for word in words_list:
        if is_composable(word, famous_person_name):
            suspects.append(word)
        else:
            continue
    suspects_set = set(suspects)
    for x in range(len(suspects)):
        if suspects[x] not in suspects_set:
            continue
        supplement_letters = word_without(famous_person_name, suspects[x])
        desired_occurences = get_occurences(supplement_letters)
        for y in range(x, len(suspects)):
            if suspects[y] not in suspects_set:
                continue
            if get_occurences(suspects[y]) == desired_occurences:
                print(f'{suspects[x]} {suspects[y]}')
                suspects_set.discard(suspects[x])
                suspects_set.discard(suspects[y])
