def prime_dividers(n):
    ret = []
    for x in range(2, n):
        while n % x == 0:
            ret.append(x)
            n /= x
    return ret


def _to_product(n):
    div = prime_dividers(n)
    ret = ''
    for x in range(len(div)):
        ret += str(div[x])
        ret += '*'
    return ret[:-1]  # bez koncowej gwiazdki


def to_products(numbers):
    return list(map(_to_product, numbers))


if __name__ == '__main__':
    print(_to_product(24))
    print(to_products([4, 24, 26]))
