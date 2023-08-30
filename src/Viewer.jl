
"""
	mutable struct Viewer

Mutable container for current parameters of the ``interactive Viewer``.
Includes:
*	`win`::Any
*	`W`::Int32
*	`H`::Int32
*	`scalex`::Float64
*	`scaley`::Float64
*	`fov`::Float64
*	`pos`::Point3d
*	`dir`::Point3d
*	`vup`::Point3d
*	`zNear`::Float64
*	`zFar`::Float64
*	`walk_speed`::Float64
*	`mouse_beginx`::Float64
*	`mouse_beginy`::Float64
*	`down_button`::Int32
*	`meshes`::Any
*	`shaders`::Dict
*	`exitNow`::Int32
"""
mutable struct Viewer
	win::Any
	W::Int32
	H::Int32
	scalex::Float64
	scaley::Float64
	fov::Float64
	pos::Point3d
	dir::Point3d
	vup::Point3d
	zNear::Float64
	zFar::Float64
	walk_speed::Float64
	mouse_beginx::Float64
	mouse_beginy::Float64
	down_button::Int32
	meshes::Any
	shaders::Dict
	use_ortho::Bool
	exitNow::Int32

	# constructor
	function Viewer(meshes)
		new(0,1024,768,1.0,1.0, 60.0, Point3d(), Point3d(), Point3d(), 0.0, 0.0, 0.0,  0,0,0, meshes,Dict(),false)
	end

end




"""
	releaseGpuResources(viewer::Viewer)

Release the memory allocated by `vertex_array`, `vertices`, `normals`, and `colors` on the GPU.
# Example

```
julia> mesh = GL.GLCuboid(GL.Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
ViewerGL.GLMesh(4, [1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0], ViewerGL.GLVertexArray(-1), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0  …  1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0]), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0  …  0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0]), ViewerGL.GLVertexBuffer(-1, Float32[]))

julia> viewer = GL.Viewer([mesh])
ViewerGL.Viewer(0, 1024, 768, 1.0, 1.0, 60.0, [0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0], 0.0, 0.0, 0.0, 0.0, 0.0, 0, ViewerGL.GLMesh[GLMesh(4, [1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0], GLVertexArray(-1), GLVertexBuffer(-1, Float32[0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0  …  1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0]), GLVertexBuffer(-1, Float32[0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0  …  0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0]), GLVertexBuffer(-1, Float32[]))], Dict{Any,Any}())

julia> GL.releaseGpuResources(viewer)

julia> GL.releaseGpuResources
releaseGpuResources (generic function with 5 methods)
```
"""
function releaseGpuResources(viewer::Viewer)

	for mesh in viewer.meshes
		releaseGpuResources(mesh)
	end

	for (key, shader) in viewer.shaders
		releaseGpuResources(shader)
	end
end



"""
	runViewer(viewer::Viewer)

Init ``GLFW``, Create a new UI ``window``, make ``context`` current, print ``shader`` parameters, set interaction ``callbacks``, poll ``events``, and render the ``meshes`` in `viewer::Viever`.
# Example
```
julia> GL.runViewer(viewer)
# GLFW init returned true
# GL_SHADING_LANGUAGE_VERSION 1.20
# GL_VERSION                  2.1 NVIDIA-12.0.23 355.11.10.50.10.103
# GL_VENDOR                   NVIDIA Corporation
# GL_RENDERER                 NVIDIA GeForce GT 750M OpenGL Engine
```
"""
function runViewer(viewer::Viewer)

	ret_code=GLFW.Init()
	# println("GLFW init returned ",ret_code)

	# seems not to be needed for julia 1.x
  	#GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
	#GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
	#GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE)
	#GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)

	win = GLFW.CreateWindow(viewer.W, viewer.H, "ViewerGL")
	viewer.win=win
	GLFW.MakeContextCurrent(win)

	# println("GL_SHADING_LANGUAGE_VERSION ",unsafe_string(glGetString(GL_SHADING_LANGUAGE_VERSION)))
	# println("GL_VERSION                  ",unsafe_string(glGetString(GL_VERSION)))
	# println("GL_VENDOR                   ",unsafe_string(glGetString(GL_VENDOR)))
	# println("GL_RENDERER                 ",unsafe_string(glGetString(GL_RENDERER)))

	# problem of retina
	window_size     =GLFW.GetWindowSize(viewer.win)
	framebuffer_size=GLFW.GetFramebufferSize(viewer.win)
	viewer.scalex=framebuffer_size[1]/Float64(window_size[1])
	viewer.scaley=framebuffer_size[2]/Float64(window_size[2])

	GLFW.SetWindowSizeCallback(win,
		function(win, width::Int32, height::Int32)
	 		handleResizeEvent(viewer) end)
	GLFW.SetKeyCallback(win,
		function((win,key, scancode, action, mods))
			handleKeyPressEvent(viewer,key,scancode,action,mods) end)
	GLFW.SetCursorPosCallback(win,
		function((win,x,y)) handleMouseMoveEvent(viewer,x,y) end)
	GLFW.SetMouseButtonCallback(win,
		function(win,button,action,mods)
	 		handleMouseButtonEvent(viewer,button,action,mods) end)
	GLFW.SetScrollCallback(win,
		function((win,dx,dy)) handleMouseWheelEvent(viewer,dy) end)

	handleResizeEvent(viewer)
	while !GLFW.WindowShouldClose(win)
		glRender(viewer)
		GLFW.SwapBuffers(win)
		GLFW.PollEvents()
	end

	releaseGpuResources(viewer)
	glDeleteNow()

	GLFW.Terminate()
end



"""
	VIEW(meshes)

Load ``meshes`` in current ``Viewer`` object, create the bounding ``BOX``, accordingly compute the initial ``viewing`` parameters, redisplay the `window`, and ``interactively`` `run the viewer`.
# Example
Generate the window, display the mesh of the unit cube, and allow for viewing interaction with it:
```
julia> mesh = ViewerGL.GLMesh(4, [2.0 0.0 0.0 -1.0; 0.0 2.0 0.0 -1.0; 0.0 0.0 2.0 -1.0; 0.0 0.0 0.0 1.0], ViewerGL.GLVertexArray(-1), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0]), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0]), ViewerGL.GLVertexBuffer(-1, Float32[]))

julia> GL.VIEW([mesh]);
# GLFW init returned true
# GL_SHADING_LANGUAGE_VERSION 1.20
# GL_VERSION                  2.1 NVIDIA-12.0.23 355.11.10.50.10.103
# GL_VENDOR                   NVIDIA Corporation
# GL_RENDERER                 NVIDIA GeForce GT 750M OpenGL Engine
```
"""
function VIEW(meshes,view=true)

	global viewer
	viewer=GL.Viewer(meshes)

	# calculate bounding box -> (-1,+1) ^3
	BOX=GL.invalidBox()
	for mesh in viewer.meshes
		box=GL.getBoundingBox(mesh)
		GL.addPoint(BOX,box.p1)
		GL.addPoint(BOX,box.p2)
	end

	S=BOX.p2-BOX.p1
	maxsize=max(S[1],S[2],S[3])
	minsize=min(S[1],S[2],S[3])

	for mesh in viewer.meshes
	    mesh.T=translateMatrix(Point3d(-1.0,-1.0,-1.0)) * 
scaleMatrix(Point3d(2.0/maxsize,2.0/maxsize,2.0/maxsize)) * translateMatrix(-BOX.p1)
	end

	if minsize == 0.0
		viewer.pos = Point3d(0,0,3)
		viewer.vup = Point3d(0,1,0)
	else
		viewer.pos = Point3d(3,3,3)
		viewer.vup = Point3d(0,0,1)
	end
	viewer.dir = normalized(Point3d(0,0,0)-viewer.pos)

	maxsize           = 2.0
	viewer.zNear	  = maxsize / 50.0
	viewer.zFar	  = maxsize * 10.0
	viewer.walk_speed = maxsize / 100.0
	if view==true
		GL.redisplay(viewer)
		GL.runViewer(viewer)
	end
	return viewer
end




"""
	getModelview(viewer::Viewer)

Compute and return the `lookAtMatrix` matrix from current ``eye parameters``.

```
julia> GL.VIEW([mesh])

julia> GL.getModelview(GL.viewer)
4×4 MArray{Tuple{4,4},Float64,2,16}:
 -0.707107   0.707107  0.0        0.0
 -0.408248  -0.408248  0.816497   0.0
  0.57735    0.57735   0.57735   -5.19615
  0.0        0.0       0.0        1.0
```
"""
function getModelview(viewer::Viewer)
	return lookAtMatrix(viewer.pos,viewer.pos+viewer.dir,viewer.vup)
end



"""
	getProjection(viewer::Viewer)

Compute and return the `perspectiveMatrix` from current ``viewing parameters``, i.e. from the five numbers defining the view volume with aspect ratio given by the current window dimensions.
# Example
Define the ``VIEW`` of a `mesh`, get the generated `viewer`, and export to a ``text file`` "test/viewcube.txt".
```
julia> mesh = ViewerGL.GLMesh(4, [2.0 0.0 0.0 -1.0; 0.0 2.0 0.0 -1.0; 0.0 0.0 2.0 -1.0; 0.0 0.0 0.0 1.0], ViewerGL.GLVertexArray(-1), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0]), ViewerGL.GLVertexBuffer(-1, Float32[0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0]), ViewerGL.GLVertexBuffer(-1, Float32[]))

julia> GL.VIEW([mesh])

julia> viewer = GL.viewer

julia> viewerstring = GL.viewer;

julia> open("test/viewcube.txt", "w") do f
	  	  print(f, viewerstring);
	   end

julia> string = readline("test/viewcube.txt");
```
# Example
```
julia> GL.VIEW([mesh])

julia> GL.getProjection(GL.viewer)  # `GL.viewer` global variable set by `GL.VIEW`
4×4 MArray{Tuple{4,4},Float64,2,16}:
 1.29904  0.0       0.0       0.0
 0.0      1.73205   0.0       0.0
 0.0      0.0      -1.00401  -0.0801603
 0.0      0.0      -1.0       0.0
```
"""
function getProjection(viewer::Viewer)
	ratio=viewer.W/float(viewer.H)
	if viewer.use_ortho
		# euristic that seem to work well
		Z=viewer.zNear + 0.5*(viewer.zFar - viewer.zNear)
		right=Z * tan(deg2rad(viewer.fov/2.0))
		left=-right
		return  orthoMatrix(left, right, -0.5*(right-left)/ratio, +0.5*(right-left)/ratio, viewer.zNear, viewer.zFar)
	else
		return perspectiveMatrix(viewer.fov,ratio,viewer.zNear,viewer.zFar)
	end

end


"""
	projectPoint(viewer::Viewer,pos::Point3d)

# Example

```
julia> GL.VIEW([mesh])

julia> pos = GL.viewer.pos
3-element MArray{Tuple{3},Float64,1,3}:
 3.0
 3.0
 3.0

projectPoint(GL.viewer,GL.Point3d(pos))
```
"""
function projectPoint(viewer::Viewer,pos::Point3d)
	viewport=[0,0,viewer.W,viewer.H]
	projection =getProjection(viewer)
	modelview=getModelview(viewer)
	map=FrustumMap(viewport,projection,modelview)
	return projectPoint(map,pos)
end



"""
	unprojectPoint(viewer::Viewer,x::Float32,y::Float32)

Inverse projection of a 2D point in screen coordinates.
"""
function unprojectPoint(viewer::Viewer,x::Float64,y::Float64)
	viewport=[0,0,viewer.W,viewer.H]
	projection =getProjection(viewer)
	modelview=getModelview(viewer)
	map=FrustumMap(viewport,projection,modelview)
	P1=unprojectPoint(map,x,viewer.H-y,-1.0)
	P2=unprojectPoint(map,x,viewer.H-y,+1.0)
	return normalized(P2-P1)
end



"""
	getShader(viewer::Viewer,lighting_enabled,color_attribute_enabled)

Return a shader from the dictionary of shaders in the current viewer, depending on the combination of lighting and color attributes.
"""
function getShader(viewer::Viewer,lighting_enabled,color_attribute_enabled)

	key=(lighting_enabled,color_attribute_enabled)

	if haskey(viewer.shaders,key)
		return viewer.shaders[key]
	end

	ret=GLPhongShader(lighting_enabled,color_attribute_enabled)
	viewer.shaders[key]=ret
	return ret
end



"""
	glRender(viewer::Viewer)

Set viewing attributes and viewing transformation. Then, for each mesh associated to the current viewer as well as for each type of primitive in the mesh, execute a rendering with the shader, using primitive attributes.
"""
function glRender(viewer::Viewer)

	glEnable(GL_DEPTH_TEST)
	glDepthFunc(GL_LEQUAL)
	glDisable(GL_CULL_FACE)
	glClearDepth(1.0)
	#glClearColor(0.3,0.4,0.5, 0.00)
	glClearColor(1.,1.,1., 0.00)
	#glPolygonOffset(-1.0,-1.0)
	glPolygonOffset(+2.0,+2.0)

	glViewport(0,0,viewer.W,viewer.H)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

	PROJECTION = getProjection(viewer)
	MODELVIEW  = getModelview(viewer)
	lightpos=MODELVIEW * Point4d(viewer.pos[1],viewer.pos[2],viewer.pos[3],1.0)

	for mesh in viewer.meshes

		pdim=Dict(
			GL_POINTS        =>0,
			GL_LINES         =>1,
			GL_LINE_LOOP     =>2,
			GL_LINE_STRIP    =>3,
			GL_TRIANGLES     =>4,
			GL_TRIANGLE_STRIP=>5,
			GL_TRIANGLE_FAN  =>6,
			GL_QUADS         =>7)[mesh.primitive]

		for polygon_mode in (pdim>=2 ? [GL_FILL,GL_LINE] : [GL_FILL])

			glPolygonMode(GL_FRONT_AND_BACK,polygon_mode)
			if pdim>=2
			 	glEnable(GL_POLYGON_OFFSET_LINE)
			end
			lighting_enabled        =polygon_mode!=GL_LINE && length(mesh.normals.vector)>0
			color_attribute_enabled =polygon_mode!=GL_LINE && length(mesh.colors.vector )>0

			shader=getShader(viewer,lighting_enabled,color_attribute_enabled)
			enableProgram(shader)

			projection=PROJECTION
			modelview=MODELVIEW * mesh.T
			normal_matrix=dropW(transpose(inv(modelview)))

			glUniformMatrix4fv(glGetUniformLocation(shader.program_id, "u_modelview_matrix" ) ,1, GL_TRUE, flatten(modelview))
			glUniformMatrix4fv(glGetUniformLocation(shader.program_id, "u_projection_matrix") ,1, GL_TRUE, flatten(projection))
			glUniformMatrix3fv(glGetUniformLocation(shader.program_id, "u_normal_matrix")	  ,1, GL_TRUE, flatten(normal_matrix))

			u_light_position = glGetUniformLocation(shader.program_id, "u_light_position")
			if u_light_position>=0
				glUniform3f(u_light_position,lightpos[1]/lightpos[4],lightpos[2]/lightpos[4],lightpos[3]/lightpos[4])
			end

			u_color = glGetUniformLocation(shader.program_id, "u_color")
			if u_color>=0
				color=polygon_mode==GL_LINE ? Point4d(0.0,0.0,0.0,1.0) : Point4d(0.5,0.5,0.5,1.0)
				glUniform4f(u_color,color[1],color[2],color[3],color[4])
			end

			enableVertexArray(mesh.vertex_array)

			a_position          = glGetAttribLocation(shader.program_id, "a_position")
			a_normal            = glGetAttribLocation(shader.program_id, "a_normal")
			a_color             = glGetAttribLocation(shader.program_id, "a_color")

			enableAttribute(a_position,mesh.vertices,3)
			enableAttribute(a_normal  ,mesh.normals ,3)
			enableAttribute(a_color   ,mesh.colors ,4)

			glDrawArrays(mesh.primitive, 0, Int64(length(mesh.vertices.vector)/3))



			disableAttribute(a_position,mesh.vertices)
			disableAttribute(a_normal  ,mesh.normals)
			disableAttribute(a_color  ,mesh.colors)

			disableVertexArray(mesh.vertex_array)
			disableProgram(shader)

			glDepthMask(true)
			glPolygonMode(GL_FRONT_AND_BACK,GL_FILL)
			glDisable(GL_POLYGON_OFFSET_LINE)

		end
	end

	glCheckError()

end



"""
	redisplay(viewer::Viewer)

Redisplay the meshes in the current viewer object
"""
function redisplay(viewer::Viewer)
	# nothing to do
end



"""
	handleResizeEvent(viewer)

Handle resize window event, by getting the current size.
The `viewer` parameters for window `size` are updated.
"""
function handleResizeEvent(viewer)
	size=GLFW.GetWindowSize(viewer.win)
	viewer.W = size[1]*viewer.scalex
	viewer.H = size[2]*viewer.scaley
	redisplay(viewer);
end



"""
	handleMouseButtonEvent(viewer,button,action,mods)

Helper GLFW function to handle the Mouse Button Event.
"""
function handleMouseButtonEvent(viewer,button,action,mods)

	button=Dict(GLFW.MOUSE_BUTTON_1=>1,GLFW.MOUSE_BUTTON_2=>3,GLFW.MOUSE_BUTTON_3=>2)[button]

	if action == GLFW.PRESS && viewer.down_button==0
		viewer.down_button=button
		redisplay(viewer)
		return
	end

	if action==GLFW.RELEASE && button==viewer.down_button
		viewer.down_button=0
		redisplay(viewer)
		return
	end
end



"""
	handleMouseMoveEvent(viewer,x,y)

Helper GLFW function to handle the Mouse Move Event.
"""
function handleMouseMoveEvent(viewer,x,y)

	x=x*viewer.scalex
	y=y*viewer.scaley

	button=viewer.down_button

	if (button==0)
		viewer.mouse_beginx = x
		viewer.mouse_beginy = y
		return
	end

	deltax = float(x - viewer.mouse_beginx)
	deltay = float(viewer.mouse_beginy - y)
	W=viewer.W
	H=viewer.H

	modelview=getModelview(viewer)

	if button==1
		screen_center=Point3d(W/2.0,H/2.0,0.0)
		a=(Point3d((float)(viewer.mouse_beginx-screen_center[1]), (float)(H-viewer.mouse_beginy-screen_center[2]), 0))*(1.0/min(W,H))
		b=(Point3d((float)(                 x -screen_center[1]), (float)(H-                  y-screen_center[2]), 0))*(1.0/min(W,H))
		a[3]=2.0^(-0.5 * norm(a))
		b[3]=2.0^(-0.5 * norm(b))
		a = normalized(a)
		b = normalized(b)
		axis = normalized(cross(a,b))
		angle = acos(dot(a,b))

		#vt=Point3d(modelview[1,4],modelview[2,4],modelview[3,4])
		#modelview=translateMatrix(vt) * convertToMatrix(convertToQuaternion(modelview))

		q=Quaternion(axis, angle) * convertToQuaternion(modelview)
		vt=Point3d(modelview[1,4],modelview[2,4],modelview[3,4])
		modelview=translateMatrix(vt) * convertToMatrix(q)

	elseif button==3
		vt=Point3d(deltax* viewer.walk_speed,deltay* viewer.walk_speed,0.0)
		modelview = translateMatrix(vt) * modelview
	end

	viewer.pos,viewer.dir,viewer.vup=getLookAt(modelview)

	viewer.mouse_beginx = x
	viewer.mouse_beginy = y
	redisplay(viewer)
end



"""
	handleMouseWheelEvent(viewer,delta)

Helper GLFW function to handle the Mouse Wheel Event.
"""
function handleMouseWheelEvent(viewer,delta)
	viewer.pos=viewer.pos+viewer.dir * ((delta>=0 ? 10.0 : -10.0) * viewer.walk_speed)
	redisplay(viewer)
end



"""
	handleKeyPressEvent(viewer,key, scancode, action, mods)

Helper GLFW function to handle the Key Press Event.
"""
function handleKeyPressEvent(viewer,key, scancode, action, mods)

	if action != GLFW.PRESS && action != GLFW.REPEAT
		return
	end;

	x,y=0.5*viewer.W,0.5*viewer.H

	if key == GLFW.KEY_ESCAPE
		viewer.exitNow = true
		return
	end;

	if (key==GLFW.KEY_KP_ADD)
		viewer.walk_speed*=0.95
		return
	end;

	if (key==GLFW.KEY_KP_SUBTRACT)
		viewer.walk_speed*=(1.0/0.95)
		return
	end;

	if (key==GLFW.KEY_W)
		dir=unprojectPoint(viewer,0.5*viewer.W,0.5*viewer.H)
		# println("dir = $dir, walk_speed = $(viewer.walk_speed)")
		viewer.pos=viewer.pos+dir*viewer.walk_speed
		return redisplay(viewer);
	end;

	if (key==GLFW.KEY_S)
		dir=unprojectPoint(viewer,0.5*viewer.W,0.5*viewer.H)
		viewer.pos=viewer.pos-dir*viewer.walk_speed
		return redisplay(viewer);
	end;

	if (key==GLFW.KEY_O)
		viewer.use_ortho=!viewer.use_ortho
		println("use_ortho ",viewer.use_ortho)
		return redisplay(viewer);
	end;


	if (key==GLFW.KEY_UP)
		viewer.pos=viewer.pos+viewer.vup*viewer.walk_speed
		return redisplay(viewer);
	end;

	if (key==GLFW.KEY_DOWN)
		viewer.pos=viewer.pos-viewer.vup*viewer.walk_speed
		return redisplay(viewer);
	end;

	if (key==GLFW.KEY_LEFT || key==GLFW.KEY_A)
		right=normalized(cross(viewer.dir,viewer.vup))
		viewer.pos=viewer.pos-right*viewer.walk_speed
		return redisplay(viewer);
	end;

	if (key==GLFW.KEY_RIGHT || key==GLFW.KEY_D)
		right=normalized(cross(viewer.dir,viewer.vup))
		viewer.pos=viewer.pos+right*viewer.walk_speed
		return redisplay(viewer);
	end;

end;


# example: see GLMesh.jl for an example about how to generate a mesh
# GL.VIEW([
# 	GL.GLCuboid(GL.Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
# 	GL.GLAxis(GL.Point3d(-2,-2,-2),GL.Point3d(+2,+2,+2))
# 	])
