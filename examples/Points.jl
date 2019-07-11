using ViewerGL
GL = ViewerGL

points = rand(1000,3)
GL.VIEW([
      GL.GLFrame,
      GL.GLPoints(points)
]);
