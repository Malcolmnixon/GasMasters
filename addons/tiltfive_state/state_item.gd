@tool
class_name T5StateItem
extends Node3D


## Unique ID of the item
@export var item_id : String

## Type of the item
@export var item_type : T5StateItemType

## Flag indicating whether the item was dynamically generated
@export var dynamic : bool


# Get configuration warnings
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()

	# Verify item ID is set
	if not item_id:
		warnings.append("Item ID not set")

	# Verify the item type is set
	if not item_type:
		warnings.append("Item Type not set")

	# Return warnings
	return warnings


# Handle notifications
func _notification(what : int) -> void:
	# Ignore notifications on freeing objects
	if is_queued_for_deletion():
		return

	match what:
		T5State.NOTIFICATION_STATE_LOAD:
			_state_load()

		T5State.NOTIFICATION_STATE_SAVE:
			_state_save()

		T5State.NOTIFICATION_STATE_DESTROY:
			_state_destroy()


## Destroy the item
func destroy() -> void:
	# Propagate destruction to this node and all children
	propagate_notification(T5State.NOTIFICATION_STATE_DESTROY)


# Perform state loading
func _state_load() -> void:
	# Read the state
	var state = T5StateData.active.get_value(item_id)
	if not state is Dictionary:
		return

	# Handle design-time item destroyed
	if state.get("destroyed", false):
		queue_free()
		return

	# Load the item state
	_load_item_state(state)


# Perform state saving
func _state_save() -> void:
	# Populate the state
	var state := { type = item_type.type_id };
	_save_item_state(state)

	# Save the state
	T5StateData.active.set_value(item_id, state)


# Perform state destruction
func _state_destroy() -> void:
	# Persist destroyed state
	if dynamic:
		# Dynamic items can be cleared from the data
		T5StateData.active.clear_value(item_id)
	else:
		# Design-time items must be saved as destroyed
		T5StateData.active.set_value(
			item_id, 
			{ 
				type = item_type.type_id,
				destroyed = true
			})

	# Queue the item for destruction
	queue_free()


# Overridable load-state function
func _load_item_state(state : Dictionary) -> void:
	# By default just persist the location
	var location = state.get("location")
	if location is Transform3D:
		global_transform = location


# Overridable save-state function
func _save_item_state(state : Dictionary) -> void:
	# By default just persist the location
	state["location"] = global_transform


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
