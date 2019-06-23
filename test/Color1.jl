
"""

# Example

```

```
"""
function GLPolyhedron(V::Lar.Points,
	EV::Lar.ChainOp,FE::Lar.ChainOp,CF::Lar.ChainOp)
	# TODO
end



"""

# Example

```

```
"""
function GLColoring(V::Lar.Points, FV::Lar.Cells, colors::GLColors) # single 3-cell

	# mesh building

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



        vertices,normals = GL.lar4mesh(points,triangles)

        ret=GL.GLMesh(GL.GL_TRIANGLES)
        ret.vertices = GL.GLVertexBuffer(vertices)
		ret.normals  = GL.GLVertexBuffer(normals)
		ret.colors  = GL.GLVertexBuffer(colors)
        return ret
end
