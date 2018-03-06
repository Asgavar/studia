#!/usr/bin/env python3.6

import timeit

setup = 'from wprawka07 import wariant_1, wariant_2;testowa = [x for x in range(100_000)]'

czas_1 = timeit.Timer('wariant_1(testowa, 3)', setup).timeit(1)
czas_2 = timeit.Timer('wariant_2(testowa, 3)', setup).timeit(1)

print(f'wariant z sortowaniem: {czas_1}')
print(f'wariant wlasny: {czas_2}')
