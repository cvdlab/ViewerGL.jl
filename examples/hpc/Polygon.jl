using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
#using Plasm
using Triangle
using Revise
using ViewerGL
GL = ViewerGL

# ////////////////////////////////////////////////////////////////////////
function GLPolygon(V::Lar.Points,EV::Lar.ChainOp,FE::Lar.ChainOp)
      # triangulation
      W = convert(Lar.Points, V')
      EV = Lar.cop2lar(EV)
      trias = Lar.triangulate2d(W,EV)
      # mesh building
      vertices,normals = GL.lar2mesh(V,trias)
      ret=GL.GLMesh(GL.GL_TRIANGLES)
      ret.vertices = GL.GLVertexBuffer(vertices)
      ret.normals  = GL.GLVertexBuffer(normals)
      return ret
end

# input 2D non-convex and non-contarctible polygon
(V, EV) = ([0.43145 0.596771 0.758062 1.0 0.778226 0.919353 0.879033 0.806447 0.778226 0.709677 0.596771 0.262094 0.322578 0.0 0.2379 0.161291 0.467739 0.429435 0.627999 0.627999 0.383062 0.694833 0.653221 0.544027 0.778226 0.848789 0.750707 0.627999 0.694833 0.806447; 0.0 0.233873 0.11694 0.330646 0.625 0.677418 0.810484 0.717742 0.834675 0.743951 0.983871 0.810484 0.625 0.388696 0.439515 0.25403 0.467743 0.625 0.697579 0.506846 0.282258 0.677418 0.439515 0.29787 0.208757 0.439515 0.497366 0.346772 0.267455 0.368691], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8], [8, 9], [9, 10], [10, 11], [11, 12], [12, 13], [13, 14], [14, 15], [15, 16], [16, 17], [17, 18], [18, 19], [19, 20], [20, 21], [21, 1], [22, 23], [24, 23], [24, 25], [25, 26], [26, 22], [27, 28], [28, 29], [29, 30], [30, 27]])
Plasm.view(V, EV)

# costruction of 2D arrangement
W = convert(Lar.Points, V')
cop_EV = Lar.coboundary_0(EV::Lar.Cells)
cop_EW = convert(Lar.ChainOp, cop_EV)
V, copEV, copFE = Lar.Arrangement.planar_arrangement(
      W::Lar.Points, cop_EW::Lar.ChainOp)

GL.VIEW([
      GLPolygon(GL.two2three(V), copEV, copFE)
      GL.GLAxis(GL.Point3d(0,0,0),GL.Point3d(1,1,1))
])
