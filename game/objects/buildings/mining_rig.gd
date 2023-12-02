class_name MiningRig
extends InteractableObject


# Handle pressed
func _on_pressed(event : T5ToolsPointerEvent) -> void:
	# Get the player
	var player := event.player as Player
	if not player:
		return

	# Show the interaction menu
	player.show_interaction_menu(
		self,
		Vector3(0, 4, 0),
		"Modify",
		[
			{
				id = "destroy",
				text = "Destroy",
				confirm = "Confirm Destroy"
			}
		])


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"destroy":
			queue_free()
