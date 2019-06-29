using ViewerGL
GL = ViewerGL

points = rand(1000,3)
GL.VIEW([
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
      GL.GLPoints(points)
])
