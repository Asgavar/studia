#!/usr/bin/env python3.6

from liczby import liczby

def tekstowa(n):
    jednosci = n % 10
    dziesiatki = (n % 100) - jednosci
    setki = (n % 1000) - dziesiatki - jednosci
    # wyeliminowanie 'dziesiec trzy' itd
    if dziesiatki == 10:
        dziesiatki += jednosci
        jednosci = 0
    if n <= 20:
        return f'{liczby[n]}'
    elif n in range(21, 100):
        return f'{liczby[dziesiatki]} {liczby[jednosci]}'
    else:  # między 100 a 999 włącznie
        return f'{liczby[setki]} {liczby[dziesiatki]} {liczby[jednosci]}'

def napis_z_liczbami(lista_slow):
    lista_slow = map(lambda x: str(x), lista_slow)
    ret = []
    for slowo in lista_slow:
        if slowo.isdigit():
            slowo = tekstowa(int(slowo))
        ret.append(slowo)
    return ' '.join(ret)

if __name__ == '__main__':
    print(tekstowa(876))
    print(tekstowa(99))
    print(tekstowa(11))
    print(tekstowa(8))
    print(tekstowa(999))
    print(napis_z_liczbami(['Ala', 'ma', 113, 'kotów', 'i', '257', 'kanarków']))
    # for x in range(1000):
        # print(tekstowa(x))
