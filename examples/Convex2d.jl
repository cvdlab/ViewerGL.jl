using ViewerGL
GL = ViewerGL

points = rand(100,2)
GL.VIEW([
  GL.GLHull2d(points),
  GL.GLPoints(points),
  GL.GLFrame2
]);
