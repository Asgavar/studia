# Zadanie 0
a = 1:100
b = 1:2:100
c = (-1:0.01:1) * pi
d = [(-1:0.01:-0.01) * pi (0.01:0.01:1) * pi]
e = sin(1:100)
e(e < 0) = 0

A = transpose(reshape(1:100, [10 10]))
B = diag(1:100) + diag(99:-1:1, -1) + diag(99:-1:1, 1)
C = triu(ones(10))
