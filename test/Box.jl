using Test
using ViewerGL
GL = ViewerGL
using StaticArrays

@testset "Box.jl" begin

   # 	function Box3d()
   @testset "Box3d()" begin
      @test typeof(GL.Box3d())==ViewerGL.Box3d
      @test GL.Box3d().p1==[0.0,0.0,0.0]
      @test GL.Box3d().p2==[0.0,0.0,0.0]
      @test typeof(GL.Box3d().p1)==StaticArrays.MArray{Tuple{3},Float64,1,3}
      @test typeof(GL.Box3d().p2)==StaticArrays.MArray{Tuple{3},Float64,1,3}
      # function Box3d(p1::Point3d,p2::Point3d)
      p1=GL.Point3d(-1,-1,-1); p2=GL.Point3d(+1,+1,+1);
      @test GL.Box3d(p1::GL.Point3d,p2::GL.Point3d)==ViewerGL.Box3d(GL.Point3d(-1.0, -1.0, -1.0), GL.Point3d(1.0, 1.0, 1.0))
      @test typeof(ViewerGL.Box3d)==DataType
   end

   # function invalidBox()
   @testset "invalidBox()" begin
      @test GL.invalidBox()==ViewerGL.Box3d(GL.Point3d(Inf,Inf,Inf),GL.Point3d(-Inf,-Inf,-Inf))
      @test GL.invalidBox().p1==GL.Point3d(Inf,Inf,Inf)
      @test GL.invalidBox().p2==GL.Point3d(-Inf,-Inf,-Inf)
      @test typeof(GL.invalidBox().p1)==StaticArrays.MArray{Tuple{3},Float64,1,3}
   end


   # function addPoint(box::Box3d,point::Point3d)
   @testset "addPoint" begin
      box=GL.invalidBox(); point=GL.Point3d(0,0,0)
      @test typeof(GL.addPoint(box::GL.Box3d,point::GL.Point3d))==ViewerGL.Box3d
      @test GL.addPoint(ViewerGL.Box3d(),GL.Point3d(0,0,1))==ViewerGL.Box3d(GL.Point3d(0.0,0.0,0.0),GL.Point3d(0.0,0.0,1.0))
      @test typeof(GL.addPoint(ViewerGL.Box3d(),GL.Point3d(0,0,1)))==ViewerGL.Box3d
   end


   # function getPoints(box::Box3d)
   a = GL.addPoint(ViewerGL.Box3d(),GL.Point3d(0,0,1))
   GL.addPoint(a,GL.Point3d(1,0,1))
   GL.addPoint(a,GL.Point3d(0,1,1))
   @testset "getPoints" begin
      @test a==ViewerGL.Box3d(GL.Point3d(0.0,0.0,0.0), GL.Point3d(1.0,1.0,1.0))
      box = GL.getPoints(GL.Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
      @test typeof(box)==Array{MArray{Tuple{3},Float64,1,3},1}
      @test box==convert(Array{MArray{Tuple{3},Float64,1,3},1},[[0.0, 0.0, 0.0],
                             [1.0, 0.0, 0.0],
                             [1.0, 1.0, 0.0],
                             [0.0, 1.0, 0.0],
                             [0.0, 0.0, 1.0],
                             [1.0, 0.0, 1.0],
                             [1.0, 1.0, 1.0],
                             [0.0, 1.0, 1.0]])
   end
end
