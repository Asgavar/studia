import duze_cyfry

def dlc(liczba):
    cyfry = []
    obraz = []
    while liczba > 0:
        cyfry.append(liczba % 10)
        liczba = liczba // 10
    for cyfra in cyfry[::-1]:
        obraz.append(duze_cyfry.dajCyfre(cyfra))
    for i in range(5):
        for c in obraz:
            print(c[i], end=' ')
        print()

if __name__ == '__main__':
    dlc(123456789)
