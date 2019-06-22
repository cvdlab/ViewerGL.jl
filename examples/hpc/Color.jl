


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
        vertices,normals = GL.lar4mesh(points,triangles)
        ret=GL.GLMesh(GL.GL_TRIANGLES)
        ret.vertices = GL.GLVertexBuffer(vertices)
        ret.normals  = GL.GLVertexBuffer(normals)
        return ret
end
