import math

REAL_ROOT = .0646926359947960

def f(x):
    return x * math.e ** (-x) - 0.06064

a = 0
b = 1
for _ in range(15+1):
    middle = 1/2 * (a + b)
    print(f'a = {a}, b = {b}')

    print(f'{_} error = {abs(REAL_ROOT - middle)}')
    print(f'{_} oszacowanie = {2**(-_-1)}')
    print(f'{_} root = {f(middle)}')
    print()

    if f(a) * f(middle) < 0:
        b = middle
    else:
        a = middle
