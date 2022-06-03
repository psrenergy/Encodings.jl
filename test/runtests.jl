using Test
using PSREncodings

text = "Café com pão"
data = UInt8[0x43, 0x61, 0x66, 0xe0, 0x20, 0x63, 0x6f, 0x6d, 0x20, 0x70, 0xe3, 0x6f]

@testset "Encoding - ISO-LATIN-1" begin 
    @test encode(text, PSREncodings.ISO_LATIN_1()) == data
end

@testset "Decoding - ISO-LATIN-1" begin
    @test decode(data, PSREncodings.ISO_LATIN_1()) == text
end