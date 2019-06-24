using ViewerGL
GL = ViewerGL

GL.VIEW([ GL.GLText("PLaSM"),
          GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1)) ])

# TODO: fix textWithAttributes()
#GL.textWithAttributes("left", pi/4)("PLaSM")
#]
