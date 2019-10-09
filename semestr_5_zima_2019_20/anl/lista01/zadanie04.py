def pi_approx(n):
    return sum([4 * (((-1)**k) / (2*k+1)) for k in range(n+1)])

for _ in range(100):
    print(_, f'value = {pi_approx(_)}')

print('EKSPERYMENT!')
print(f'wynik -> {pi_approx(200_000)}')
