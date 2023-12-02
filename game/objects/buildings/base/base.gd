extends InteractableObject


## Base UI
const UI : PackedScene = \
	preload("res://game/objects/buildings/base/base_ui.tscn")


# Handle pressed
func _on_pressed(event : T5ToolsPointerEvent) -> void:
	# Get the player
	var player := event.player as Player
	if not player:
		return

	# Show the UI
	player.show_interaction_ui(
		self,
		Vector3(0, 2, 0),
		UI)
