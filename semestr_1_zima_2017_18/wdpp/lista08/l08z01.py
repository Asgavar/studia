#!/usr/bin/env python3.6

import random
import re
import sys

if __name__ == '__main__':
    to_translate = sys.argv[1:]
    with open('brown.txt') as browntxt:
        brown_corpus = browntxt.readlines()
    with open('pol_ang.txt') as polangtxt:
        translations = polangtxt.readlines()[4:]  # 3 pierwsze linie to wstep
    brown_corpus = list(map(lambda line: line.split(' '), brown_corpus))
    # jedna, dluga lista slow
    brown_corpus = [word for line in brown_corpus for word in line]
    brown_corpus = ' '.join(brown_corpus)
    # uciecie koncowego '\n' i rozbicie na wersje polska i angielska
    translations = list(map(lambda line: line[:-1].split('='), translations))
    # kilkadziesiat tlumaczen sklada sie z jednego slowa (?)
    translations = list(filter(lambda word: len(word) == 2, translations))
    # tlumaczenia maja postac: polskie_slowo: [lista angielskich]
    d = {}
    for word in translations:
        d[word[0]] = d[word[0]] + ' ' + word[1] if word[0] in d else word[1]
    translations = d
    del d
    occurences = {}
    inenglish = {}
    output = {}
    for word in to_translate:
        inenglish[word] = translations[word].split(' ')
    for word in inenglish:
        for trans in inenglish[word]:
            to_find = r'\b' + trans + r'\b'
            print(f'{word} -> {trans} : {len(re.findall(to_find, brown_corpus))}')
            current_transes = output[word] if word in output else ()
            output[word] = current_transes + (trans, len(re.findall(to_find, brown_corpus)))
    final_string = ''
    for word in output:
        curr_max = 0
        curr_max_set = set()
        for x in range(0, len(output[word]), 2):
            if int(output[word][x+1]) >= curr_max:
                if int(output[word][x+1]) != curr_max:  # max sie zwiekszyl
                    curr_max_set = set()
                curr_max_set.add(output[word][x])
                curr_max = int(output[word][x+1])
        print(f'{word} -> {curr_max_set}')
        final_string += random.choice(list(curr_max_set))
        final_string += ' '
    print(final_string)
