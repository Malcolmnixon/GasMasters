extends InteractionUI


# Current action
var _action : String


func _on_buy_turbine_low_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_low"
	%ConfirmMessage.text = "Confirm purchase\nof Turbine Low"
	%TabContainer.current_tab = 1


func _on_buy_turbine_high_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_high"
	%ConfirmMessage.text = "Confirm purchase\nof Turbine High"
	%TabContainer.current_tab = 1


func _on_close_pressed():
	# Hide the UI
	container.visible = false


func _on_yes_pressed():
	# Deliver the interaction and hide the UI
	interactable.interaction(_action)
	container.visible = false


func _on_no_pressed():
	# Go back to construct tab
	%TabContainer.current_tab = 0
