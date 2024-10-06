class_name Util
extends Object

# taken from chat lol
# puts the point in the same coordinate system as the shape, then clamps it to the side of the
# rect, then undoes the transform
static func closest_point_rect(collision_shape: CollisionShape2D, target_point: Vector2) -> Vector2:
	var rect := collision_shape.shape as RectangleShape2D
	var xform := collision_shape.global_transform
	var extents := rect.size

	var local_point := xform.affine_inverse() * target_point

	var closest_local_point = Vector2(
        clamp(local_point.x, -extents.x, extents.x),
        clamp(local_point.y, -extents.y, extents.y),
    )

	return xform * closest_local_point
