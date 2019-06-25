using Test
using StaticArrays
using ViewerGL
GL = ViewerGL

@testset "Frustum.jl" begin

   # projectPoint(map::FrustumMap,p3::Point3d)
   mesh = GL.GLCuboid(GL.Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
   GL.VIEW([mesh],false);
   viewport=[0,0,GL.viewer.W,GL.viewer.H];
   projection =GL.getProjection(GL.viewer);
   modelview=GL.getModelview(GL.viewer);
   themap=GL.FrustumMap(viewport,projection,modelview)
#=   @testset "FrustumMap" begin

      @test map=GL.FrustumMap(viewport,projection,modelview) ==
      ViewerGL.FrustumMap(
      [1024.0 0.0 0.0 1024.0; 0.0 768.0 0.0 768.0; 0.0 0.0 0.5 0.5; 0.0 0.0 0.0 1.0],
      [1.29904 0.0 0.0 0.0; 0.0 1.73205 0.0 0.0; 0.0 0.0 -1.00401 -0.0801603; 0.0 0.0 -1.0 0.0],
      [-0.707107 0.707107 0.0 0.0; -0.408248 -0.408248 0.816497 0.0; 0.57735 0.57735 0.57735 -5.19615; 0.0 0.0 0.0 1.0],
      [0.000976563 0.0 0.0 -1.0; 0.0 0.00130208 0.0 -1.0; 0.0 0.0 2.0 -1.0; 0.0 0.0 0.0 1.0],
      [0.7698 -0.0 -0.0 -0.0; -0.0 0.57735 0.0 -0.0; -0.0 -0.0 -0.0 -1.0; -0.0 -0.0 -12.475 12.525],
      [-0.707107 -0.408248 0.57735 3.0; 0.707107 -0.408248 0.57735 3.0; 0.0 0.816497 0.57735 3.0; 0.0 0.0 -0.0 1.0])

      @test map.viewport==GL.Matrix4([1024.0 0.0 0.0 1024.0; 0.0 768.0 0.0 768.0; 0.0 0.0 0.5 0.5; 0.0 0.0 0.0 1.0])
      @test map.projection==GL.Matrix4([1.29904 0.0 0.0 0.0; 0.0 1.73205 0.0 0.0; 0.0 0.0 -1.00401 -0.0801603; 0.0 0.0 -1.0 0.0])
      @test map.modelview==GL.Matrix4([-0.707107 0.707107 0.0 0.0; -0.408248 -0.408248 0.816497 0.0; 0.57735 0.57735 0.57735 -5.19615; 0.0 0.0 0.0 1.0])
      @test map.inv_viewport==GL.Matrix4([0.000976563 0.0 0.0 -1.0; 0.0 0.00130208 0.0 -1.0; 0.0 0.0 2.0 -1.0; 0.0 0.0 0.0 1.0])
      @test map.inv_projection==GL.Matrix4([0.7698 -0.0 -0.0 -0.0; -0.0 0.57735 0.0 -0.0; -0.0 -0.0 -0.0 -1.0; -0.0 -0.0 -12.475 12.525])
      @test map.inv_modelview=GL.Matrix4([-0.707107 -0.408248 0.57735 3.0; 0.707107 -0.408248 0.57735 3.0; 0.0 0.816497 0.57735 3.0; 0.0 0.0 -0.0 1.0])
   end

   # function FrustumMap(viewport,projection::Matrix4,modelview::Matrix4)
   @testset "FrustumMap" begin
      @test
      @test
      @test
      @test
   end
=#
   # function projectPoint(map::FrustumMap,p3::Point3d)
   @testset "projectPoint" begin
      @test GL.projectPoint(themap::GL.FrustumMap,GL.Point3d(1.5,1.5,1.5))==GL.Point3d(512.0, 384.0, 0.9865771471158417)
      @test GL.projectPoint(themap::GL.FrustumMap,GL.Point3d(-1.5,-1.5,-1.5))==GL.Point3d(512.0, 384.0,0.9968617210493019)
      @test typeof(GL.projectPoint(themap::GL.FrustumMap,GL.Point3d(1.5,1.5,1.5)))==StaticArrays.MArray{Tuple{3},Float64,1,3}
      @test typeof(themap)==ViewerGL.FrustumMap
      @test typeof(GL.Point3d(1.5,1.5,1.5))==StaticArrays.MArray{Tuple{3},Float64,1,3}
    end

   # function unprojectPoint(map::FrustumMap,x::Float32,y::Float32, z::Float32)
   @testset "unprojectPoint" begin
      x=1.5; y=1.5; z=1.5;
      p4 = (themap.inv_modelview * (themap.inv_projection * (themap.inv_viewport * GL.Point4d(x,y,z, 1.0))))
      @test typeof(themap)==ViewerGL.FrustumMap
      @test GL.Point4d(x,y,z, 1.0)==[1.5,1.5,1.5,1.0]
      @test p4 == [-37.0748323866816,-38.160305054815986,-38.32191336607133,-12.425000000000002]
   end

end
