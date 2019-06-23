
"""
	Box3d(p1::Point3d,p2::Point3d)

Mutable `struct`, with two fields `p1::Point3d` and `p2::Point3d`.
Two constructors `Box3d()` and `Box3d(p1::Point3d,p2::Point3d)`
# Example
```

```
"""
mutable struct Box3d
	p1::Point3d
	p2::Point3d

	# constyructor
	function Box3d()
		new(Point3d(0,0,0),Point3d(0,0,0))
	end

	# constructor
	function Box3d(p1::Point3d,p2::Point3d)
		new(p1,p2)
	end

end

Base.:(==)(a::Box3d, b::Box3d) = a.p1 == b.p1 && a.p2 == b.p2



"""
	invalidBox()

Returns an object of type `ViewerGL.Box3d`.
# Example
```
julia> invalidBox().p1
3-element StaticArrays.MArray{Tuple{3},Float64,1,3}:
 Inf
 Inf
 Inf

 julia> invalidBox().p2
 3-element StaticArrays.MArray{Tuple{3},Float64,1,3}:
  -Inf
  -Inf
  -Inf
```
"""
function invalidBox()
	m,M=typemin(Float64),typemax(Float64)
	return Box3d(Point3d(M,M,M),Point3d(m,m,m))
end



"""
	addPoint(box::GL.Box3d,point::GL.Point3d)

Update a mutable `Box3d`.
# Example
```
julia> box = GL.addPoint(GL.invalidBox(), GL.Point3d(1.0,2.0,0.0))
ViewerGL.Box3d([1.0, 2.0, 0.0], [1.0, 2.0, 0.0])
```
"""
function addPoint(box::Box3d,point::Point3d)
	for i in 1:3
		box.p1[i]=min(box.p1[i],point[i])
		box.p2[i]=max(box.p2[i],point[i])
	end
	return box
end



"""
	getPoints(box::Box3d)

Return the 8 vertices of an object of `Box3d` type.
# Example
```
julia> box = GL.getPoints(GL.Box3d(GL.Point3d(0,0,0),GL.Point3d(1,1,1)))
8-element Array{StaticArrays.MArray{Tuple{3},Float64,1,3},1}:
 [0.0, 0.0, 0.0]
 [1.0, 0.0, 0.0]
 [1.0, 1.0, 0.0]
 [0.0, 1.0, 0.0]
 [0.0, 0.0, 1.0]
 [1.0, 0.0, 1.0]
 [1.0, 1.0, 1.0]
 [0.0, 1.0, 1.0]
```
"""
function getPoints(box::Box3d)
	return [
		Point3d(box.p1[1],box.p1[2],box.p1[3]),
		Point3d(box.p2[1],box.p1[2],box.p1[3]),
		Point3d(box.p2[1],box.p2[2],box.p1[3]),
		Point3d(box.p1[1],box.p2[2],box.p1[3]),
		Point3d(box.p1[1],box.p1[2],box.p2[3]),
		Point3d(box.p2[1],box.p1[2],box.p2[3]),
		Point3d(box.p2[1],box.p2[2],box.p2[3]),
		Point3d(box.p1[1],box.p2[2],box.p2[3])
	]
end
