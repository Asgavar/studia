#!/usr/bin/env python3.6
# -*- coding: utf-8 -*-


def is_prime(n):
    threshold = n ** .5
    for i in range(2, int(threshold)):
        if n % i == 0:
            return False
    return True


if __name__ == '__main__':
    # lista wszystkich 10-cyfrowych liczb zawierajacych 7 siodemek pod rzad
    hyperluckies = []
    prime_count = 0
    for x in range(10):
        for y in range(10):
            for z in range(10):
                hyperluckies.extend((
                    str(x) + str(y) + str(z) + '7'*7,
                    str(x) + str(y) + '7'*7 + str(z),
                    str(x) + '7'*7 + str(y) + str(z),
                    '7'*7 + str(x) + str(y) + str(z)
                ))
    for h in hyperluckies:
        if is_prime(int(h)):
            prime_count += 1
    print(f'Jest ich {prime_count}')
