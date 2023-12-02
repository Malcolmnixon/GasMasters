extends InteractableObject


const UI = preload("res://game/objects/terrain/construction_spot/construction_spot_ui.tscn")
const TURBINE_LOW = preload("res://game/objects/buildings/turbine_low/turbine_low.tscn")
const TURBINE_HIGH = preload("res://game/objects/buildings/turbine_high/turbine_high.tscn")


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

	player.show_interaction_ui(
		self,
		Vector3.ZERO,
		UI)


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"buy_turbine_low":
			_construction = TURBINE_LOW.instantiate()
			add_child(_construction)

		"buy_turbine_high":
			_construction = TURBINE_HIGH.instantiate()
			add_child(_construction)
