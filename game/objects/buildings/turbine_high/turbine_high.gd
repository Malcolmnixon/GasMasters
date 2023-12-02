class_name TurbineHigh
extends InteractableObject


## Turbine High UI
const UI : PackedScene = \
	preload("res://game/objects/buildings/turbine_high/turbine_high_ui.tscn")

## Turbine High price
const PRICE : int = 100


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
		UI)


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"destroy":
			queue_free()
