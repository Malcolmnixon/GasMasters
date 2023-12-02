extends InteractableObject


const MINING_RIG = preload("res://game/objects/buildings/mining_rig/mining_rig.tscn")


# Current construction
var _construction : InteractableObject


# Handle pressed
func _on_pressed(event : T5ToolsPointerEvent) -> void:
	# If we have a construction then defer to it
	if is_instance_valid(_construction):
		_construction._on_pressed(event)
		return

	# Get the player
	var player := event.player as Player
	if not player:
		return

	# Show the UI
	player.show_interaction_ui(
		self,
		Vector3.ZERO,
		preload("res://game/objects/terrain/green_mining_spot/green_mining_spot_ui.tscn"))


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"buy_mine":
			_construction = MINING_RIG.instantiate()
			add_child(_construction)
