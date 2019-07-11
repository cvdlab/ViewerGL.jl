using LinearAlgebraicRepresentation, ViewerGL
GL = ViewerGL; Lar = LinearAlgebraicRepresentation

function randomlines(n=300, t=0.4)
	V = zeros(Float64,2,2*n)
	EV = [zeros(Int64,2) for k=1:n]
	for k=1:n
		v1 = rand(Float64,2)
		v2 = rand(Float64,2)
		vm = (v1+v2)/2
		transl = rand(Float64,2)
		V[:,k] = (v1-vm)*t + transl
		V[:,n+k] = (v2-vm)*t + transl
		EV[k] = [k,n+k]
	end
	return V,EV
end

V,EV = randomlines(300,.4)

meshes = []
for k=1:length(EV)
	color = GL.COLORS[k%12+1] - (rand(Float64,4)*0.1)
	push!(meshes, GL.GLGrid(V,[EV[k]],color,1) )
end
GL.VIEW(meshes);


meshes = []
model = V,EV
W,EW = Lar.fragmentlines(model);
for k=1:length(EW)
	color = GL.COLORS[k%12+1] - (rand(Float64,4)*0.1)
	push!(meshes, GL.GLGrid(W,[EW[k]],color,1) )
end
GL.VIEW(meshes);
