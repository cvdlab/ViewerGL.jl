using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL


"""
	lar4mesh(points,faces)

Transform a LAR model (verts, cells) in a GLMesh

# Example

```
julia> using LinearAlgebraicRepresentation

julia> Lar = LinearAlgebraicRepresentation
LinearAlgebraicRepresentation

julia> V,FV = Lar.simplexGrid([2,2])
([0.0 1.0 … 1.0 2.0; 0.0 0.0 … 2.0 2.0],
Array{Int64,1}[[1, 2, 4], [2, 4, 5], [2, 3, 5], [3, 5, 6], [4, 5, 7], [5, 7, 8], [5, 6, 8], [6, 8, 9]])

julia> vertices,normals = GL.lar4mesh(GL.two2three(V'),FV);
(Float32[0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0  …  0.0, 4.0, 4.0, 0.0, 3.0, 4.0, 0.0, 4.0, 3.0, 0.0],
Float32[0.0, 0.0, -0.5, 0.0, 0.0, -0.5, 0.0, 0.0, -0.5, 0.0  …  -0.5, 0.0, 0.0, 0.5, 0.0, 0.0, 0.5, 0.0, 0.0, 0.5])
```
"""
function lar4mesh(verts,cells) # cells are triangles
	vertices=Vector{Float32}()
	normals =Vector{Float32}()
	for cell in cells
		p3,p2,p1 = verts[cell[1],:],verts[cell[2],:],verts[cell[3],:]
		p1 = convert(Point3d, p1)
		p2 = convert(Point3d, p2)
		p3 = convert(Point3d, p3)
		n=0.5*computeNormal(p1::Point3d,p2::Point3d,p3::Point3d)

		append!(vertices,p1); append!(normals,n)
		append!(vertices,p2); append!(normals,n)
		append!(vertices,p3); append!(normals,n)
	end
	return vertices,normals
end



"""
	two2three(points)

Transform a ``n×2`` `Array{Float64,2}` of 2D points to an ``nx3`` array of 3D points, adding a column of zeros.
# Example
```
julia> V
2×9 Array{Float64,2}:
 0.0  1.0  2.0  0.0  1.0  2.0  0.0  1.0  2.0
 0.0  0.0  0.0  1.0  1.0  1.0  2.0  2.0  2.0

 julia> GL.two2three(V')
 9×3 Array{Float64,2}:
  0.0  0.0  0.0
  1.0  0.0  0.0
  2.0  0.0  0.0
  0.0  1.0  0.0
  1.0  1.0  0.0
  2.0  1.0  0.0
  0.0  2.0  0.0
  1.0  2.0  0.0
  2.0  2.0  0.0
```
"""
function two2three(points)
      return [points zeros(Float64,size(points,1),1)]
end




"""
	glGenBuffer()

Return 1 buffer object name.
"""
function glGenBuffer()
	id = GLuint[0]
	glGenBuffers(1, id)
	glCheckError("generating a buffer, array, or texture")
	id[]
end



"""
	glGenVertexArray()

Specifies the number (one) of vertex array object names to generate.
"""
function glGenVertexArray()
	id = GLuint[0]
	glGenVertexArrays(1, id)
	glCheckError("generating a buffer, array, or texture")
	id[]
end


"""
	glLineWidth()

Define the width of the line primitive
"""
function glLineWidth()
	width = convert(UInt32, 2)
	ModernGL.glLineWidth(width)
end


"""
	glPointSize()

Define the size of the point primitive
"""
function glPointSize()
	size = convert(UInt32, 8) # multiples of 2 give sprites!!
	ModernGL.glPointSize(size)
end


"""
	glCheckError(actionName="")

`glGetError` returns the value of the error flag. Each detectable error is assigned a numeric code and symbolic name. When an error occurs, the error flag is set to the appropriate error code value.
"""
function glCheckError(actionName="")
	message = glErrorMessage()
	if length(message) > 0
		if length(actionName) > 0
		error("Error ", actionName, ": ", message)
		else
		error("Error: ", message)
		end
	end
end



"""
	glErrorMessage()

Error message management.
"""
function glErrorMessage()
	err = glGetError()
	if err == GL_NO_ERROR return "" end
	if err == GL_INVALID_ENUM return "GL_INVALID_ENUM" end
	if err == GL_INVALID_VALUE return "GL_INVALID_VALUE"  end
	if err == GL_INVALID_OPERATION return "GL_INVALID_OPERATION"  end
	if err == GL_INVALID_FRAMEBUFFER_OPERATION return "GL_INVALID_FRAMEBUFFER_OPERATION"  end
	if err == GL_OUT_OF_MEMORY return "GL_OUT_OF_MEMORY" end
	return "Unknown OpenGL error with error code"
end


const __release_gpu_resources__=[]


"""
	glDeleteLater(fun::Function)
"""
function glDeleteLater(fun::Function)
	global __release_gpu_resources__
	append!(__release_gpu_resources__,[fun])
end


"""
	glDeleteNow()
"""
function glDeleteNow()
	global __release_gpu_resources__
	for fun in __release_gpu_resources__
		fun()
	end
end



"""
	normalize2(V::Lar.Points; flag=true::Bool)::Lar.Points

2D normalization transformation (isomorphic by defaults) of model
vertices to normalized coordinates ``[0,1]^2``. Used with SVG importing.
"""
function normalize2(V::Lar.Points; flag=true, fold=-1)
	m,n = size(V)
	if m > n # V by rows
		V = convert(Lar.Points, V')
	end

	xmin = minimum(V[1,:]); ymin = minimum(V[2,:]);
	xmax = maximum(V[1,:]); ymax = maximum(V[2,:]);
	box = [[xmin; ymin] [xmax; ymax]]	# containment box
	aspectratio = (xmax-xmin)/(ymax-ymin)
	if flag
		if aspectratio > 1
			umin = 0; umax = 1
			vmin = 0; vmax = 1/aspectratio; ty = vmax
		elseif aspectratio < 1
			umin = 0; umax = aspectratio
			vmin = 0; vmax = 1; ty = vmax
		end
		T = fold==-1 ? Lar.t(0,ty) : Lar.t(0,0) *
		 	Lar.s(1,fold) * Lar.s((umax-umin), (vmax-vmin)) *
			Lar.s(1/(xmax-xmin),1/(ymax-ymin)) * Lar.t(-xmin,-ymin)
	else
		T = Lar.t(0, ymax-ymin) * Lar.s(1,-1)
	end
	dim = size(V,1)
	W = T[1:dim,:] * [V;ones(1,size(V,2))]
	#V = map( x->round(x,digits=8), W )
	V = map(Lar.approxVal(8), W)

	if m > n # V by rows
		V = convert(Lar.Points, V')
	end
	return V
end


function normalize3(V::Lar.Points, flag=true)
	Vxy = normalize2(V[1:2,:], flag=flag, fold=1)
	if size(V,1) == 3
		zmin = minimum(V[3,:]); zmax = maximum(V[3,:]);
		Vz = (V[3,:] .- zmin) / (zmax - zmin)
	elseif size(V,1) == 2
		Vz = zeros(1,size(V,2))
	end
	return [Vxy; Vz]
end



function explodecells(V,FVs,sx=1.2,sy=1.2,sz=1.2)
	V,FVs
	outVerts, outCells = [],[]
	grids = []
	for FV in FVs
		vertidx = sort(collect(Set(cat(FV))))
		vcell = V[:,vertidx]
		vdict = Dict(zip(vertidx,1:length(vertidx)))

		center = sum(vcell,dims=2)/size(vcell,2)
		scaled_center = size(center,1)==2 ? center .* [sx;sy] : center .* [sx;sy;sz]
		translation_vector = scaled_center - center
		cellverts = vcell .+ translation_vector
		newcells = [[vdict[v] for v in cell] for cell in FV]

		mesh = cellverts, newcells
		push!(grids, mesh)
	end
	return grids
end
