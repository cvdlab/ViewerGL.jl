using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

V,(VV,EV,FV,CV) = Lar.cuboidGrid([10,10,5],true)

GL.VIEW([
    GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1))
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
]);

GL.VIEW([
	GL.GLGrid(V,VV,GL.COLORS[4])
	GL.GLGrid(V,EV,GL.COLORS[2])
	GL.GLGrid(V,FV,GL.Point4d(0,1,0,0.1))
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
]);

# visualization of a simplicial 3-complex (CV are all tetrahedra)
V,CV = Lar.simplexGrid([4,4,4])
FV = Lar.simplexFacets(CV)
GL.VIEW([
	GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1))
	GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
]);

# visualization of a simplicial 2-complex (TV are all triangles)
V,CV = Lar.simplexGrid([4,4,4])
FV = Lar.simplexFacets(CV)
TV = Lar.simplexBoundary_3(CV,FV)
EV = Lar.simplexFacets(TV)

GL.VIEW([
	GL.GLGrid(V,TV,GL.Point4d(1,1,1,0.1))
	GL.GLGrid(V,EV,GL.Point4d(1,1,1,0.25))
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
]);
