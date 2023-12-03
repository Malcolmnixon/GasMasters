@tool
class_name GameItem
extends T5StateItem


## Pointer event
signal pointer_event(event : T5ToolsPointerEvent)


## Inspection UI
@export var inspection_ui : PackedScene

## Inspection UI offset
@export var inspection_offset : Vector3

## Forward inspections to children
@export var inspect_child : bool


# Highlight object
var _highlight : Node3D


# Subscribe to pointer events
func _ready() -> void:
	# Get the highlight object
	_highlight = find_child("Highlight")
	if _highlight:
		_highlight.visible = false

	# Subscribe to pointer events
	pointer_event.connect(_on_pointer_event)


# Handle pointer event
func _on_pointer_event(event : T5ToolsPointerEvent) -> void:
	match event.event_type:
		T5ToolsPointerEvent.Type.ENTERED:
			if _highlight:
				_highlight.visible = true

		T5ToolsPointerEvent.Type.EXITED:
			if _highlight:
				_highlight.visible = false

		T5ToolsPointerEvent.Type.PRESSED:
			_on_pointer_pressed(event)


func _on_pointer_pressed(event : T5ToolsPointerEvent) -> void:
	# Test if inspections should be routed to child
	if inspect_child:
		var child := _find_child_game_item()
		if child:
			child._on_pointer_pressed(event)
			return

	# Skip if no UI
	if not inspection_ui:
		return

	# Trigger inspection on the player
	var player := event.player as Player
	if player:
		player.show_inspection_ui(
			self,
			inspection_offset,
			inspection_ui)


## Triger an interaction
func interaction(id : String) -> void:
	# Process the interaction
	match id:
		"destroy":
			destroy()


# Overridable load-state function
func _load_item_state(state : Dictionary) -> void:
	# Set parent if needed and specified
	if not get_parent():
		var parent_path = state.get("parent")
		if parent_path is NodePath:
			var parent := T5ToolsScene.get_current().get_node(parent_path)
			if parent:
				parent.add_child(self)


# Overridable save-state function
func _save_item_state(state : Dictionary) -> void:
	# Save the path to the parent	
	state["parent"] = T5ToolsScene.get_current().get_path_to(get_parent())


# Find a child game item
func _find_child_game_item() -> GameItem:
	# Search all children
	for index in get_child_count():
		var item := get_child(index) as GameItem
		if item:
			return item

	# No child game item found
	return null
