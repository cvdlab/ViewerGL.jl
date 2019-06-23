using ViewerGL
GL = ViewerGL


points = rand(1000,2)
GL.VIEW([
  GL.GLPoints(points)
  GL.GLHull2d(points)
  GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
