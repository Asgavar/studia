def srednia_trudnosc(zdanie):
    niewystąpienia = {
        'a': 1, 'ą': 0, 'b': 20, 'c': 4, 'ć': 32, 'd': 7, 'e': 0, 'ę': 0,
        'f': 41, 'g': 18, 'h': 30, 'i': 0, 'j': 12, 'k': 9, 'l': 7, 'ł': 9,
        'm': 0, 'n': 7, 'ń': 46, 'o': 0, 'ó': 0, 'p': 13, 'r': 3, 's': 10,
        'ś': 24, 't': 11, 'u': 0, 'w': 1, 'y': 0, 'z': 0, 'ż': 11, 'ź': 42
    }
    zdanie = zdanie.replace(' ', '').replace('#', '').replace('_', '').replace('x', '')
    trudności = [niewystąpienia[lit] for lit in zdanie]
    uśredniona = sum(trudności) / len(trudności)
    return uśredniona

if __name__ == '__main__':
    with open('wyniki_pomiarow.txt') as infile:
        wyniki = infile.readlines()
    pomiary = []
    for x in range(1, len(wyniki), 2):
        alfabeton = wyniki[x][:-1].lower()
        print(alfabeton)
        pomiary.append((alfabeton, srednia_trudnosc(alfabeton)))
    print(pomiary)
    pomiary.sort(key=lambda x: x[1])
    print('\n'.join(str(kr) for kr in pomiary))
