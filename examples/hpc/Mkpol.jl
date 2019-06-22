using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

V,(VV,EV,FV,CV) = Lar.cuboidGrid([10,20,1],true)

GL.VIEW([
      GL.GLLar2gl(V,CV)
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
])

GL.VIEW([
	GL.GLGrid(V,VV,GL.COLORS[4])
	GL.GLGrid(V,EV,GL.COLORS[2])
	GL.GLGrid(V,FV,GL.COLORS[3])
	GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
])
