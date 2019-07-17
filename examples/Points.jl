using ViewerGL
GL = ViewerGL

points = rand(1000,3)
GL.VIEW([
      GL.GLFrame,
      GL.GLPoints(points)
]);

points = rand(1000,2)
GL.VIEW([
      GL.GLFrame2,
      GL.GLPoints(points)
]);
