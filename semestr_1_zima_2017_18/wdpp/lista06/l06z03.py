def dividers(n):
    ret = set()
    for x in primes(n):
        while n % x == 0:
            ret.add(x)
            n = n / x
    return ret


def primes(n):
    """
    Generator liczb pierwszych.
    """
    for x in range(2, n):
        is_prime = True
        for y in range(2, x):
            if x % y == 0:
                is_prime = False
        if is_prime:
            yield x


if __name__ == '__main__':
    print(dividers(2048))
    print(dividers(1520))
