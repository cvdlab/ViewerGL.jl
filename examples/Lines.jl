using ViewerGL
GL = ViewerGL

points,lines = GL.text("PLaSM")
GL.VIEW([
      GL.GLFrame2
      GL.GLLines(points,lines)
]);
