using ViewerGL
GL = ViewerGL

points = rand(50,3)
GL.VIEW([
      GL.GLPoints(points),
      GL.GLHull(points,GL.Point4d(1,1,1,0.2)),
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
]);
