using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using QHull
using Revise
using ViewerGL
GL = ViewerGL

const M44 = convert(GL.Matrix4, Matrix{Float64}(I,4,4))

"""
	GLHull(points::Array{Float64,2})::GL.GLMesh

To generate the `GL.mesh` of the ``convex hull`` of an array of `points`.
# Example
```
points = rand(50,3)
GL.VIEW([
      GLHull(points)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
```
"""
function GLHull(points::Array{Float64,2})::GL.GLMesh
	#data preparation
	ch = QHull.chull(points)
	verts = ch.vertices
	vdict = Dict(zip(verts, 1:length(verts)))
	trias = [[vdict[u],vdict[v],vdict[w]] for (u,v,w) in ch.simplices]
	points = points[verts,:]
	# mesh building
	vertices,normals = GL.lar4mesh(points,trias)
	ret=GL.GLMesh(GL.GL_TRIANGLES)
	ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	return ret
end



"""
	GLHull2d(points::Array{Float64,2})::GL.GLMesh

To generate the `GL.mesh` of the 1D polygonal ``convex hull`` of an array of 2D `points`.
# Example

```
points = rand(50,2)
GL.VIEW([
	  GL.GLHull2d(points)
	  GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
```
"""
function GLHull2d(points::Array{Float64,2})::GL.GLMesh # points by row

	ch = QHull.chull(points)
	verts = ch.vertices
	vdict = Dict(zip(verts, 1:length(verts)))
	edges = [[vdict[u],vdict[v]] for (u,v) in ch.simplices]
	points = points[verts,:]
	faces = edges

	vertices=Vector{Float32}()
	normals =Vector{Float32}()
	for face in faces
		p2,p1=points[face[1],:],points[face[2],:]
		t=p2-p1;  n=LinearAlgebra.normalize([-t[2];+t[1]])

		p1 = convert(GL.Point3d, [p1; 0.0])
		p2 = convert(GL.Point3d, [p2; 0.0])
		n  = convert(GL.Point3d, [ n; 0.0])

		append!(vertices,p1); append!(normals,n)
		append!(vertices,p2); append!(normals,n)
	end

	ret=GL.GLMesh(GL.GL_LINES)
	ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	return ret
end



"""
      GLPolygon(V::Lar.Points,EV::Lar.ChainOp,FE::Lar.ChainOp)::GL.GLMesh

Generate the `GL.GLMesh` ``mesh`` to visualize a ``2D polygon``.

The input polygon is very general, according to the ``Lar`` scheme: it may be non-connected, and may contain multiple holes, i.e. may be non-contractible.

# Example

```
V = hcat([[0,0],[1,0],[1,1],[0,1],[.25,.25],[.75,.25],[.75,.75],[.25,.75]]...)
EV = [[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,5]]
```
"""
function GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp)::GL.GLMesh
      # triangulation
      W = convert(Lar.Points, V')
      EV = Lar.cop2lar(copEV)
      trias = Lar.triangulate2d(W,EV)
      # mesh building
      vertices,normals = GL.lar4mesh(V,trias)
      ret=GL.GLMesh(GL.GL_TRIANGLES)
      ret.vertices = GL.GLVertexBuffer(vertices)
      ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end

"""
      GLPolygon(V::Lar.Points,EV::Lar.Cells)::GL.GLMesh

Generate the `GL.GLMesh` ``mesh`` to visualize a ``2D polygon``.

The input polygon is very general, according to the ``Lar`` scheme: it may be non-connected, and may contain multiple holes, i.e. may be non-contractible.

# Example

```
V = hcat([[0,0],[1,0],[1,1],[0,1],[.25,.25],[.75,.25],[.75,.75],[.25,.75]]...)
EV = [[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,5]]

GL.VIEW([
      GL.GLPolygon(V,EV)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
```
"""
function GLPolygon(V::Lar.Points,EV::Lar.Cells)::GL.GLMesh
      W = convert(Lar.Points, V')
      cop_EV = Lar.coboundary_0(EV::Lar.Cells)
      cop_EW = convert(Lar.ChainOp, cop_EV)
      V, copEV, copFE = Lar.Arrangement.planar_arrangement(
            W::Lar.Points, cop_EW::Lar.ChainOp)
	  if size(V,2)==2
		  V = GL.two2three(V)
	  elseif size(V,2)==3
		  V=V
	  else error("bad coordinates: $V =")
	  end
      return GLPolygon(V, copEV, copFE)
end



"""
	GLLar2gl(V::Array{Float64,2}, CV::Array{Array{Int64,1},1})

Generate the `GL.GLMesh` ``mesh`` to visualize a ``Lar.LAR`` model.

# Example
```
V,CV = Lar.cuboidGrid([10,20,1])
GL.VIEW([
      GL.GLLar2gl(V,CV)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
```
"""
function GLLar2gl(V::Lar.Points, CV::Lar.Cells)::GL.GLMesh
	points = convert(Array{Float64,2},V') # points by rows
	vertices=Vector{Float32}()
	normals =Vector{Float32}()

	dim = size(points,2)

	for cell in CV
		ch = QHull.chull(points[cell,:])
		verts = ch.vertices
		trias = ch.simplices
		vdict = Dict(zip(verts, 1:length(verts)))
		fdict = Dict(zip(1:length(cell), cell))
		faces = [[vdict[u],vdict[v],vdict[w]] for (u,v,w) in trias]
		triangles = [[fdict[v1],fdict[v2],fdict[v3]] for (v1,v2,v3) in faces]

		cellverts,cellnorms = GL.lar4mesh(points,triangles)
		append!(vertices,cellverts)
		append!(normals,cellnorms)
	end

	ret=GL.GLMesh(GL.GL_TRIANGLES)
	ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	return ret
end

"""
	GLLines(points::Lar.Points,lines::Lar.Cells)::GLMesh
# Example
```
julia> (points, lines) = GL.text("PLaSM");

julia> mesh = GL.GLLines(points::Lar.Points,lines::Lar.Cells);

julia> mesh
```
"""
function GLLines(points::Lar.Points,lines::Lar.Cells)::
      points = convert(Lar.Points, points')
      vertices=Vector{Float32}()
      #normals =Vector{Float32}()
	  if size(points,2) == 2
		  points = [points zeros(size(points,1),1)]
	  end
      for line in lines
            p2,p1 = points[line[1],:], points[line[2],:]
            t=p2-p1;  n=LinearAlgebra.normalize([-t[2];+t[1];t[3]])

            p1 = convert(GL.Point3d, p1)
            p2 = convert(GL.Point3d, p2)
            n  = convert(GL.Point3d,  n)

            append!(vertices,p1); #append!(normals,n)
            append!(vertices,p2); #append!(normals,n)
      end
      ret=GL.GLMesh(GL.GL_LINES)
      ret.vertices = GL.GLVertexBuffer(vertices)
      #ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end

"""
	GLText(string)::GLMesh

Transform a string into a mesh of lines.
To display as graphical text.
# Example
```
julia> GL.text("Plasm")
([0.0 0.0 … 0.833333 0.833333; 0.0 0.25 … 0.0 0.125; 0.0 0.0 … 0.0 0.0], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]
, [6, 7], [8, 9], [9, 10], [11, 12], [13, 14]  …  [25, 26], [26, 27], [27, 28], [28, 29], [29, 30], [31, 32], [32, 33], [34, 3
5], [35, 36], [37, 38]])

julia> GL.GLText("Plasm")
ViewerGL.GLMesh(1, [1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0], ViewerGL.GLVertexArray(-1), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 0.125, 0.25, 0.0, 0.0  …  0.0, 0.916667, 0.125, 0.0, 0.833333, 0.125, 0.0, 0.833333, 0.0, 0.0]), ViewerGL.GLVertexBuffer(-1, Float32[]), ViewerGL.GLVertexBuffer(-1, Float32[]))
```
"""
function GLText(string)
	GL.GLLines(GL.text(string)...)
end

"""
	GLText(string)::GLMesh

Transform a string into a mesh of lines.
To display as graphical text.
# Example
```
julia> GL.text("Plasm")
([0.0 0.0 … 0.833333 0.833333; 0.0 0.25 … 0.0 0.125; 0.0 0.0 … 0.0 0.0], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]
, [6, 7], [8, 9], [9, 10], [11, 12], [13, 14]  …  [25, 26], [26, 27], [27, 28], [28, 29], [29, 30], [31, 32], [32, 33], [34, 3
5], [35, 36], [37, 38]])

julia> GL.GLText("Plasm")
ViewerGL.GLMesh(1, [1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0], ViewerGL.GLVertexArray(-1), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 0.125, 0.25, 0.0, 0.0  …  0.0, 0.916667, 0.125, 0.0, 0.833333, 0.125, 0.0, 0.833333, 0.0, 0.0]), ViewerGL.GLVertexBuffer(-1, Float32[]), ViewerGL.GLVertexBuffer(-1, Float32[]))
```
"""
function GLPoints(points::Lar.Points)::GL.GLMesh # points by row
      #points = convert(Lar.Points, points')
	  if size(points,2) == 2
		  points = [points zeros(size(points,1),1)]
	  end
      vertices=Vector{Float32}()
      #normals =Vector{Float32}()
      for k=1:size(points,1)
		point = convert(GL.Point3d,points[k,:])
        append!(vertices,convert(GL.Point3d,point)); #append!(normals,n)
      end
      ret=GL.GLMesh(GL.GL_POINTS)
      ret.vertices = GL.GLVertexBuffer(vertices)
      #ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end



"""
# Example
```
```
"""
function GLPolyhedron(V::Lar.Points, FV::Lar.Cells, T::GL.Matrix4=M44)
	# data preparation
	function mycat(a::Lar.Cells)
		out=[]
		for cell in a append!(out,cell) end
		return out
	end
	vindexes = sort(collect(Set(mycat(FV))))
	W = V[:,vindexes]
	vdict = Dict(zip(vindexes,1:length(vindexes)))
	triangles = [[vdict[u],vdict[v],vdict[w]] for (u,v,w) in FV]
	points = (M44 * [W; ones(1,size(W,2))])[1:3,:]
	points = convert(Lar.Points, points') # points by row

	# mesh building
        vertices,normals = GL.lar4mesh(points,triangles)
        ret=GL.GLMesh(GL.GL_TRIANGLES)
        ret.vertices = GL.GLVertexBuffer(vertices)
        ret.normals  = GL.GLVertexBuffer(normals)
        return ret
end


"""
# Example
```
```
"""
function GLPolyhedron(V::Lar.Points,
	EV::Lar.ChainOp,FE::Lar.ChainOp,CF::Lar.ChainOp)
	# TODO
end




function GLGrid(V::Lar.Points,CV::Lar.Cells,color=GL.COLORS[1])
	# test if all cells have same length
	ls = map(length,CV)
	@assert( (&)(map((==)(ls[1]),ls)...) == true )

	n = size(V,1)  # space dimension
	points = GL.embed(3-n)((V,CV))[1]
	cells = CV
	len = length(cells[1])  # cell dimension

	c  = convert(GL.Point4d, color)

	vertices= Vector{Float32}()
	normals = Vector{Float32}()
	colors  = Vector{Float32}()

      if len==1   # zero-dimensional grids
		ret=GL.GLMesh(GL.GL_POINTS)
		for k=1:size(points,2)
			p1 = convert(GL.Point3d, points[:,k])
			append!(vertices,p1); #append!(normals,n)
			append!(colors,c); #append!(normals,n)
		end
      elseif len==2   # one-dimensional grids
		ret=GL.GLMesh(GL.GL_LINES)
		for k=1:length(cells)
			p1,p2=cells[k]
			p1 = convert(GL.Point3d, points[:,p1]);
			p2 = convert(GL.Point3d, points[:,p2])
			t = p2-p1;
			n = LinearAlgebra.normalize([-t[2];+t[1];t[3]])
			#n  = convert(GL.Point3d, n)
			append!(vertices,p1); append!(vertices,p2);
			append!(normals,n);   append!(normals,n);
			append!(colors,c);    append!(colors,c);
		end
      elseif len==3 # triangle grids
		vertices=Vector{Float32}()
		normals =Vector{Float32}()
		colors =Vector{Float32}()
		ret=GL.GLMesh(GL.GL_TRIANGLES)
		for k=1:length(cells)
			p1,p2,p3=cells[k]
			p1 = convert(GL.Point3d, points[:,p1]);
			p2 = convert(GL.Point3d, points[:,p2])
			p3 = convert(GL.Point3d, points[:,p3])
			n = 0.5*GL.computeNormal(p1,p2,p3)
			append!(vertices,p1); append!(vertices,p2); append!(vertices,p3);
			append!(normals,n);   append!(normals,n);   append!(normals,n);
			append!(colors,c);    append!(colors,c);    append!(colors,c);
		end
      elseif len==4  # quad grids
		vertices=Vector{Float32}()
		normals =Vector{Float32}()
		colors =Vector{Float32}()
		ret=GL.GLMesh(GL.GL_QUADS)
		for k=1:length(cells)
			p1,p2,p3,p4=cells[k]
			p1 = convert(GL.Point3d, points[:,p1]);
			p2 = convert(GL.Point3d, points[:,p2])
			p3 = convert(GL.Point3d, points[:,p3])
			p4 = convert(GL.Point3d, points[:,p4])
			n = 0.5*GL.computeNormal(p1,p2,p3)
			append!(vertices,p1); append!(vertices,p2); append!(vertices,p4); append!(vertices,p3);
			append!(normals,n);   append!(normals,n);   append!(normals,n);   append!(normals,n);
			append!(colors,c);    append!(colors,c);    append!(colors,c);    append!(colors,c);
		end
      else # dim > 3
            error("cannot visualize dim > 3")
      end
      ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	ret.colors  = GL.GLVertexBuffer(colors)
    return ret
end
