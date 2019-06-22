


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
function GLColoring(V::Lar.Points, FV::Lar.Cells) # single 3-cell
	color = GL.GLColor()

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
