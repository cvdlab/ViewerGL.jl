using ViewerGL
GL = ViewerGL


points = rand(1000,2)
GL.VIEW([
  GL.GLHull2d(points),
  GL.GLPoints(points),
  GL.GLFrame2
]);
