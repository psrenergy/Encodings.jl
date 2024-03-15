using Test
using Encodings

text = "Café com pão"
data = UInt8[0x43, 0x61, 0x66, 0xe9, 0x20, 0x63, 0x6f, 0x6d, 0x20, 0x70, 0xe3, 0x6f]

@testset "Encoding :: ISO-LATIN-1" begin 
    @test encode(text, Encodings.ISO_LATIN_1()) == data
end

@testset "Decoding :: ISO-LATIN-1" begin
    @test decode(data, Encodings.ISO_LATIN_1()) == text
end

text = "The Lorentz factor γ"
data = UInt8[0x54, 0x68, 0x65, 0x20, 0x4c, 0x6f, 0x72, 0x65, 0x6e, 0x74, 0x7a, 0x20, 0x66, 0x61, 0x63, 0x74, 0x6f, 0x72, 0x20, 0x3f]

@testset "Encoding Error + Fallback :: ISO-LATIN-1" begin
    @test_throws EncodingError encode(text, Encodings.ISO_LATIN_1())
    @test encode(text, Encodings.ISO_LATIN_1(), UInt8('?')) == data
end

text = "xyz?"
data = UInt8[0x78, 0x79, 0x7a, 0x80]

@testset "Decoding Error + Fallback :: ISO-LATIN-1" begin
    @test_throws DecodingError decode(data, Encodings.ISO_LATIN_1())
    @test decode(data, Encodings.ISO_LATIN_1(), Char(0x3f)) == text
end