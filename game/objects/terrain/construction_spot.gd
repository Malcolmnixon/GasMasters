extends InteractableObject


const TURBINE_LOW = preload("res://game/objects/buildings/turbine_low.tscn")
const TURBINE_HIGH = preload("res://game/objects/buildings/turbine_high.tscn")


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

	# Show the interaction menu
	player.show_interaction_menu(
		self,
		Vector3.ZERO,
		"Construct",
		[
			{
				id = "lander",
				text = "Lander",
				confirm = "Confirm Landing Site"
			},
			{
				id = "turbine_low",
				text = "Turbine Low",
				confirm = "Confirm Turbine Low: ₡40"
			},
			{
				id = "turbine_high",
				text = "Turbine High",
				confirm = "Confirm Turbine Low: ₡100"
			}
		])


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"lander":
			pass

		"turbine_low":
			_construction = TURBINE_LOW.instantiate()
			add_child(_construction)

		"turbine_high":
			_construction = TURBINE_HIGH.instantiate()
			add_child(_construction)
