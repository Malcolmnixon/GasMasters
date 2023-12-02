class_name MiningRig
extends InteractableObject


## Mining Rig UI
const UI : PackedScene = \
	preload("res://game/objects/buildings/mining_rig/mining_rig_ui.tscn")

## Mining Rig price
const PRICE : int = 140


# Handle pressed
func _on_pressed(event : T5ToolsPointerEvent) -> void:
	# Get the player
	var player := event.player as Player
	if not player:
		return

	# Show the ui
	player.show_interaction_ui(
		self,
		Vector3(0, 4, 0),
		UI)


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"destroy":
			queue_free()
