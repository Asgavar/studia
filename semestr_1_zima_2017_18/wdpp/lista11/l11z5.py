import itertools
import os.path

from l11z4 import ppn

def czy_kompatybilne(szyfr, tlumaczenia):
    """
    Generuje slowniki podstawień i sprawdza, czy są ze sobą kompatybilne.
    """
    mapping = {}
    for slowo in tlumaczenia:
        for litera in slowo:
            zaszyfrowana = szyfr[tlumaczenia.index(slowo)][slowo.index(litera)]
            if litera in mapping and mapping[litera] != zaszyfrowana:
                return False
            if litera not in mapping and zaszyfrowana in mapping.values():
                return False
            mapping[litera] = zaszyfrowana
    return True


if __name__ == '__main__':
    with open(os.path.expanduser('~/Dropbox/studia/wdpp/lista11/szyfrogramy.txt')) as infile:
        ciphers = infile.readlines()
        ciphers = [ciph[:-1].replace('.', '').replace(',', '').replace('?', '').split() for ciph in ciphers]
    with open('slowa.txt') as infile:
        words = infile.readlines()
    words = [w[:-1] for w in words] # bez '\n'
    words_ppn = [ppn(w) for w in words] # indeks danego ppn odpowiada slowu
    for cipher in ciphers:
        mozliwosci_wszystkich = []
        for word in cipher:
            ppn_slowa = ppn(word)
            # wszystkie slowa o tej samej PPN
            takie_same_ppn = [
                words[ind] for ind, w_ppn in enumerate(words_ppn) if w_ppn == ppn_slowa
            ]
            mozliwosci_wszystkich.append(takie_same_ppn)
        # kombinacje listy list z pasujacymi (badz nie) slowami
        for possib in itertools.product(*mozliwosci_wszystkich):
            if czy_kompatybilne(cipher, possib):
                print(f'Odszyfrowano!\n{cipher} okazał się być: {possib}')
