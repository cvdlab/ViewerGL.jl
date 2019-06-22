"""
	module ViewerGL

3D `interactive Viewer` for geometric and topological data.

Helper module for Julia's native ``OpenGL visualization``, forked from [Plasm.jl](https://github.com/plasm-language/pyplasm/tree/master/src/plasm.jl). To be used with geometric models and geometric expressions from [LinearAlgebraicRepresentation.jl](https://github.com/cvdlab/LinearAlgebraicRepresentation.jl), the simplest data structures for geometric and solid modeling :-)
"""
module ViewerGL

	using LinearAlgebra
	using ModernGL
	using GLFW
	import Base:*

	include("./src/Point.jl")
	include("./src/Box.jl")
	include("./src/Matrix.jl")
	include("./src/Quaternion.jl")
	include("./src/Frustum.jl")

	include("./src/GLUtils.jl")
	include("./src/GLVertexBuffer.jl")
	include("./src/GLVertexArray.jl")
	include("./src/GLMesh.jl")
	include("./src/GLShader.jl")
	include("./src/GLPhongShader.jl")

	include("./src/Viewer.jl")
	include("./src/Geometry.jl")
	include("./src/GLText.jl")
	include("./src/GLColorBuffer.jl")

end # module
