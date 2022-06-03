module PSREncodings

export UTF8, ISO_8859_1, ISO_LATIN_1
export encode, decode
export EncodingError, DecodingError

include("types.jl")
include("error.jl")
include("tables.jl")
include("encode.jl")
include("decode.jl")

end # module
