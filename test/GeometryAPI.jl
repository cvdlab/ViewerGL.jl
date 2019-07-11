function GLHull(points::Array{Float64,2},color::GL.Point4d)::GL.GLMesh
function GLHull(points::Array{Float64,2})::GL.GLMesh
function GLHull2d(points::Array{Float64,2})::GL.GLMesh # points by row
function GLHulls(V::Array{Float64,2},
function GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp)::GL.GLMesh
function GLPolygon(V::Lar.Points,EV::Lar.Cells)::GL.GLMesh
function GLLar2gl(V::Lar.Points, CV::Lar.Cells)::GL.GLMesh
function GLLines(points::Lar.Points,lines::Lar.Cells,color=COLORS[12])::GL.GLMesh
function GLPoints(points::Lar.Points,color=COLORS[12])::GL.GLMesh # points by row
function GLPolyhedron(V::Lar.Points, FV::Lar.Cells, T::GL.Matrix4=M44)::GL.GLMesh
function GLPolyhedron(V::Lar.Points,
function GLGrid(V::Lar.Points,CV::Lar.Cells,color=GL.COLORS[1])::GL.GLMesh
function GLExplode(V,FVs,sx=1.2,sy=1.2,sz=1.2,colors=1)


