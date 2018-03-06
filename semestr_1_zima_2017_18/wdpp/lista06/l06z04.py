#!/usr/bin/env python3.6


def podziel(s):
    delimiters = ' \t\n'
    ret = []
    in_word = True
    temp_word = ''
    for x in range(len(s)):
        if s[x] not in delimiters:
            if in_word:
                temp_word += s[x]
            else:
                ret.append(temp_word)
                temp_word = s[x]  # zaczynamy nowe slowo
            in_word = True
        else:
            in_word = False
    ret.append(temp_word)
    return ret


if __name__ == '__main__':
    print(podziel('Ala ma kota'))
    print(podziel('''a    inna Ala go \tnie
        ma'''))
