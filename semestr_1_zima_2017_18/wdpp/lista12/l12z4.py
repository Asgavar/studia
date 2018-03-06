import argparse
import random
from collections import defaultdict

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--poczatek', required=True)
    parser.add_argument('--dlugosc', required=True, type=int)
    args = parser.parse_args()
    with open('pan-tadeusz.txt') as infile:
        tekst = infile.readlines()
        tekst = [linia[:-1] for linia in tekst if linia != '\n']
        tekst = ' '.join(tekst)
        nastepcy = defaultdict(lambda: [])
        poprzednik = 'Adam'
        for slowo in tekst.split()[1:]:
            nastepcy[poprzednik].append(slowo)
            poprzednik = slowo
    obecne_slowo = args.poczatek
    wiersz_wynikowy = [obecne_slowo]
    while len(wiersz_wynikowy) <= args.dlugosc and nastepcy[obecne_slowo]:
        obecne_slowo = random.choice(nastepcy[obecne_slowo])
        wiersz_wynikowy.append(obecne_slowo)
    print(wiersz_wynikowy)
