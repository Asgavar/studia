#!/usr/bin/env python3.6
# -*- coding: utf-8 -*-

def is_prime(n):
    threshold = n ** .5
    for i in range(2, int(threshold)):
        if n % i == 0:
            return False
    return True

if __name__ == '__main__':
    lucky_numbers = []
    for i in range(1, 100_000):
        if '777' in str(i):
            if is_prime(i):
                lucky_numbers.append(i)
    for n in lucky_numbers:
        print(n)
    print(f'\nJest ich {len(lucky_numbers)}')
