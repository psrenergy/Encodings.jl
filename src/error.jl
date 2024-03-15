struct EncodingError <: Exception
    c::Char
    e::Encoding

    function EncodingError(c::Char, e::Encoding)
        new(c, e)
    end
end

struct DecodingError <: Exception
    c::UInt8
    e::Encoding

    function DecodingError(c::UInt8, e::Encoding)
        new(c, e)
    end
end

function Base.showerror(io::IO, e::Union{EncodingError, DecodingError})
    print(io, "Char '$(e.c)' not available for encoding '$(nameof(typeof(e.e)))'")
end

function encoding_error(c::Char, e::Encoding)
    throw(EncodingError(c, e))
end

function decoding_error(c::UInt8, e::Encoding)
    throw(DecodingError(c, e))
end