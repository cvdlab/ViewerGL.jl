using ViewerGL
GL = ViewerGL


points = rand(1000,2)
GL.VIEW([
  GL.GLPoints(points)
  GL.GLHull2d(points)
  GL.GLFrame2
]);
