using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using QHull
using ViewerGL
GL = ViewerGL


V,CV = Lar.cuboidGrid([10,20,1])
GL.VIEW([
      # GL.GLCuboid(Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      GL.GLLar2gl(V,CV)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
