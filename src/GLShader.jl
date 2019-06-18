
"""
	`mutable struct GLShader`

Container for vertex and fragment shaders, their ids, and program id.
"""
mutable struct GLShader

	vertex_source
	frag_source

	program_id::Int32
	vertex_shader_id::Int32
	frag_shader_id::Int32

	# constructor
	function GLShader(vertex, fragment)
		ret=new(vertex,fragment,-1,-1,-1)
		finalizer(releaseGpuResources, ret)
		return ret
	end

end




"""
	releaseGpuResources(shader::GLShader)

Management of shader program memory on the GPU.
"""
function releaseGpuResources(shader::GLShader)

	global __release_gpu_resources__

	if shader.vertex_shader_id>=0
		id=shader.vertex_shader_id
		shader.vertex_shader_id=-1
		glDeleteLater(function()  glDeleteShader(id) end)
	end

	if shader.frag_shader_id>=0
		id=shader.frag_shader_id
		shader.frag_shader_id=-1
		glDeleteLater(function()  glDeleteShader(id) end)

	end

	if shader.program_id>=0
		id=shader.program_id
		shader.program_id=-1
		glDeleteLater(function()  glDeleteProgram(id) end)
	end

end




"""
	createShader(type,source)

Shaders creation and compilation by `type`. Return `shader_id`
"""
function createShader(type,source)
	shader_id = glCreateShader(type)::GLuint
	glCheckError()
	glShaderSource(shader_id, 1, convert(Ptr{UInt8}, pointer([convert(Ptr{GLchar}, pointer(source))])) , C_NULL)
	glCompileShader(shader_id)
	status = GLint[0]
	glGetShaderiv(shader_id, GL_COMPILE_STATUS, status)
	if status[1] == GL_FALSE
		maxlength = 8192
		buffer = zeros(GLchar, maxlength)
		sizei = GLsizei[0]
		glGetShaderInfoLog(shader_id, maxlength, sizei, buffer)
		len = sizei[]
		error_msg=unsafe_string(pointer(buffer), len)
		error("shader compilation failed\n",error_msg,"\nsource\n",source)
	end
	return shader_id
end





"""
	enableProgram(shader)

Compiling and linking program shaders. Return status.

A program object will contain an executable that will run on the vertex processor if it contains one or more shader objects of type `GL_VERTEX_SHADER` that have been successfully compiled and linked.
Similarly, a program object will contain an executable that will run on the fragment processor if it contains one or more shader objects of type `GL_FRAGMENT_SHADER` that have been successfully compiled and linked.

# Example
```
shader = GL.GLPhongShader(true,true)
GL.enableProgram(shader)
```

"""
function enableProgram(shader)

	if (shader.program_id<0)

		shader.program_id = glCreateProgram()
		glCheckError()

		shader.vertex_shader_id=createShader(GL_VERTEX_SHADER,shader.vertex_source)
		glAttachShader(shader.program_id, shader.vertex_shader_id)
		glCheckError()

		shader.frag_shader_id=createShader(GL_FRAGMENT_SHADER,shader.frag_source)
		glAttachShader(shader.program_id, shader.frag_shader_id)
		glCheckError()

		glLinkProgram(shader.program_id)
		glCheckError()
		status = GLint[0]
		glGetProgramiv(shader.program_id, GL_LINK_STATUS, status)
		if status[1] == GL_FALSE
			maxlength = 8192
			buffer = zeros(GLchar, maxlength)
			sizei = GLsizei[0]
			glGetProgramInfoLog(shader.program_id, maxlength, sizei, buffer)
			len = sizei[]
			error_msg = unsafe_string(pointer(buffer), len)
			error("Error linking program\n",error_msg)
		end
		glCheckError()
	end

	glUseProgram(shader.program_id)
end



"""
	disableProgram(shader)

Make sure that the last used shader is not active anymore.

`glUseProgram` is available only if the GL version is 2.0 or greater. It specifies the handle of the program object whose executables are to be used as part of current rendering state.
"""
function disableProgram(shader)
	glUseProgram(0)
end
