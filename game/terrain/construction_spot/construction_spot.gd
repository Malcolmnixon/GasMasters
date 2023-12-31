@tool
extends Terrain


const TURBINE_LOW := preload("res://game/objects/game_items/turbine_low/turbine_low_type.tres")
const TURBINE_HIGH := preload("res://game/objects/game_items/turbine_high/turbine_high_type.tres")
const RESEARCH_STATION := preload("res://game/objects/game_items/research_station/research_station_type.tres")


# Interaction invoked
func interaction(id : String) -> void:
	match id:
		"buy_turbine_low":
			add_child(TURBINE_LOW.create_dynamic())

		"buy_turbine_high":
			add_child(TURBINE_HIGH.create_dynamic())

		"buy_research_station":
			add_child(RESEARCH_STATION.create_dynamic())
