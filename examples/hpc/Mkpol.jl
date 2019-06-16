using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using QHull
using ViewerGL
GL = ViewerGL

function lar2gl(V::Array{Float64,2}, CV::Array{Array{Int64,1},1})

	points = convert(Array{Float64,2}, V') # points by rows
	vertices=Vector{Float32}()
	normals =Vector{Float32}()
	for cell in CV

		ch = QHull.chull(points[cell,:])
		verts = ch.vertices
		trias = ch.simplices
		vdict = Dict(zip(verts, 1:length(verts)))
		fdict = Dict(zip(1:length(cell), cell))
		faces = [[vdict[u],vdict[v],vdict[w]] for (u,v,w) in trias]
		triangles = [[fdict[v1],fdict[v2],fdict[v3]] for (v1,v2,v3) in faces]
		pts = points[verts,:]

		for tri in triangles
			p3,p2,p1 = points[tri[1],:],points[tri[2],:],points[tri[3],:]
			p1 = convert(GL.Point3d, p1)
			p2 = convert(GL.Point3d, p2)
			p3 = convert(GL.Point3d, p3)
			n=0.5*GL.computeNormal(p1::GL.Point3d,p2::GL.Point3d,p3::GL.Point3d)

			append!(vertices,p1); append!(normals,n)
			append!(vertices,p2); append!(normals,n)
			append!(vertices,p3); append!(normals,n)
		end
	end

	ret=GL.GLMesh(GL.GL_TRIANGLES)
	ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	return ret
end

V,CV = Lar.cuboidGrid([10,20,1])
GL.VIEW([
      # GL.GLCuboid(Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      lar2gl(V,CV)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
