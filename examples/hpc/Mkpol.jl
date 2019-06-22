using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using QHull
using ViewerGL
GL = ViewerGL


V,(VV,EV,FV,CV) = Lar.cuboidGrid([10,20,1],true)
GL.VIEW([
      # GL.GLCuboid(Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      GL.GLLar2gl(V,CV)
      GL.GLAxis(GL.Point3d(-1,-1,-1),GL.Point3d(1,1,1))
])


function GLGrid(V::Lar.Points,CV::Lar.Cells)
      # all cells have same length
      ls = map(length,CV)
      @assert( (&)(map((==)(ls[1]),ls)...) == true )

      dim = size(V,1)
      if dim==1   # one-dimensional grids
            points   = GL.embed(1)((V,CV))
            vertices,normals = GL.lar4mesh(points,CV)
            ret=GL.GLMesh(GL.GL_LINES)
      elseif dim==2     # one-, two-dimensional grids

      elseif dim==3     # one-, two-, three-imensional grids

      else # dim > 3
            error("cannot visualize dim > 3")
      end
      ret.vertices = GL.GLVertexBuffer(vertices)
      ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end
