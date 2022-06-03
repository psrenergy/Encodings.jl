@doc raw"""
"""
function encode end

function encode(s::String, e::Encoding)
    UInt8.(filter(c -> !isnothing(c), [encode(c, e) for c in s]))
end

function encode(s::String, e::Encoding, fallback::Union{UInt8, Nothing})
    UInt8.(filter(c -> !isnothing(c), [encode(c, e, fallback) for c in s]))
end

function encode(c::Char, e::ISO_8859_1)
    if isascii(c)
        c
    elseif haskey(ENCODE_ISO_LATIN_1, c)
        getindex(ENCODE_ISO_LATIN_1, c)
    else
        encoding_error(c, e)
    end
end

function encode(c::Char, ::ISO_8859_1, fallback::Union{UInt8, Nothing})
    if isascii(c)
        c
    else
        get(ENCODE_ISO_LATIN_1, c, fallback)
    end
end