module ViewerGL

	using LinearAlgebra
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

end # module
