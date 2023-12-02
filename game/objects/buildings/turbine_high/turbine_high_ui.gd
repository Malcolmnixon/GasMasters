extends InteractionUI


func _on_destroy_pressed():
	# Show the confirmation
	%TabContainer.current_tab = 1


func _on_yes_pressed():
	# Discard the mining rig
	interactable.interaction("destroy")

	# Hide the UI
	container.visible = false


func _on_no_pressed():
	# Go back to status
	%TabContainer.current_tab = 0


func _on_close_pressed():
	# Just hide the UI
	container.visible = false
