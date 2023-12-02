extends InteractionUI


func _ready() -> void:
	# Update the status
	%Cash.text = "₡%d" % GameState.cash


func _on_status_button_pressed():
	# Switch to the Status Tab
	%TabContainer.current_tab = 0


func _on_resources_button_pressed():
	# Switch to the Resources Tab
	%TabContainer.current_tab = 1


func _on_close_button_pressed():
	# Hide the container
	container.visible = false
