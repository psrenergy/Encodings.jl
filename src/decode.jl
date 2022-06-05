@doc raw"""
"""
function decode end

function decode(s::Vector{UInt8}, e::Encoding)
    String(filter(c -> !isnothing(c), [decode(c, e) for c in s]))
end

function decode(s::Vector{UInt8}, e::Encoding, fallback::Union{Char, Nothing})
    String(filter(c -> !isnothing(c), [decode(c, e, fallback) for c in s]))
end

function decode(c::UInt8, e::ISO_8859_1)
    if c < 0x80
        Char(c)
    elseif haskey(DECODE_ISO_LATIN_1, c)
        getindex(DECODE_ISO_LATIN_1, c)
    else
        decoding_error(c, e)
    end
end

function decode(c::UInt8, ::ISO_8859_1, fallback::Union{Char, Nothing})
    if c < 0x80
        Char(c)
    else
        get(DECODE_ISO_LATIN_1, c, fallback)
    end
end