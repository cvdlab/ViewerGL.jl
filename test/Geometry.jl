using Test
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

@testset "Goemetry.jl" begin

   # function GLHull(points::Array{Float64,2})::GL.GLMesh
   @testset "GLHull" begin
      @test
      @test
      @test
      @test
   end

   # function GLHull2d(points::Array{Float64,2})::GL.GLMesh # points by row
   @testset "GLHull2d" begin
      @test
      @test
      @test
      @test
   end

   # function GLPolygon(V::Lar.Points,copEV::Lar.ChainOp,copFE::Lar.ChainOp)::GL.GLMesh
   @testset "GLPolygon" begin
      @test
      @test
      @test
      @test
   end

   # function GLPolygon(V::Lar.Points,EV::Lar.Cells)::GL.GLMesh
   @testset "GLPolygon" begin
      @test
      @test
      @test
      @test
   end

   # function GLLar2gl(V::Lar.Points, CV::Lar.Cells)::GL.GLMesh
   @testset "GLLar2gl" begin
      @test
      @test
      @test
      @test
   end

   # function GLLines(points::Lar.Points,lines::Lar.Cells)
   @testset "GLLines" begin
      @test
      @test
      @test
      @test
   end

   # function GLText(string)
   @testset "GLText" begin
      @test
      @test
      @test
      @test
   end

   # function GLPoints(points::Lar.Points) # points by row
   @testset "GLPoints" begin
      @test
      @test
      @test
      @test
   end

   # function GLPolyhedron(V::Lar.Points, FV::Lar.Cells, T::GL.Matrix4=M44)
   @testset "GLPolyhedron" begin
      @test
      @test
      @test
      @test
   end

   # 	function mycat(a::Lar.Cells)
   @testset "mycat" begin
      @test
      @test
      @test
      @test
   end

   # function GLPolyhedron(V::Lar.Points, ...
   @testset "GLPolyhedron" begin
      @test
      @test
      @test
      @test
   end

   # function GLGrid(V::Lar.Points,CV::Lar.Cells,color=GL.COLORS[1])
   @testset "GLGrid" begin
      @test
      @test
      @test
      @test
   end

end
