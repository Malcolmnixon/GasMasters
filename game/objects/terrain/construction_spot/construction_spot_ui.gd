extends InteractionUI


# Current action
var _action : String

# Current action price
var _price : int


func _ready():
	# Update the cash line
	%Cash.text = "₡%d" % GameState.cash

	# Update the turbine low information
	%BuyTurbineLow.disabled = GameState.cash < TurbineLow.PRICE
	%TurbineLowPrice.text = "₡%d" % TurbineLow.PRICE

	# Update the turbine high information
	%BuyTurbineHigh.disabled = GameState.cash < TurbineHigh.PRICE
	%TurbineHighPrice.text = "₡%d" % TurbineHigh.PRICE


func _on_buy_turbine_low_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_low"
	_price = TurbineLow.PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Turbine Low"
	%TabContainer.current_tab = 1


func _on_buy_turbine_high_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_high"
	_price = TurbineHigh.PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Turbine High"
	%TabContainer.current_tab = 1


func _on_close_pressed():
	# Hide the UI
	container.visible = false


func _on_yes_pressed():
	# Deliver the interaction and hide the UI
	GameState.cash -= _price
	interactable.interaction(_action)
	container.visible = false


func _on_no_pressed():
	# Go back to construct tab
	%TabContainer.current_tab = 0
