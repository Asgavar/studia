# ważne, by x miał exponent = 1023, wtedy -exponent wykroczyc 
x = float64frombitstring("0111111111101111111111111111111111111111111111111111111111111111")
x_reciprocal = 1/x

println("Taką liczbą jest na przykład: $(x)")
println("x * 1/x = $(x * x_reciprocal)")
