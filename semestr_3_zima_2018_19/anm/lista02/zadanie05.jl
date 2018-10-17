PRECISION = setprecision(128)


function pi_estimate(two_exp)
    sk = BigFloat(1)
    ck = BigFloat(0)
    current_exp = 2

    while current_exp < two_exp
        sk = (1/2 * (1 - ck)) ^ 1/2
        ck = (1/2 * (1 + ck)) ^ 1/2
        current_exp += 1
    end

    return (2 ^ (two_exp - 1)) * sk
end


for two_exp = 2:(PRECISION*2)
    println("exp = $(two_exp) P$(2^two_exp) = $(pi_estimate(two_exp))")
    two_exp += 1
end
