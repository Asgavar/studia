import math

def recur(n):
    if n == 0: return math.log(2020/2019)
    return 1/n - 2019 * recur(n-1)

for _ in range (100):
    print(f'{_} -> {recur(_)}')
