using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

V,(VV,EV,FV,CV) = Lar.cuboidGrid([100,100,100],true)

GL.VIEW([
    GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1))
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
])

GL.VIEW([
	GL.GLGrid(V,VV,GL.COLORS[4])
	GL.GLGrid(V,EV,GL.COLORS[2])
	GL.GLGrid(V,FV,GL.Point4d(0,1,0,0.1))
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
])

# visualization of a simplicial 3-complex (CV are all tetrahedra)
V,CV = Lar.simplexGrid([4,4,4])
FV = Lar.simplexFacets(CV)
GL.VIEW([
	GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1))
])



function simplexBoundary_3(CV,FV)
	K_2 = Lar.characteristicMatrix(FV)
	K_3 = Lar.characteristicMatrix(CV
	function sparsetranspose(S::SparseMatrixCSC{Int8,Int64}
				)::SparseMatrixCSC{Int8,Int64}
		I,J,V = SparseArrays.findnz(S)
		return SparseArrays.sparse(J,I,V)
	end
	FC = K_2 * sparsetranspose(K_3)
	I,J,Vs = SparseArrays.findnz(FC)
	triples = hcat([[I[k],J[k],1] for k=1:length(Vs) if Vs[k]==3]...)
	simplBoundary_3 =
		SparseArrays.sparse(triples[1,:],triples[2,:],triples[3,:])

	chain_3 = ones(Int,length(CV))
	incidence_numbers = simplBoundary_3 * chain_3
	chain_2 = [k for k=1:length(incidence_numbers) if incidence_numbers[k]==1]
	return boundary_triangles = FV[chain_2]
return

# visualization of a simplicial 2-complex (TV are all triangles)
V,CV = Lar.simplexGrid([4,4,4])
FV = Lar.simplexFacets(CV)
TV = simplexBoundary_3(CV,FV)

GL.VIEW([
	GL.GLGrid(V,TV,GL.Point4d(1,1,1,0.1))
])
