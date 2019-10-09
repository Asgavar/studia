import functools

@functools.lru_cache(maxsize=128)
def xn(n):
    if n == 0: return 1
    if n == 1: return 1/3

    return 1/3 * ((-299*xn(n-1)) + 100*xn(n-2))

for _ in range(2, 50+1):
    print(f'{_} wyraz = {xn(_)}')
    
