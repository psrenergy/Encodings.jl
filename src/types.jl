abstract type Encoding end

struct UTF8 <: Encoding end
struct ISO_8859_1 <: Encoding end

# -*- Alias -*-
const ISO_LATIN_1 = ISO_8859_1