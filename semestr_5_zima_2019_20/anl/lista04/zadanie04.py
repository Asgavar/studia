import math
import matplotlib.pyplot as plt
import numpy as np

def g(x):
    return x**2 - 2*x

def h(x):
    return np.arctan(7*x - 2)

def f(x):
    return g(x) - h(x)

x = np.arange(0, 5, 0.0001)
g_y = g(x)
h_y = h(x)
f_y = f(x)

plt.plot(x, g_y, 'orange')
plt.plot(x, h_y, 'green')
plt.plot(x, f_y, 'black')

plt.axhline(y=0, linestyle=':')

plt.legend(['g(x)', 'h(x)', 'f(x)'])

plt.savefig('zadanie04.png')

def bisection(func, a, b, err):
    a0, b0 = a, b
    n = 0

    while err < 2 ** (-n-1) * (b0 - a0):
        middle = 1/2 * (a + b)
        print(f'a = {a}, b = {b}')
        print(f'{n} root = {middle}')
        print()
        if f(a) * f(middle) < 0:
            b = middle
        else:
            a = middle
        n += 1

    return middle

x1 = bisection(f, 0, 1, 10**(-5))
x2 = bisection(f, 2, 3, 10**(-5))

print(f'x1 = {x1}, x2 = {x2}')
