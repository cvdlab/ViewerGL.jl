using QHull
using Revise
using ViewerGL
GL = ViewerGL

# ////////////////////////////////////////////////////////////////////////
function lar2mesh(points,faces)
	vertices=Vector{Float32}()
	normals =Vector{Float32}()
	for face in faces
		p3,p2,p1 = points[face[1],:],points[face[2],:],points[face[3],:]
		p1 = convert(GL.Point3d, p1)
		p2 = convert(GL.Point3d, p2)
		p3 = convert(GL.Point3d, p3)
		n=0.5*GL.computeNormal(p1::GL.Point3d,p2::GL.Point3d,p3::GL.Point3d)

		append!(vertices,p1); append!(normals,n)
		append!(vertices,p2); append!(normals,n)
		append!(vertices,p3); append!(normals,n)
	end
	return vertices,normals
end

# ////////////////////////////////////////////////////////////////////////
function GLHull(points::Array{Float64,2})
	ch = QHull.chull(points)
	verts = ch.vertices
	vdict = Dict(zip(verts, 1:length(verts)))
	trias = [[vdict[u],vdict[v],vdict[w]] for (u,v,w) in ch.simplices]
	points = points[verts,:]

	vertices,normals = lar2mesh(points,trias)
	ret=GL.GLMesh(GL.GL_TRIANGLES)
	ret.vertices = GL.GLVertexBuffer(vertices)
	ret.normals  = GL.GLVertexBuffer(normals)
	return ret
end


points = rand(50,3)
GL.VIEW([
      # GL.GLCuboid(Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      GLHull(points)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
