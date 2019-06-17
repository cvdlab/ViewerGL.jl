using QHull
using LinearAlgebra
using Revise
using ViewerGL
GL = ViewerGL
using Plasm, QHull

# ////////////////////////////////////////////////////////////////////////
function GLHull2d(points::Array{Float64,2})

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


points = rand(50,2)
GL.VIEW([
      # GL.GLCuboid(Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      GLHull2d(points)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
