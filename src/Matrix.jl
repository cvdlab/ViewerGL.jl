using LinearAlgebra

"""
Construct a statically-sized, mutable array of dimensions S (expressed as a Tuple{...}) using the data from a.
# Example
```
Matrix3(a0,a1,a2,a3,a4,a5,a6,a7,a8)= Matrix3([a0 a1 a2 ; a3 a4 a5 ; a6 a7 a8])
```
"""
const Matrix3=MMatrix{3, 3, Float64}
Matrix3(a0,a1,a2,a3,a4,a5,a6,a7,a8)= Matrix3([a0 a1 a2 ; a3 a4 a5 ; a6 a7 a8])
Matrix3() =  Matrix4(1,0,0, 0,1,0, 0,0,1)




"""
Construct a statically-sized, mutable array of dimensions S (expressed as a Tuple{...}) using the data from a.
# Example
```
Matrix4(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15)= Matrix4([a0 a1 a2 a3 ; a4 a5 a6 a7; a8 a9 a10 a11; a12 a13 a14 a15])
```
"""
const Matrix4=MMatrix{4, 4, Float64}
Matrix4(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15)= Matrix4([a0 a1 a2 a3 ; a4 a5 a6 a7; a8 a9 a10 a11; a12 a13 a14 a15])
Matrix4() =  Matrix4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1)



 """
 	flatten(T::Matrix3)

Flatten `T`  by row: value of `Matrix3` into a 1D array,.
 # Example
 ```
 julia> T = convert(GL.Matrix3, rand(Float64, 3,3))
 3×3 StaticArrays.MArray{Tuple{3,3},Float64,2,9}:
  0.774754  0.681844  0.642835
  0.686775  0.448813  0.0144597
  0.824035  0.438451  0.0153561

 julia> GL.flatten(T::GL.Matrix3)
 9-element Array{Float32,1}:
  0.77475363
  0.6818439
	...
  0.4384512
  0.01535608
 ```
 """
function flatten(T::Matrix3)
	return Vector{Float32}([
		T[1,1],T[1,2],T[1,3],
		T[2,1],T[2,2],T[2,3],
		T[3,1],T[3,2],T[3,3]])
end



"""
	flatten(T::Matrix4)

Flatten `T` by row a value of `Matrix4` into a 1D array.

# Example

```
julia> T = convert(GL.Matrix4, rand(Float64, 4,4))
4×4 StaticArrays.MArray{Tuple{4,4},Float64,2,16}:
 0.23079   0.620179  0.362604   0.136963
	...		 ...	   ...		  ...
 0.328367  0.709699  0.170108   0.848778

julia> GL.flatten(T::GL.Matrix4)
16-element Array{Float32,1}:
 0.23079032
 0.6201795
	...
 0.17010835
 0.84877783
```
"""
function flatten(T::Matrix4)
	return Vector{Float32}([
		T[1,1],T[1,2],T[1,3],T[1,4],
		T[2,1],T[2,2],T[2,3],T[2,4],
		T[3,1],T[3,2],T[3,3],T[3,4],
		T[4,1],T[4,2],T[4,3],T[4,4]])
end



"""
	dropW(T::Matrix4)

Remove the last row and column of a `Matrix4`.
# Example
```
julia> typeof(T)
StaticArrays.MArray{Tuple{4,4},Float64,2,16}

julia> GL.dropW(T)
3×3 StaticArrays.MArray{Tuple{3,3},Float64,2,9}:
 0.23079   0.620179  0.362604
 0.650641  0.431527  0.0229223
 0.534276  0.190774  0.946666
```
"""
function dropW(T::Matrix4)
	return Matrix3(
		T[1,1],T[1,2],T[1,3],
		T[2,1],T[2,2],T[2,3],
		T[3,1],T[3,2],T[3,3])
end


"""
	translateMatrix(vt::Point3d)

Build a translation `Matrix4` from a translaction vector `Point3d`.
# Example
```
julia> GL.translateMatrix(GL.Point3d(1,2,3))
4×4 MArray{Tuple{4,4},Float64,2,16}:
 1.0  0.0  0.0  1.0
 0.0  1.0  0.0  2.0
 0.0  0.0  1.0  3.0
 0.0  0.0  0.0  1.0
```
"""
function translateMatrix(vt::Point3d)
	return Matrix4(
		1.0, 0.0, 0.0, vt[1],
		0.0, 1.0, 0.0, vt[2],
		0.0, 0.0, 1.0, vt[3],
		0.0, 0.0, 0.0, 1.0)
end



"""
	scaleMatrix(vs::Point3d)

Build a scaling `Matrix4` from a `vs` scaling vector `Point3d`.
# Example
```
julia> GL.scaleMatrix(GL.Point3d(1.1,1.2,1.3))
4×4 MArray{Tuple{4,4},Float64,2,16}:
 1.1  0.0  0.0  0.0
 0.0  1.2  0.0  0.0
 0.0  0.0  1.3  0.0
 0.0  0.0  0.0  1.0
```
"""
function scaleMatrix(vs::Point3d)
	return Matrix4(
		vs[1], 0.0, 0.0, 0.0,
		0.0, vs[2], 0.0, 0.0,
		0.0, 0.0, vs[3], 0.0,
		0.0, 0.0, 0.0, 1.0)
end



"""
	lookAtMatrix(eye::Point3d, center::Point3d, up::Point3d)

Build a *lookAtMatrix* `Matrix4`.

In order to set a camera position, all really needed is a point to set the *camera position* in world space, referred to as the `from` point, and a point that defines *where the camera is looking at*, referred as the `to` point. The camera orintation is specified by the `up` vector, whose projection is seen vertical in screen coordinates.

# Example
```
julia> GL.lookAtMatrix(GL.Point3d(2,2,2), GL.Point3d(0,0,0), GL.Point3d(0,0,1))
4×4 MArray{Tuple{4,4},Float64,2,16}:
 -0.707107   0.707107  0.0        0.0
 -0.408248  -0.408248  0.816497   0.0
  0.57735    0.57735   0.57735   -3.4641
  0.0        0.0       0.0        1.0
```
"""
function lookAtMatrix(eye::Point3d, center::Point3d, up::Point3d)
	forward = normalized(center-eye)
	side    = normalized(cross(forward,up))
	up      = cross(side,forward)
	m = Matrix4(
		side[1],up[1],-forward[1], 0.0,
		side[2],up[2],-forward[2], 0.0,
		side[3],up[3],-forward[3], 0.0,
		    0.0,  0.0,        0.0, 1.0
	)
	return transpose(m) * translateMatrix(-1*eye)
end




"""
	perspectiveMatrix(fovy::Float64, aspect::Float64, zNear::Float64, zFar::Float64)

Generation of the perspective matrix. Using 4 real parameters:
-	`fovy::Float64` is the ``y`` component of ``field-ov-view`` in radians
-	`aspect::Float64` is the ratio ``width/height`` of viewport in screen space
-	`zNear::Float64` is -1 in clip space.
-	`zFar::Float64` is a positive number in clip space.
"""
function perspectiveMatrix(fovy::Float64, aspect::Float64, zNear::Float64, zFar::Float64)
	radians =  deg2rad(fovy/2.0)
	cotangent = cos(radians) / sin(radians)
	m=Matrix4()
	m[1,1] = cotangent / aspect
	m[2,2] = cotangent
	m[3,3] = -(zFar + zNear) / (zFar - zNear)
	m[3,4] = -1.0
	m[4,3] = -2.0 * zNear * zFar / (zFar - zNear)
	m[4,4] =  0.0
	return transpose(m)
end


function orthoMatrix(left::Float64, right::Float64, bottom::Float64, top::Float64, nearZ::Float64, farZ::Float64)
	m=Matrix4()
	m[1,1] = 2 / (right-left); m[1,2] =                0; m[1,3] =                 0; m[1,4] = -(right+left) / (right-left)
	m[2,1] =                0; m[2,2] = 2 / (top-bottom); m[2,3] =                 0; m[2,4] = -(top+bottom) / (top-bottom)
	m[3,1] =                0; m[3,2] =                0; m[3,3] = -2 / (farZ-nearZ); m[3,4] = -(farZ+nearZ) / (farZ-nearZ)
	m[4,1] =                0; m[4,2] =                0; m[4,3] =                 0; m[4,4] = 1
	return m
end


"""
	getLookAt(T::Matrix4)

Return `pos`,`dir`,`vup` vectors in world space.
"""
function getLookAt(T::Matrix4)
	T=inv(T)
	pos=          (Point3d(  T[1,4], T[2,4], T[3,4]))
	dir=normalized(Point3d( -T[1,3],-T[2,3],-T[3,3]))
	vup=normalized(Point3d(  T[1,2], T[2,2], T[3,2]))
	pos,dir,vup
end
