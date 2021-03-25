using StaticArrays
using ViewerGL
GL = ViewerGL

const rgb = [77 202 137;
       130 70 88;
       198 180 71;
       133 185 98;
       175 115 69;
       227 184 128;
       144 121 86;
       203 107 113;
       231 157 134;
       146 230 136;
       79 153 125;
       187 154 38]

const RGBMaya = [[rgb[k,:]' 255]./ 255 for k=1:12]
const MayaColors = GL.Point4d.(RGBMaya)

"""
Palette of twelve predefined colors
"""
const WHITE   = Point4d([1.0, 1.0, 1.0, 1.0])
const RED     = Point4d([1.0, 0.0, 0.0, 1.0])
const GREEN   = Point4d([0.0, 1.0, 0.0, 1.0])
const BLUE    = Point4d([0.0, 0.0, 1.0, 1.0])
const CYAN    = Point4d([0.0, 1.0, 1.0, 1.0])
const MAGENTA = Point4d([1.0, 0.0, 1.0, 1.0])
const YELLOW  = Point4d([1.0, 1.0, 0.0, 1.0])
const ORANGE  = Point4d([1.0, 0.65, 1.0, 1.0])
const PURPLE  = Point4d([0.5, 0.0, 0.5, 1.0])
const BROWN   = Point4d([0.65, 0.16, 0.16, 1.0])
const GRAY    = Point4d([0.5, 0.5, 0.5, 1.0])
const BLACK   = Point4d([0.0, 0.0, 0.0, 1.0])

const palette = Dict(1=>WHITE, 2=>RED, 3=>GREEN, 4=>BLUE,
        5=>CYAN, 6=>MAGENTA, 7=>YELLOW, 8=>ORANGE,
        9=>PURPLE, 10=>BROWN, 11=>GRAY, 12=>BLACK )

const COLORS = palette
#const COLORS = MayaColors

"""
	mutable struct GLColor

"""
mutable struct GLColor

    choice::Int   # to select between per_body, per_cell, and per_vertex

    color_per_body::Vector{Point4d}
    color_per_cell::Vector{Point4d}
    color_per_vertex::Vector{Point4d}

    colors::GL.GLVertexBuffer

    # constructor
    GLColor() = GLColor(1,COLORS[1],Point4d[],Point4d[],Point4d[],Point4d[])

    # constructor
    GLColor(choice) = GLColor(choice,COLORS[1],Point4d[],Point4d[],Point4d[],Point4d[])

    # constructor
    function GLColor(choice,color_per_body,color_per_cell,color_per_vertex,colors)
        ret = new(choice,color_per_body,color_per_cell,color_per_vertex,colors)
        return ret
    end

end
