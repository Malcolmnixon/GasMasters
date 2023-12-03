@tool
extends Terrain


const MINING_RIG := preload("res://game/objects/game_items/mining_rig/mining_rig_type.tres")


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"buy_mine":
			add_child(MINING_RIG.create_dynamic())
