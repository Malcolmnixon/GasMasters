class_name InteractableObject
extends Node3D


## Pointer event
signal pointer_event(event : T5ToolsPointerEvent)


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
			_on_pressed(event)


# Handle pressed
func _on_pressed(_event : T5ToolsPointerEvent) -> void:
	pass


# Interaction invoked
func interaction(_id : String) -> void:
	pass
