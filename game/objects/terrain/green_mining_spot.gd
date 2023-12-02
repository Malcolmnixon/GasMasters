extends InteractableObject


const MINING_RIG = preload("res://game/objects/buildings/mining_rig.tscn")


# Current construction
var _construction : InteractableObject


# Handle pressed
func _on_pressed(_event : T5ToolsPointerEvent) -> void:
	# Get the player
	var player := _event.player as Player
	if not player:
		return

	# Show the interaction menu
	player.show_interaction_menu(
		self,
		Vector3.ZERO,
		"Mine",
		[
			{
				id = "mine",
				text = "Mine",
				confirm = "Confirm Mining: ₡100"
			}
		])


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"mine":
			_construction = MINING_RIG.instantiate()
			add_child(_construction)
