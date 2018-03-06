from l09z05 import alfabeton

if __name__ == '__main__':
    alfabet_polski = 'aąbcćdeęfghijklłmnńoóprsśtuwyzżź'  # uznałem 'x' za niepolski
    niewystąpienia = {lit: 0 for lit in alfabet_polski}
    zapis = open('wyniki_pomiarow.txt', 'w')
    for x in range(50):
        obiekt_badań = alfabeton()
        tektorychniebylo = list(filter(lambda lit: lit not in obiekt_badań, alfabet_polski))
        for ten in tektorychniebylo:
            niewystąpienia[ten] = niewystąpienia[ten] + 1
        print(tektorychniebylo)
        print(obiekt_badań)
        zapis.write(str(tektorychniebylo) + '\n')
        zapis.write(obiekt_badań + '\n')
    print(niewystąpienia)
    zapis.write(str(niewystąpienia) + '\n')
