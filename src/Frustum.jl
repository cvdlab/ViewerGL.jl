


"""
	FrustumMap(viewport::Matrix4,projection::Matrix4,modelview::Matrix4)

`mutable struct` to contain the current values of matrices of viewing pipeline.

The constructor `FrustumMap()` returns the `viewport`, `projection`, `modelview` matrices and their inverses.

# Example
```
function projectPoint(map::FrustumMap,p3::Point3d)
	p4=(map.viewport * (map.projection * (map.modelview * Point4d(p3[1],p3[2],p3[3],1.0))))
	return Point3d(p4[1]/p4[4],p4[2]/p4[4],p4[3]/p4[4])
end
```
"""
mutable struct FrustumMap

	viewport::Matrix4
	projection::Matrix4
	modelview::Matrix4

	inv_viewport::Matrix4
	inv_projection::Matrix4
	inv_modelview::Matrix4

	# constructor
	function FrustumMap(viewport,projection::Matrix4,modelview::Matrix4)
		viewport_T=Matrix4(
			viewport[3] / 2.0,                  0,       0, viewport[1] + viewport[3] / 2.0,
		                   0,  viewport[4] / 2.0,       0, viewport[2] + viewport[4] / 2.0,
		                   0,                  0, 1 / 2.0, 1 / 2.0)
		new(viewport_T,projection,modelview,inv(ret.viewport),inv(ret.projection),inv(ret.modelview))
	end

end



"""
	projectPoint(map::FrustumMap,p3::Point3d)

Return in 3D screen coordinates the *point of projection*, given in 3D world coordinates.
"""
function projectPoint(map::FrustumMap,p3::Point3d)
	p4=(map.viewport * (map.projection * (map.modelview * Point4d(p3[1],p3[2],p3[3],1.0))))
	return Point3d(p4[1]/p4[4],p4[2]/p4[4],p4[3]/p4[4])
end



"""
	nprojectPoint(map::FrustumMap,x::Float32,y::Float32, z::Float32)

Return in 3D world coordinates a `GL.Point3d`, given in 3D screen coordinates.
Use the inverse matrices of viewing transformation, contained in `map::FrustumMap`.
"""
function unprojectPoint(map::FrustumMap,x::Float32,y::Float32, z::Float32)
	p4 = (map.inv_modelview * (map.inv_projection * (map.inv_viewport * Point4d(x,y,z, 1.0))))
	if p4.w==0
		p4.w=1
	end
	return Point3d(p4[1]/p4[4],p4[2]/p4[4],p4[3]/p4[4])
end
