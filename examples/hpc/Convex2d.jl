using QHull
using LinearAlgebra
using Revise
using ViewerGL
GL = ViewerGL


points = rand(50,2)
GL.VIEW([
	  GL.GLHull2d(points)
	  GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
