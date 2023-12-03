extends InspectionUI


func _on_destroy_pressed():
	# Show the confirmation
	%TabContainer.current_tab = 1


func _on_yes_pressed():
	# Discard the mining rig
	item.interaction("destroy")

	# Hide the UI
	container.visible = false


func _on_no_pressed():
	# Hide the UI
	container.visible = false


func _on_close_pressed():
	# Just hide the UI
	container.visible = false
