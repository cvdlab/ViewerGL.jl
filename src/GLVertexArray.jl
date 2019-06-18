



"""
	mutable struct GLVertexArray

Submitting vertex data for rendering requires creating a stream of vertices, and then telling OpenGL how to interpret that stream. A Vertex Array Object (VAO) is an OpenGL Object that stores all of the state needed to supply vertex data
"""
mutable struct GLVertexArray

	id::Int32

	# constructor
	function GLVertexArray()
		ret=new(-1)
		finalizer(releaseGpuResources, ret)
		return ret
	end

end




"""
	releaseGpuResources(array::GLVertexArray)

Release an array of `GLVertexArray`, a Gpu resource. It is a list of indices that will select which vertices to use and in which order.
"""
function releaseGpuResources(array::GLVertexArray)
	global __release_gpu_resources__
	if array.id>=0
		id=array.id
		array.id=-1
		glDeleteLater(function() glDeleteVertexArrays(1,[id]) end)
	end
end



"""
	enableVertexArray(array::GLVertexArray)

# Example

There are many ways for OpenGL to interpret a stream of, for example, 12 vertices. It can interpret the vertices as a sequence of triangles, points, or lines. It can even interpret these differently; it can interpret 12 vertices as 4 independent triangles (take every 3 verts as a triangle), as 10 dependent triangles (every group of 3 sequential vertices in the stream is a triangle), and so on.
Each attribute can be enabled or disabled for array access.
"""
function enableVertexArray(array::GLVertexArray)

	# not needed or osx
	if Sys.isapple() return end

	if array.id<0
		array.id=glGenVertexArray()
	end
	glBindVertexArray(array.id)
end



"""
	disableVertexArray(array::GLVertexArray)

Each attribute can be enabled or disabled for array access. 
"""
function disableVertexArray(array::GLVertexArray)

	# not needed or osx
	if Sys.isapple() return end

	glBindVertexArray(0)
end
