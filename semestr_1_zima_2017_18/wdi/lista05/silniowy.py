def silniowy(n):
    iteracja = 2
    zapis = ''
    while n > 0:
        zapis += str(n % iteracja)
        n = n // iteracja
        iteracja += 1
    print(zapis)


silniowy(100)
