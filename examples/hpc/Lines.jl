using ViewerGL
GL = ViewerGL

function GLLines(points::Lar.Points,lines::Lar.Cells)
      points = convert(Lar.Points, points')
      vertices=Vector{Float32}()
      normals =Vector{Float32}()
      for line in lines
            p2,p1 = points[line[1],:], points[line[2],:]
            t=p2-p1;  n=LinearAlgebra.normalize([-t[2];+t[1]])

            p1 = convert(GL.Point3d, [p1; 0.0])
            p2 = convert(GL.Point3d, [p2; 0.0])
            n  = convert(GL.Point3d, [ n; 0.0])

            append!(vertices,p1); append!(normals,n)
            append!(vertices,p2); append!(normals,n)
      end
      ret=GL.GLMesh(GL.GL_LINES)
      ret.vertices = GL.GLVertexBuffer(vertices)
      ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end




points,lines = GL.text("PLaSM")
GL.VIEW([
      GLLines(points,lines)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
