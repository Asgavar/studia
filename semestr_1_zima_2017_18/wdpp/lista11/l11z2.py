import sys
import os

from l11z1 import caesar

def przesun_do_a_z_przodu(slowo):
    o_ile = ord('a') - ord(slowo[0])
    return caesar(slowo, o_ile)


if __name__ == '__main__':
    with open('slowa.txt') as infile:
        words = infile.readlines()
    words = [w[:-1] for w in words if '|' not in w]
    words_set = set(words)
    max_len = max([len(w) for w in words])
    words_by_size = []
    for x in range(1, max_len+1):
        this_size = [w for w in words if len(w) == x]
        words_by_size.append(this_size)
    for x in range(max_len-1, 1, -1):
        size_list = words_by_size[x]
        a_wersje = {}
        for word in size_list:
            z_a_z_przodu = przesun_do_a_z_przodu(word)
            if z_a_z_przodu in a_wersje:
                # niektore slowa powtarzaja sie
                a_wersje[z_a_z_przodu].add(word)
            else:
                a_wersje[z_a_z_przodu] = {word}
        for awersja in a_wersje:
            if len(a_wersje[awersja]) > 1:
                print(f'Cesarskie słowa: {a_wersje[awersja]}')
