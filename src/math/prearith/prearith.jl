@inline signbit(a::DoubleFloat{T}) where {T} = signbit(HI(a))
@inline sign(a::DoubleFloat{T}) where {T} = sign(HI(a))

@inline function (-)(a::DoubleFloat{T}) where {T}
    if iszero(LO(a))
        DoubleFloat(-HI(a), LO(a))
    else
        DoubleFloat(-HI(a), -LO(a))
    end
end

@inline function abs(a::DoubleFloat{T}) where {T}
    if HI(a) >= 0.0
        a
    else # HI(a) < 0.0
        -a
    end
end


@inline function flipsign(x::DoubleFloat{T}, y::T) where {T<:AbstractFloat}
    signbit(y) ? -x : x
end
@inline function flipsign(x::DoubleFloat{T}, y::DoubleFloat{T}) where {T<:AbstractFloat}
    signbit(y) ? -x : x
end

@inline function copysign(x::DoubleFloat{T}, y::T) where {T<:AbstractFloat}
    signbit(y) ? -abs(x) : abs(x)
end
@inline function copysign(x::DoubleFloat{T}, y::DoubleFloat{T}) where {T<:AbstractFloat}
    signbit(y) ? -abs(x) : abs(x)
end

flipsign(x::DoubleFloat{T}, y::U) where {T<:AbstractFloat, U<:Unsigned} = +x
copysign(x::DoubleFloat{T}, y::U) where {T<:AbstractFloat, U<:Unsigned} = +x

flipsign(x::DoubleFloat{T}, y::S) where {T<:AbstractFloat, S<:Signed} =
    signbit(y) ? -x : x
copysign(x::DoubleFloat{T}, y::S) where {T<:AbstractFloat, S<:Signed} =
    signbit(y) ? -abs(x) : abs(x)

function frexp(x::DoubleFloat{T}) where {T<:AbstractFloat}
    frhi, exphi = frexp(HI(x))
    frlo, explo = frexp(LO(x))
    return (frhi, exphi), (frlo, explo)
end

function ldexp(x::DoubleFloat{T}, exponent::I) where {T, I<:Integer}
    return DoubleFloat(ldexp(HI(x), exponent), ldexp(LO(x), exponent))
end

function ldexp(dhi::Tuple{T,I}, dlo::Tuple{T,I}) where {T<:AbstractFloat, I<:Integer}
    return DoubleFloat(ldexp(dhi[1], dhi[2]), ldexp(dlo[1], dlo[2]))
end

function ldexp(dhilo::Tuple{Tuple{T,I}, Tuple{T,I}}) where {T<:AbstractFloat, I<:Integer}
    return ldexp(dhilo[1], dhilo[2])
end

function exponent(x::DoubleFloat{T}) where {T<:AbstractFloat}
    ehi = Base.exponent(HI(x))
    elo = Base.exponent(LO(x))
    return ehi, elo
end

function significand(x::DoubleFloat{T}) where {T<:AbstractFloat}
    shi = Base.significand(HI(x))
    slo = Base.significand(LO(x))
    return shi, slo
end

function signs(x::DoubleFloat{T}) where {T<:AbstractFloat}
    shi = sign(HI(x))
    slo = sign(LO(x))
    return shi, slo
end


ulp(x::T) where {T<:IEEEFloat} = significand(x) !== -one(T) ? eps(x) : eps(x)/2

posulp(x::T) where {T<:IEEEFloat} = significand(x) !== -one(T) ? eps(x) : eps(x)/2
negulp(x::T) where {T<:IEEEFloat} = significand(x) !== one(T) ? -eps(x) : -eps(x)/2

ulp(::Type{T}) where {T<:IEEEFloat} = ulp(one(T))
posulp(::Type{T}) where {T<:IEEEFloat} = ulp(one(T))
negulp(::Type{T}) where {T<:IEEEFloat} = ulp(one(T))

function eps(x::DoubleFloat{T}) where {T<:AbstractFloat}
    return LO(x) !== zero(T) ? eps(LO(x)) : eps(posulp(HI(x)))
end

function ulp(x::DoubleFloat{T}) where {T<:AbstractFloat}
    return LO(x) !== zero(T) ? posulp(LO(x)) : posulp(posulp(HI(x)))
end

eps(::Type{D}) where {T<:AbstractFloat, D<:DoubleFloat{T}} = D(eps(posulp(one(T))))
ulp(::Type{D}) where {T<:AbstractFloat, D<:DoubleFloat{T}} = D(posulp(poslulp(one(T))))


function nextfloat(x::DoubleFloat{T}) where {T<:AbstractFloat}
    !isfinite(x) && return(x)
    if !iszero(LO(x))
        DoubleFloat{T}(HI(x)) + nextfloat(LO(x))
    else
        DoubleFloat{T}(HI(x), ulp(ulp(HI(x))))
    end
end

function prevfloat(x::DoubleFloat{T}) where {T<:AbstractFloat}
    !isfinite(x) && return(x)
    if !iszero(LO(x))
        DoubleFloat{T}(HI(x)) + prevfloat(LO(x))
    else
        DoubleFloat{T}(HI(x), -ulp(ulp(HI(x))))
    end
end

function nextfloat(x::DoubleFloat{T}, n::Int) where {T<:AbstractFloat}
    !isfinite(x) && return(x)
    if !iszero(LO(x))
        x + n*ulp(LO(x))
    else
        DoubleFloat{T}(HI(x), n*ulp(ulp(HI(x))))
    end
end

function prevfloat(x::DoubleFloat{T}, n::Int) where {T<:AbstractFloat}
    !isfinite(x) && return(x)
    if !iszero(LO(x))
        x - n*ulp(LO(x))
    else
        DoubleFloat{T}(HI(x), -n*ulp(ulp(HI(x))))
    end
end


@inline function intpart(x::Tuple{T,T}) where {T<:AbstractFloat}
    hi, lo = x
    ihi = modf(hi)[2]
    ilo = modf(lo)[2]
    return two_sum(ihi, ilo)
end

@inline function fracpart(x::Tuple{T,T}) where {T<:AbstractFloat}
    hi, lo = x
    fhi = modf(hi)[1]
    flo = modf(lo)[1]
    return two_sum(fhi, flo)
end

function intpart(x::DoubleFloat{T}) where {T<:AbstractFloat}
    ihi, ilo = intpart(HILO(x))
    return DoubleFloat(ihi, ilo)
end


function fracpart(x::DoubleFloat{T}) where {T<:AbstractFloat}
    fhi, flo = fracpart(HILO(x))
    return DoubleFloat(fhi, flo)
end

function modf(x::DoubleFloat{T}) where {T<:AbstractFloat}
    hi, lo = HILO(x)
    fhi, ihi = modf(hi)
    flo, ilo = modf(lo)
    ihi, ilo = two_sum(ihi, ilo)
    fhi, flo = two_sum(fhi, flo)
    i = DoubleFloat(ihi, ilo)
    f = DoubleFloat(fhi, flo)
    return f, i
end

function fmod(fpart::DoubleFloat{T}, ipart::DoubleFloat{T}) where {T<:AbstractFloat}
   return ipart + fpart
end

function fmod(parts::Tuple{DoubleFloat{T}, DoubleFloat{T}}) where {T<:AbstractFloat}
   return parts[1] + parts[2]
end
