@tool
class_name T5StateItem
extends Node3D


## Unique ID of the item
@export var item_id : String

## Type of the item
@export var item_type : T5StateItemType

## Flag indicating whether the item was dynamically generated
@export var dynamic : bool


## Find all T5StateItem under the specified node
static func find_instances(p_node : Node) -> Array[T5StateItem]:
	var found : Array[T5StateItem] = []
	if p_node:
		_find_instances(p_node, found)
	return found


# Find all T5StateItem under the specified node
static func _find_instances(p_node : Node, p_found : Array[T5StateItem]) -> void:
	# Test this node
	var item := p_node as T5StateItem
	if item:
		p_found.append(item)

	# Recurse into children
	for i in p_node.get_child_count():
		_find_instances(p_node.get_child(i), p_found)
