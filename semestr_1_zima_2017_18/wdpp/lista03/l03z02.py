#!/usr/bin/env python3.6
# -*- coding: utf-8 -*-

def is_hyperlucky(n, seven_count):
    return '7' * seven_count in str(n)

def is_prime(n):
    threshold = n ** .5
    for i in range(2, int(threshold)):
        if n % i == 0:
            return False
    return True

def n_digit_numbers(n):
    """
    Iteracja zaczyna sie od najwyzszej liczby n-cyfrowej, wiec pierwsza
    spelniajaca warunki jest jednoczesnie najwieksza.
    """
    lowest = int('1' + '0' * (n-1))
    highest = int('9' * n)
    for i in range(highest, lowest, -1):
        yield i

if __name__ == '__main__':
    for i in n_digit_numbers(10):
        if is_hyperlucky(i, 7):
            if is_prime(i):
                print(i)
                break
