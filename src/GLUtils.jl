using ViewerGL
GL = ViewerGL

# ////////////////////////////////////////////////////////////////////////
function lar2mesh(points,faces)
	vertices=Vector{Float32}()
	normals =Vector{Float32}()
	for face in faces
		p3,p2,p1 = points[face[1],:],points[face[2],:],points[face[3],:]
		p1 = convert(GL.Point3d, p1)
		p2 = convert(GL.Point3d, p2)
		p3 = convert(GL.Point3d, p3)
		n=0.5*GL.computeNormal(p1::GL.Point3d,p2::GL.Point3d,p3::GL.Point3d)

		append!(vertices,p1); append!(normals,n)
		append!(vertices,p2); append!(normals,n)
		append!(vertices,p3); append!(normals,n)
	end
	return vertices,normals
end

# /////////////////////////////////////////////////////////////////////
function two2three(points)
      return [points zeros(Float64,size(points,1),1)]
end


# /////////////////////////////////////////////////////////////////////
function glGenBuffer()
	id = GLuint[0]
	glGenBuffers(1, id)
	glCheckError("generating a buffer, array, or texture")
	id[]
end

# /////////////////////////////////////////////////////////////////////
function glGenVertexArray()
	id = GLuint[0]
	glGenVertexArrays(1, id)
	glCheckError("generating a buffer, array, or texture")
	id[]
end




# /////////////////////////////////////////////////////////////////////
function glCheckError(actionName="")
	message = glErrorMessage()
	if length(message) > 0
		if length(actionName) > 0
		error("Error ", actionName, ": ", message)
		else
		error("Error: ", message)
		end
	end
end

# /////////////////////////////////////////////////////////////////////
function glErrorMessage()
	err = glGetError()
	if err == GL_NO_ERROR return "" end
	if err == GL_INVALID_ENUM return "GL_INVALID_ENUM" end
	if err == GL_INVALID_VALUE return "GL_INVALID_VALUE"  end
	if err == GL_INVALID_OPERATION return "GL_INVALID_OPERATION"  end
	if err == GL_INVALID_FRAMEBUFFER_OPERATION return "GL_INVALID_FRAMEBUFFER_OPERATION"  end
	if err == GL_OUT_OF_MEMORY return "GL_OUT_OF_MEMORY" end
	return "Unknown OpenGL error with error code"
end


# /////////////////////////////////////////////////////////////////////
__release_gpu_resources__=[]

function glDeleteLater(fun::Function)
	global __release_gpu_resources__
	append!(__release_gpu_resources__,[fun])
end

# /////////////////////////////////////////////////////////////////////
function glDeleteNow()
	global __release_gpu_resources__
	for fun in __release_gpu_resources__
		fun()
	end
end
