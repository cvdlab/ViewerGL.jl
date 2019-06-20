using StaticArrays
using ViewerGL
GL = ViewerGL

"""
Color4 defines a structure which contains 4 floats values, each for red, green, blue and alpha.
"""
const Color3 = MVector{3,Float64}
Color3() = Color4(1.0,1.0,1.0)


"""
Color4 defines a structure which contains 4 floats values, each for red, green, blue and alpha.
"""
const Color4 = MVector{4,Float64}
Color4() = Color4(1.0,1.0,1.0,1.0)

"""
Palette of twelve predefined colors
"""
const WHITE   = Color4([1.0, 1.0, 1.0, 1.0])
const RED	  = Color4([1.0, 0.0, 0.0, 1.0])
const GREEN   = Color4([0.0, 1.0, 0.0, 1.0])
const BLUE	  = Color4([0.0, 0.0, 1.0, 1.0])
const CYAN	  = Color4([0.0, 1.0, 1.0, 1.0])
const MAGENTA = Color4([1.0, 0.0, 1.0, 1.0])
const YELLOW  = Color4([1.0, 1.0, 0.0, 1.0])
const ORANGE  = Color4([1.0, 0.65, 1.0, 1.0])
const PURPLE  = Color4([0.5, 0.0, 0.5, 1.0])
const BROWN   = Color4([0.65, 0.16, 0.16, 1.0])
const GRAY    = Color4([0.5, 0.5, 0.5, 1.0])
const BLACK   = Color4([0.0, 0.0, 0.0, 1.0])

const COLORS = Dict(1=>WHITE, 2=>RED, 3=>GREEN, 4=>BLUE, 5=>CYAN, 6=>MAGENTA, 7=>YELLOW, 8=>ORANGE, 9=>PURPLE, 10=>BROWN, 11=>GRAY, 12=>BLACK )



"""
	mutable struct GLColor

"""
mutable struct GLColor

    choice::Int # to select between per_body, per_cell, and per_vertex

    color_per_body::Vector{Color4}
    color_per_cell::Vector{Color4}
    color_per_vertex::Vector{Color4}

    colors::GL.GLVertexBuffer

    # constructor
    GLColor() = GLColor(1,COLORS[1],Color4[],Color4[],Color4[],Color4[])

    # constructor
    function GLColor(choice,color_per_body,color_per_cell,color_per_vertex,colors)
        ret = new(choice,color_per_body,color_per_cell,color_per_vertex,colors)
        return ret
    end

end
