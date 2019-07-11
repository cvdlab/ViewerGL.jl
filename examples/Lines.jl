using ViewerGL
GL = ViewerGL


points,lines = GL.text("PLaSM",false)
GL.VIEW([
      GL.GLFrame2
      GL.GLLines(points,lines)
]);
