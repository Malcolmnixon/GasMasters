extends StaticBody3D


## Pointer event
signal pointer_event(event : T5ToolsPointerEvent)


func _ready() -> void:
	# Subscribe to pointer events
	pointer_event.connect(_on_pointer_event)


# Handle pointer event
func _on_pointer_event(event : T5ToolsPointerEvent) -> void:
	if event.event_type == T5ToolsPointerEvent.Type.ENTERED:
		$HighlightMesh.visible = true
	elif event.event_type == T5ToolsPointerEvent.Type.EXITED:
		$HighlightMesh.visible = false
