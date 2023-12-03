extends GameItem


# Gas Cargo Limit
const CARGO_LIMIT : float = 60.0

# Gas Cargo Type
const CARGO_TYPE := preload("res://game/objects/game_items/mining_cargo/mining_cargo_type.tres")


## Drill speed
@export var speed : float = 7.0

## Gas gathered
@export var gas_gathered : float = 0.0


func _process(delta : float) -> void:
	# Test if we have cargo
	var child := _find_child_game_item()
	if child:
		gas_gathered = 0.0
		return

	# Skip if no power
	if not _zone.has_power:
		return

	# Rotate the drill module when powered
	$drill_structure/drill_module.rotate_y(delta * speed)

	# Spawn cargo when full
	gas_gathered += delta
	if gas_gathered > CARGO_LIMIT:
		gas_gathered = 0.0
		add_child(CARGO_TYPE.create_dynamic())
