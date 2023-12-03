extends InspectionUI


func _on_yes_pressed():
	GameState.cash += 40
	item.interaction("destroy")
	container.visible = false


func _on_no_pressed():
	container.visible = false
