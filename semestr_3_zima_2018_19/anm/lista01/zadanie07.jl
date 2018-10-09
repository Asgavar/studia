EXPONENT_OFFSET = 1023


function float64frombitstring(bits)
    sign = parse(Int, bits[1])
    sign = sign == 0 ? 1 : -1
    exponent = binstring2int64(bits[2:12]) - EXPONENT_OFFSET
    significand = 1 + significant2decimalfrac(bits[13:end])

    return sign * significand * (2 ^ Float64(exponent))
end


function binstring2int64(bits)
    value = 0
    current_exponent = 0
    howmanybits = length(bits)

    while current_exponent < howmanybits
        value += bit2zeroorone(bits[end - current_exponent]) * (2 ^ current_exponent)
        current_exponent += 1
    end

    return value
end


function bit2zeroorone(bit)
    return bit == '0' ? 0 : 1
end


function significant2decimalfrac(bits)
    value = 0
    idx = 1
    bitscount = length(bits)

    while idx <= bitscount
        value += bit2zeroorone(bits[idx]) * ((1/2) ^ idx)
        idx += 1
    end

    return value
end


println(float64frombitstring("0011111111110000000000000000000000000000000000000000000000000001"))
println(float64frombitstring("0011111111010101010101010101010101010101010101010101010101010101"))

println(float64frombitstring(bitstring(42.1337)))
println(float64frombitstring(bitstring(7.99999987)))
