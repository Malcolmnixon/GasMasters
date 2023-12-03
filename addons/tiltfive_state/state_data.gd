class_name T5StateData
extends Node


## Active state data for the current game
static var active : T5StateData = null


## Password for encrypted save files
@export var save_file_password := ""

## Database of zones
@export var zone_database : T5StateZoneDatabase

## Database of items
@export var item_database : T5StateItemDatabase


# State data dictionary
var _data := {}


## Set a state value
func set_value(p_id : String, p_value : Variant) -> void:
	_data[p_id] = p_value


## Get a state value
func get_value(p_id : String, p_default : Variant = null) -> Variant:
	return _data.get(p_id, p_default)


## Clear a state value
func clear_value(p_id : String) -> void:
	_data.erase(p_id)


## Clear state values matching a pattern
func clear_matching(p_pattern : String) -> void:
	for key : String in _data.keys():
		if key.match(p_pattern):
			_data.erase(key)


## Clear all state values
func clear_all() -> void:
	_data.clear()


## Load summary information from save-data
func load_summary(p_save_name : String) -> Variant:
	# Open the save-file for reading
	var file := _open_file(p_save_name, FileAccess.READ)
	if not file:
		return null

	# Read the summary
	var summary = file.get_var()
	file.close()

	# Return the summary
	return summary


## Load save-data
func load_data(p_save_name : String) -> bool:
	# Open the save-file for reading
	var file := _open_file(p_save_name, FileAccess.READ)
	if not file:
		return false

	# Skip the summary
	file.get_var()

	# Read the data
	var new_data = file.get_var()
	file.close()

	# Skip if not dictionary
	if not new_data is Dictionary:
		return false

	# Use the new data and report success
	_data = new_data
	return true


## Save current state 
func save_data(p_save_name : String, p_summary : Variant) -> bool:
	# Open the save-file for writing
	var file := _open_file(p_save_name, FileAccess.WRITE)
	if not file:
		return false

	# Write the summary
	file.store_var(p_summary)

	# Write the data
	file.store_var(_data)

	# Close the file and return success
	file.close()
	return true


## Get a list of save-data
func list_save_names() -> Array[String]:
	# Construct the return list
	var ret : Array[String] = []

	# Build a regular expression to match save file names
	var regex := RegEx.new()
	regex.compile("^save_(?<name>.*)\\.data$")

	# Process all files in the user folder
	for file in DirAccess.get_files_at("user://"):
		var result := regex.search(file)
		if result:
			ret.append(result.get_string("name"))

	# Return the save files
	return ret


## Delete save-data by name
static func delete_save(p_save_name : String) -> bool:
	# Construct the file name
	var file_path := "user://save_%s.data" % p_save_name

	# Remove the file
	return DirAccess.remove_absolute(file_path) == OK


# Open a save-file
func _open_file(p_save_name : String, p_mode : FileAccess.ModeFlags) -> FileAccess:
	# Construct the file name
	var file_path := "user://save_%s.data" % p_save_name

	# Warn about unencrypted save files for debugging
	if save_file_password == "":
		push_warning("Unencrypted save file: ", file_path)
		return FileAccess.open(file_path, p_mode)

	# Handle encrypted file with password
	return FileAccess.open_encrypted_with_pass(file_path, p_mode, save_file_password)
