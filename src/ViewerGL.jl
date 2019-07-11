"""
	module ViewerGL

3D `interactive Viewer` for geometric and topological data.

Helper module for Julia's native ``OpenGL visualization``, forked from [Plasm.jl](https://github.com/plasm-language/pyplasm/tree/master/src/plasm.jl). To be used with geometric models and geometric expressions from [LinearAlgebraicRepresentation.jl](https://github.com/cvdlab/LinearAlgebraicRepresentation.jl), the simplest data structures for geometric and solid modeling :-)
"""
module ViewerGL

	using LinearAlgebra,StaticArrays
	using ModernGL
	using GLFW
	import Base:*

	include("Point.jl")
	include("Box.jl")
	include("Matrix.jl")
	include("Quaternion.jl")
	include("Frustum.jl")

	include("GLUtils.jl")
	include("GLVertexBuffer.jl")
	include("GLVertexArray.jl")
	include("GLMesh.jl")
	include("GLShader.jl")
	include("GLPhongShader.jl")

	include("Viewer.jl")
	include("Geometry.jl")
	include("GLText.jl")
	include("GLColorBuffer.jl")

	const GLFrame2 = GLAxis(Point3d(0,0,0),Point3d(1,1,0))
	const GLFrame = GLAxis(Point3d(0,0,0),Point3d(1,1,1))


end # module
