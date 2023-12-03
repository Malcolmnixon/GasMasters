extends Control


signal close


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed():
	# Disable whennot in game
	%Save.disabled = not GameState.is_in_game()


func _on_quit_pressed() -> void:
	# If in a game then exit the game
	if GameState.is_in_game():
		GameState.exit_game()
		close.emit()
		return

	# Exit the application
	get_tree().quit()


func _on_save_pressed() -> void:
	GameState.save_game()
	close.emit()
