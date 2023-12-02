class_name TurbineHigh
extends InteractableObject


# Handle pressed
func _on_pressed(event : T5ToolsPointerEvent) -> void:
	# Get the player
	var player := event.player as Player
	if not player:
		return

	# Show the UI
	player.show_interaction_ui(
		self,
		Vector3(0, 4, 0),
		preload("res://game/objects/buildings/turbine_high/turbine_high_ui.tscn"))


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"destroy":
			queue_free()
