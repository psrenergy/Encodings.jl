# Encodings

<div align="center">
    <a href="/docs/src/assets/">
        <img src="/docs/src/assets/logo.svg" width=400px alt="Encodings.jl" />
    </a>
    <br>
    <br>
    <a href="https://github.com/psrenergy/Encodings.jl/actions/workflows/ci.yml">
        <img src="https://github.com/psrenergy/Encodings.jl/actions/workflows/ci.yml/badge.svg?branch=master" alt="CI" />
    </a>
    <a href="https://codecov.io/gh/psrenergy/Encodings.jl">
      <img src="https://codecov.io/gh/psrenergy/Encodings.jl/branch/master/graph/badge.svg?token=0P1MVOMZJ0"/>
    </a>
</div>

## Getting Started

### Installation
```julia
julia> ]add https://github.com/psrenergy/Encodings.jl#master
```

### Basic Usage
```julia
julia> using Encodings

julia> data = encode("café com pão", ISO_LATIN_1())
12-element Vector{UInt8}:
 0x63
 0x61
 0x66
 0xe0
 0x20
 0x63
 0x6f
 0x6d
 0x20
 0x70
 0xe3
 0x6f

julia> decode(data, ISO_LATIN_1())
"café com pão"
```

### Encoding/Decoding Error
`Encodings` provides two custom error types: `EncodingError` and `DecodingError`. They are raised when a given encoding doesn't supports some character:
```julia
julia> data = encode("μηχανικός means 'engineer' in greek", ISO_LATIN_1())
ERROR: Char 'μ' not available for encoding 'ISO_8859_1'
Stacktrace:
 [1] encoding_error(c::Char, e::ISO_8859_1)
   @ Encodings ~/.julia/packages/Encodings/9EX17/src/error.jl:24
 [2] encode
   @ ~/.julia/packages/Encodings/9EX17/src/encode.jl:19 [inlined]
 [3] #3
   @ ./none:0 [inlined]
 [4] iterate
   @ ./generator.jl:47 [inlined]
 [5] collect(itr::Base.Generator{String, Encodings.var"#3#5"{ISO_8859_1}})
   @ Base ./array.jl:724
 [6] encode(s::String, e::ISO_8859_1)
   @ Encodings ~/.julia/packages/Encodings/9EX17/src/encode.jl:6
 [7] top-level scope
   @ REPL[9]:1
```

### Encoding/Decoding Fallbacks
Both `encode` and `decode` also dispatch over three-argument calls by adding a `fallback` parameter.

If it is `nothing`, codec failures are silently ignored:
```julia
julia> data = encode("μηχανικός means 'engineer' in greek", ISO_LATIN_1(), nothing)
26-element Vector{UInt8}:
 0x20
 0x6d
 0x65
 0x61
 0x6e
 0x73
    ⋮
 0x20
 0x67
 0x72
 0x65
 0x65
 0x6b

julia> decode(data, ISO_LATIN_1())
" means 'engineer' in greek"
```
If it is a `UInt8` (for encoding) or a `Char` (for decoding), the troubling entry is replaced by the given fallback:
```julia
julia> data = encode("μηχανικός means 'engineer' in greek", ISO_LATIN_1(), UInt8('?'))
35-element Vector{UInt8}:
 0x3f
 0x3f
 0x3f
 0x3f
 0x3f
 0x3f
    ⋮
 0x20
 0x67
 0x72
 0x65
 0x65
 0x6b

julia> decode(data, ISO_LATIN_1())
"????????? means 'engineer' in greek"
```

## Supported Encodings
| Name       | Type                       |
| :--------- | :------------------------- |
| ISO-8859-1 | `ISO_8859_1` `ISO_LATIN_1` |
