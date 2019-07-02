using Test
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

@testset "Geometry.jl" begin

   points = [0.214359   0.261879  0.317665;
        0.0235449  0.584002  0.477773;
        0.0353606  0.245789  0.0913658;
        0.168101   0.941013  0.120331]
   # function GLHull(points::Array{Float64,2})::GL.GLMesh
   @testset "GLHull" begin
      @test typeof(GL.GLHull(points::Array{Float64,2}))==ViewerGL.GLMesh
      @test ViewerGL.GLMesh.super==Any
      @test supertype(ViewerGL.GLMesh)==Any
      @test GL.GLHull(points::Array{Float64,2}).primitive==4
      @test GL.GLHull(points::Array{Float64,2}).T==
      [1.0  0.0  0.0  0.0;
       0.0  1.0  0.0  0.0;
       0.0  0.0  1.0  0.0;
       0.0  0.0  0.0  1.0];
      @test typeof(GL.GLHull(points))==ViewerGL.GLMesh
   end

   # function GLHull2d(points::Array{Float64,2})::GL.GLMesh # points by row
   @testset "GLHull2d" begin
      points = [0.214359   0.261879;
           0.0235449  0.584002 ;
           0.0353606  0.245789 ;
           0.168101   0.941013 ]
      @test typeof(GL.GLHull2d(points))==ViewerGL.GLMesh
      @test GL.GLHull2d(points::Array{Float64,2}).primitive==1
      @test GL.GLHull2d(points::Array{Float64,2}).T==GL.M44
   end

   # function GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp)::GL.GLMesh
   @testset "GLPolygon" begin
      V = hcat([[0,0],[1,0],[1,1],[0,1],[.25,.25],[.75,.25],[.75,.75],[.25,.75]]...)
      EV = [[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,5]]
      W = convert(Lar.Points, V')
      cop_EV = Lar.coboundary_0(EV::Lar.Cells)
      cop_EW = convert(Lar.ChainOp, cop_EV)
      V, copEV, copFE = Lar.Arrangement.planar_arrangement(W::Lar.Points, cop_EW::Lar.ChainOp)
      V = GL.two2three(V)
      @test typeof(GL.GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp))==GL.GLMesh
      @test GL.GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp).primitive==4
      @test GL.GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
   end

   # function GLPolygon(V::Lar.Points,EV::Lar.Cells)::GL.GLMesh
   @testset "GLPolygon" begin
      (V, EV) = ([0.43145 0.596771 0.758062 1.0 0.778226 0.919353 0.879033 0.806447 0.778226 0.709677 0.596771 0.262094 0.322578 0.0 0.2379 0.161291 0.467739 0.429435 0.627999 0.627999 0.383062 0.694833 0.653221 0.544027 0.778226 0.848789 0.750707 0.627999 0.694833 0.806447; 0.0 0.233873 0.11694 0.330646 0.625 0.677418 0.810484 0.717742 0.834675 0.743951 0.983871 0.810484 0.625 0.388696 0.439515 0.25403 0.467743 0.625 0.697579 0.506846 0.282258 0.677418 0.439515 0.29787 0.208757 0.439515 0.497366 0.346772 0.267455 0.368691], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8], [8, 9], [9, 10], [10, 11], [11, 12], [12, 13], [13, 14], [14, 15], [15, 16], [16, 17], [17, 18], [18, 19], [19, 20], [20, 21], [21, 1], [22, 23], [24, 23], [24, 25], [25, 26], [26, 22], [27, 28], [28, 29], [29, 30], [30, 27]])
      @test typeof(GL.GLPolygon(V::Lar.Points,EV::Lar.Cells))==GL.GLMesh
      @test GL.GLPolygon(V::Lar.Points,EV::Lar.Cells).primitive==4
      @test GL.GLPolygon(V::Lar.Points,EV::Lar.Cells).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
   end

   # function GLLar2gl(V::Lar.Points, CV::Lar.Cells)::GL.GLMesh
   @testset "GLLar2gl" begin
      (V, CV) = ([0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0; 0.0 0.0 1.0 1.0 2.0 2.0 0.0 0.0 1.0 1.0 2.0 2.0; 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0], Array{Int64,1}[[1, 2, 3, 4, 7, 8, 9, 10], [3, 4, 5, 6, 9, 10, 11, 12]])
      @test typeof(GL.GLLar2gl(V,CV))==ViewerGL.GLMesh
      @test GL.GLLar2gl(V::Lar.Points, CV::Lar.Cells).primitive==4
      @test GL.GLLar2gl(V::Lar.Points, CV::Lar.Cells).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end

   # function GLLines(points::Lar.Points,lines::Lar.Cells)
   @testset "GLLines" begin
      (points, lines) = ([0.0 0.0 3.0 4.0 4.0 3.0 0.0 9.0 5.0 5.0 14.0 13.0 11.0 10.0 10.0 11.0 13.0 14.0 14.0 14.0 15.0 16.0 18.0 19.0 19.0 18.0 16.0 15.0 15.0 16.0 18.0 19.0 20.0 20.0 22.0 24.0 24.0; 6.0 0.0 0.0 1.0 3.0 4.0 4.0 6.0 6.0 0.0 5.0 6.0 6.0 5.0 4.0 3.0 3.0 4.0 6.0 3.0 5.0 6.0 6.0 5.0 4.0 3.0 3.0 2.0 1.0 0.0 0.0 1.0 6.0 0.0 2.0 0.0 6.0; 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [8, 9], [9, 10], [11, 12], [12, 13], [13, 14], [14, 15], [15, 16], [16, 17], [17, 18], [18, 11], [19, 20], [21, 22], [22, 23], [23, 24], [24, 25], [25, 26], [26, 27], [27, 28], [28, 29], [29, 30], [30, 31], [31, 32], [33, 34], [34, 35], [35, 36], [36, 37]])
      @test typeof(GL.GLLines(points::Lar.Points,lines::Lar.Cells))==ViewerGL.GLMesh
      @test GL.GLLines(points::Lar.Points,lines::Lar.Cells).primitive==1
      @test GL.GLLines(points::Lar.Points,lines::Lar.Cells).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end

   # function GLText(string)
   @testset "GLText" begin
      @test typeof(GL.GLText("Plasm"))==ViewerGL.GLMesh
      @test GL.GLText("Plasm").primitive==1
      @test GL.GLText("Plasm").T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end

   # function GLPoints(points::Lar.Points) # points by row
   @testset "GLPoints" begin
      points = rand(50,3)
      @test typeof(GL.GLPoints(points::Lar.Points))==GL.GLMesh
      @test GL.GLPoints(points::Lar.Points).primitive==0
      @test GL.GLPoints(points::Lar.Points).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end

   # function GLPolyhedron(V::Lar.Points, FV::Lar.Cells, T::GL.Matrix4=M44)
   @testset "GLPolyhedron" begin
      (V, FV) = ([0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0; 0.0 0.0 1.0 1.0 0.0 0.0 1.0 1.0; 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0], Array{Int64,1}[[1, 2, 3, 4], [5, 6, 7, 8], [1, 2, 5, 6], [3, 4, 7, 8], [1, 3, 5, 7], [2, 4, 6, 8]])
      @test typeof(GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells))==GL.GLMesh
      @test GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells).primitive==4
      @test GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end
#=
   @testset "GLPolyhedron" begin
      (V, FV, EV) = ([0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0; 0.0 0.0 1.0 1.0 0.0 0.0 1.0 1.0; 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0], Array{Int64,1}[[1, 2, 3, 4], [5, 6, 7, 8], [1, 2, 5, 6], [3, 4, 7, 8], [1, 3, 5, 7], [2, 4, 6, 8]], Array{Int64,1}[[1, 2], [3, 4], [5, 6
      ], [7, 8], [1, 3], [2, 4], [5, 7], [6, 8], [1, 5], [2, 6], [3, 7], [4, 8]])
      cop_EV = Lar.coboundary_0(EV::Lar.Cells);
      cop_EW = convert(Lar.ChainOp, cop_EV);
      cop_FE = Lar.coboundary_1(V, FV::Lar.Cells, EV::Lar.Cells);
      W = convert(Lar.Points, V');

      V, copEV, copFE, copCF = Lar.Arrangement.spatial_arrangement(
      	W::Lar.Points, cop_EW::Lar.ChainOp, cop_FE::Lar.ChainOp)
      @test typeof(GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells))==GL.GLMesh
      @test GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells).primitive==4
      @test GL.GLPolyhedron(V::Lar.Points, FV::Lar.Cells).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end
=#

   # function GLGrid(V::Lar.Points,CV::Lar.Cells,color=GL.COLORS[1])
   @testset "GLGrid" begin
      V,(VV,EV,FV,CV) = Lar.cuboidGrid([1,2,1],true)
      @test typeof(GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1)))==GL.GLMesh
      @test GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1)).primitive==7
      @test GL.GLGrid(V,FV,GL.Point4d(1,1,1,0.1)).T==GL.M44
      @test GL.GLMesh.size==48
      @test GL.GLMesh.isbitstype==false
      @test GL.GLVertexBuffer.isconcretetype==true
   end

end
