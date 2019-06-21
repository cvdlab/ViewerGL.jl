using ViewerGL
GL = ViewerGL

points = rand(1000,3)
GL.VIEW([
      GL.GLPoints(points)
])
