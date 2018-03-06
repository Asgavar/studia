def funct_ret(n, m):
    if m == 0:
        return n
    if n == 0:
        return m
    return func_tret(n-1, m) + 2 * func_tret(n, m-1)

print(funct_ret(3, 4))
