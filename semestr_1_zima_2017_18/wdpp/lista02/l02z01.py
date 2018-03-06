def szachownica(n, k):
    for x in range(2*n*k):
        for y in range(2*n):
            if y % 2 == x // k % 2:
                biale(k)
            else:
                czarne(k)
        print()

def biale(k):
    print(" " * k, end="")

def czarne(k):
    print("#" * k, end="")

if __name__ == '__main__':
    szachownica(4, 3)
