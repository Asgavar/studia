#!/usr/bin/env python3.6

import sys


class Życie:
    def __init__(self, stan_pierwotny):
        self.mapa = stan_pierwotny
        self.czerw = self.ile_czerwonych()
        self.nieb = self.ile_niebieskich()
        self.historia = set()

    def ile_niebieskich(self):
        ile = 0
        for rząd in range(15):
            for kolumna in range(30):
                if self.mapa[rząd][kolumna] == 'N':
                    ile += 1
        return ile

    def ile_czerwonych(self):
        ile = 0
        for rząd in range(15):
            for kolumna in range(30):
                if self.mapa[rząd][kolumna] == 'C':
                    ile += 1
        return ile

    def sasiedzi(self, x, y):
        """
        X jest kolumną, Y jest rzędem.
        """
        sasiadujacy = [
            (-1, -1), (-1, 1), (1, -1), (1, 1), (0, -1), (0, 1), (1, 0), (-1, 0)
        ]
        pola = []
        faktyczni_sasiedzi = []
        for d_rzad, d_kolumna in sasiadujacy:
            # nx = (x + dx) % 30
            n_rzad = (x + d_rzad) % 15
            # ny = (y + dy) % 15
            n_kolumna = (y + d_kolumna) % 30
            pola.append((n_rzad, n_kolumna))
        for pole in pola:
            kto_tam = self.mapa[pole[0]][pole[1]]
            if kto_tam != '.':
                faktyczni_sasiedzi.append(pole)
        return faktyczni_sasiedzi

    def co_z_nia(self, rzad, kolumna):
        ile_sasiadow = len(self.sasiedzi(rzad, kolumna))
        if ile_sasiadow == 3:
            return 'narodziny'
        elif ile_sasiadow < 2:
            return 'smierc'
        elif ile_sasiadow > 3:
            return 'smierc'
        else:
            return 'nic'

    def wyswietl(self):
        print('-'*30)
        for rząd in range(15):
            rząd_str = ''
            for kolumna in range(30):
                rząd_str += self.mapa[rząd][kolumna]
            print(rząd_str)
        print('-'*30 + '\n')

    def pokolenie_naprzod(self):
        # zliczenie N i C, wyswietlenie planszy itd
        for rząd in range(15):
            for kolumna in range(30):
                co_dalej = self.co_z_nia(rząd, kolumna)
                if co_dalej == 'nic':
                    continue
                if co_dalej == 'smierc':
                    self.umiesc('.', rząd, kolumna)
                if co_dalej == 'narodziny':
                    noworodek = self.kolor_dzidziusia(rząd, kolumna)
                    self.umiesc(noworodek, rząd, kolumna)
        self.wyswietl()
        self.czerw = self.ile_czerwonych()
        self.nieb = self.ile_niebieskich()
        if self.czy_koniec():
            print('KONIEC GRY')
            print(f'NIEBIESCY: {self.nieb}')
            print(f'CZERWONI: {self.czerw}')
            sys.exit(0)
        self.do_historii()

    def kolor_dzidziusia(self, rzad, kolumna):
        sasiedzi = self.sasiedzi(rzad, kolumna)
        czerwoni_tatusie = 0
        niebieskie_mamusie = 0
        for sasiad in sasiedzi:
            kolor = self.mapa[sasiad[0]][sasiad[1]]
            if kolor == 'C':
                czerwoni_tatusie += 1
            if kolor == 'N':
                niebieskie_mamusie += 1
        if czerwoni_tatusie > niebieskie_mamusie:
            return 'C'
        else:
            return 'N'

    def umiesc(self, kogo, gdzie_rzad, gdzie_kolumna):
        nowy_rząd = self.mapa[gdzie_rzad]
        nowy_rząd = nowy_rząd[:gdzie_kolumna] + kogo + nowy_rząd[gdzie_kolumna+1:]
        self.mapa[gdzie_rzad] = nowy_rząd

    def czy_koniec(self):
        # stan sie powtorzyl lub 0 C lub 0 N
        return self.czerw == 0 or self.nieb == 0 or str(self.mapa) in self.historia

    def do_historii(self):
        self.historia.add(str(self.mapa))  # listy są niehashowalne


if __name__ == '__main__':
    początek = [('.' * 30) for ą in range(15)]  # lista stringów-rzędów
    with open('czerwony.txt') as infile:
        czerwoni = infile.readlines()
    with open('niebieski.txt') as infile:
        niebiescy = infile.readlines()
    for x in range(15):
        for y in range(15):
            if niebiescy[x][y] == 'N':
                nowy_rząd = początek[x]
                nowy_rząd = nowy_rząd[:y] + 'N' + nowy_rząd[y+1:]
                początek[x] = nowy_rząd
            if czerwoni[x][y] == 'C':
                nowy_rząd = początek[x]
                nowy_rząd = nowy_rząd[:y+15] + 'C' + nowy_rząd[y+1+15:]
                początek[x] = nowy_rząd
    # print(początek)
    żywot = Życie(początek)
    żywot.wyswietl()
    while True:
        żywot.pokolenie_naprzod()
