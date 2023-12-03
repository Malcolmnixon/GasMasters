extends T5StateData


## Starting cash
const STARTING_CASH : int = 300


## Starting zone
@export var game_start_zone : T5StateZoneInfo

## Current game name (save slot)
@export var game_name : String = ""

## Current game cash
@export var cash : int

## Current play time
@export var play_time : float


func _enter_tree() -> void:
	T5StateData.active = self


func _process(delta : float) -> void:
	if not get_tree().paused:
		play_time += delta


## Test if in a game
func is_in_game() -> bool:
	return game_name != ""


## Start a new game
func new_game(p_name : String) -> void:
	# Initialize game state
	clear_all()
	game_name = p_name
	cash = STARTING_CASH
	play_time = 0.0

	# Switch to the game start zone
	switch_zone(game_start_zone.zone_id)


## Save the current game
func save_game() -> void:
	# Skip if no game
	if not game_name:
		push_error("No current game to save")
		return

	# Get the current zone
	var zone = T5ToolsStaging.instance.current_scene as T5StateZone
	if not zone:
		push_error("Current game is not in a zone")
		return

	# Save all information about the zone
	zone.save_state()

	# Construct summary
	var date := Time.get_datetime_dict_from_system()
	var summary := {
		"date" : "%d / %d / %d" % [ date.year, date.month, date.day ],
		"cash" : cash,
		"play_time" : play_time
	}

	# Save the current information
	set_value("current_zone", zone.zone_info.zone_id)
	set_value("cash", cash)
	set_value("play_time", play_time)
	save_data(game_name, summary)


## Load an existing game
func load_game(p_name : String) -> bool:
	# Attempt to load the game data
	if not load_data(p_name):
		return false

	# Switch to the game
	game_name = p_name
	cash = get_value("cash")
	play_time = get_value("play_time")
	switch_zone(get_value("current_zone"))
	return true


## Exit the current game
func exit_game() -> void:
	# Clear game state
	clear_all()
	game_name = ""

	# Switch to start scene
	T5ToolsStaging.load_scene(T5ToolsStaging.instance.start_scene)


## Switch to a zone
func switch_zone(p_zone_id : String) -> void:
	# Get the zone
	var zone := zone_database.get_zone(p_zone_id)
	if not zone:
		push_error("Zone %s not found", p_zone_id)
		return

	# Switch to the zone scene
	T5ToolsStaging.load_scene(zone.instance_scene)
