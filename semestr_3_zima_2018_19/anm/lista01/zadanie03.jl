function our_polynomial(x)
    return x^3 - 6*x^2 + 3x - 0.149
end

as_float_16 = Float16(4.71)
as_float_32 = Float32(4.71)
as_float_64 = Float64(4.71)

exact_value = 0 - 14.636489

println("Dokładny wynik: $(exact_value)")

from_float_16 = our_polynomial(as_float_16)
from_float_32 = our_polynomial(as_float_32)
from_float_64 = our_polynomial(as_float_64)

println("Wynik z Float16: $(from_float_16)")
println("Wynik z Float32: $(from_float_32)")
println("Wynik z Float64: $(from_float_64)")

error_from_16 = abs((from_float_16 - exact_value) / exact_value)
error_from_32 = abs((from_float_32 - exact_value) / exact_value)
error_from_64 = abs((from_float_64 - exact_value) / exact_value)

println("Błąd z Float16: $(error_from_16)")
println("Błąd z Float32: $(error_from_32)")
println("Błąd z Float64: $(error_from_64)")
