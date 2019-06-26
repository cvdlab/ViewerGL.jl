using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

function randomlines(n=300, t=0.4)
	V = zeros(Float64,2,2*n)
	EV = [zeros(Int64,2) for k=1:n]

	for k=1:n
		v1 = rand(Float64,2)
		v2 = rand(Float64,2)
		vm = (v1+v2)/2
		transl = rand(Float64,2)
		V[:,k] = (v1-vm)*t + transl
		V[:,n+k] = (v2-vm)*t + transl
		EV[k] = [k,n+k]
	end

	V = GL.normalize2(V)
	model = (V,EV)
	Sigma = Lar.spaceindex(model)

	#Plasm.view(V,EV)
	GL.VIEW([ GL.GLLines(V,EV) ]);
	model = V,EV;
	W,EW = Lar.fragmentlines(model);

	#Plasm.viewexploded(W,EW)(1.2,1.2,1.2)
	W,EW = Lar.fragmentlines(model);
	U,EVs = Lar.biconnectedComponent((W,EW::Lar.Cells));
	# 2-connected components (H & T)

	W = convert(Lar.Points, U')
	cop_EV = Lar.coboundary_0(EW::Lar.Cells)
	cop_EW = convert(Lar.ChainOp, cop_EV)
	V, copEV, copFE = Lar.Arrangement.planar_arrangement(W::Lar.Points, cop_EW::Lar.ChainOp)

	triangulated_faces = Lar.triangulate2D(V, [copEV, copFE])
	FVs = convert(Array{Lar.Cells}, triangulated_faces)
	W = convert(Lar.Points, V')
	#Plasm.viewcolor(W::Lar.Points, FVs::Array{Lar.Cells})
	V = convert(Lar.Points, V')
	FV = convert(Lar.Cells, cat(triangulated_faces))
	GL.VIEW([ GL.GLGrid(V,FV) ]);

	model = U,EVs;
	Plasm.view(Plasm.lar_exploded(model)(1.2,1.2,1.2))
end

randomlines(30,2)





"""
	lar_exploded(model)

Generate an exploded `Hpc` value starting from a `LARmodel` instance.
Useful to show the explosion of a 2-complex made by possibly non-convex polygons.

# Example

```
V, copEV, copFE = Lar.planar_arrangement(W::Lar.Points, cop_EW::Lar.ChainOp)
EVs = FV2EVs(copEV, copFE) # polygonal face fragments

Plasm.viewcolor(V::Lar.Points, EVs::Array{Lar.Cells})
model = V,EVs
Plasm.view(lar_exploded(model)(1.2,1.2,1.2))
```
"""
function lar_exploded(model)
	function lar_exploded0( sx=1.2, sy=1.2, sz=1.2 )
		verts,arrayofcells = model
		outVerts, outCells = [],[]
		for cells in arrayofcells
			vcell = convert(Lar.Cells,[collect(Set(cat(cells)))])

			center = sum([verts[:,v] for v in vcell[1]])/length(vcell[1])
			scaled_center = size(center,1)==2 ? center .* [sx,sy] :
												center .* [sx,sy,sz]
			translation_vector = scaled_center - center
			vertcell = [verts[:,k]+translation_vector for k in vcell[1]]
			cellverts = hcat(vertcell...)

			vdict = DataStructures.OrderedDict( zip( vcell[1],
						[k for k=1:length(vcell[1])] ))
			edges = [[vdict[e[1]], vdict[e[2]]] for e in cells]

			append!(outVerts,cellverts)
			append!(outCells,edges)
		end
		return outVerts,outCells
	end
	return lar_exploded0
end
