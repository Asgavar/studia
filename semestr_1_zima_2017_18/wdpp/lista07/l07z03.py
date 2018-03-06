#!/usr/bin/env python3.6

import sys


class LongestWords:
    def __init__(self, infile_path):
        self.infile_path = infile_path
        self.longest = set()
        self.currentmaxlength = 0
        self.ignored = ' \n\t;:-.,?!()'

    def _process_infile(self):
        with open(infile_path) as infile:
            for line in infile:
                for word in line.split():
                    for character in self.ignored:
                        word = word.replace(character, '')
                    wordlength = len(word)
                    if wordlength > self.currentmaxlength:
                        self.currentmaxlength = wordlength
                        self.longest = set()
                    if wordlength == self.currentmaxlength:
                        self.longest.add(word)

    def getlongests(self):
        self._process_infile()
        ret = f'Najdluzsze (majace dlugosc {self.currentmaxlength}):\n'
        for word in sorted(list(self.longest)):
            ret += word
            ret += '\n'
        return ret


if __name__ == '__main__':
    infile_path = sys.argv[1]
    print(LongestWords(infile_path).getlongests())
