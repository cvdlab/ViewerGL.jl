
using ModernGL


"""
	mutable struct GLVertexBuffer

Submitting vertex data for rendering requires creating a stream of vertices, and then telling OpenGL how to interpret that stream. `GLVertexBuffer` provides methods for uploading vertex data (position, normal vector, color, etc.) to the device for non-immediate-mode rendering.
A Vertex Buffer Object is the common term for a Buffer Object when it is used as a source for vertex array data.
Two inner constructor methods, with and without a `Vector{Float32}`.
"""
mutable struct GLVertexBuffer

	id::Int32
	vector::Vector{Float32}

	# constructor
	function GLVertexBuffer()
		ret=new(-1,[])
		finalizer(releaseGpuResources, ret)
		return ret
	end

	# constructor
	function GLVertexBuffer(vector::Vector{Float32})
		ret=new(-1,vector)
		finalizer(releaseGpuResources, ret)
		return ret
	end

end



"""

# Example

Release an array of `GLVertexBuffer`, a Gpu resource. It is a list of indices that will select which vertices to use and in which order.
"""
function releaseGpuResources(buffer::GLVertexBuffer)
	global __release_gpu_resources__
	if buffer.id>=0
		id=buffer.id
		buffer.id=-1
		glDeleteLater(function()  glDeleteBuffers(1,[id]) end)
	end
end



"""
	enableAttribute(location::Int32,buffer::GLVertexBuffer,num_components::Int64)

If enabled, the values in the generic vertex attribute array will be accessed and used for rendering when calls are made to vertex array commands.
"""
function enableAttribute(location::Int32,buffer::GLVertexBuffer,num_components::Int64)
	if length(buffer.vector)==00 || location<0 return end
	if buffer.id<0 buffer.id=glGenBuffer() end
	# Enable blending
	glEnable(GL_BLEND)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

	glLineWidth()
	glPointSize()
	glBindBuffer(GL_ARRAY_BUFFER, buffer.id)
	glBufferData(GL_ARRAY_BUFFER, sizeof(buffer.vector), buffer.vector, GL_STATIC_DRAW)
	glVertexAttribPointer(location,num_components,GL_FLOAT,false,0,C_NULL)
	glEnableVertexAttribArray(location)
	glBindBuffer(GL_ARRAY_BUFFER, 0)
end



"""
	disableAttribute(location::Int32,buffer::GLVertexBuffer)

By default, all client-side capabilities are disabled, including all generic vertex attribute arrays.
"""
function disableAttribute(location::Int32,buffer::GLVertexBuffer)
	if length(buffer.vector)==00 || location<0 return end
	glDisableVertexAttribArray(location)
end
