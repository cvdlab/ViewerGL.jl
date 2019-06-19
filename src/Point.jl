using StaticArrays

const Point2d=MVector{2,Float64}
const Point3d=MVector{3,Float64}
const Point4d=MVector{4,Float64}

Point2d() = Point2d(0.0,0.0)
Point3d() = Point3d(0.0,0.0,0.0)
Point4d() = Point4d(0.0,0.0,0.0,0.0)



"""
	norm(p::Point2d)

Return the norm of a `Point2d` object
# Example
```
julia> GL.norm(GL.Point2d(1,1))
1.4142135623730951
```
"""
function norm(p::Point2d)
	return sqrt(p[1]*p[1] + p[2]*p[2])
end



"""
	norm(p::Point3d)

Return the norm of a `Point3d` object
# Example
```
julia> GL.norm(GL.Point3d(1,1,1))
1.7320508075688772
```
"""
function norm(p::Point3d)
	return sqrt(p[1]*p[1] + p[2]*p[2] + p[3]*p[3])
end



"""
norm(p::Point4d)

Return the norm of a `Point4d` object
# Example
```
julia> GL.norm(GL.Point4d(1,1,1,1))
2.0
```
"""
function norm(p::Point4d)
	return sqrt(p[1]*p[1] + p[2]*p[2] + p[3]*p[3] + p[4]*p[4])
end



"""
	normalized(p::Point2d)

Return the unit vector parallel to `p::Point2d`.
# Example
```
julia> GL.normalized(GL.Point2d(1,1))
2-element MArray{Tuple{2},Float64,1,2}:
 0.7071067811865475
 0.7071067811865475
```
"""
function normalized(p::Point2d)
	len=norm(p)
	return Point2d(p[1] / len, p[2] / len)
end



"""
normalized(p::Point3d)

Return the unit vector parallel to `p::Point3d`.
# Example
```
julia> GL.normalized(GL.Point3d(1,1,1))
3-element MArray{Tuple{3},Float64,1,3}:
 0.5773502691896258
 0.5773502691896258
 0.5773502691896258

julia> GL.norm(GL.normalized(GL.Point3d(1,1,1)))
1.0
```
"""
function normalized(p::Point3d)
	len=norm(p)
	return Point3d(p[1] / len, p[2] / len, p[3] / len)
end



"""
normalized(p::Point4d)

Return the unit vector parallel to `p::Point4d`.
# Example
```
julia> GL.normalized(GL.Point4d(1,1,1,1))
4-element MArray{Tuple{4},Float64,1,4}:
 0.5
 0.5
 0.5
 0.5

julia> GL.norm(GL.normalized(GL.Point4d(1,1,1)))
1.0
```
"""
function normalized(p::Point4d)
	len=norm(p)
	return Point4d(p[1] / len, p[2] / len, p[3] / len, p[4] / len)
end



"""
	dropW(p::Point4d)

Divide `p` for the fourth coordinate, and return the first three ones.
# Example
```
julia> GL.dropW(GL.Point4d(2,2,2,2))
3-element MArray{Tuple{3},Float64,1,3}:
 1.0
 1.0
 1.0
"""
function dropW(p::Point4d)
	return Point3d(p[1] / p[4], p[2] / p[4], p[3] / p[4])
end
