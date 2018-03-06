def gieoden(n):
    alfa = 1
    bravo = 1
    charlie = 1
    while n > 2:
        delta = alfa + bravo + charlie
        alfa = bravo
        bravo = charlie
        charlie = delta
        n -= 1
    return charlie

print(gieoden(0))
print(gieoden(1))
print(gieoden(2))
print(gieoden(200))
