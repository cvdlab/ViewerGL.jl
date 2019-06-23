using ViewerGL
GL = ViewerGL


points,lines = GL.text("PLaSM",false)
#points = Plasm.normalize(points)
GL.VIEW([
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
      GL.GLLines(points,lines)
])
