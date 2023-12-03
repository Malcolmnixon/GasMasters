extends Control


## Start scene
@export_file('*.tscn') var start_scene : String


func _ready() -> void:
	_load_summary("slot1", %Slot1)
	_load_summary("slot2", %Slot2)
	_load_summary("slot3", %Slot3)


func _on_slot_new_pressed(p_save_name : String) -> void:
	GameState.new_game(p_save_name)


func _on_slot_load_pressed(p_save_name : String) -> void:
	GameState.load_game(p_save_name)


func _on_quit_pressed():
	get_tree().quit()


func _load_summary(p_save_name : String, p_slot : Control) -> void:
	# Get the summary
	var summary = GameState.load_summary(p_save_name)
	if not summary:
		p_slot.find_child("SlotLoad").disabled = true
		return

	# Construct the label
	var label = "Date: %s\nCash: %s\nPlay Time: %.1f" % [
		summary.get("date", "N/A"),
		summary.get("cash", "N/A"),
		summary.get("play_time", 0.0)
	]

	# Set the label
	p_slot.find_child("SlotLabel").text = label
