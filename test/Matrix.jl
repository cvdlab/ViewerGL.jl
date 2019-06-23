using Test
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL
GL = ViewerGL

@testset "Matrix.jl" begin

   # function flatten(T::Matrix3)
   @testset "flatten" begin
      @test
      @test
      @test
      @test
   end

	# function flatten(T::Matrix4)
   @testset "flatten" begin
      @test
      @test
      @test
      @test
   end

	 # function dropW(T::Matrix4)
   @testset "dropW" begin
      @test
      @test
      @test
      @test
   end

	 # function translateMatrix(vt::Point3d)
   @testset "translateMatrix" begin
      @test
      @test
      @test
      @test
   end

	 # function scaleMatrix(vs::Point3d)
   @testset "scaleMatrix" begin
      @test
      @test
      @test
      @test
   end

	 # function lookAtMatrix(eye::Point3d, center::Point3d, up::Point3d)
   @testset "lookAtMatrix" begin
      @test
      @test
      @test
      @test
   end

	 # function perspectiveMatrix(fovy::Float64, aspect::Float64, zNear::Float64, zFar::Float64)
   @testset "perspectiveMatrix" begin
      @test
      @test
      @test
      @test
   end

	 # function getLookAt(T::Matrix4)
   @testset "getLookAt" begin
      @test
      @test
      @test
      @test
   end

end
