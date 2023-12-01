class_name T5ToolsMotionBox
extends T5ToolsMotionRegion


@export var shape : BoxShape3D


func region_move(position : Vector3, distance : Vector3) -> Vector3:
	# Get the extents
	var extents := shape.size * 0.5

	# Get the target
	var target := position + distance

	# Clamp in local space
	target = to_local(target)
	target.x = clamp(target.x, -extents.x, extents.x)
	target.y = clamp(target.y, -extents.y, extents.y)
	target.z = clamp(target.z, -extents.z, extents.z)
	target = to_global(target)

	# Return the clamped target
	return target
