# ===============================================================
# Sposob zadowolenia smoka dostarczamy przez arg. wiersza polecen
# ===============================================================

import random
import sys

import strategie

sposoby = {
    '5-rosnacy': strategie.piec_rosnacy,
    '6-niemalejacy': strategie.szesc_niemalejacy
}

if __name__ == '__main__':
    udanych = 0
    for i in range(10_000):
        rzuty = [random.randint(1, 6) for i in range(100)]
        if sposoby[sys.argv[1]](rzuty):
            udanych += 1
    print(f"Prawdopodobienstwo metody {sys.argv[1]} wynosi: {udanych/10000}")
