
V,FVs = randomlines(30,2)

assembly = explodecells(V,FVs,1,1,1)
meshes = Any[]
for k=1:length(assembly)-1
	mesh = assembly[k]
	color = GL.COLORS[k%12+1] - (rand(Float64,4)*0.1)
	push!(meshes, GL.GLGrid(mesh,color) )
end

GL.VIEW(meshes);


assembly = explodecells(V,FVs,1.2,1.2,1.2)
meshes = Any[]
for k=1:length(assembly)-1
	mesh = assembly[k]
	color = GL.COLORS[k%12+1] - (rand(Float64,4)*0.1)
	push!(meshes, GL.GLGrid(mesh) )
end

GL.VIEW(meshes);
