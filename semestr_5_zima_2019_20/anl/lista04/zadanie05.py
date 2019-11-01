# newton: f(x) = 1/x - R (= 0)
# x_n+1 = x_n - (1 / x_n - R) / (-1/x_n^2)

#x_n+1 = x_n(2 - x_n * R)

def reciprocal(R, x0, times):
    rec = x0

    for _ in range(times):
        rec = rec * (2 - R*rec)

    return rec

print(reciprocal(0.00001, 0.00001, 100))
print(reciprocal(0.9, 0.9, 100))
print(reciprocal(100, 1/100, 100))
print(reciprocal(100, 0.5, 100))
print(reciprocal(100, 0.05, 100))
print(reciprocal(100, 0.001, 100))
#print(reciprocal(100, 1, 100))
#print(reciprocal(10, 10, 100))
