function twopi_minus(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(6.28318530717958600, hi)
    t2, t3 = two_diff(2.4492935982947064e-16, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 5.9895396194366790e-33
    zlo += t7
    return DoubleFloat{Float64}(zhi, zlo)
end

twopi_minus(x::DoubleFloat{Float64}) = twopi_minus(HI(x), LO(x))

function pi_minus(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(3.14159265358979300, hi)
    t2, t3 = two_diff(1.2246467991473532e-16, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 2.9947698097183397e-33
    zlo += t7
    return DoubleFloat{Float64}(zhi, zlo)
end

pi_minus(x::DoubleFloat{Float64}) = pi_minus(HI(x), LO(x))

function halfpi_minus(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(1.57079632679489660, hi)
    t2, t3 = two_diff(6.1232339957367660e-17, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 1.4973849048591698e-33
    zlo += t7
    return DoubleFloat{Float64}(zhi, zlo)
end

halfpi_minus(x::DoubleFloat{Float64}) = halfpi_minus(HI(x), LO(x))

function qrtrpi_minus(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(0.78539816339744830, hi)
    t2, t3 = two_diff(3.0616169978683830e-17, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 7.4869245242958490e-34
    zlo += t7
    return DoubleFloat{Float64}(zhi, zlo)
end

qrtrpi_minus(x::DoubleFloat{Float64}) = qrtrpi_minus(HI(x), LO(x))


function minus_twopi(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(6.28318530717958600, hi)
    t2, t3 = two_diff(2.4492935982947064e-16, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 5.9895396194366790e-33
    zlo += t7
    return DoubleFloat{Float64}(-zhi, -zlo)
end

minus_twopi(x::DoubleFloat{Float64}) = minus_twopi(HI(x), LO(x))

function minus_pi(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(3.14159265358979300, hi)
    t2, t3 = two_diff(1.2246467991473532e-16, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 2.9947698097183397e-33
    zlo += t7
    return DoubleFloat{Float64}(-zhi, -zlo)
end

minus_pi(x::DoubleFloat{Float64}) = minus_pi(HI(x), LO(x))

function minus_halfpi(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(1.57079632679489660, hi)
    t2, t3 = two_diff(6.1232339957367660e-17, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 1.4973849048591698e-33
    zlo += t7
    return DoubleFloat{Float64}(-zhi, -zlo)
end

minus_halfpi(x::DoubleFloat{Float64}) = minus_halfpi(HI(x), LO(x))

function minus_qrtrpi(hi::T, lo::T) where {T<:Float64}
    zhi, t1 = two_diff(0.78539816339744830, hi)
    t2, t3 = two_diff(3.0616169978683830e-17, lo)
    t7, t4 = two_sum(t1, t2)
    t5 = t3 + t4
    zlo = t5 - 7.4869245242958490e-34
    zlo += t7
    return DoubleFloat{Float64}(-zhi, -zlo)
end

minus_qrtrpi(x::DoubleFloat{Float64}) = minus_qrtrpi(HI(x), LO(x))

