using QHull
using ViewerGL
GL = ViewerGL

points = rand(50,3)
GL.VIEW([
      GL.GLHull(points)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
